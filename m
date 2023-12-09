Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A795780B2A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjLIGxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 01:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjLIGxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 01:53:00 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB510E7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 22:53:07 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-590b580ae39so302464eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 22:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702104786; x=1702709586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hqSkZ34vz0wPtVzsrSAKgl9zxnB2coK4o0LbmskvUY=;
        b=PNr875n0MlcEmGvP/GHyip1dUH/diJ16iCaU5wNaTpKDuLndel+obu6FXSu6NBhumW
         nNZajipJK1Daqol6X8o8ZqZ4izmPCAXJCSg6qKZhjX3BcmgVAavn6wj2uCumLVxVlxCs
         Qe+u4vSHUHp6ZY9oCtDp1GjMlD0YWMkgQbiIihI9f49FOaZdyKeqD6/tye7144rV9WMV
         MB2mpGRYh7ky9dLlDWHMRjuhCNqfd7KHlJQUhm8hqbria4ExuyyBs2ZDhfQfDGAp7Zd4
         IPv4CFhkuh4/ONzYrHCIL1t+V999YeeKDqwiMTST1G4KM1UjHCOqiuLnwcS8vpQcCHbe
         o79Q==
X-Gm-Message-State: AOJu0Yz0cIP4GWvAfPJGC5mBr7FaSNOi57k9Lec0iBB1C6xQG6t/Z7G/
        7iz1ysYvC2WlA0CihtUFwZMvIcRrVN2liatR2y7g6GnnGhm4VrE=
X-Google-Smtp-Source: AGHT+IFyd16jZ+E643OF59bCsZmyjUySuEUft390y04V14kS4NsbZWswANjwhxaQa9FDzqzT8PeRKPt4LCubrZmbOIHAN0R5Xmcn
MIME-Version: 1.0
X-Received: by 2002:a4a:dfc4:0:b0:58d:cd82:4702 with SMTP id
 p4-20020a4adfc4000000b0058dcd824702mr509597ood.0.1702104786512; Fri, 08 Dec
 2023 22:53:06 -0800 (PST)
Date:   Fri, 08 Dec 2023 22:53:06 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bb22d060c0e278e@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
+		flow, flow->pending, flow->failed, node->ep);
 	ret = wait_event_interruptible_locked_irq(flow->resume_tx,
 						  flow->pending < QRTR_TX_FLOW_HIGH ||
 						  flow->tx_failed ||
 						  !node->ep);
+	printk("r: %d, f: %p, pd: %d, ff: %d, ep: %p\n", 
+		ret, flow, flow->pending, flow->failed, node->ep);
 	if (ret < 0) {
 		confirm_rx = ret;
 	} else if (!node->ep) {

