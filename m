Return-Path: <linux-kernel+bounces-30026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C583181A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD34F288285
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAB2377A;
	Thu, 18 Jan 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqObrR2i"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E48C127
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576095; cv=none; b=I8NGDhF7xNFS3UdfmkMwIhco4bOtjbvFer/JC0OSs5UygbwoSgyt7d9brE811ivGvAdSVn4yEEMXVl05XQFv8A5tQzOevCOo/a7FWFSKEFGnLlRJ9z1uuacZp04M1OCqckThnT8r8tGd94+HvpOe1X88wxgoB0dl4ro+qumFT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576095; c=relaxed/simple;
	bh=CvbWims4wKwR0eh2WfAIVC0tAFWt8GTZnGP+3TUk1hw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=bMZtffkpQ52svBECDHRTTaNrMVaZ3znUWckwC+iX/wN0aML87xuIlZtmvyhQ4RfHJg1BnpmiunsY0BeMFB8b26g5PGlkWC/aqx8au8r96tQR4GMNU7yMveMVDC+CkKasPq0XqwOx/Pnp7TsJaUu6QYYwawWgRyhaCGTPtAj7Whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqObrR2i; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b72f2bdbdaso3256564e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705576092; x=1706180892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3fBRUIb2Xioj9IoQ1nhfd3l3Jn6qijKU/uajCdRr4Q4=;
        b=rqObrR2ihorypfqLqzOE7zHpYtjLTwH/+eJ95QPli8hUHsVwZ231wf5Gn6pmEvu4QX
         9vTSwObIvF1TDUvwY1GKe3DMBGhJ/l24qJgGlkvZJrDHqvsSrjyds7t8xU126oKVngNT
         P+efTRHba5waiBIgqxc9qb+Frof8+OEd25GfshjLrtKAQ31dTyhyWqMuFZggyWpCyEBo
         /aEVFlB+74W7+4BYZpjckBdw51Z+F6l9Eg/aVFsMvs9f+ythg0PhNlh0wFTLiydnk+6h
         A6NSd3FxdcPusR3vEdcM5KCba4D13nnSDBnA+dFOph/dGt8kD7GDfY303/Xq+s7PFzbr
         3Fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576092; x=1706180892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fBRUIb2Xioj9IoQ1nhfd3l3Jn6qijKU/uajCdRr4Q4=;
        b=NSZv6Nc5ilMwebEYUCTB6jR8Mi1G9Lq+nzIwM93v/afCyFsPqzRi30TZHdOFjcnHNt
         qWwRjuo1LXQJaWe/yKnZDDGBtpZLvQ3JN4YR2GJb5dpdIg9QvyKkCcCxVIavy3pelbtm
         ZQOO2/CD3RW7w5Kl14tcSIE2LIGL56XW4Q7ThhdQHIMEgXkq025vHMWQ+UT3t2lVxMNt
         7IZagN3oRP7SZ9ZflhOpBxDrayjuXtrAjsPc8O5rj6zqL8prosf4Y4gKX/57FvYH2MlB
         dp3ICIMq61zunc24pUkMGbfkhhCDArS5q58AaowlWi8KElzRxwwTSJGWOET4EKnmjE6n
         pqZA==
X-Gm-Message-State: AOJu0Yz8WP0rNC2ypgp9Zj2jbAiIKYppmdL01ZN/mCqKqQgguE1+Bsp8
	0YwwczPmp1N4JyEp3YGWLuyS5WgtVMf2ixgE30gWQJc5bsm3CmvjIX2MQESel4uuKZlAAnbqBhM
	zWNlh5W9vrpSzIugIaHUuuzX7XZclTlTbr+/4
X-Google-Smtp-Source: AGHT+IEoAcSXDDVl4x6IPLR2yRPfpy0nUGBJ3WO4L/jouRR6M2ibsaNZ3Hq8iBqXnuEShXsvo4mHyLoW0z/PMHWkbRE=
X-Received: by 2002:ac5:cd93:0:b0:4b6:ef57:a068 with SMTP id
 i19-20020ac5cd93000000b004b6ef57a068mr362816vka.32.1705576092216; Thu, 18 Jan
 2024 03:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118110022.2538350-1-elver@google.com>
In-Reply-To: <20240118110022.2538350-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 18 Jan 2024 12:07:34 +0100
Message-ID: <CANpmjNPx0j-x_SDu777gaV1oOFuPmHV3xFfru56UzBXHnZhYLg@mail.gmail.com>
Subject: Re: [PATCH] mm, kmsan: fix infinite recursion due to RCU critical section
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com, 
	Charan Teja Kalla <quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 12:00, Marco Elver <elver@google.com> wrote:
>
> Alexander Potapenko writes in [1]: "For every memory access in the code
> instrumented by KMSAN we call kmsan_get_metadata() to obtain the
> metadata for the memory being accessed. For virtual memory the metadata
> pointers are stored in the corresponding `struct page`, therefore we
> need to call virt_to_page() to get them.
>
> According to the comment in arch/x86/include/asm/page.h,
> virt_to_page(kaddr) returns a valid pointer iff virt_addr_valid(kaddr)
> is true, so KMSAN needs to call virt_addr_valid() as well.
>
> To avoid recursion, kmsan_get_metadata() must not call instrumented
> code, therefore ./arch/x86/include/asm/kmsan.h forks parts of
> arch/x86/mm/physaddr.c to check whether a virtual address is valid or
> not.
>
> But the introduction of rcu_read_lock() to pfn_valid() added
> instrumented RCU API calls to virt_to_page_or_null(), which is called by
> kmsan_get_metadata(), so there is an infinite recursion now.  I do not
> think it is correct to stop that recursion by doing
> kmsan_enter_runtime()/kmsan_exit_runtime() in kmsan_get_metadata(): that
> would prevent instrumented functions called from within the runtime from
> tracking the shadow values, which might introduce false positives."
>
> Fix the issue by switching pfn_valid() to the _sched() variant of
> rcu_read_lock/unlock(), which does not require calling into RCU. Given
> the critical section in pfn_valid() is very small, this is a reasonable
> trade-off (with preemptible RCU).
>
> KMSAN further needs to be careful to suppress calls into the scheduler,
> which would be another source of recursion. This can be done by wrapping
> the call to pfn_valid() into preempt_disable/enable_no_resched(). The
> downside is that this sacrifices breaking scheduling guarantees;
> however, a kernel compiled with KMSAN has already given up any
> performance guarantees due to being heavily instrumented.
>
> Note, KMSAN code already disables tracing via Makefile, and since
> mmzone.h is included, it is not necessary to use the notrace variant,
> which is generally preferred in all other cases.
>
> Link: https://lkml.kernel.org/r/20240115184430.2710652-1-glider@google.com [1]
> Reported-by: Alexander Potapenko <glider@google.com>
> Reported-by: syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Charan Teja Kalla <quic_charante@quicinc.com>

This might want a:

Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
memory_section->usage")

For reference which patch introduced the problem.

> ---
>  arch/x86/include/asm/kmsan.h | 17 ++++++++++++++++-
>  include/linux/mmzone.h       |  6 +++---
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
> index 8fa6ac0e2d76..d91b37f5b4bb 100644
> --- a/arch/x86/include/asm/kmsan.h
> +++ b/arch/x86/include/asm/kmsan.h
> @@ -64,6 +64,7 @@ static inline bool kmsan_virt_addr_valid(void *addr)
>  {
>         unsigned long x = (unsigned long)addr;
>         unsigned long y = x - __START_KERNEL_map;
> +       bool ret;
>
>         /* use the carry flag to determine if x was < __START_KERNEL_map */
>         if (unlikely(x > y)) {
> @@ -79,7 +80,21 @@ static inline bool kmsan_virt_addr_valid(void *addr)
>                         return false;
>         }
>
> -       return pfn_valid(x >> PAGE_SHIFT);
> +       /*
> +        * pfn_valid() relies on RCU, and may call into the scheduler on exiting
> +        * the critical section. However, this would result in recursion with
> +        * KMSAN. Therefore, disable preemption here, and re-enable preemption
> +        * below while suppressing reschedules to avoid recursion.
> +        *
> +        * Note, this sacrifices occasionally breaking scheduling guarantees.
> +        * Although, a kernel compiled with KMSAN has already given up on any
> +        * performance guarantees due to being heavily instrumented.
> +        */
> +       preempt_disable();
> +       ret = pfn_valid(x >> PAGE_SHIFT);
> +       preempt_enable_no_resched();
> +
> +       return ret;
>  }
>
>  #endif /* !MODULE */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4ed33b127821..a497f189d988 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2013,9 +2013,9 @@ static inline int pfn_valid(unsigned long pfn)
>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>                 return 0;
>         ms = __pfn_to_section(pfn);
> -       rcu_read_lock();
> +       rcu_read_lock_sched();
>         if (!valid_section(ms)) {
> -               rcu_read_unlock();
> +               rcu_read_unlock_sched();
>                 return 0;
>         }
>         /*
> @@ -2023,7 +2023,7 @@ static inline int pfn_valid(unsigned long pfn)
>          * the entire section-sized span.
>          */
>         ret = early_section(ms) || pfn_section_valid(ms, pfn);
> -       rcu_read_unlock();
> +       rcu_read_unlock_sched();
>
>         return ret;
>  }
> --
> 2.43.0.381.gb435a96ce8-goog
>

