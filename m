Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24727F3AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjKVATL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKVATJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:19:09 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00BA9D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:19:06 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28513eccb01so325643a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700612346; x=1701217146;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UN0RV/dxSvp2k4Odllrd9UgohuWC+yGLlZdD/8NYF0s=;
        b=ZFpLkqv8HgQjj3Ti73MQRgUCtBzafWarDwfJohwns23V45Y8Ur1cZzbt2m3AXk2DgR
         TfJ7eovO/pooY8i6NvVcA7vmVKh/u5NGERPd5MDMqcP6FBDID/Z2Gle6WNetKxb/++NS
         c1IPBd8LjP6yPysfsOVxPu8iMMX5tOcdkmMYkkBADKw9Tlen2kiUx9RxeJmloOL9yk+T
         Xatx4Cf9izz7/kfEOY67n1J+5tvc+fcUHPCzv414Ja/sD4X2+ggrypmRlP8loY7Dz5R1
         eNgnT+FpfuK589qo+Uj3AaEby/HzP/nA/1GyZUzTCBOBRJozaPjpp7+95rZgMmtRcHum
         Bbqw==
X-Gm-Message-State: AOJu0YygYPpZNewAY0kSr3tZvc78/ZhF761aKRQjK1vJObWIk/Pt3zvd
        Hr5CLOih7zfEbKBHFPOwe/2gO1AqEJjyG6XDDub37Mux3UAdAhs=
X-Google-Smtp-Source: AGHT+IErALHmhDrZc0GXaStJgR3taS880cBEEjDs+wk31ph41r8k5pNOpZwSaAD2aNCFfzO4swaW3prmselEPvvGpmhZOhSSPZiT
MIME-Version: 1.0
X-Received: by 2002:a17:90a:6545:b0:27d:1bd8:de69 with SMTP id
 f5-20020a17090a654500b0027d1bd8de69mr267238pjs.1.1700612346262; Tue, 21 Nov
 2023 16:19:06 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:19:06 -0800
In-Reply-To: <0000000000004b6de5060ab1545b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccbc6c060ab2aa42@google.com>
Subject: Re: [syzbot] [syzbot] [bpf?] [trace?] WARNING in format_decode (3)
From:   syzbot <syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [bpf?] [trace?] WARNING in format_decode (3)
Author: eadavis@qq.com

please test unsupported %? in format string

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git 76df934c6d5f
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c9fdcc5cdce1..78258a822a5c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -845,6 +845,9 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 {
 	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
 
+	if (!skb->len)
+		return -EINVAL;
+
 	if (!__skb)
 		return 0;
 

