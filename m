Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12395802544
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjLCPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjLCPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:51:16 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A367AFC;
        Sun,  3 Dec 2023 07:51:21 -0800 (PST)
Received: from localhost.localdomain (unknown [46.242.8.170])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3E8F140F1DE6;
        Sun,  3 Dec 2023 15:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3E8F140F1DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1701618677;
        bh=OzqlpYzBI15i6FXYFGVQXHLoruvKle2z9Cu7A+AYusY=;
        h=From:To:Cc:Subject:Date:From;
        b=TXgQzPbfxSrdpYYw84oDK20OZfkSeQdWdzqyfZOwnJMGcYsbwkX1D27IEo/QQ2F8F
         nn6+wULBdJn0Hz87drvzHz3Rj+/WG0VhY5x8uqGqgBG7YV2bYKjbd8LGroyWhns4gz
         q7IDTPju6sD5xZhcREAO5OXY+BKTeKm1dmwVZJfg=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] scsi: megaraid_mm: do not access uninit kioc_list members
Date:   Sun,  3 Dec 2023 18:50:57 +0300
Message-ID: <20231203155058.24293-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adapter->kioc_list is allocated using kmalloc_array() so its values are
left uninitialized. In a rare OOM case when dma_pool_alloc() fails in
mraid_mm_register_adp(), we should free the already allocated DMA pools
but comparing kioc->pthru32 with NULL doesn't guard from accessing uninit
memory.

Properly roll back in error case: free array members with lower indices.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/scsi/megaraid/megaraid_mm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index c509440bd161..701eb5ee2a69 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -1001,12 +1001,10 @@ mraid_mm_register_adp(mraid_mmadp_t *lld_adp)
 
 pthru_dma_pool_error:
 
-	for (i = 0; i < lld_adp->max_kioc; i++) {
+	while (--i >= 0) {
 		kioc = adapter->kioc_list + i;
-		if (kioc->pthru32) {
-			dma_pool_free(adapter->pthru_dma_pool, kioc->pthru32,
-				kioc->pthru32_h);
-		}
+		dma_pool_free(adapter->pthru_dma_pool, kioc->pthru32,
+			kioc->pthru32_h);
 	}
 
 memalloc_error:
-- 
2.43.0

