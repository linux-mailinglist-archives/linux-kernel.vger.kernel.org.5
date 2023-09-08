Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529F1798830
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbjIHN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjIHN6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:58:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E01BF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:58:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E64C433C8;
        Fri,  8 Sep 2023 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694181527;
        bh=DIyVsAgPTuZDFaF1kjOkcsN7GoZd5mVihCW+Y3SnfNk=;
        h=From:To:Cc:Subject:Date:From;
        b=IhjrXiMtZu//SHbGWnbEwG45KcP6g29qsuFescaLsR6b9wY63OhL2P92TXGghhr9G
         4Fmvq2MbmPkRJUaMxXB2NIWKYa/q3p2p6rnhd+YG5nvOq0+8CwhjkNP4oxX0oKneRl
         uE/qr1FLUZHfkAtCUIegC8NfCTI/k1uIVmrq+ggBIhEEriDYUrji5xjSXXTFM3yZF5
         XNxJFYSydkxAqQG05h7barZSW33Jc5bQss9pnzcuuK/bz9/5I+vmlyROxTA9aqbdGU
         MpF5dCBbFFy64DVhFtkHPQ63eeRAu0iOS1tRnwum/u9nW45PF1lELBUgclw+V6zInX
         kY8ggvPm1+sEA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] devres: rename the first parameter of devm_add_action(_or_reset)
Date:   Fri,  8 Sep 2023 22:58:40 +0900
Message-Id: <20230908135840.2362708-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first parameter of devm_add_action(_or_reset) is a device.
The name 'release' is confusing because it is often used for
dr_release_t in the devres context.

Rename it to 'dev'. No functional change intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - Change devm_add_action too

 include/linux/device.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b..d7a72a8749ea 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -389,8 +389,8 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
 void devm_release_action(struct device *dev, void (*action)(void *), void *data);
 
 int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
-#define devm_add_action(release, action, data) \
-	__devm_add_action(release, action, data, #action)
+#define devm_add_action(dev, action, data) \
+	__devm_add_action(dev, action, data, #action)
 
 static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
 					     void *data, const char *name)
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

