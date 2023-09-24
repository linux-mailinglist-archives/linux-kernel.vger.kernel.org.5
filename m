Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417C7AC925
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjIXNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjIXNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:24:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EDE5580;
        Sun, 24 Sep 2023 06:20:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB60C4339A;
        Sun, 24 Sep 2023 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561636;
        bh=5o/7+bfcajmYC3wkUtOI5QGvaYZc3ylWHck73AYKVYc=;
        h=From:To:Cc:Subject:Date:From;
        b=ue//2ZzLJHbx+T+SgRdyTg8F5F915pxDKXimYm7dX+KSvh0rGiDnn7x7yavQ3wHjy
         iT1M/QpNqOwgZKxxhzDvX/CO+SKvDI8aBYthl3gjdftdEEw/aOgjgTfIHaE4k5g0Xw
         lyLMNNzrg0oLob9Bz1cc7PznwQrZhaC7nRV5CufwSDEgmZaZ9tifeuLf9S0Sp4KXHR
         h5boTxaS+CnAQ0LMKC4VjwNXz3WrlHgpurA1fbErcL/Y83KzDfOtZ4cllqyaJZwX8K
         9gAI3d6IcgiM2MEp/1ebhFLlQBoEpPmv58YmqW7kBfUsXep+S+knvJSA6WKNgAfV3/
         P3pcYT4if1SDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, airlied@redhat.com,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 1/7] parisc: sba: Fix compile warning wrt list of SBA devices
Date:   Sun, 24 Sep 2023 09:20:25 -0400
Message-Id: <20230924132033.1276920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.295
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

From: Helge Deller <deller@gmx.de>

[ Upstream commit eb3255ee8f6f4691471a28fbf22db5e8901116cd ]

Fix this makecheck warning:
drivers/parisc/sba_iommu.c:98:19: warning: symbol 'sba_list'
	was not declared. Should it be static?

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/ropes.h | 3 +++
 drivers/char/agp/parisc-agp.c   | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/ropes.h b/arch/parisc/include/asm/ropes.h
index 8e51c775c80a6..62399c7ea94a1 100644
--- a/arch/parisc/include/asm/ropes.h
+++ b/arch/parisc/include/asm/ropes.h
@@ -86,6 +86,9 @@ struct sba_device {
 	struct ioc		ioc[MAX_IOC];
 };
 
+/* list of SBA's in system, see drivers/parisc/sba_iommu.c */
+extern struct sba_device *sba_list;
+
 #define ASTRO_RUNWAY_PORT	0x582
 #define IKE_MERCED_PORT		0x803
 #define REO_MERCED_PORT		0x804
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index 1d5510cb6db4e..1962ff624b7c5 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -385,8 +385,6 @@ find_quicksilver(struct device *dev, void *data)
 static int __init
 parisc_agp_init(void)
 {
-	extern struct sba_device *sba_list;
-
 	int err = -1;
 	struct parisc_device *sba = NULL, *lba = NULL;
 	struct lba_device *lbadev = NULL;
-- 
2.40.1

