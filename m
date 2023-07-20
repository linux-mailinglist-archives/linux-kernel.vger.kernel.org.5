Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4675BA67
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGTWTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGTWTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:19:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99716E47
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:19:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-682a5465e9eso264715b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689891547; x=1690496347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVlmD6Cai8xXy17J6HGSSxnEYFsK5TVR9Bij+nhELSU=;
        b=pNFvIZNJ/OuFuPT10N5T/mocD8A11gY/PpEHIx816IC3XkWam1P85Yvn9F3Adaftrc
         opViTWT/iuQyIHW2VHMRAjPr+XAFSy3MTPYdr8YRcoddzbrdYNQrQ/pLnAeWWd5vB067
         7PT/m23rpRxRJ9hk9U5zkbtmMXErlJo+r9DgPllJ55Q7AVmCkxS7lk/RbiPa2YvisgTs
         Mjq3JJX62SslZ2FSQ9XYcY9iz7fJL8Q6Qcj9Xt4KVd3rN13GYp72vldPuSQpGtie85+Z
         9zKvCHRsBf6MY8hyMWp5DAkEGM59+hHBXot+YFbhF5mAdWWYlfRhaP6CimCYf6RwNhLd
         ua5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891547; x=1690496347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVlmD6Cai8xXy17J6HGSSxnEYFsK5TVR9Bij+nhELSU=;
        b=JQi1Kr+oZ6pChhh4ongiCjfZ2aPyPLNQtfGTnm1doKWrlKpS7l1eib5xN9sAohZSl7
         Njpyi7XYVjA9mApNI+I6+HWa/eDYOXs8vsHGJ90GW+Odqax9N26+J0SdBmuX6ZpvyoaF
         EwgkLObrvZeOLXVpM8A0prGgR1YhEH53sxf0SXStmNW9jZa1ONy4/j4dSSSwiuX22AKW
         2fRNP9+2v2cPAq+SZMDijWBXk3v12yzlqQJQ8nZ7Atrz1vXPp5znUPQRmjfQ3VRN+drn
         XekAIL4Uc6Q1BVvR043DT7itYbxMt5pxd64SSn3IUHATiKcPV53Ji22DVvUHISdlUyy/
         4GMw==
X-Gm-Message-State: ABy/qLYqhiToHfDK+NLwfa6BENkTGWQEqHFwDemdZzu1lkbpCSkyetVm
        8dt3Bac7O3fwlkTnUV6Y/AwkzA==
X-Google-Smtp-Source: APBJJlHqQfcorMZnQT72lvQSVFT9t0airkDf7aV143YsSWf4j0Ke590qicZfl3jXtZgvsg5vFzurjA==
X-Received: by 2002:a05:6a20:42a8:b0:123:3ec2:360d with SMTP id o40-20020a056a2042a800b001233ec2360dmr204852pzj.5.1689891546782;
        Thu, 20 Jul 2023 15:19:06 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q1-20020a63bc01000000b0055b3af821d5sm1762454pge.25.2023.07.20.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:19:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, andres@anarazel.de
Subject: [PATCHSET v3 0/10] Add io_uring futex/futexv support
Date:   Thu, 20 Jul 2023 16:18:48 -0600
Message-Id: <20230720221858.135240-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds support for first futex wake and wait, and then
futexv.

For both wait/wake/waitv, we support the bitset variant, as the
"normal" variants can be easily implemented on top of that.

PI and requeue are not supported through io_uring, just the above
mentioned parts. This may change in the future, but in the spirit
of keeping this small (and based on what people have been asking for),
this is what we currently have.

When I did these patches, I forgot that Pavel had previously posted a
futex variant for io_uring. The major thing that had been holding me
back from people asking about futexes and io_uring, is that I wanted
to do this what I consider the right way - no usage of io-wq or thread
offload, an actually async implementation that is efficient to use
and don't rely on a blocking thread for futex wait/waitv. This is what
this patchset attempts to do, while being minimally invasive on the
futex side. I believe the diffstat reflects that.

As far as I can recall, the first request for futex support with
io_uring came from Andres Freund, working on postgres. His aio rework
of postgres was one of the early adopters of io_uring, and futex
support was a natural extension for that. This is relevant from both
a usability point of view, as well as for effiency and performance.
In Andres's words, for the former:

"Futex wait support in io_uring makes it a lot easier to avoid deadlocks
in concurrent programs that have their own buffer pool: Obviously pages in
the application buffer pool have to be locked during IO. If the initiator
of IO A needs to wait for a held lock B, the holder of lock B might wait
for the IO A to complete.  The ability to wait for a lock and IO
completions at the same time provides an efficient way to avoid such
deadlocks."

and in terms of effiency, even without unlocking the full potential yet,
Andres says:

"Futex wake support in io_uring is useful because it allows for more
efficient directed wakeups.  For some "locks" postgres has queues
implemented in userspace, with wakeup logic that cannot easily be
implemented with FUTEX_WAKE_BITSET on a single "futex word" (imagine
waiting for journal flushes to have completed up to a certain point). Thus
a "lock release" sometimes need to wake up many processes in a row.  A
quick-and-dirty conversion to doing these wakeups via io_uring lead to a
3% throughput increase, with 12% fewer context switches, albeit in a
fairly extreme workload."

Some basic io_uring futex support and test cases are available in the
liburing 'futex' branch:

https://git.kernel.dk/cgit/liburing/log/?h=futex

testing all of the variants. I originally wrote this code about a
month ago and Andres has been using it with postgres, and I'm not
aware of any bugs in it. That's not to say it's perfect, obviously,
and I welcome some feedback so we can move this forward and hash out
any potential issues.

 include/linux/io_uring_types.h |   3 +
 include/uapi/linux/futex.h     |  17 +-
 include/uapi/linux/io_uring.h  |   4 +
 io_uring/Makefile              |   4 +-
 io_uring/cancel.c              |   5 +
 io_uring/cancel.h              |   4 +
 io_uring/futex.c               | 364 +++++++++++++++++++++++++++++++++
 io_uring/futex.h               |  36 ++++
 io_uring/io_uring.c            |   5 +
 io_uring/opdef.c               |  35 +++-
 kernel/futex/futex.h           |  64 +++++-
 kernel/futex/requeue.c         |   3 +-
 kernel/futex/syscalls.c        |  42 ++--
 kernel/futex/waitwake.c        |  53 +++--
 14 files changed, 593 insertions(+), 46 deletions(-)

You can also find the code here:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-futex

V3:
- Rebase on top of Peter's futex flag patches
- Move to using FUTEX2 flags

-- 
Jens Axboe


