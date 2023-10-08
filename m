Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCCF7BD11E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjJHXRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:17:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C129D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 16:17:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812FEC433C7;
        Sun,  8 Oct 2023 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696807061;
        bh=Qf38YFgO4c1hDZg7HIwSf4GPCmPU++37t8SPdZkKpwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lz8uewtpdPzI/9WJ0j09j7waSlGej2f2QnIYcRVYAGDBn3vUEYPvX25PSiadRtpIK
         vnx7eGCteHfxnutfmVur8+tOJjXq+yYBQWEbBvLFR2l//8IKTJ93ysAxSr3b6qywJS
         m+OPNXOZzSzXH9U67HVhuD22oO0KlSj056gfpaP+aXRiHlgTlB+NgL+kv/+swfWf1W
         qsWz0vrnbbSx2VUnX+nbgwFruMwbnobOW7u+nPJVkKbksZmG/hn2hXCBOtnBOSmQge
         Vi5SB/l/t/uUZeClvEsjglbxG4qzyUBPQeOkOSDUi/IIjY4M9PrrjAQ5IK4VvqnD1B
         j1qcOzPv9+lmQ==
Date:   Mon, 9 Oct 2023 08:17:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     wuqiang <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v9 0/5] lib,kprobes: kretprobe scalability improvement
Message-Id: <20231009081734.a968a1e5c997136e1efd9acb@kernel.org>
In-Reply-To: <30892865-c92e-433e-2dba-ec6004c3d0e2@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
        <20230923175746.da3ab516a5c17c5d1897d6d6@kernel.org>
        <30892865-c92e-433e-2dba-ec6004c3d0e2@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 02:33:09 +0800
wuqiang <wuqiang.matt@bytedance.com> wrote:

> On 2023/9/23 16:57, Masami Hiramatsu (Google) wrote:
> > Hi Wuqiang,
> > 
> > I dug my mail box and found this. Sorry for replying late.
> > 
> > On Tue,  5 Sep 2023 09:52:50 +0800
> > "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> > 
> >> This patch series introduces a scalable and lockless ring-array based
> >> object pool and replaces the original freelist (a LIFO queue based on
> >> singly linked list) to improve scalability of kretprobed routines.
> >>
> >> v9:
> >>    1) objpool: raw_local_irq_save/restore added to prevent interruption
> >>
> >>       To avoid possible ABA issues, we must ensure objpool_try_add_slot
> >>       and objpool_try_add_slot are uninterruptible. If these operations
> >>       are blocked or interrupted in the middle, other cores could overrun
> >>       the same slot's ages[] of uint32, then after resuming back, the
> >>       interrupted pop() or push() could see same value of ages[], which
> >>       is a typical ABA problem though the possibility is small.
> >>
> >>       The pair of pop()/push() costs about 8.53 cpu cycles, measured
> >>       by IACA (Intel Architecture Code Analyzer). That is, on a 4Ghz
> >>       core dedicated for pop() & push(), theoretically it would only
> >>       need 8.53 seconds to overflow a 32bit value. Testings upon Intel
> >>       i7-10700 (2.90GHz) cost 71.88 seconds to overrun a 32bit integer.
> > 
> > What does this mean? This sounds like "There is a timing issue if it's enough fast".
> 
> Yes, that's why local irq must be disabled. If push()/pop() is interrupted or 
> preempted long enough (> 10 seconds for the extreme cases), other nodes could
> overrun the same ages[] of 32-bit, then after resuming to execution the push()
> or pop() would see the same value without notifying the overrun, which is a
> typical ABA.

Yeah, indeed.

> 
> Changing ages[] to 64-bit could be a solution, but it's inappropriate for
> 32-bit OS and looks too heavy. With local irg disabled, push() or pop() is
> uninterrupted，thus the ABA is avoided.

As I found, ages[] can be removed. In that case, you can only update the
head and tail to 64 bit (but in that case cmpxchg will be more complicated)

Thank you,

> 
> push() or pop() consumes only ~4 cycles to complete (most of the use cases), 
> so raw_local_irq_save/restore are used instead of local_irq_save/restore to
> minimize the overhead.
> 
> > Let me reivew the patch itself.
> > 
> > Thanks,
> > 
> >>
> >>    2) codes improvements: thanks to Masami for the thorough inspection
> >>
> >> v8:
> >>    1) objpool: refcount added for objpool lifecycle management
> >>
> >> wuqiang.matt (5):
> >>    lib: objpool added: ring-array based lockless MPMC
> >>    lib: objpool test module added
> >>    kprobes: kretprobe scalability improvement with objpool
> >>    kprobes: freelist.h removed
> >>    MAINTAINERS: objpool added
> >>
> >>   MAINTAINERS              |   7 +
> >>   include/linux/freelist.h | 129 --------
> >>   include/linux/kprobes.h  |  11 +-
> >>   include/linux/objpool.h  | 174 ++++++++++
> >>   include/linux/rethook.h  |  16 +-
> >>   kernel/kprobes.c         |  93 +++---
> >>   kernel/trace/fprobe.c    |  32 +-
> >>   kernel/trace/rethook.c   |  90 +++--
> >>   lib/Kconfig.debug        |  11 +
> >>   lib/Makefile             |   4 +-
> >>   lib/objpool.c            | 338 +++++++++++++++++++
> >>   lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
> >>   12 files changed, 1320 insertions(+), 274 deletions(-)
> >>   delete mode 100644 include/linux/freelist.h
> >>   create mode 100644 include/linux/objpool.h
> >>   create mode 100644 lib/objpool.c
> >>   create mode 100644 lib/test_objpool.c
> >>
> >> -- 
> >> 2.40.1
> >>
> > 
> > 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
