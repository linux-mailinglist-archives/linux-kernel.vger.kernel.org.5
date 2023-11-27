Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC47F9866
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjK0Eed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0Eec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:34:32 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84710136
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:34:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50ba8177c9fso3615e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701059676; x=1701664476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IXbKy2pJw1weWM2AUX6qsAkpX0IgEY8LocF0NM/epjw=;
        b=15Dd2Zy+17OiBlpkXITchllL/RZsVXC3gOE/7TE67o+frvAEOQ1MKR5rHzVOLyxLlv
         oSs002rQJ/dphUqpdi/hP10kgJ8bZEWuzKhklW7zekP4Y/vQose5SHNnzvDhWTdgdxLk
         xgcZmsQL0fyISWhKU+aMMU0B+p2aIRI6s2iHLeNVYwvMHE40WveS6/rt0eWdRtw+1l4Q
         /ze7vtn9lfR8ozNER73tpJOaah+qq1OZzRjmVychz6qbzl2R7yS0fKKinGjL0I9NM8/3
         a2m4AgOm/thelf1dHeGXjdx49YAq107mSy8pr/mwSj93qSXYistJbnsZ/U09C2Fbf7p5
         niFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701059676; x=1701664476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXbKy2pJw1weWM2AUX6qsAkpX0IgEY8LocF0NM/epjw=;
        b=VJTU9jeVXuDdBchTbUzctCy6ba6qYOyPHGhcUI+LWFc/j9d6dPheBNqVltXBDD2wr8
         pbYfObOMrw8euKoMB4AxGjZA2s+gwJtOGn09gdi48FiQuzm87afYaaj+vh8mp3N79aWl
         JWv+u1ub07ojsosEIiqvQlnlPp2A//DIxexyVtJXMhRYgYHc0qTy82iWAR8UJ87xLdKF
         bHXEBH4c3eeYWaBKos3ANYhDSTyKhSKrqORapQmfo6xpxPGh5zqHz3Ix5zoMZmgNE6Th
         jcE7oJTb6NnWZNGVxdKfb3Wi0b1yDsdPv+bgemqVM4OcPTxjKCi/D+r8t4kbAQYI//GR
         B++g==
X-Gm-Message-State: AOJu0YxKQTo0V+ie7EuqGMbAFdQqDvHs7BHnzJqQbV5mIq0vX12wprq2
        KOQvC8usIm2qzuGIYYP6Rh12soKO45+S4stkhPmUwA==
X-Google-Smtp-Source: AGHT+IFhdT60DfmJFK01YP5LJxJl2q5WHKddBuvyqA3O+DhvY0L2910Po9fgOI0KxYcxbbBEVJoe6jXahBGdrtcbosA=
X-Received: by 2002:a05:6512:239e:b0:501:a2b9:6046 with SMTP id
 c30-20020a056512239e00b00501a2b96046mr452354lfv.7.1701059675534; Sun, 26 Nov
 2023 20:34:35 -0800 (PST)
MIME-Version: 1.0
References: <VI1P193MB07529BC28E5B333A8526BEBD99BEA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB07529BC28E5B333A8526BEBD99BEA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Nov 2023 05:34:22 +0100
Message-ID: <CACT4Y+aVjKTxTamnybC9gS7uvSodYjvHst9obo=GjJ_km-_pdw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Record and report more information
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

On Sun, 26 Nov 2023 at 23:25, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> Record and report more information to help us find the cause of the
> bug and to help us correlate the error with other system events.
>
> This patch adds recording and showing CPU number and timestamp at
> allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO). The
> timestamps in the report use the same format and source as printk.
>
> Error occurrence timestamp is already implicit in the printk log,
> and CPU number is already shown by dump_stack_lvl, so there is no
> need to add it.
>
> In order to record CPU number and timestamp at allocation and free,
> corresponding members need to be added to the relevant data structures,
> which will lead to increased memory consumption.
>
> In Generic KASAN, members are added to struct kasan_track. Since in
> most cases, alloc meta is stored in the redzone and free meta is
> stored in the object or the redzone, memory consumption will not
> increase much.
>
> In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
> struct kasan_stack_ring_entry. Memory consumption increases as the
> size of struct kasan_stack_ring_entry increases (this part of the
> memory is allocated by memblock), but since this is configurable,
> it is up to the user to choose.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> V1 -> V2: Use bit field to reduce memory consumption. Add more detailed
> config help. Cancel printing of redundant error occurrence timestamp.
>
>  lib/Kconfig.kasan      | 21 +++++++++++++++++++++
>  mm/kasan/common.c      | 10 ++++++++++
>  mm/kasan/kasan.h       | 10 ++++++++++
>  mm/kasan/report.c      |  6 ++++++
>  mm/kasan/report_tags.c | 16 ++++++++++++++++
>  mm/kasan/tags.c        | 17 +++++++++++++++++
>  6 files changed, 80 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 935eda08b1e1..8653f5c38be7 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -207,4 +207,25 @@ config KASAN_MODULE_TEST
>           A part of the KASAN test suite that is not integrated with KUnit.
>           Incompatible with Hardware Tag-Based KASAN.
>
> +config KASAN_EXTRA_INFO
> +       bool "Record and report more information"
> +       depends on KASAN
> +       help
> +         Record and report more information to help us find the cause of the
> +         bug and to help us correlate the error with other system events.
> +
> +         Currently, the CPU number and timestamp are additionally
> +         recorded for each heap block at allocation and free time, and
> +         8 bytes will be added to each metadata structure that records
> +         allocation or free information.
> +
> +         In Generic KASAN, each kmalloc-8 and kmalloc-16 object will add
> +         16 bytes of additional memory consumption, and each kmalloc-32
> +         object will add 8 bytes of additional memory consumption, not
> +         affecting other larger objects.
> +
> +         In SW_TAGS KASAN and HW_TAGS KASAN, depending on the stack_ring_size
> +         boot parameter, it will add 8 * stack_ring_size bytes of additional
> +         memory consumption.
> +
>  endif # KASAN
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index b5d8bd26fced..2f0884c762b7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/printk.h>
>  #include <linux/sched.h>
> +#include <linux/sched/clock.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/slab.h>
>  #include <linux/stackdepot.h>
> @@ -49,6 +50,15 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
>
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
>  {
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +       u32 cpu = raw_smp_processor_id();
> +       u64 ts_nsec = local_clock();
> +       unsigned long rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
> +
> +       track->cpu = cpu;
> +       track->ts_sec = ts_nsec;
> +       track->ts_usec = rem_usec;
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>         track->pid = current->pid;
>         track->stack = kasan_save_stack(flags,
>                         STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index b29d46b83d1f..2a37baa4ce2f 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -187,6 +187,11 @@ static inline bool kasan_requires_meta(void)
>  struct kasan_track {
>         u32 pid;
>         depot_stack_handle_t stack;
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +       u64 cpu:20;
> +       u64 ts_sec:22;
> +       u64 ts_usec:22;
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>  };
>
>  enum kasan_report_type {
> @@ -278,6 +283,11 @@ struct kasan_stack_ring_entry {
>         u32 pid;
>         depot_stack_handle_t stack;
>         bool is_free;
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +       u64 cpu:20;
> +       u64 ts_sec:22;
> +       u64 ts_usec:22;
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>  };
>
>  struct kasan_stack_ring {
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index e77facb62900..8cd8f6e5cf24 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -262,7 +262,13 @@ static void print_error_description(struct kasan_report_info *info)
>
>  static void print_track(struct kasan_track *track, const char *prefix)
>  {
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +       pr_err("%s by task %u on cpu %d at %u.%06us:\n",
> +                       prefix, track->pid, track->cpu,
> +                       track->ts_sec, track->ts_usec);
> +#else
>         pr_err("%s by task %u:\n", prefix, track->pid);
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>         if (track->stack)
>                 stack_depot_print(track->stack);
>         else
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index 55154743f915..bf895b1d2dc2 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -27,6 +27,16 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
>         return "invalid-access";
>  }
>
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +static void kasan_complete_extra_report_info(struct kasan_track *track,
> +                                        struct kasan_stack_ring_entry *entry)
> +{
> +       track->cpu = entry->cpu;
> +       track->ts_sec = entry->ts_sec;
> +       track->ts_usec = entry->ts_usec;
> +}
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> +
>  void kasan_complete_mode_report_info(struct kasan_report_info *info)
>  {
>         unsigned long flags;
> @@ -73,6 +83,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>
>                         info->free_track.pid = entry->pid;
>                         info->free_track.stack = entry->stack;
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +                       kasan_complete_extra_report_info(&info->free_track, entry);
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>                         free_found = true;
>
>                         /*
> @@ -88,6 +101,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>
>                         info->alloc_track.pid = entry->pid;
>                         info->alloc_track.stack = entry->stack;
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +                       kasan_complete_extra_report_info(&info->alloc_track, entry);
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>                         alloc_found = true;
>
>                         /*
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 739ae997463d..c172e115b9bb 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -13,6 +13,7 @@
>  #include <linux/memblock.h>
>  #include <linux/memory.h>
>  #include <linux/mm.h>
> +#include <linux/sched/clock.h>
>  #include <linux/stackdepot.h>
>  #include <linux/static_key.h>
>  #include <linux/string.h>
> @@ -93,6 +94,19 @@ void __init kasan_init_tags(void)
>         }
>  }
>
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +static void save_extra_info(struct kasan_stack_ring_entry *entry)
> +{
> +       u32 cpu = raw_smp_processor_id();
> +       u64 ts_nsec = local_clock();
> +       unsigned long rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
> +
> +       entry->cpu = cpu;
> +       entry->ts_sec = ts_nsec;
> +       entry->ts_usec = rem_usec;

I would timestamp as a single field in all structs and convert it to
sec/usec only when we print it. It would make all initialization and
copying shorter. E.g. this function can be just:

       entry->cpu = raw_smp_processor_id();
       entry->timestamp = local_clock() / 1024;

Dividing by 1024 is much faster and gives roughly the same precision.
This can be unscaled during reporting:

       u64 sec = entry->timestamp * 1024;
       unsigned long usec = do_div(sec, NSEC_PER_SEC) / 1000;

But otherwise the patch looks good to me.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> +}
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
> +
>  static void save_stack_info(struct kmem_cache *cache, void *object,
>                         gfp_t gfp_flags, bool is_free)
>  {
> @@ -128,6 +142,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>         entry->pid = current->pid;
>         entry->stack = stack;
>         entry->is_free = is_free;
> +#ifdef CONFIG_KASAN_EXTRA_INFO
> +       save_extra_info(entry);
> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>
>         entry->ptr = object;
>
> --
> 2.39.2
>
