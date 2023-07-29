Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE7767DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjG2J0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjG2J0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:26:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F1B35A3;
        Sat, 29 Jul 2023 02:26:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-56433b1b0e0so101484a12.0;
        Sat, 29 Jul 2023 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690622806; x=1691227606;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVn67woWrYaVl+gtOIxQbSZMyVcRvQ2Gn5jYKy1xEYg=;
        b=pmLORHA8bjhwC5vtHpEwKML5DM69V3vYTP8Td8g1J+Uatmv6YiwRZaKYFMyPRlLhB8
         WkRfvTuIf2ToZyD0rNxPCXmzY/qRzSvFHg8a1X0gyt336gR6fUF32AieB1x0Kxf8vQYp
         qxfg3w9hEgXgdKelv+/EmiWPQjqp7rOjBQ6pSrPfD1ziRHZ1e4J7em3Rf1D5PmwJtqZY
         v+1+sxH2BcKv8QXhkVW340GsceENt4hu31UdLT9TBWkGiX4NTLkAfTfDzBJ7lRL10q5X
         WGvoHOVmTFrGxUYIAUZnkVi39KznA9J1lxXNfuAT65mFe2Q3wOYxyWj0WKHpFnJotDEo
         f1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690622806; x=1691227606;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVn67woWrYaVl+gtOIxQbSZMyVcRvQ2Gn5jYKy1xEYg=;
        b=DNSUvwf9cYLiznHPQU2Njtp7fdBTl4NHV3WGp+42fcFTkke66I4q4rvjmtXOs2ksdC
         7Tdb7wYUC4Y8V402rwWsshQ8kll7lB1T3TuVYNMAlQXB1eYs8zSKZH+NOn5GA2zlNe3y
         uNiJAkl6rlTqZ1lKpFUkXZusyr4oqwOhUoeq2zHACh++NpcXNYOfhLXUYlRH1tiXN115
         +Xnz9iKK7uPbv9e6wt0WLiMY6Kic3jfeRrU3gBlYTM1GKo5eNwsU0x5CoHmTTpXVtly5
         sDBmHF1rjYepG88LrLAS8rcUClYXHxK+GWY3t8f/gi5v4wPbQcbjCGcc6nEL53Ef+q94
         oRwQ==
X-Gm-Message-State: ABy/qLYYwuxoZOqdtqsOoX512wLYGOHqS2gbdyLWrWG9Kx9tO+iFBPOs
        SwFtDDKfIywRYRiSV0BYgOU=
X-Google-Smtp-Source: APBJJlHiDK3L2PVha3QdApJdUglp+JDthsx8uq//JiECYyhDA48jb468vldw3pePXL2h7XVkbBAb2w==
X-Received: by 2002:a17:90b:4c89:b0:268:3582:a6be with SMTP id my9-20020a17090b4c8900b002683582a6bemr4145023pjb.33.1690622805660;
        Sat, 29 Jul 2023 02:26:45 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b0019ee045a2b3sm4869161plf.308.2023.07.29.02.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 02:26:45 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     giometti@linux.it, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] usb: host: oxu210hp-hcd: Fix potential deadlock on &oxu->mem_lock
Date:   Sat, 29 Jul 2023 09:26:34 +0000
Message-Id: <20230729092634.78336-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&oxu->mem_lock is acquired by isr oxu_irq() along the below call
chain under hardirq context.

<hard interrupt>
        -> oxu_irq()
        -> oxu210_hcd_irq()
        -> ehci_work()
        -> scan_async()
        -> qh_completions()
        -> oxu_murb_free()
        -> spin_lock(&oxu->mem_lock)

Thus the acquisition of the lock under process context should disable
irq, otherwise deadlock could happen if the irq happens to preempt the
execution while the lock is held in process context on the same CPU.

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock. x86_64 allmodconfig using gcc shows no new
warning.

The patch fixes the potential deadlocks by using spin_lock_irqsave() on
&oxu->mem_lock

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Changes in v2
- use spin_lock_irqsave() on more potential deadlock sites of &oxu->mem_lock
---
 drivers/usb/host/oxu210hp-hcd.c | 42 ++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 50c1ccabb0f5..83061204b033 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -908,6 +908,7 @@ static int oxu_buf_alloc(struct oxu_hcd *oxu, struct ehci_qtd *qtd, int len)
 {
 	int n_blocks;	/* minium blocks needed to hold len */
 	int a_blocks;	/* blocks allocated */
+	unsigned long flags;
 	int i, j;
 
 	/* Don't allocte bigger than supported */
@@ -916,7 +917,7 @@ static int oxu_buf_alloc(struct oxu_hcd *oxu, struct ehci_qtd *qtd, int len)
 		return -ENOMEM;
 	}
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	/* Number of blocks needed to hold len */
 	n_blocks = (len + BUFFER_SIZE - 1) / BUFFER_SIZE;
@@ -944,14 +945,14 @@ static int oxu_buf_alloc(struct oxu_hcd *oxu, struct ehci_qtd *qtd, int len)
 		qtd->qtd_buffer_len = BUFFER_SIZE * a_blocks;
 		oxu->db_used[i] = a_blocks;
 
-		spin_unlock(&oxu->mem_lock);
+		spin_unlock_irqrestore(&oxu->mem_lock, flags);
 
 		return 0;
 	}
 
 	/* Failed */
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 
 	return -ENOMEM;
 }
@@ -959,8 +960,9 @@ static int oxu_buf_alloc(struct oxu_hcd *oxu, struct ehci_qtd *qtd, int len)
 static void oxu_buf_free(struct oxu_hcd *oxu, struct ehci_qtd *qtd)
 {
 	int index;
+	unsigned long flags;
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	index = (qtd->buffer - (void *) &oxu->mem->db_pool[0])
 							 / BUFFER_SIZE;
@@ -969,7 +971,7 @@ static void oxu_buf_free(struct oxu_hcd *oxu, struct ehci_qtd *qtd)
 	qtd->buffer_dma = 0;
 	qtd->buffer = NULL;
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 }
 
 static inline void ehci_qtd_init(struct ehci_qtd *qtd, dma_addr_t dma)
@@ -985,24 +987,26 @@ static inline void ehci_qtd_init(struct ehci_qtd *qtd, dma_addr_t dma)
 static inline void oxu_qtd_free(struct oxu_hcd *oxu, struct ehci_qtd *qtd)
 {
 	int index;
+	unsigned long flags;
 
 	if (qtd->buffer)
 		oxu_buf_free(oxu, qtd);
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	index = qtd - &oxu->mem->qtd_pool[0];
 	oxu->qtd_used[index] = 0;
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 }
 
 static struct ehci_qtd *ehci_qtd_alloc(struct oxu_hcd *oxu)
 {
 	int i;
 	struct ehci_qtd *qtd = NULL;
+	unsigned long flags;
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	for (i = 0; i < QTD_NUM; i++)
 		if (!oxu->qtd_used[i])
@@ -1022,7 +1026,7 @@ static struct ehci_qtd *ehci_qtd_alloc(struct oxu_hcd *oxu)
 		oxu->qtd_used[i] = 1;
 	}
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 
 	return qtd;
 }
@@ -1030,13 +1034,14 @@ static struct ehci_qtd *ehci_qtd_alloc(struct oxu_hcd *oxu)
 static void oxu_qh_free(struct oxu_hcd *oxu, struct ehci_qh *qh)
 {
 	int index;
+	unsigned long flags;
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	index = qh - &oxu->mem->qh_pool[0];
 	oxu->qh_used[index] = 0;
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 }
 
 static void qh_destroy(struct kref *kref)
@@ -1058,8 +1063,9 @@ static struct ehci_qh *oxu_qh_alloc(struct oxu_hcd *oxu)
 {
 	int i;
 	struct ehci_qh *qh = NULL;
+	unsigned long flags;
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	for (i = 0; i < QHEAD_NUM; i++)
 		if (!oxu->qh_used[i])
@@ -1086,7 +1092,7 @@ static struct ehci_qh *oxu_qh_alloc(struct oxu_hcd *oxu)
 		oxu->qh_used[i] = 1;
 	}
 unlock:
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 
 	return qh;
 }
@@ -1106,13 +1112,14 @@ static inline void qh_put(struct ehci_qh *qh)
 static void oxu_murb_free(struct oxu_hcd *oxu, struct oxu_murb *murb)
 {
 	int index;
+	unsigned long flags;
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	index = murb - &oxu->murb_pool[0];
 	oxu->murb_used[index] = 0;
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 }
 
 static struct oxu_murb *oxu_murb_alloc(struct oxu_hcd *oxu)
@@ -1120,8 +1127,9 @@ static struct oxu_murb *oxu_murb_alloc(struct oxu_hcd *oxu)
 {
 	int i;
 	struct oxu_murb *murb = NULL;
+	unsigned long flags;
 
-	spin_lock(&oxu->mem_lock);
+	spin_lock_irqsave(&oxu->mem_lock, flags);
 
 	for (i = 0; i < MURB_NUM; i++)
 		if (!oxu->murb_used[i])
@@ -1133,7 +1141,7 @@ static struct oxu_murb *oxu_murb_alloc(struct oxu_hcd *oxu)
 		oxu->murb_used[i] = 1;
 	}
 
-	spin_unlock(&oxu->mem_lock);
+	spin_unlock_irqrestore(&oxu->mem_lock, flags);
 
 	return murb;
 }
-- 
2.17.1

