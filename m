Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B78019B6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjLBBZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:25:01 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A428116
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 17:25:07 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58db2015327so2810940eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 17:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701480306; x=1702085106;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+idYJvm7kZteexJ00hgZc6UHQFg380Sn+VulJa8JKk=;
        b=WWwkZgt438D6vWvSGBpyHYpXA7yogBaby4yTAtoF9ZSdOpuzYQR25KjsSZW/6hEW9A
         wTXJIIO6j/91Y8aId+U/W28UzFIaEhbGjUUAKt/CvycFxRD/+szFXeEuYNEJqHFGO+3a
         CSKZUJcRnePM4DHrRZWtWyWhjhQnI3WN6RcojLQ2DaRIWiv2Y6eKA3ZUwPaFaBg6dUTX
         3OEjFtL4/EJHfz6gft4SxXE/BQF0zyx244h7z04F3ojUFMXnctfQ5ZR7+pLYThhtlg8L
         sP6Xz5rKTHIK4yDbMuTtwN/vsj3Jn0JprTi4ozWEI94GL8ffgyaQyJnkGOY2kpa0GbyX
         7URg==
X-Gm-Message-State: AOJu0YyX+l2iOzE1Q6J6NUFqHmzvO0kSrTbVseNfVTFfIsl6caAI5YkP
        vBeFU8uN2I+xRbKKS+SibiV2+S4BoITfMt+c67+rhMd0tICu8/k=
X-Google-Smtp-Source: AGHT+IGJhv9ra6Hwt99yUzhmf++Ga0vW0bn8f2Er/VcZmJKP/r5OB94dRcjP8PDdk5GtMdc15Vce/Nq5wbAW6LHIdAJ9wzkow6or
MIME-Version: 1.0
X-Received: by 2002:a05:6820:175:b0:58a:12d8:dbce with SMTP id
 k21-20020a056820017500b0058a12d8dbcemr384568ood.0.1701480306441; Fri, 01 Dec
 2023 17:25:06 -0800 (PST)
Date:   Fri, 01 Dec 2023 17:25:06 -0800
In-Reply-To: <00000000000047eb7e060b652d9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000420309060b7cc1bd@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl
From:   syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
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

Subject: [block?] [trace?] INFO: task hung in blk_trace_ioctl
Author: eadavis@qq.com

please test task hung in blk_trace_ioctl

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 8c9660f65153

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510af..54ade89a1a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -588,8 +588,10 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	debugfs_create_file("dropped", 0444, dir, bt, &blk_dropped_fops);
 	debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
 
+	mutex_unlock(&q->debugfs_mutex);
 	bt->rchan = relay_open("trace", dir, buts->buf_size,
 				buts->buf_nr, &blk_relay_callbacks, bt);
+	mutex_lock(&q->debugfs_mutex);
 	if (!bt->rchan)
 		goto err;
 

