Return-Path: <linux-kernel+bounces-98737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2133E877E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0108B219AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11250383B5;
	Mon, 11 Mar 2024 11:02:36 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08E36AEF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154955; cv=none; b=VZ6fz4Eh4gXGgRsjF5CFysOz7U3rSuI61y0pZvfY6oSYcwp2ocVTCFC32+MmRxJuFOhAOTOSKj/lhTKcFaE2bkycAocP2dZoIwOHoyAIlIDRSit64USIPt0Kmo0NDb3igIlksdfe8WKdyXi8rJezoPET/tUbTw/WuYYhrluopjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154955; c=relaxed/simple;
	bh=0A0K4y5XOT6do6vzcN1PPIM8k6P516zwvH5G2Cqm7nM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thrkI6N1xmwiQIJaB9Hg03W3altl0jB3i2hiLrqEQWMIWcyb7Io5F87ihLDdIAgKFXAtyDZHWQTcACQ5x7Hp3KvNaw7nKstkAVUM7Weui58vS8Wt0v+WkQRS6H4Y6Z6axW+n5SZJ1bsByKolv5OMnZPC9W8nEV3/80aB8tPtbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TtYhm5LwNz1Q9Ws;
	Mon, 11 Mar 2024 19:00:24 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 0484414040F;
	Mon, 11 Mar 2024 19:02:29 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100011.china.huawei.com
 (7.221.188.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 11 Mar
 2024 19:02:28 +0800
Date: Mon, 11 Mar 2024 19:02:23 +0800
From: Changbin Du <changbin.du@huawei.com>
To: <elver@google.com>, Changbin Du <changbin.du@huawei.com>
CC: Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, <kasan-dev@googlegroups.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] kmsan: instrumentation recursion problems
Message-ID: <20240311110223.nzsplk6a6lzxmzqi@M910t>
References: <20240308043448.masllzeqwht45d4j@M910t>
 <CANpmjNOc4Z6Qy_L3pjuW84BOxoiqXgLC1tWbJuZwRUZqs2ioMA@mail.gmail.com>
 <20240311093036.44txy57hvhevybsu@M910t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311093036.44txy57hvhevybsu@M910t>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100011.china.huawei.com (7.221.188.204)

On Mon, Mar 11, 2024 at 05:30:36PM +0800, Changbin Du wrote:
> On Fri, Mar 08, 2024 at 10:39:15AM +0100, Marco Elver wrote:
> > On Fri, 8 Mar 2024 at 05:36, 'Changbin Du' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > >
> > > Hey, folks,
> > > I found two instrumentation recursion issues on mainline kernel.
> > >
> > > 1. recur on preempt count.
> > > __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> preempt_disable() -> __msan_metadata_ptr_for_load_4()
> > >
> > > 2. recur in lockdep and rcu
> > > __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() -> pfn_valid() -> rcu_read_lock_sched() -> lock_acquire() -> rcu_is_watching() -> __msan_metadata_ptr_for_load_8()
> > >
> > >
> > > Here is an unofficial fix, I don't know if it will generate false reports.
> > >
> > > $ git show
> > > commit 7f0120b621c1cbb667822b0f7eb89f3c25868509 (HEAD -> master)
> > > Author: Changbin Du <changbin.du@huawei.com>
> > > Date:   Fri Mar 8 20:21:48 2024 +0800
> > >
> > >     kmsan: fix instrumentation recursions
> > >
> > >     Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > >
> > > diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> > > index 0db4093d17b8..ea925731fa40 100644
> > > --- a/kernel/locking/Makefile
> > > +++ b/kernel/locking/Makefile
> > > @@ -7,6 +7,7 @@ obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
> > >
> > >  # Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
> > >  KCSAN_SANITIZE_lockdep.o := n
> > > +KMSAN_SANITIZE_lockdep.o := n
> > 
> > This does not result in false positives?
> >
This does result lots of false positives.

> I saw a lot of reports but seems not related to this.
> 
> [    2.742743][    T0] BUG: KMSAN: uninit-value in unwind_next_frame+0x3729/0x48a0
> [    2.744404][    T0]  unwind_next_frame+0x3729/0x48a0
> [    2.745623][    T0]  arch_stack_walk+0x1d9/0x2a0
> [    2.746838][    T0]  stack_trace_save+0xb8/0x100
> [    2.747928][    T0]  set_track_prepare+0x88/0x120
> [    2.749095][    T0]  __alloc_object+0x602/0xbe0
> [    2.750200][    T0]  __create_object+0x3f/0x4e0
> [    2.751332][    T0]  pcpu_alloc+0x1e18/0x2b00
> [    2.752401][    T0]  mm_init+0x688/0xb20
> [    2.753436][    T0]  mm_alloc+0xf4/0x180
> [    2.754510][    T0]  poking_init+0x50/0x500
> [    2.755594][    T0]  start_kernel+0x3b0/0xbf0
> [    2.756724][    T0]  __pfx_reserve_bios_regions+0x0/0x10
> [    2.758073][    T0]  x86_64_start_kernel+0x92/0xa0
> [    2.759320][    T0]  secondary_startup_64_no_verify+0x176/0x17b
> 
Above reports are triggered by KMEMLEAK and KFENCE.

Now with below fix, I was able to run kmsan kernel with:
  CONFIG_DEBUG_KMEMLEAK=n
  CONFIG_KFENCE=n
  CONFIG_LOCKDEP=n

KMEMLEAK and KFENCE generate too many false positives in unwinding code.
LOCKDEP still introduces instrumenting recursions.

> 
> > Does
> > KMSAN_ENABLE_CHECKS_lockdep.o := n
> > work as well? If it does, that is preferred because it makes sure
> > there are no false positives if the lockdep code unpoisons data that
> > is passed and used outside lockdep.
> > 
> > lockdep has a serious impact on performance, and not sanitizing it
> > with KMSAN is probably a reasonable performance trade-off.
> > 
> Disabling checks is not working here. The recursion become this:
> 
> __msan_metadata_ptr_for_load_4() -> kmsan_get_metadata() -> virt_to_page_or_null() -> pfn_valid() -> lock_acquire() -> __msan_unpoison_alloca() -> kmsan_get_metadata()
> 
> > >  ifdef CONFIG_FUNCTION_TRACER
> > >  CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index b2bccfd37c38..8935cc866e2d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -692,7 +692,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
> > >   * Make notrace because it can be called by the internal functions of
> > >   * ftrace, and making this notrace removes unnecessary recursion calls.
> > >   */
> > > -notrace bool rcu_is_watching(void)
> > > +notrace __no_sanitize_memory bool rcu_is_watching(void)
> > 
> > For all of these, does __no_kmsan_checks instead of __no_sanitize_memory work?
> > Again, __no_kmsan_checks (function-only counterpart to
> > KMSAN_ENABLE_CHECKS_.... := n) is preferred if it works as it avoids
> > any potential false positives that would be introduced by not
> > instrumenting.
> > 
> This works because it is not unpoisoning local variables.
> 
> > >  {
> > >         bool ret;
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 9116bcc90346..33aa4df8fd82 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -5848,7 +5848,7 @@ static inline void preempt_latency_start(int val)
> > >         }
> > >  }
> > >
> > > -void preempt_count_add(int val)
> > > +void __no_sanitize_memory preempt_count_add(int val)
> > >  {
> > >  #ifdef CONFIG_DEBUG_PREEMPT
> > >         /*
> > > @@ -5880,7 +5880,7 @@ static inline void preempt_latency_stop(int val)
> > >                 trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> > >  }
> > >
> > > -void preempt_count_sub(int val)
> > > +void __no_sanitize_memory preempt_count_sub(int val)
> > >  {
> > >  #ifdef CONFIG_DEBUG_PREEMPT
> > >
> > >
> > > --
> > > Cheers,
> > > Changbin Du
> 
> -- 
> Cheers,
> Changbin Du

-- 
Cheers,
Changbin Du

