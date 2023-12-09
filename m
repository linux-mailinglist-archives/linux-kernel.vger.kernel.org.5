Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E880B20B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 05:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjLIEke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 23:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIEkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 23:40:32 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ABE1AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 20:40:36 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9e506f794so2930489b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 20:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702096835; x=1702701635;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5QeCnGqe5EXJ49xvLLJRk2S6ILUwbU1B105Q0H0/5k=;
        b=pYB1aXDtuBBXj3T7Wpb7V4oLynCUpfBMH+g/7Gv5yAYI3C01VbGcM2b8oHRe+BLr6t
         /fGHQIV/vf8PGTJ2Ew+wlIkshUY0lu9jlkd8CvYahEDofHw6hUOAGxqA4RTD/y++hOuj
         pGFt+ajs8uqwZQMvvLBINSKk5bFoNHl2CriGO2w9sN6Za9umIwB8jFAck8/N/qJeaR7B
         VwGBDAkrArNKMOlufxvfe9RqhwCW/huUIaHBvYMXCW/8BkFQfw7fmRv1FXL+BBoPWdSc
         VJCr5STK9HqxcPIaQzapCfCYiJhbV+jheAeG7fz+WsHLP8//4jDO+KNmgDar5yTwbQZn
         hPCA==
X-Gm-Message-State: AOJu0YxiWumupzucmjQKgieN74gO+g0hL3gYZRx3lSF3aLPHB++ttF+f
        gdUuuuMQv0KchzZ/rS2adDmWEescTTbJ/Ew7UVI1sTQX5xiza1s=
X-Google-Smtp-Source: AGHT+IFVb40pUfYC3Les1xqK1P/wnbItAS8tyn1dZEhm0nbImww5VJjxVyKflKaWQio4WBk181STDJznXSU9aQ5A1xtpo6XhI5zq
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1597:b0:3b8:93b3:ea9e with SMTP id
 t23-20020a056808159700b003b893b3ea9emr1041694oiw.9.1702096835879; Fri, 08 Dec
 2023 20:40:35 -0800 (PST)
Date:   Fri, 08 Dec 2023 20:40:35 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046a8a3060c0c4d2c@google.com>
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
index 41ece61eb57a..f08f7ba7d2b1 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -911,6 +911,9 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	u32 type;
 	int rc;
 
+	if (!msg->msg_iter.count)
+		return -EINVAL;
+
 	if (msg->msg_flags & ~(MSG_DONTWAIT))
 		return -EINVAL;
 

