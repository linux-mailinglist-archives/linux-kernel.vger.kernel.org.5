Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A598019F1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjLBCOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjLBCOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:14:41 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BDD48
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:14:47 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b8b0fb63cbso256603b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 18:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701483287; x=1702088087;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hul+Elo9f6B4+TplkMlf+ft8nPG5pNQ1JFIjGrSDHVw=;
        b=njydJuVE8P/a7QgIwMS4YRl6B6qkLzBTSa4znKcYBdxjOLpaVekZSMDZTXcGXgkStq
         LfTwh7ywGhx+CB1myGpykO9ji7bw1wSSdBm03ejG0PLi/8RnE5kQIxRfnVzqI1TmJkP9
         aHEe9/wKBCtfjsYHGDfo/7CYHV6nEqejvXpyA7mtnnbiftTDkJD9vR6po/QW04BTLFga
         L1np+l9v2eHSTP5o8guafTllB3R+0YQxlP1ijCsVjBMfx8cmaY1w+LOD0Y6z7lwwZidF
         6uZI48OLk2SWa7Tb0trmzMWWQVO/DEaLnstqNJnl8ujCKDfMYoGxgb0ttXunWsmH2oRj
         7cdQ==
X-Gm-Message-State: AOJu0YwolEc3UsfSreUGq+wcg0QWgvZ0SE53SoZG4a9sJAVsQMuu3MLu
        i2eS5rNQzRdtmjN4m93L6Y06p5BpLRen7qT6FqkiQ78vMVzpwfw=
X-Google-Smtp-Source: AGHT+IEcfiDrGCUuZRICRlKd+13SPobNyMwX7vNTqjpeDaHuaR9ZoMyObWbE0Wkn+0jukL884mm9hmRL5PEbDH9jxBfrOauGeJ0L
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc4:b0:3b8:8f2e:5ef0 with SMTP id
 o4-20020a0568080bc400b003b88f2e5ef0mr227520oik.8.1701483286973; Fri, 01 Dec
 2023 18:14:46 -0800 (PST)
Date:   Fri, 01 Dec 2023 18:14:46 -0800
In-Reply-To: <00000000000047eb7e060b652d9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e952ff060b7d724d@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl
From:   syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
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

Subject: [block?] [trace?] INFO: task hung in blk_trace_ioctl
Author: eadavis@qq.com

please test task hung in blk_trace_ioctl

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 8c9660f65153


diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 54ade89a1ad2..a1b341722693 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -735,7 +735,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	mutex_lock(&q->debugfs_mutex);
+	if (cmd == BLKTRACESETUP)
+		mutex_lock_nested(&q->debugfs_mutex, 0);
+	else
+		mutex_lock_nested(&q->debugfs_mutex, 1);
 
 	switch (cmd) {
 	case BLKTRACESETUP:

