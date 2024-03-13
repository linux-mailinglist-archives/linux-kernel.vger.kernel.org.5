Return-Path: <linux-kernel+bounces-101079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596F87A1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A960B1C21A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71872101C1;
	Wed, 13 Mar 2024 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="XO+dlv7e"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90AC13D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710301187; cv=none; b=frLuniZ3yAgg0RejB1F4qFrixZL1jx+jDpi/5SteQDESAVv2DE7ijNmFSfUgCU/Ejgl35eU2mAgwuOZ4J6rbZfLOmgbaZJCyiZBSvsrm80QpHZeDU8IYBM8X+WuilK3ItYpcng9tPMq0VXy1p/zUKTE/ON6vvckd9UVffD9XVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710301187; c=relaxed/simple;
	bh=39uOgg9PIFzC+7prTu6AQkgUNXDCqKb7QB4lSU2sAE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ldtIWhhKZGmrcK0i60c/6Wm6u6wIch4JzjhgOXJ0QrfVOmNSLYV/yd/KLBgZz6e5U+LZIvWzjxy4jd1BqKk0sVB5WZEe1u8taMp3XckhxY8OcbAskmIjGrNYc0kJWDPpRe7LposFh2xpR19rVNMTh8IbaKRcjNtM0nlc4LBIkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=XO+dlv7e; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42e323a2e39so4423591cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710301184; x=1710905984; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+cVQJVLwoiO9g0DaXnniEXx29wxNY/O5V/frLtrtm8=;
        b=XO+dlv7eVRpN7H4l5mm2LEWZXNE3XQdf+bYVap9oMc7cgtsdWdy8WoQ0jSjgwF4q8m
         XVaVc3UzNMSAxje8k8h36ZO3RQtZkY7VNsBCfGqY0Gk0rN2VBOdEXe/OcCiI7kb8rMTb
         tznFY/MKk96BKpG0pXZclBovvx7YgVtVwEZTk7TjRF2zZISNeJUwFPiexiPaUE6bc/ME
         jn/GEO47Jy8mQgbWgbjSGduw3RTtpEntySz6oB4T7qWLXQ1+nXYBT0nW3SJYGQV+Yw8d
         9uG9jOV3LGsT8tdwTXulEsO0D3SU0e4AjSZz1sX15mJD1vxPVNNWPyQv7wepQt+bwnGC
         RFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710301184; x=1710905984;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+cVQJVLwoiO9g0DaXnniEXx29wxNY/O5V/frLtrtm8=;
        b=Yebghcu3qw2K81XMYzqO3CK0f2qYVYqX1GH//G4ZX5YZ2Q9/0rr1lf1XSOhw2bW7/c
         znrYAW50lW+Eg/85Z+NT1Shwt3A32345V+uzFKyN16vlScu4Hg3HQDuOX00kGNjZoNcU
         lEeUWCSPW6tGN569/RkiqReyhpwBVo5MpXB+6yvkTyTBtkzYsTD+6fb7CYkVMqvRMkOb
         K36okry2/MUNdIDNF4dXYR5mgYsVybD9WVWO/sfRguRhnqZHTFzsF2/l1pEKustOdXW3
         mjMvwod3RZCW5A/B42g4NFF07XYglryMvpcerJ5Qifjio19RXYXuxEL4RM2Gs2Fy+0jU
         45AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF/ZlWYCAhdfBHcc4WOTmUzavCs/2ZKpBUipxqjmTIS7RQbOCmEDC5S0i3WYmpcV0TF6XtbvkvOgx/KxFu93ymiGZluXBdEmtP+9Yr
X-Gm-Message-State: AOJu0YxRgSJ/4URJwC/tKM8vZ0BDQEtMYZgKlegzhm5BNjeiPwVu3ThB
	xJj3D8WZcCAIbJ9CzSx5KYF5GCU50t5sN5DL3Soqlr0iOh3nCTfOXZ0DRYLdffqzdvwZdArN9uX
	s+xdTyjbyU7xby55uGOwRR4bZfoFuemWcJn+NJA==
X-Google-Smtp-Source: AGHT+IGY7KAmRSDaJZ7t69yb+cZb/GwQoFC/JMjFLgVO91JAfe0Rat47i12z63cZZfmHJNirPYbEbMyIO6I1QRCeQhA=
X-Received: by 2002:a05:622a:1483:b0:42e:b90d:40b1 with SMTP id
 t3-20020a05622a148300b0042eb90d40b1mr2752273qtx.21.1710301184660; Tue, 12 Mar
 2024 20:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313033417.447216-1-pasha.tatashin@soleen.com>
In-Reply-To: <20240313033417.447216-1-pasha.tatashin@soleen.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 12 Mar 2024 23:39:07 -0400
Message-ID: <CA+CK2bCA6aoM0UGX+-vu5aG7iR-ngKB3oV8CxuNDc-pRvUr92w@mail.gmail.com>
Subject: Re: [PATCH] vmstat: Keep count of the maximum page reached by the
 kernel stack
To: akpm@linux-foundation.org, jpoimboe@kernel.org, pasha.tatashin@soleen.com, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@suse.cz, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:34=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> CONFIG_DEBUG_STACK_USAGE provides a mechanism to know the minimum amount
> of memory that was left in stack. Every time the new anti-record is
> reached a message is printed to the console.
>
> However, this is not useful to know how much each page within stack was
> actually used. Provide a mechanism to count the number of time each
> stack page was reached throughout the live of the stack:
>
>         $ grep kstack /proc/vmstat
>         kstack_page_1 19974
>         kstack_page_2 94
>         kstack_page_3 0
>         kstack_page_4 0
>
> In the above example only out of ~20K threads that ever exited on that
> machine only 94 touched second page of the stack, and none touched
> pages three and four.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/sched/task_stack.h | 39 ++++++++++++++++++++++++++++++--
>  include/linux/vm_event_item.h    | 29 ++++++++++++++++++++++++
>  include/linux/vmstat.h           | 16 -------------
>  mm/vmstat.c                      | 11 +++++++++
>  4 files changed, 77 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_=
stack.h
> index ccd72b978e1f..7ff7f9997266 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -95,9 +95,41 @@ static inline int object_is_on_stack(const void *obj)
>  extern void thread_stack_cache_init(void);
>
>  #ifdef CONFIG_DEBUG_STACK_USAGE
> +#ifdef CONFIG_VM_EVENT_COUNTERS
> +#include <linux/vm_event_item.h>
> +
> +/* Count the maximum pages reached in kernel stacks */
> +static inline void count_kstack_page(int stack_max_page)
> +{
> +       switch (stack_max_page) {
> +       case 1:
> +               this_cpu_inc(vm_event_states.event[KSTACK_PAGE_1]);
> +               break;
> +       case 2:
> +               this_cpu_inc(vm_event_states.event[KSTACK_PAGE_2]);
> +               break;
> +#if THREAD_SIZE >=3D (4 * PAGE_SIZE)
> +       case 3:
> +               this_cpu_inc(vm_event_states.event[KSTACK_PAGE_3]);
> +               break;
> +       case 4:
> +               this_cpu_inc(vm_event_states.event[KSTACK_PAGE_4]);
> +               break;
> +#endif
> +#if THREAD_SIZE > (4 * PAGE_SIZE)
> +       default:
> +               this_cpu_inc(vm_event_states.event[KSTACK_PAGE_5]);

It should:
this_cpu_inc(vm_event_states.event[KSTACK_PAGE_REST]);

Will fix it in the next version.

> +#endif
> +       }
> +}
> +#else /* !CONFIG_VM_EVENT_COUNTERS */
> +static inline void count_kstack_page(int stack_max_page) {}
> +#endif /* CONFIG_VM_EVENT_COUNTERS */
> +
>  static inline unsigned long stack_not_used(struct task_struct *p)
>  {
>         unsigned long *n =3D end_of_stack(p);
> +       unsigned long unused_stack;
>
>         do {    /* Skip over canary */
>  # ifdef CONFIG_STACK_GROWSUP
> @@ -108,10 +140,13 @@ static inline unsigned long stack_not_used(struct t=
ask_struct *p)
>         } while (!*n);
>
>  # ifdef CONFIG_STACK_GROWSUP
> -       return (unsigned long)end_of_stack(p) - (unsigned long)n;
> +       unused_stack =3D (unsigned long)end_of_stack(p) - (unsigned long)=
n;
>  # else
> -       return (unsigned long)n - (unsigned long)end_of_stack(p);
> +       unused_stack =3D (unsigned long)n - (unsigned long)end_of_stack(p=
);
>  # endif
> +       count_kstack_page(((THREAD_SIZE - unused_stack) >> PAGE_SHIFT) + =
1);
> +
> +       return unused_stack;
>  }
>  #endif
>  extern void set_task_stack_end_magic(struct task_struct *tsk);
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
> index 747943bc8cc2..1dbfe47ff048 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -153,10 +153,39 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPO=
UT,
>                 VMA_LOCK_ABORT,
>                 VMA_LOCK_RETRY,
>                 VMA_LOCK_MISS,
> +#endif
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +               KSTACK_PAGE_1,
> +               KSTACK_PAGE_2,
> +#if THREAD_SIZE >=3D (4 * PAGE_SIZE)
> +               KSTACK_PAGE_3,
> +               KSTACK_PAGE_4,
> +#endif
> +#if THREAD_SIZE > (4 * PAGE_SIZE)
> +               KSTACK_PAGE_REST,
> +#endif
>  #endif
>                 NR_VM_EVENT_ITEMS
>  };
>
> +#ifdef CONFIG_VM_EVENT_COUNTERS
> +/*
> + * Light weight per cpu counter implementation.
> + *
> + * Counters should only be incremented and no critical kernel component
> + * should rely on the counter values.
> + *
> + * Counters are handled completely inline. On many platforms the code
> + * generated will simply be the increment of a global address.
> + */
> +
> +struct vm_event_state {
> +       unsigned long event[NR_VM_EVENT_ITEMS];
> +};
> +
> +DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
> +#endif
> +
>  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>  #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
>  #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 343906a98d6e..18d4a97d3afd 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -41,22 +41,6 @@ enum writeback_stat_item {
>  };
>
>  #ifdef CONFIG_VM_EVENT_COUNTERS
> -/*
> - * Light weight per cpu counter implementation.
> - *
> - * Counters should only be incremented and no critical kernel component
> - * should rely on the counter values.
> - *
> - * Counters are handled completely inline. On many platforms the code
> - * generated will simply be the increment of a global address.
> - */
> -
> -struct vm_event_state {
> -       unsigned long event[NR_VM_EVENT_ITEMS];
> -};
> -
> -DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
> -
>  /*
>   * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
>   * local_irq_disable overhead.
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index db79935e4a54..737c85689251 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1413,6 +1413,17 @@ const char * const vmstat_text[] =3D {
>         "vma_lock_retry",
>         "vma_lock_miss",
>  #endif
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +       "kstack_page_1",
> +       "kstack_page_2",
> +#if THREAD_SIZE >=3D (4 * PAGE_SIZE)
> +       "kstack_page_3",
> +       "kstack_page_4",
> +#endif
> +#if THREAD_SIZE > (4 * PAGE_SIZE)
> +       "kstack_page_rest",
> +#endif
> +#endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG =
*/
> --
> 2.44.0.278.ge034bb2e1d-goog
>

