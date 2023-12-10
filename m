Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0780B8AA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjLJDwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJDwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:52:13 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B30EA9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 19:52:20 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9f55676a1so1724965b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 19:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702180339; x=1702785139;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxiIKH3fpOh5V5gXHwfBtJkmAVriRGHmEPZ1CY/4luE=;
        b=cJk+hKA3fS7Anti3lSltHaEqc1TpqHS0o5vGvO0XZfcIuzntXeIgzxYBx8apkJ6BKu
         uuT0Xz19jG9QJfm57xV/8vT88JUtzKu9JMT+FqX/b7ufYCfmJiGNYUkkhLWXrEf0t756
         8Cea5idrsnPU158JF94rP4jJ9qf8GEIULaSlRzdesLY65ppQREG7ibNkUFbWzgrLKLzq
         dZ1S4OZjqeLrertZR8ykuW+XhP7ncLPvjUJe4CpHglaq2Jh+5GdVQWHr+m5cbbdYiY5b
         Nn1Ozeercnqzepls9D46uPVn16h/NrMJBWkNDJJ5qieBi2nnWR7XuUoZfHrN1QuCBjgv
         TRhQ==
X-Gm-Message-State: AOJu0Yx0gxLeMPEgG63yEyVwLJ9ZM7BK8l/n3eHdH103LME3xMd11hN2
        ZCKcz9JARoBLaWpczsKjHuCDc0hUnlf38uyuHYBk6T8N+2VZGpI=
X-Google-Smtp-Source: AGHT+IFw3HYZkst+VBkSbdzQLcJ0E0mH5ubVYhuk+A9r8CbLXR+N6onISTsnGQSaCTAARkuuIbCBGcXsmZCj5WTfM+GFOVJCQfXY
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2129:b0:3b5:6432:e0ec with SMTP id
 r41-20020a056808212900b003b56432e0ecmr2593801oiw.1.1702180339393; Sat, 09 Dec
 2023 19:52:19 -0800 (PST)
Date:   Sat, 09 Dec 2023 19:52:19 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000792be0060c1fbe8a@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
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
index 41ece61eb57a..4946a14b819d 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -273,11 +273,17 @@ static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
 	if (!flow) {
 		flow = kzalloc(sizeof(*flow), GFP_KERNEL);
 		if (flow) {
+			if (radix_tree_preload(GFP_KERNEL)) {
+				mutex_unlock(&node->qrtr_tx_lock);
+				return -ENOMEM;
+			}
 			init_waitqueue_head(&flow->resume_tx);
-			if (radix_tree_insert(&node->qrtr_tx_flow, key, flow)) {
+			if (ret = radix_tree_insert(&node->qrtr_tx_flow, key, flow)) {
+				printk("r: %d\n", ret);
 				kfree(flow);
 				flow = NULL;
 			}
+			radix_tree_preload_end();
 		}
 	}
 	mutex_unlock(&node->qrtr_tx_lock);

