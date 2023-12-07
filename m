Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7C808943
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441922AbjLGNfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjLGNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:34:58 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E7123;
        Thu,  7 Dec 2023 05:35:04 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce32821a53so444814b3a.0;
        Thu, 07 Dec 2023 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956104; x=1702560904; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRTzlruS03W9af/VQ5z7QRDszsj8/IYotlOynmYM3G8=;
        b=gd60ctfhqdAJeSenjc7HWhJyG/vHJSmX1k/u8CeudLcV+1UeZdZN6Fah0JKszmY9Bb
         0bjV7qvzj9V07v/FFaXSrutS00s/MmPr3qDGD/DwlZ6Np5VdcY/QjUGQ0pvTmHH1v9hK
         0bp0ATvs6CwOxSuIOndLLlEa7XJ9NyHK2hm76tBFiwzCb30wSXGBKRLoNtqOFhb+KloD
         rCiF2jrHUdnGoTteqvRCK6YN546aGexIvytDQIuSFEXmUVneTPahK1J5L1DTzwZBILBV
         Tqzc40PtywOrjRWe653jqvKgxztHXOg0MTV6AoIObDMenU+pRBnY5Raip82YTjS0xg+m
         QaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956104; x=1702560904;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRTzlruS03W9af/VQ5z7QRDszsj8/IYotlOynmYM3G8=;
        b=iufawzxmQlxZY/Tgn3+TvcHZ3Qh4GfGTP78A+7sk42QTbSEIHEk7RGaqZBh4fGu4x9
         amh54NuVFPlGAEDptRuDidL1jbUjKFZMrawwSPay3TFk5Pnny7QSYpiCgSiw5NbpVJhH
         fMyNjKGJJ6bG332f6gQbjlxFrb/i3YFBbdtKkZt0oWS9mgCihXunqc3AUYz8zIgeSZxn
         cndtcr4DNxrOIU/eVRCdmH1R6SJ0Si5d31SEj9HVjmXC3zc3ZTEJl7elqi0VypXF/AIn
         ROwCdUdcyt0psA7i5doT7BaPPJfEcnE+qQiAc1RmkP/hckSYXNN3oWiN1YkiIy7A/5S2
         3Jxg==
X-Gm-Message-State: AOJu0YydumiMeiUVvIeRljf7pY3hI5E/iFaFDlxEewhvvM3MFYGdEmxs
        PPXPF11s/xgaOKyc81oEAW0=
X-Google-Smtp-Source: AGHT+IHFIIBb/Pc2NOsSGu4FGrav3Qw1ptK/bHaF+FmbByi3IJkvRqbxEBe5UfCHredzqwZQQYnSqg==
X-Received: by 2002:a05:6a00:8d93:b0:6ce:60d7:2aa0 with SMTP id im19-20020a056a008d9300b006ce60d72aa0mr2207083pfb.55.1701956103608;
        Thu, 07 Dec 2023 05:35:03 -0800 (PST)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b006ce7d0d2590sm1299176pfa.0.2023.12.07.05.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:35:03 -0800 (PST)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     vkoul@kernel.org, allen.lkml@gmail.com, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] dmaengine: pch_dma: Fix potential deadlock on &pd_chan->lock
Date:   Thu,  7 Dec 2023 13:34:52 +0000
Message-Id: <20231207133452.14726-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &pd_chan->lock is acquired by pdc_tasklet() under softirq context,
other acquisition of the same lock under process context should at least
disable bottom half, otherwise deadlock could happen if the tasklet
preempts the execution while the lock is held under process context on
the same CPU.

pd_issue_pending(), pd_tx_submit(), pdc_desc_put() and pdc_desc_get()
seem like that could execute under process context without bottom half
disaled.

One Possible deadlock scenario:
pd_prep_slave_sg()
    -> pdc_desc_put()
    -> spin_lock(&pd_chan->lock)
        <tasklet softirq interruption>
        -> pdc_tasklet()
        -> spin_lock_irqsave(&pd_chan->lock, flags); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_bh() to
disable bottom half while lock is held.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
V2: change to spin_lock_bh() instead of spin_lock_irqsave()

 drivers/dma/pch_dma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index c359decc07a3..2c4e479ca124 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -410,7 +410,7 @@ static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 	struct pch_dma_desc *desc = to_pd_desc(txd);
 	struct pch_dma_chan *pd_chan = to_pd_chan(txd->chan);
 
-	spin_lock(&pd_chan->lock);
+	spin_lock_bh(&pd_chan->lock);
 
 	if (list_empty(&pd_chan->active_list)) {
 		list_add_tail(&desc->desc_node, &pd_chan->active_list);
@@ -419,7 +419,7 @@ static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 		list_add_tail(&desc->desc_node, &pd_chan->queue);
 	}
 
-	spin_unlock(&pd_chan->lock);
+	spin_unlock_bh(&pd_chan->lock);
 	return 0;
 }
 
@@ -447,7 +447,7 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 	struct pch_dma_desc *ret = NULL;
 	int i = 0;
 
-	spin_lock(&pd_chan->lock);
+	spin_lock_bh(&pd_chan->lock);
 	list_for_each_entry_safe(desc, _d, &pd_chan->free_list, desc_node) {
 		i++;
 		if (async_tx_test_ack(&desc->txd)) {
@@ -457,15 +457,15 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 		}
 		dev_dbg(chan2dev(&pd_chan->chan), "desc %p not ACKed\n", desc);
 	}
-	spin_unlock(&pd_chan->lock);
+	spin_unlock_bh(&pd_chan->lock);
 	dev_dbg(chan2dev(&pd_chan->chan), "scanned %d descriptors\n", i);
 
 	if (!ret) {
 		ret = pdc_alloc_desc(&pd_chan->chan, GFP_ATOMIC);
 		if (ret) {
-			spin_lock(&pd_chan->lock);
+			spin_lock_bh(&pd_chan->lock);
 			pd_chan->descs_allocated++;
-			spin_unlock(&pd_chan->lock);
+			spin_unlock_bh(&pd_chan->lock);
 		} else {
 			dev_err(chan2dev(&pd_chan->chan),
 				"failed to alloc desc\n");
@@ -478,11 +478,12 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 static void pdc_desc_put(struct pch_dma_chan *pd_chan,
 			 struct pch_dma_desc *desc)
 {
+
 	if (desc) {
-		spin_lock(&pd_chan->lock);
+		spin_lock_bh(&pd_chan->lock);
 		list_splice_init(&desc->tx_list, &pd_chan->free_list);
 		list_add(&desc->desc_node, &pd_chan->free_list);
-		spin_unlock(&pd_chan->lock);
+		spin_unlock_bh(&pd_chan->lock);
 	}
 }
 
@@ -557,9 +558,9 @@ static void pd_issue_pending(struct dma_chan *chan)
 	struct pch_dma_chan *pd_chan = to_pd_chan(chan);
 
 	if (pdc_is_idle(pd_chan)) {
-		spin_lock(&pd_chan->lock);
+		spin_lock_bh(&pd_chan->lock);
 		pdc_advance_work(pd_chan);
-		spin_unlock(&pd_chan->lock);
+		spin_unlock_bh(&pd_chan->lock);
 	}
 }
 
-- 
2.17.1

