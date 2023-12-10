Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E480B844
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 02:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjLJBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 20:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 20:04:17 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9DFE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 17:04:24 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb2132b0edso6120404fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 17:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702170263; x=1702775063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OQnRc36TMxqEoU10ESmIL5BWzXs4NdEo+e5jbz/hAw=;
        b=ZCdnILUcsr4f0rms8mAp2MMdp5Kjyl25vaDwppYjubKxqzxliVNxhQ1nqCStvWeLcu
         fRUzGmrE27HAlfedfZaB1EFB3X+7ynRkU2jDsXdKZc2bfmIt3rGjwYmqDN2UxORPTQi7
         mF3Fic4P8lj/8zdf8tWw3w6skyg3uZDhJ8KVdvEIpwQGRuxawzY4JhR/0Ho3yOp9utwi
         16eFI1iLNHP5uCjFixK56DgmegmxQApdHvCSc80vyQOHVCvFSrnKuJW9cvF0YwW6Kiw2
         qto6w6XEdMfZE0fxkCRb/S2GkkVrzMu5VRpc5lpY4h6KAeDJpjis92P/XeSc6WpZ8/qh
         zlQQ==
X-Gm-Message-State: AOJu0YwJfuOMJ8gb5lC/Q3wAWvfgWM0KQ3P0CancCHeUVNo+Fy3zb93v
        FAYKFT6ZLgaV4nf28MN8fUHzo4xsYehn1D3JfqGDN4vSxEMHltE=
X-Google-Smtp-Source: AGHT+IENA90DBUQ545YEzR6cruTyIKk+MsO4cNtwsvsBDYbj0lovNzyHlr/3qICOm4QrOQKgovOzTh+yTyHd2z+stHaY0rBjHybE
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8197:b0:1fa:fa54:1a6a with SMTP id
 k23-20020a056870819700b001fafa541a6amr2950785oae.6.1702170263562; Sat, 09 Dec
 2023 17:04:23 -0800 (PST)
Date:   Sat, 09 Dec 2023 17:04:23 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e83079060c1d659c@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [arm-msm?] [net?] memory leak in radix_tree_insert
Author: eadavis@qq.com

please test memory leak in radix_tree_insert

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33cc938e65a9

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 41ece61eb57a..3d06156fe913 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -275,6 +275,8 @@ static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
 		if (flow) {
 			init_waitqueue_head(&flow->resume_tx);
 			if (radix_tree_insert(&node->qrtr_tx_flow, key, flow)) {
+				printk("f: %p\n", flow);
+				radix_tree_delete(&node->qrtr_tx_flow, key);
 				kfree(flow);
 				flow = NULL;
 			}
@@ -287,10 +289,14 @@ static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
 		return 1;
 
 	spin_lock_irq(&flow->resume_tx.lock);
+	printk("to wait, f: %p, pd: %d, ff: %d, ep: %p\n", 
+		flow, flow->pending, flow->tx_failed, node->ep);
 	ret = wait_event_interruptible_locked_irq(flow->resume_tx,
 						  flow->pending < QRTR_TX_FLOW_HIGH ||
 						  flow->tx_failed ||
 						  !node->ep);
+	printk("r: %d, f: %p, pd: %d, ff: %d, ep: %p\n", 
+		ret, flow, flow->pending, flow->tx_failed, node->ep);
 	if (ret < 0) {
 		confirm_rx = ret;
 	} else if (!node->ep) {

