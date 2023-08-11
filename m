Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8FB7784EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHKBey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHKBex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:34:53 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB52D54
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:34:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpVG78-_1691717688;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VpVG78-_1691717688)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 09:34:49 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] mailbox: bcm-pdc: Fix some kernel-doc comments
Date:   Fri, 11 Aug 2023 09:34:48 +0800
Message-Id: <20230811013448.115153-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some kernel-doc comments to silence the warnings:

drivers/mailbox/bcm-pdc-mailbox.c:707: warning: Function parameter or member 'pdcs' not described in 'pdc_tx_list_sg_add'
drivers/mailbox/bcm-pdc-mailbox.c:707: warning: Excess function parameter 'spu_idx' description in 'pdc_tx_list_sg_add'
drivers/mailbox/bcm-pdc-mailbox.c:875: warning: Function parameter or member 'pdcs' not described in 'pdc_rx_list_sg_add'
drivers/mailbox/bcm-pdc-mailbox.c:875: warning: Excess function parameter 'spu_idx' description in 'pdc_rx_list_sg_add'
drivers/mailbox/bcm-pdc-mailbox.c:966: warning: Function parameter or member 't' not described in 'pdc_tasklet_cb'
drivers/mailbox/bcm-pdc-mailbox.c:966: warning: Excess function parameter 'data' description in 'pdc_tasklet_cb'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 8c95e3ce295f..5401b9e3f5e8 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -694,7 +694,7 @@ pdc_receive(struct pdc_state *pdcs)
  * pdc_tx_list_sg_add() - Add the buffers in a scatterlist to the transmit
  * descriptors for a given SPU. The scatterlist buffers contain the data for a
  * SPU request message.
- * @spu_idx:   The index of the SPU to submit the request to, [0, max_spu)
+ * @pdcs:      PDC state for the SPU that will process this request
  * @sg:        Scatterlist whose buffers contain part of the SPU request
  *
  * If a scatterlist buffer is larger than PDC_DMA_BUF_MAX, multiple descriptors
@@ -861,7 +861,7 @@ static int pdc_rx_list_init(struct pdc_state *pdcs, struct scatterlist *dst_sg,
  * pdc_rx_list_sg_add() - Add the buffers in a scatterlist to the receive
  * descriptors for a given SPU. The caller must have already DMA mapped the
  * scatterlist.
- * @spu_idx:    Indicates which SPU the buffers are for
+ * @pdcs:       PDC state for the SPU that will process this request
  * @sg:         Scatterlist whose buffers are added to the receive ring
  *
  * If a receive buffer in the scatterlist is larger than PDC_DMA_BUF_MAX,
@@ -960,7 +960,7 @@ static irqreturn_t pdc_irq_handler(int irq, void *data)
 /**
  * pdc_tasklet_cb() - Tasklet callback that runs the deferred processing after
  * a DMA receive interrupt. Reenables the receive interrupt.
- * @data: PDC state structure
+ * @t: Pointer to the Altera sSGDMA channel structure
  */
 static void pdc_tasklet_cb(struct tasklet_struct *t)
 {
-- 
2.20.1.7.g153144c

