Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2774D801A24
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjLBCy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:54:26 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B213FD4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:54:32 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b88c1f5ecaso1342799b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 18:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701485672; x=1702090472;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HQfyyLQgiVMocyXxgPBbUQnxc/KUPh6dUwMZ5FwIiA=;
        b=Cf+jbq0aG1ATEQ1f5QcHSIV081wDgpwVFuJm91a8K5SziDLP44V84LuICwcvfXElgG
         0m/cfLJ/P4bs4PmB5lTFzAh4ELbY4hFAx6B0hwGL45eYJCQu6Ijkf7nap73g46/joNWX
         94G6m/z4sLrVja+0PIBiI2YFVNIGVSE5PnT2hjtL+ixjMzcsijIlUjyPHXkAmFB18czL
         +eqXeeLxKjLoG5auiWZZ4Mnf1+00kc0RLioebYHPTgaXntzCqtD81ZJjgfBchm1fPkhh
         THBRWxXWrNuEDZ5fyCIO/WjqP8X0OaJRA4WYqMcIqdc4FKdna0g4hzG69h89eeEojf8h
         K9gQ==
X-Gm-Message-State: AOJu0Yx5PEiR6ZeRLO83citpX2x3IJYj3n9oanXP73gP4i77kwVhEtg3
        sy/jhHfMg6f8J2IB9c+QP/cB+cfwt4jU7/byiCPdhzIN7XcGPAU=
X-Google-Smtp-Source: AGHT+IEWIP/pk2sDPPFYOeV+UuI82UFtK3/QRlUyO3lZqd/YuobkIxWMCDpnGk35s2XYSbxI7DxraYvPXN3l5Tnoz7NVnh1D523Q
MIME-Version: 1.0
X-Received: by 2002:a05:6808:178e:b0:3b8:94f5:9158 with SMTP id
 bg14-20020a056808178e00b003b894f59158mr230510oib.10.1701485672199; Fri, 01
 Dec 2023 18:54:32 -0800 (PST)
Date:   Fri, 01 Dec 2023 18:54:32 -0800
In-Reply-To: <00000000000047eb7e060b652d9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014fd00060b7e01f7@google.com>
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
index 54ade89a1ad2..34e5bce42b1e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -735,7 +735,8 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	mutex_lock(&q->debugfs_mutex);
+	if (!mutex_trylock(&q->debugfs_mutex))
+		return -EBUSY;
 
 	switch (cmd) {
 	case BLKTRACESETUP:

