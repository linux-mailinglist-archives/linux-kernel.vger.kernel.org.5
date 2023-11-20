Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875F07F1151
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjKTLHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjKTLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:07:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE9590
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:07:14 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so4853a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700478433; x=1701083233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9X1lEHhnslF3qD6Jz9mSyrwZQeP6F/9h+Bwg9+ejQE4=;
        b=4UPfGilfytJUwuYEKJ+tXVNzVi8HQ/Qy+KYWeppar+2Kpuyo0UoDi+hCpwlk6KSGgj
         niM9V5Qng1gUQTf1o7lEzprL3nOOCdcsNlclA44PeVRw9h/uh1dc7TmBn4cU7NOXy2Uh
         Sa0sh6BQSODRJxm+nnqh3au48xG7XuOrItjPWohkYF5lDJDXAGnwSg7O7dF/NF06ZdV+
         Yre8pgu1fQay6OdlGBb5KP9LqRdedFEXYnhS9hPMNLCxdoPg3IgpWTTuzFSpcocFqER2
         uJfHrbNLMkArHRya0L+3d+7VyS6zM5BhtmEIj1EYMh6wrFPgeU9ElcoY1pwuM460NHGH
         VfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478433; x=1701083233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X1lEHhnslF3qD6Jz9mSyrwZQeP6F/9h+Bwg9+ejQE4=;
        b=UEu9utME8M7nykrJWkt5PMp5TlW+jbND4oMtiJT38T/7IlWvbT4h+y1S9za1om+B5y
         TT1M33E+s22E/bH6RrNHPNhiy79P3wmPma3bND8L0w0eRZ5c0z232SMps4mn50UlYXTy
         fv8aMOUVFYQg00hQLII0gpdx69NhuRqvyQUJtslXCD7qb//w3OCRwTXMQNLK3+8YBrGF
         eFvvZ5x5npkWz7kDfIdb5a7bvZbubVQIJIt+UCtLTVSTmqrykGMI21wrtGX36QJme8eh
         uHrT5kErq95OTfepPGWDikBaMTaIqg007wiLTlS17sDotesRtyao8XLrJUoLyPqoqMKA
         DL+Q==
X-Gm-Message-State: AOJu0YyBCpQGTw8Pkma/qum276uRmROqI9ci/TnlJIvMEzSGWtWZ5CLK
        H9WDc41SmC20nvXc5r1j50Ma1e4hrLytpJep+j6+9w==
X-Google-Smtp-Source: AGHT+IHaRywZaGNW+1pE/MWarVPDL7z2+ya3VaPrYKXP471jGKjAyZ4IED0eq855c+ydBEZ6onV37793eFhr6IFcWYU=
X-Received: by 2002:a05:6402:3886:b0:543:fb17:1a8 with SMTP id
 fd6-20020a056402388600b00543fb1701a8mr399270edb.3.1700478432861; Mon, 20 Nov
 2023 03:07:12 -0800 (PST)
MIME-Version: 1.0
References: <VI1P193MB0752058FAECD2AC1E5E68D7399B3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+Ya4yTvAmaELJN5st3GJYo1KKzC9qw9sdD0g3jb48O7tg@mail.gmail.com> <VI1P193MB075265616010AF82CE201ADD99B1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB075265616010AF82CE201ADD99B1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Nov 2023 12:06:56 +0100
Message-ID: <CACT4Y+ZE8DO1u6NHATXC9tfcVS4diM0LO4r3cQ15HaGHVoFAbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kasan: Record and report more information
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 22:53, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> On 2023/11/14 15:27, Dmitry Vyukov wrote:
> > On Mon, 13 Nov 2023 at 22:17, Juntong Deng <juntong.deng@outlook.com> wrote:
> >>
> >> Record and report more information to help us find the cause of
> >> the bug (for example, bugs caused by subtle race condition).
> >>
> >> This patch adds recording and showing CPU number and timestamp at
> >> allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO), and
> >> adds recording and showing timestamp at error occurrence (CPU number
> >> is already shown by dump_stack_lvl). The timestamps in the report use
> >> the same format and source as printk.
> >>
> >> In order to record CPU number and timestamp at allocation and free,
> >> corresponding members need to be added to the relevant data structures,
> >> which may lead to increased memory consumption.
> >>
> >> In Generic KASAN, members are added to struct kasan_track. Since in
> >> most cases, alloc meta is stored in the redzone and free meta is
> >> stored in the object or the redzone, memory consumption will not
> >> increase much.
> >>
> >> In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
> >> struct kasan_stack_ring_entry. Memory consumption increases as the
> >> size of struct kasan_stack_ring_entry increases (this part of the
> >> memory is allocated by memblock), but since this is configurable,
> >> it is up to the user to choose.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   lib/Kconfig.kasan      | 11 +++++++++++
> >>   mm/kasan/common.c      |  5 +++++
> >>   mm/kasan/kasan.h       |  9 +++++++++
> >>   mm/kasan/report.c      | 28 ++++++++++++++++++++++------
> >>   mm/kasan/report_tags.c | 18 ++++++++++++++++++
> >>   mm/kasan/tags.c        | 15 +++++++++++++++
> >>   6 files changed, 80 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> >> index fdca89c05745..d9611564b339 100644
> >> --- a/lib/Kconfig.kasan
> >> +++ b/lib/Kconfig.kasan
> >> @@ -207,4 +207,15 @@ config KASAN_MODULE_TEST
> >>            A part of the KASAN test suite that is not integrated with KUnit.
> >>            Incompatible with Hardware Tag-Based KASAN.
> >>
> >> +config KASAN_EXTRA_INFO
> >> +       bool "Record and report more information"
> >> +       depends on KASAN
> >> +       help
> >> +         Record and report more information to help us find the cause of
> >> +         the bug. The trade-off is potentially increased memory consumption
> >> +         (to record more information).
> >> +
> >> +         Currently the CPU number and timestamp are additionally recorded
> >> +         at allocation and free.
> >
> > Hi Juntong,
> >
> > Thanks for working on this.
> >
>
>
> Thanks for your reply!
>
>
> > As a KASAN developer I understand what this is doing, but I am trying
> > to think from a position of a user that does not know details of KASAN
> > implementation. From this position it may be useful to say somewhere
> > that information is recorded "per heap allocation". Perhaps something
> > like:
> >
> > "Currently the CPU number and timestamp are additionally recorded for
> > each heap block at allocation and free time".
>
>
> Yes, I agree, that is a better expression.
>
>
> >
> > Also it's unclear what the memory consumption increase is. You say
> > "potentially|, so may it not increase at all? If it increases, by how
> > much? I obviously want more information, if I can afford it, but I
> > can't understand if I can or not based on this description. I would
> > assume that this may be a problem only for small/embedded devices.
> > Can we provide some ballpark estimation of the memory consumption
> > increase? And somehow say that's probably not an issue for larger
> > machines?
> >
>
>
> How about this expression?
>
> Currently, in order to record CPU number and timestamp, the data
> structure to record allocation and free information will increase
> by 12 bytes.
>
> In Generic KASAN, this affects all allocations less than 32 bytes.
> In SW_TAGS KASAN and HW_TAGS KASAN, depending on the stack_ring_size
> boot parameter increases the memory consumption by
> 12 * stack_ring_size bytes.

Let's go with this version.


> >>   endif # KASAN
> >> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> >> index 256930da578a..7a81566d9d66 100644
> >> --- a/mm/kasan/common.c
> >> +++ b/mm/kasan/common.c
> >> @@ -20,6 +20,7 @@
> >>   #include <linux/module.h>
> >>   #include <linux/printk.h>
> >>   #include <linux/sched.h>
> >> +#include <linux/sched/clock.h>
> >>   #include <linux/sched/task_stack.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/stacktrace.h>
> >> @@ -50,6 +51,10 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
> >>   {
> >>          track->pid = current->pid;
> >>          track->stack = kasan_save_stack(flags, true);
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +       track->cpu = raw_smp_processor_id();
> >> +       track->ts_nsec = local_clock();
> >
> > What does "local_" mean? Is this clock value comparable across CPUs?
> >
>
>
> No, local_clock is the local CPU clock and cannot be used for comparison
> across CPUs, I made a mistake here.
>
> I delved into the clock subsystem of the Linux kernel today and I found
> that we have two choices.
>
> - sched_clock(): based on jiffies, high performance, but on some
> hardware, it will drift between CPUs.
>
> - ktime_get_boot_fast_ns(): based on clocksource, highly accurate,
> can be compared between CPUs, but performance is worse (seqlock).
>
> I tested 100000 calls respectively on my laptop, the average of
> sched_clock() is 17ns and the average of ktime_get_boot_fast_ns()
> is 25ns.
>
> ktime_get_boot_fast_ns() takes about 1.5 times as long as sched_clock().
>
> With Generic KASAN enabled, the average of one memory allocation is
> 3512ns on my laptop.
>
> Personally, I prefer ktime_get_boot_fast_ns() because it is more
> accurate and the extra time is insignificant for the time required for
> one memory allocation with Generic KASAN enabled.
>
> But maybe using ktime_get_boot_fast_ns() would have a more serious
> impact on small/embedded devices.
>
> Which do you think is the better choice?

I don't have a strong preference.

Re drift of sched_clock(), do you mean unsynchronized RDTSC on
different cores? I had the impression that RDTSC is synchronized
across cores on all recent CPUs/systems.


> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >>   }
> >>
> >>   #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> >> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> >> index 8b06bab5c406..b3899a255aca 100644
> >> --- a/mm/kasan/kasan.h
> >> +++ b/mm/kasan/kasan.h
> >> @@ -187,6 +187,10 @@ static inline bool kasan_requires_meta(void)
> >>   struct kasan_track {
> >>          u32 pid;
> >>          depot_stack_handle_t stack;
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +       u32 cpu;
> >> +       u64 ts_nsec;
> >
> > This increases the size of meta from 8 to 24 bytes.
> > Can we somehow store the timestamp as 32 bits? Maybe compress the CPU
> > number (it shouldn't be larger than 20 bits?)?
> > I see below we report on microseconds, so we don't low bits of the
> > timestamp as well.
> >
>
>
> Maybe we can use bit field.
>
> struct kasan_track {
>         u32 pid;
>         depot_stack_handle_t stack;
> #ifdef CONFIG_KASAN_EXTRA_INFO
>         u64 cpu:20;
>         u64 ts_sec:22;
>         u64 ts_usec:22;
> #endif /* CONFIG_KASAN_EXTRA_INFO */
> };
>
> For example, 20-bit cpu, 22-bit ts_sec, 22-bit ts_usec, 64 bits
> (8 bytes), and the data structure is 16 bytes in total.

This looks better.
Can't we have a single field for time instead of ts_sec/usec?
Both sched_clock() and ktime_get_boot_fast_ns() return just u64.

> If the data structure becomes 16 bytes, it will not affect objects
> larger than 16 bytes.
>
> But the bit field can only be used in struct kasan_track (Generic),
> and cannot be used in struct kasan_stack_ring_entry (SW_TAGS KASAN
> and HW_TAGS KASAN).
>
> Because we need to use READ_ONCE and WRITE_ONCE to read and write
> struct kasan_stack_ring_entry, but READ_ONCE and WRITE_ONCE cannot
> read or write bit field.

If that's necessary, we could store both values as a single u64 and
the manually pack/unpack.


> > I see there is a deficiency in kasan_cache_create():
> > https://elixir.bootlin.com/linux/latest/source/mm/kasan/generic.c#L412
> >
> > If free_meta does not fit into the object, we add it after the object.
> > But we could overlap it with the object.
> > For example if the object size is 16 bytes and free_meta size is 24
> > bytes, we could increase object size to 24, while currently we
> > increase it to 16+24 = 40.
> > We need to place it after the object only if we have these other cases
> > "(cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor".
> >
> > Currently it affects only kmalloc-8 slab.
> > But with this change it will affect at least kmalloc-16 slab as well.
> >
>
>
> I completely agree that we can use both object space and redzone
> space to store free meta, thereby further reducing the extra memory
> consumption caused by KASAN.
>
> Of course, in this case we need to readjust the offset of the
> alloc meta.
>
> If you agree I can make this change in a separate patch.

This would be good. Thanks.

> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >>   };
> >>
> >>   enum kasan_report_type {
> >> @@ -202,6 +206,7 @@ struct kasan_report_info {
> >>          size_t access_size;
> >>          bool is_write;
> >>          unsigned long ip;
> >> +       u64 ts_nsec;
> >>
> >>          /* Filled in by the common reporting code. */
> >>          const void *first_bad_addr;
> >> @@ -278,6 +283,10 @@ struct kasan_stack_ring_entry {
> >>          u32 pid;
> >>          depot_stack_handle_t stack;
> >>          bool is_free;
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +       u32 cpu;
> >> +       u64 ts_nsec;
> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >>   };
> >>
> >>   struct kasan_stack_ring {
> >> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> >> index e77facb62900..b6feaf807c08 100644
> >> --- a/mm/kasan/report.c
> >> +++ b/mm/kasan/report.c
> >> @@ -25,6 +25,7 @@
> >>   #include <linux/types.h>
> >>   #include <linux/kasan.h>
> >>   #include <linux/module.h>
> >> +#include <linux/sched/clock.h>
> >>   #include <linux/sched/task_stack.h>
> >>   #include <linux/uaccess.h>
> >>   #include <trace/events/error_report.h>
> >> @@ -242,27 +243,40 @@ static void end_report(unsigned long *flags, const void *addr, bool is_write)
> >>
> >>   static void print_error_description(struct kasan_report_info *info)
> >>   {
> >> +       unsigned long rem_usec = do_div(info->ts_nsec, NSEC_PER_SEC) / 1000;
> >> +
> >>          pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
> >>
> >>          if (info->type != KASAN_REPORT_ACCESS) {
> >> -               pr_err("Free of addr %px by task %s/%d\n",
> >> -                       info->access_addr, current->comm, task_pid_nr(current));
> >> +               pr_err("Free of addr %px by task %s/%d at %lu.%06lus\n",
> >> +                       info->access_addr, current->comm, task_pid_nr(current),
> >> +                       (unsigned long)info->ts_nsec, rem_usec);
> >>                  return;
> >>          }
> >>
> >>          if (info->access_size)
> >> -               pr_err("%s of size %zu at addr %px by task %s/%d\n",
> >> +               pr_err("%s of size %zu at addr %px by task %s/%d at %lu.%06lus\n",
> >>                          info->is_write ? "Write" : "Read", info->access_size,
> >> -                       info->access_addr, current->comm, task_pid_nr(current));
> >> +                       info->access_addr, current->comm, task_pid_nr(current),
> >> +                       (unsigned long)info->ts_nsec, rem_usec);
> >>          else
> >> -               pr_err("%s at addr %px by task %s/%d\n",
> >> +               pr_err("%s at addr %px by task %s/%d at %lu.%06lus\n",
> >>                          info->is_write ? "Write" : "Read",
> >> -                       info->access_addr, current->comm, task_pid_nr(current));
> >> +                       info->access_addr, current->comm, task_pid_nr(current),
> >> +                       (unsigned long)info->ts_nsec, rem_usec);
> >>   }
> >>
> >>   static void print_track(struct kasan_track *track, const char *prefix)
> >>   {
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +       unsigned long rem_usec = do_div(track->ts_nsec, NSEC_PER_SEC) / 1000;
> >> +
> >> +       pr_err("%s by task %u on cpu %d at %lu.%06lus:\n",
> >> +                       prefix, track->pid, track->cpu,
> >> +                       (unsigned long)track->ts_nsec, rem_usec);
> >> +#else
> >>          pr_err("%s by task %u:\n", prefix, track->pid);
> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >>          if (track->stack)
> >>                  stack_depot_print(track->stack);
> >>          else
> >> @@ -544,6 +558,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
> >>          info.access_size = 0;
> >>          info.is_write = false;
> >>          info.ip = ip;
> >> +       info.ts_nsec = local_clock();
> >>
> >>          complete_report_info(&info);
> >>
> >> @@ -582,6 +597,7 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
> >>          info.access_size = size;
> >>          info.is_write = is_write;
> >>          info.ip = ip;
> >> +       info.ts_nsec = local_clock();
> >>
> >>          complete_report_info(&info);
> >>
> >> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> >> index 8b8bfdb3cfdb..4d62f1b3e11d 100644
> >> --- a/mm/kasan/report_tags.c
> >> +++ b/mm/kasan/report_tags.c
> >> @@ -26,6 +26,18 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
> >>          return "invalid-access";
> >>   }
> >>
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +static void kasan_complete_extra_report_info(struct kasan_track *track,
> >> +                                        struct kasan_stack_ring_entry *entry)
> >> +{
> >> +       u32 cpu = READ_ONCE(entry->cpu);
> >> +       u64 ts_nsec = READ_ONCE(entry->ts_nsec);
> >> +
> >> +       track->cpu = cpu;
> >> +       track->ts_nsec = ts_nsec;
> >> +}
> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >> +
> >>   void kasan_complete_mode_report_info(struct kasan_report_info *info)
> >>   {
> >>          unsigned long flags;
> >> @@ -82,6 +94,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
> >>
> >>                          info->free_track.pid = pid;
> >>                          info->free_track.stack = stack;
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +                       kasan_complete_extra_report_info(&info->free_track, entry);
> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >>                          free_found = true;
> >>
> >>                          /*
> >> @@ -97,6 +112,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
> >>
> >>                          info->alloc_track.pid = pid;
> >>                          info->alloc_track.stack = stack;
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +                       kasan_complete_extra_report_info(&info->alloc_track, entry);
> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >>                          alloc_found = true;
> >>
> >>                          /*
> >> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> >> index 7dcfe341d48e..474ce7e8be8b 100644
> >> --- a/mm/kasan/tags.c
> >> +++ b/mm/kasan/tags.c
> >> @@ -13,6 +13,7 @@
> >>   #include <linux/memblock.h>
> >>   #include <linux/memory.h>
> >>   #include <linux/mm.h>
> >> +#include <linux/sched/clock.h>
> >>   #include <linux/static_key.h>
> >>   #include <linux/string.h>
> >>   #include <linux/types.h>
> >> @@ -92,6 +93,17 @@ void __init kasan_init_tags(void)
> >>          }
> >>   }
> >>
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +static void save_extra_info(struct kasan_stack_ring_entry *entry)
> >> +{
> >> +       u32 cpu = raw_smp_processor_id();
> >> +       u64 ts_nsec = local_clock();
> >> +
> >> +       WRITE_ONCE(entry->cpu, cpu);
> >> +       WRITE_ONCE(entry->ts_nsec, ts_nsec);
> >> +}
> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >> +
> >>   static void save_stack_info(struct kmem_cache *cache, void *object,
> >>                          gfp_t gfp_flags, bool is_free)
> >>   {
> >> @@ -124,6 +136,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
> >>          WRITE_ONCE(entry->pid, current->pid);
> >>          WRITE_ONCE(entry->stack, stack);
> >>          WRITE_ONCE(entry->is_free, is_free);
> >> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >> +       save_extra_info(entry);
> >> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> >>
> >>          /*
> >>           * Paired with smp_load_acquire() in kasan_complete_mode_report_info().
> >> --
> >> 2.39.2
> >>
>
