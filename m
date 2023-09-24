Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B97AC984
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjIXNcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjIXNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:31:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC16F3A87;
        Sun, 24 Sep 2023 06:19:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B45FC433C7;
        Sun, 24 Sep 2023 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561540;
        bh=/0DxeFclJanmHoVCa2JuctmAc4IoTLcES89kTw6xPoU=;
        h=From:To:Cc:Subject:Date:From;
        b=psCznLbE00vO5iBzy3hah1OTK/41um+QTYPmgHjCMtdCslsyeCvkxvUiz/tb2PUPL
         DZ/PNzR+0oQmzz7gpnLXJIVJMbd4MEYNlecpqvOndNoTA6WT/H85/LjpsKF6xiQW0l
         Zhi/2tuBiap1JFjZSRLBHHvUB8c5PynkQWKIm+I2le3PmWleMwizyZ4X+yUWjD3ofK
         pBx6HiKUIBE9mQmNyQX4t1Qai4AUa8TSKQEpi+j4akU8Rkq3GbwaiwCcxZ/8gl6on8
         v+udwmEhOHRyqwlAGfnu2tDvrnBS7IIDrwc1vrkYv9JT837B37mA6zdVkZPBS1tzDJ
         BvxZqW2Y2Mdfw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, airlied@redhat.com,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 01/18] parisc: sba: Fix compile warning wrt list of SBA devices
Date:   Sun, 24 Sep 2023 09:18:38 -0400
Message-Id: <20230924131857.1276330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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
index 514f9f287a781..c6f181702b9a7 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -394,8 +394,6 @@ find_quicksilver(struct device *dev, void *data)
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

