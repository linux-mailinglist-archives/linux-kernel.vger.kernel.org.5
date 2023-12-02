Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA33801A1E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjLBCo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:44:26 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2DAE6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:44:32 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d8755daf0fso265858a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 18:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701485072; x=1702089872;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8VsQd2odPhELMIVrd9xtcS8mJ60nf1olqzHfv0Kv38=;
        b=rrUS4oz0MrDs7U5BC5QKHSrjztR/pCM7JQnfhD1vmdvu6ZvY3NywtkoNACymwAK4Ov
         zM5qjZT2gke3oNcIWPem24qCUEvOl4+Gw6l3MPZxWnARBUm/fQC/Fswiuw4NGYlj41D6
         M7f+Pi5fiQ4ZNiroZPR/VIrMiPGissb6cH+DQUEcCTz9GbH3Jid/Fbz9u4yk9r92CaMd
         5gaPItkK7JZK52THnCh3LpB9aTQQS2ibPevqh98xuvw70Or3YJ6CLwy05T6bhPLbqD+M
         bSp6llIAgKyKOTipvUpWxj5aT2IYu2lBbEl6YX6AN0Kwi0ykQHHuxmEScaXFzq8ej0AY
         9tyw==
X-Gm-Message-State: AOJu0Yz9DOw9IWHdWs00jCNJIHMR6Tu8nkmQpRYciETeSaexAsWVMpnj
        dHOMmDDCFfbSJUbECyKUJNKLRWDTgzn9UzTcqfa4DUtOM4IM5sU=
X-Google-Smtp-Source: AGHT+IHHF+3dX5oUR8dmH1WO539o1uCdmlSNSwscgHONbdcBMO8ZD6cPCf7sLj8sOFEZl5qI5aIa7lV6JD1eMxFjmmfgvFLGjMtB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0c:b0:3ad:f525:52bf with SMTP id
 bk12-20020a0568081a0c00b003adf52552bfmr248132oib.1.1701485072031; Fri, 01 Dec
 2023 18:44:32 -0800 (PST)
Date:   Fri, 01 Dec 2023 18:44:31 -0800
In-Reply-To: <00000000000047eb7e060b652d9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f26a8060b7ddda2@google.com>
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
index 54ade89a1ad2..f5d3576ef3ed 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -735,7 +735,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	mutex_lock(&q->debugfs_mutex);
+	if (cmd == BLKTRACESETUP)
+		mutex_lock(&q->debugfs_mutex);
+	else
+		mutex_lock_nested(&q->debugfs_mutex, 2);
 
 	switch (cmd) {
 	case BLKTRACESETUP:

