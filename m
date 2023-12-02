Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF6801EF4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjLBWHn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Dec 2023 17:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:07:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528BF119
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:07:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFD1C433C9;
        Sat,  2 Dec 2023 22:07:45 +0000 (UTC)
Date:   Sat, 2 Dec 2023 17:07:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, axboe@kernel.dk, dvyukov@google.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        pengfei.xu@intel.com, syzkaller-bugs@googlegroups.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH next] trace/blktrace: fix task hung in blk_trace_ioctl
Message-ID: <20231202170743.7557e7b5@rorschach.local.home>
In-Reply-To: <5116cbb4-2c85-2459-5499-56c95bb42d16@huaweicloud.com>
References: <00000000000047eb7e060b652d9a@google.com>
        <tencent_6537E04AAC74F976B567603CEB377A96FA09@qq.com>
        <5116cbb4-2c85-2459-5499-56c95bb42d16@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2023 17:19:25 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
> 
> 在 2023/12/02 17:01, Edward Adam Davis 写道:
> > The reproducer involves running test programs on multiple processors separately,
> > in order to enter blkdev_ioctl() and ultimately reach blk_trace_ioctl() through
> > two different paths, triggering an AA deadlock.
> > 
> > 	CPU0						CPU1
> > 	---						---
> > 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> > 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> > 
> > 
> > The first path:
> > blkdev_ioctl()->
> > 	blk_trace_ioctl()->
> > 		mutex_lock(&q->debugfs_mutex)
> > 
> > The second path:
> > blkdev_ioctl()->				
> > 	blkdev_common_ioctl()->
> > 		blk_trace_ioctl()->
> > 			mutex_lock(&q->debugfs_mutex)  
> I still don't understand how this AA deadlock is triggered, does the
> 'debugfs_mutex' already held before calling blk_trace_ioctl()?

Right, I don't see where the mutex is taken twice. You don't need two
paths for an AA lock, you only need one.

> 
> > 
> > The solution I have proposed is to exit blk_trace_ioctl() to avoid AA locks if
> > a task has already obtained debugfs_mutex.
> > 
> > Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")

How does it fix the above? I don't see how the above is even related to this.

-- Steve

> > Reported-and-tested-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >   kernel/trace/blktrace.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
