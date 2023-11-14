Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33BD7EAFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjKNMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjKNMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:23:20 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 04:23:16 PST
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D8F0;
        Tue, 14 Nov 2023 04:23:15 -0800 (PST)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Tue, 14 Nov 2023 13:23:03 +0100
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
        ; Tue, 14 Nov 2023 13:23:02 +0100
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 14 Nov 2023 13:23:03 +0100
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 14 Nov 2023 13:23:03 +0100
Date:   Tue, 14 Nov 2023 13:23:03 +0100
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>
CC:     <nicolas.ferre@microchip.com>, <vkoul@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 2/2 stable-6.1] dmaengine: at_hdmac: complete chain after
 next message is started
Message-ID: <4412b25a-d4e1-f455-f7bd-82262e691a2b@pcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14.11.2023 10:04:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Pfaff <tpfaff@pcs.com>

calling atc_chain_complete with unlocked spinlock in the middle of 
atc_advance_work might cause a race condition regarding the next dma 
transfer.
If the dma_callback is handled by a task with higher priority and 
starts a new dma transfer it might call atc_issue_pending before the 
spinlock is locked again.
In this case, the active list contains already a new entry that is started, 
and atc_advance_work tries to start it again, which will fail because the 
channel is already enabled.

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 68c1bfbefc5c..9b2a1cf23763 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -529,15 +529,12 @@ static void atc_advance_work(struct at_dma_chan *atchan)
 	desc = atc_first_active(atchan);
 	/* Remove the transfer node from the active list. */
 	list_del_init(&desc->desc_node);
-	spin_unlock_irqrestore(&atchan->lock, flags);
-	atc_chain_complete(atchan, desc);
-
 	/* advance work */
-	spin_lock_irqsave(&atchan->lock, flags);
 	atc_start_next(atchan);
 	spin_unlock_irqrestore(&atchan->lock, flags);
-}
 
+	atc_chain_complete(atchan, desc);
+}
 
 /**
  * atc_handle_error - handle errors reported by DMA controller


