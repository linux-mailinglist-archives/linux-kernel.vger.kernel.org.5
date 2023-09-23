Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8057ABF0F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjIWI6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIWI57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:57:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC34196
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:57:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC8C433C8;
        Sat, 23 Sep 2023 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459472;
        bh=B5iJK8d6K4hWUoky1Er/Avif20xo+seTHte0YQPQhEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XujPLn2psJEGWQtIsNS1J7Oi5htuRC+mCdPf43HFye5Mg1FjNoldDrRh0VFSy0ERe
         iXvHRC8XzLjNi5iRfuocQwqCzymOSiuTN+8A44axl1JeFn5/2HeVhAuu/Pc7G143ZJ
         nk6EKBFyE25snL1OEDEYgWbxVmxGgc5oOo6hUYFxrcWtzhMrKSmpoXZoLy5w/biopx
         FfnUMAwsUIsRlzQGM0rbYHLR3u6UpigGWPe6/omjlYP69OAzSo4qjqirSgbI9WvRm0
         8CzqPBBRt7kFgmceWQxTqsWSzwmoe9DQm6nHwDhXNc6Q+a/t1gCsBjZPj7oCSh6fxD
         CIxDlQ+x6uIKQ==
Date:   Sat, 23 Sep 2023 17:57:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v9 0/5] lib,kprobes: kretprobe scalability improvement
Message-Id: <20230923175746.da3ab516a5c17c5d1897d6d6@kernel.org>
In-Reply-To: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wuqiang,

I dug my mail box and found this. Sorry for replying late.

On Tue,  5 Sep 2023 09:52:50 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> This patch series introduces a scalable and lockless ring-array based
> object pool and replaces the original freelist (a LIFO queue based on
> singly linked list) to improve scalability of kretprobed routines.
> 
> v9:
>   1) objpool: raw_local_irq_save/restore added to prevent interruption
> 
>      To avoid possible ABA issues, we must ensure objpool_try_add_slot
>      and objpool_try_add_slot are uninterruptible. If these operations
>      are blocked or interrupted in the middle, other cores could overrun
>      the same slot's ages[] of uint32, then after resuming back, the
>      interrupted pop() or push() could see same value of ages[], which
>      is a typical ABA problem though the possibility is small.
> 
>      The pair of pop()/push() costs about 8.53 cpu cycles, measured
>      by IACA (Intel Architecture Code Analyzer). That is, on a 4Ghz
>      core dedicated for pop() & push(), theoretically it would only
>      need 8.53 seconds to overflow a 32bit value. Testings upon Intel
>      i7-10700 (2.90GHz) cost 71.88 seconds to overrun a 32bit integer.

What does this mean? This sounds like "There is a timing issue if it's enough fast".

Let me reivew the patch itself.

Thanks,

> 
>   2) codes improvements: thanks to Masami for the thorough inspection
> 
> v8:
>   1) objpool: refcount added for objpool lifecycle management
> 
> wuqiang.matt (5):
>   lib: objpool added: ring-array based lockless MPMC
>   lib: objpool test module added
>   kprobes: kretprobe scalability improvement with objpool
>   kprobes: freelist.h removed
>   MAINTAINERS: objpool added
> 
>  MAINTAINERS              |   7 +
>  include/linux/freelist.h | 129 --------
>  include/linux/kprobes.h  |  11 +-
>  include/linux/objpool.h  | 174 ++++++++++
>  include/linux/rethook.h  |  16 +-
>  kernel/kprobes.c         |  93 +++---
>  kernel/trace/fprobe.c    |  32 +-
>  kernel/trace/rethook.c   |  90 +++--
>  lib/Kconfig.debug        |  11 +
>  lib/Makefile             |   4 +-
>  lib/objpool.c            | 338 +++++++++++++++++++
>  lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
>  12 files changed, 1320 insertions(+), 274 deletions(-)
>  delete mode 100644 include/linux/freelist.h
>  create mode 100644 include/linux/objpool.h
>  create mode 100644 lib/objpool.c
>  create mode 100644 lib/test_objpool.c
> 
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
