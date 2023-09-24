Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4B7AC839
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjIXNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIXNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:15:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF497FC;
        Sun, 24 Sep 2023 06:15:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFE8C433C7;
        Sun, 24 Sep 2023 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561336;
        bh=/0DxeFclJanmHoVCa2JuctmAc4IoTLcES89kTw6xPoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bR1Yob74BY5CzeZQBeWz8kI862Gzg9ba5Qj05zKbv/+wUjsH1qH2otBNGLkMZLYjF
         HgNiEh6U9MZ1C3AnwWhwl5Shg2Ork26W9HFv8uE79x208SnJ+/AYsVwMtvW+PK7zAL
         CeH7BZNUbxE9qnHh5TXlYLHBieSM1jnbvondHCHYocvDB8p8cLSlKIWsjV7eC9NuHv
         p/GHztpkF1nIPLnrOX+SF52b9Zv3JglRnFdL2Sy4ZAITRYHpCgTD3WuJv6weltN9aN
         ForcIYOZbuEDnLvQGqVadoadWo8NbViXhvHnquUNBlX1aGhIcL0HxefhVVw9MFhj9V
         oTDN6mx1AtIRA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, airlied@redhat.com,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 02/41] parisc: sba: Fix compile warning wrt list of SBA devices
Date:   Sun, 24 Sep 2023 09:14:50 -0400
Message-Id: <20230924131529.1275335-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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

