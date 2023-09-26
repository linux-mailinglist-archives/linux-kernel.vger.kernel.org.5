Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E37AEAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjIZKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjIZKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:45:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD4095;
        Tue, 26 Sep 2023 03:45:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c451541f23so63396655ad.2;
        Tue, 26 Sep 2023 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725102; x=1696329902; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OFg+CmpolgvCX6g/gLLkrhmgtpJ8DW+NkLUPpc1HfQ=;
        b=hS7WywrLOjii72nUfCjhQ10/vX8QPEfVHji69BkdbiJJdHzuPwK0hFAn8HEIYSB5GX
         9dauTFjTQxlo/5eg+8Kqn+YrMWh/kIe7joCI2dXpmBON8j4Rd6KrE57jJ0o+XvxnE4uB
         eQGCvPMowuHYCo+OiTy/BL2BuFilNu4fA64oB1FvEV/lvwhHQKG4E+/tYlESYXJbuHta
         WbbqsPCBrCSM8iGc6Dl6LkgTxLf8KNzBBJBWwK4mX0DErlSFvwYc5VdnJRVhC7CFmjD+
         mbVSgnoDnFsEHrQzHlNxIlp9iIYGcnvrsjLjW3+s9mjgIZkFJs7YdR7xnxKsacWExKKw
         DAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725102; x=1696329902;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OFg+CmpolgvCX6g/gLLkrhmgtpJ8DW+NkLUPpc1HfQ=;
        b=QVKzOe1qWRsSuvuUipWL8gCN5sB97X3x0YPjciLilijhgXNXOOEkQNJySUDlZQgKYN
         JqHoxSRcbb5kdxdgTWMW1Bxm5KRvhNE3mBNKl5sow1GHywWozuoTn/76+5Cp4s0F855R
         hsLIWxrFlGZYm7wTOu6vtTNObSacsZPJauOAYbXmNQYhMoQuqF1eyIXl/PT5T9knq+1y
         Rxrc3mow5xQ0f9bsx1bkejYMBvr46G5ai5xENirO7SWqbhpv1H3VM6y6S9sVRpCq7oZ3
         6zpVzO/tk7tqYkWN1yFy39nVYvi9sUV3/hFrs9eeWaTyPlJl4ldg4Dgrg45MQoVbVqpF
         OQLQ==
X-Gm-Message-State: AOJu0YzCct/UFODDG7zo9/IDd9Me621omPa8qYTqcqZDU9NR24m1HwFz
        hRBQ1MmZMR9JJlc+LvB/9Cg=
X-Google-Smtp-Source: AGHT+IG2Lyf2d4NWF2kkBCFKcr7v9xw7gqIca+Iq8O6LajQjKy8qgbZeoUAI6zEGd2p40qqg6XSM2w==
X-Received: by 2002:a17:90a:f10b:b0:274:98c4:b6e8 with SMTP id cc11-20020a17090af10b00b0027498c4b6e8mr6647036pjb.5.1695725102251;
        Tue, 26 Sep 2023 03:45:02 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id gw7-20020a17090b0a4700b00273f65fa424sm9732257pjb.8.2023.09.26.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:45:01 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     3chas3@gmail.com, davem@davemloft.net
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] atm: solos-pci: Fix potential deadlock on &cli_queue_lock and &tx_queue_lock
Date:   Tue, 26 Sep 2023 10:44:42 +0000
Message-Id: <20230926104442.8684-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &card->cli_queue_lock and &card->tx_queue_lock are acquired under
softirq context along the following call chain from solos_bh(), other
acquisition of the same lock inside process context should disable
at least bh to avoid double lock.

<deadlock #1>
console_show()
--> spin_lock(&card->cli_queue_lock)
<interrupt>
   --> solos_bh()
   --> spin_lock(&card->cli_queue_lock)

<deadlock #2>
pclose()
--> spin_lock(&card->tx_queue_lock)
<interrupt>
   --> solos_bh()
   --> fpga_tx()
   --> spin_lock(&card->tx_queue_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_irqsave()
on the two locks under process context code consistently to prevent
the possible deadlock scenario.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/atm/solos-pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e..247e9200e312 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -447,11 +447,12 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct atm_dev *atmdev = container_of(dev, struct atm_dev, class_dev);
 	struct solos_card *card = atmdev->dev_data;
 	struct sk_buff *skb;
+	unsigned long flags;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_irqsave(&card->cli_queue_lock, flags);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_irqrestore(&card->cli_queue_lock, flags);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
@@ -954,16 +955,17 @@ static void pclose(struct atm_vcc *vcc)
 	unsigned char port = SOLOS_CHAN(vcc->dev);
 	struct sk_buff *skb, *tmpskb;
 	struct pkt_hdr *header;
+	unsigned long flags;
 
 	/* Remove any yet-to-be-transmitted packets from the pending queue */
-	spin_lock(&card->tx_queue_lock);
+	spin_lock_irqsave(&card->tx_queue_lock, flags);
 	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
 		if (SKB_CB(skb)->vcc == vcc) {
 			skb_unlink(skb, &card->tx_queue[port]);
 			solos_pop(vcc, skb);
 		}
 	}
-	spin_unlock(&card->tx_queue_lock);
+	spin_unlock_irqrestore(&card->tx_queue_lock, flags);
 
 	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
 	if (!skb) {
-- 
2.17.1

