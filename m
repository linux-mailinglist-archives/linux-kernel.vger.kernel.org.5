Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087F80B2A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjLIGwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 01:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 01:52:41 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D865E10C9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 22:52:47 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9f7c18b6eso376417b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 22:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702104767; x=1702709567;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw0wEEd7f+vJ6Q/m7+r8ZL1x5tJhpeAYet+UixU1q8s=;
        b=jDYQArHzMfj5wV2aL8muQ7JoIG4C+w2ykueJI/wHlw+rsiGnifLraNRsQkdJZ50UFA
         PSZYdM3bXYRpFaSKJW+35ipyNkFLE5JBycyaDkZ+Mn3WHoCS0unbVb2e6hQTSpomPDvn
         stDANzeVtZKjDC2+oW+vIVAm4TOijlSXsjw7g3Ap3qi5cDxfXMD0g36MEPWKQtcrvz6d
         QoDtNXqK/z2N84OuAnjJ4HMM/Y3f2JPZjSAwz+ATXNHPk1tGVJA7/5t6v26/pF2IKYSc
         1eYCN5Ue7eDZYsx7/w1rWC/X6PGaJB8MoX9q7cHFtoOfYKYFtA1VOz6txLcnJ3bSc+Uc
         heog==
X-Gm-Message-State: AOJu0YwkUQl1VblgPaomz7DiV/4caOhvosDhdw/lqPorsLb0ojx/V7wD
        2rFgS0RLFiniWjnIQWRK01G9XQv8wrUgJBFMWBWABguKmUXwOW0=
X-Google-Smtp-Source: AGHT+IHzCc4hgmYN0YkZhRtUyRk5tT8kr6KzAGRu3/7ofubZxXo5ZA/4LAd1UiCLhAW/h2uHKhK5NZFjMyqfa97XwVMGeUes1F/Q
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1441:b0:3b9:e69f:c0a6 with SMTP id
 x1-20020a056808144100b003b9e69fc0a6mr1364538oiv.2.1702104767250; Fri, 08 Dec
 2023 22:52:47 -0800 (PST)
Date:   Fri, 08 Dec 2023 22:52:47 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005c4ff060c0e26ca@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
@@ -911,6 +917,9 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	u32 type;
 	int rc;
 
+	if (!msg->msg_iter.count)
+		return -EINVAL;
+
 	if (msg->msg_flags & ~(MSG_DONTWAIT))
 		return -EINVAL;
 

