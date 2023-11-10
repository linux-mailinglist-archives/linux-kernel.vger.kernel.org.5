Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAC07E7F64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjKJRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjKJRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:44 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178252B7A8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:07:31 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28001f80712so1805857a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699614451; x=1700219251;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9H5dVWUDiaoGHrAuGgBz7tZ/b3G3ogVvTmA+Sa5YyQ=;
        b=cdnSYdtaBMnY4kgixzTvwYBPkpD5c4VZUSF8kgGRZP1KD358wNZh/G0a5VS8F+xXNY
         D8gkPgc/KUgtIkyy0CkeemEpNzpYTk8whTzWipacZP/GOsPJ6T1uKInMPDwIGcbBkhFb
         TIZ3p9y5Bqzup1KfalgPMk4cuxwqzejthwN/P+Q+/Ebh4srJEzVTRnOWpZjMzAs4gh+5
         xP+8sj7g9cWMPmFEXTg/h4ysQ8Gr3nlVgYNMYSz1GtRlGs9eVaMdYVzSfcGm5F6QMsyW
         n9QU9syvjVn7lQoay8CmAZLQ4+ArizFrF/R+O3kJ/gQtNs3gF4R1ySY+mtUyLEZVHiV/
         HwfQ==
X-Gm-Message-State: AOJu0YzmdpchnBOtV4rALJjuTNEoMIo7KT3bYQDR3CNICT6xlzyeEXH7
        8HUa9rEtXg5mTjO/KWQltNl4+0xQo/owY6kNiRp1MJev1uLc664=
X-Google-Smtp-Source: AGHT+IFlUyOyR/xRIdkppwE772LJ+pukm6vVdzOiXw/scdKo8NlSb6wRsGQSC2YPgzpTiPo67cD4IfpfzixXe71999eQZDAmNoQO
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d311:b0:281:ae8:2af6 with SMTP id
 p17-20020a17090ad31100b002810ae82af6mr1067642pju.7.1699614451400; Fri, 10 Nov
 2023 03:07:31 -0800 (PST)
Date:   Fri, 10 Nov 2023 03:07:31 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1840c0609ca5330@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
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

Subject: [PATCH] test 305230142ae0
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 305230142ae0

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 752acff2c734..21cf7a7f18ab 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3799,6 +3799,11 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
+	if (sa->create && sa->qgroupid == BTRFS_FIRST_FREE_OBJECTID) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
