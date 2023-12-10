Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83BD80B8F2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjLJFO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 00:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJFOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 00:14:24 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523F10A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 21:14:31 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59077a760d7so3595235eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 21:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702185270; x=1702790070;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8JVAn+vbFktNFt7tOFoDEiuegHhU/cJ407wE36XT7g=;
        b=tadCgHDfVZ0tAc923IFiEcRbwMYMb6vq9F1oKnE+bwQxrzE01IRMDup2TXrN5UEtQC
         IPrBsSMdM/1TrgN8Ty7uOVBZFBkXJEaNX44afAfFaGwrXv8os09M/5WLDDeAAj/TLU3h
         VuEg6PtsVe1rqVaBT3pgIjqVzWtQNLlOuLCcPPU7uFLTAfNLwfDAif1cn1Hq0ONVMqGH
         +CRUZiARS4I77QX9ZvvrUEEVtZeG1uAa8pUNvOSwRP2tMJ2Y689eXcLpUWN+eYAi5QqO
         qZ3FJSFiB0wyCNBNyYWwylNK3kXDSQMgC9RthD9rOXdqd4T9ePaeHPa0bnt5dJBeOAjl
         I1AA==
X-Gm-Message-State: AOJu0YyLzbwSQulf2VCnVWTO+wVgMHgbJF/0X1oHa+8YYE4tCahOYOIS
        rwFHAe0T87XCQQSLTUjPHrgoNI1oBFLl06kIw5B/6ueqgZE1RAI=
X-Google-Smtp-Source: AGHT+IHmeIflZuSJ9dn8U4LuSv+78Fh56kIdeBjooVgPUM13KI6UhVZHNgtVWt5kW4odXfxCrPa0JLZlHlq4ZFBc/1N26/eZDF7x
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2225:b0:3b9:e8d0:6de5 with SMTP id
 bd37-20020a056808222500b003b9e8d06de5mr2521420oib.2.1702185270499; Sat, 09
 Dec 2023 21:14:30 -0800 (PST)
Date:   Sat, 09 Dec 2023 21:14:30 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063e0d3060c20e4ce@google.com>
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
index 41ece61eb57a..3615a9f35bbb 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -267,6 +267,9 @@ static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
 	/* Never set confirm_rx on non-data packets */
 	if (type != QRTR_TYPE_DATA)
 		return 0;
+	printk("dn: %d, dp: %d, %s\n", dest_node, dest_port, type, __func__);
+	if (dest_node < 0)
+		return -EINVAL;
 
 	mutex_lock(&node->qrtr_tx_lock);
 	flow = radix_tree_lookup(&node->qrtr_tx_flow, key);

