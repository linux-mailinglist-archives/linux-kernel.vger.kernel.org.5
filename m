Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2C7977C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjIGQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjIGQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72613588
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A690BC116B6;
        Thu,  7 Sep 2023 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694084591;
        bh=x231l01soUhHZY1UintuQFo1TgQhxF9ul7C5Syudzfk=;
        h=From:To:Cc:Subject:Date:From;
        b=LApz67d4TPv9yWMhOatFYjd6W6cDCqjGkHuICPHJ5MvXidHZbhWTpCzMT9KBx0e/S
         pgY/uX4vQYRE/OQHL2n69IPcpH4zG5WEi640v42iDsBcUeV7pdmVbndTAwdYSyHHje
         OcoPnvTjZL8qMq9ACwP623nBMGewXRlVrdJENXKoT8D4p856+GNmbm5MZMAKFiHk2x
         SH1l0usRbjsB8yVeTcKEy3q3kwEdz2Bv0H4087raT3PAysjehl6AGk6wAbGCBhF6xk
         rW+G32PJCGQEq/bGD7LVTxGylwoezMaN87urvH47Xy8iJUA9EbUSYC0z1IZP9N1V/l
         /g0wby+UCVkOg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] devres: rename the first parameter of devm_add_action_or_reset()
Date:   Thu,  7 Sep 2023 20:03:05 +0900
Message-Id: <20230907110305.2096052-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a possible mistake in commit 410e7088e971 ("devres: Pass unique name
of the resource to devm_add_action_or_reset()").

The first parameter of devm_add_action_or_reset() is the associated
device. The name 'release' is confusing because it is often used for
dr_release_t in the devres context.

Rename it to 'dev'. No functional change intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/device.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b..1fa0e9cb5e01 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -403,8 +403,8 @@ static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(
 
 	return ret;
 }
-#define devm_add_action_or_reset(release, action, data) \
-	__devm_add_action_or_reset(release, action, data, #action)
+#define devm_add_action_or_reset(dev, action, data) \
+	__devm_add_action_or_reset(dev, action, data, #action)
 
 /**
  * devm_alloc_percpu - Resource-managed alloc_percpu
-- 
2.39.2

