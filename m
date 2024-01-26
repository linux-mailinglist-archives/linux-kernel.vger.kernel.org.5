Return-Path: <linux-kernel+bounces-39990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7B83D82F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990481C22181
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2E1D530;
	Fri, 26 Jan 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6x1F5MX"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC21CD0F;
	Fri, 26 Jan 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264166; cv=none; b=tjnwWw3IxpLti1L55QVURYKxU5eH0PrPbV9jz3GjBkGlgVrBoxZkCMuKcypLdiyemU0Pk6RLTm1ZM/jxvuNBP7ZHIWr9jpxD3mS2W8PS7bXBnlRLOLnGb4Ai36RQ3PTubuYuRRj7befGXzWi6IfAeSjwjj32hxEagQ4bnMrAhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264166; c=relaxed/simple;
	bh=z3Lja6VcJKpC7qc4agJ9TaFZNw5fNgRMLfM9msgIfTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfLjX/6MW0t8KtVL2g9uItsVv3fn70vWsoXwwxj9ECNmXZRgoJmtCsuT11cq7XqMNx84dvRp/Jlkz9zMpAB0w+29rUPM0SlyBukJllCJ6Bhx/edWHa8/xeoulXR2ROoNSN3SKzZUJc5g84WD5YUG2g5mUrmD+5RSu8Qp0sYSBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6x1F5MX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6029e069e08so7514527b3.0;
        Fri, 26 Jan 2024 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706264163; x=1706868963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7xDsoHGA/u32CDMqKiVNSmBCLWpWQL3KC549th7KB4=;
        b=F6x1F5MXB1gaj/sdU0m37xyC0Hcf9efTKwDiixZgGK4wYrgOFo6InU49F5rpyK05vS
         Z2kvYagFuJzDtIdwAaGDoDxjdPtFfH1ab86UARprHcV3iM7NtLoj+E5EL3pPPXuQJsK2
         qESLIUL1UMOhUV+UPUZV/Z3Hf4Abf1/l0T9hWvfCfYbE5uYd2KQNPLSNp39DemFHr1X+
         OPWgnqNMcUTtkx5+wMckyS8ieHoBe4ExmVuIVGVD3ULPsCLUPsLZCmDHOq8TlIyFvn6E
         Uf94+95xG5lYgxVMdNrMcbflMUbwvxxm0oElrXk39hcynxdY59XR6u++0b0D/6Yi8kNO
         Jtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706264163; x=1706868963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7xDsoHGA/u32CDMqKiVNSmBCLWpWQL3KC549th7KB4=;
        b=S6ifMHesTge0gMVsz8YV7toeaZxI2RONefgvVtH6B/HU3Lw3F2cNnG9G+Iy81wiP83
         X085aNwEdNKaJJrutFyXUqVVE+IwuogohKXjRq+N4QI2ywiLDYaPO/Diug78k32wHesI
         cv9P5KoSW5PdrA6hXLiwx7ztMA+d6kWPCA4irqufri6Apw6FFU4EhmqKfBxrZ4GyI0vk
         qsMabpGPYcAyNzeqb6CxFrWq9EUhGY35vPwyRkhT7bBkAZ/yNMsMOXGzAIgsgkgWBpVq
         IocolOQOW+pKtPReJBhp7UAZ6+PnpyaGZo8ZGKKp1c8xP+70m1cA04JuoHrx7wiQq1Fs
         Ov+A==
X-Gm-Message-State: AOJu0YxU158lR8ATu0KALHyYANr0KJ5p43VcAgMvFsNQIS5uZpeYiGmg
	rzjF71FadcTFzWH8CKUrLacWTugHTi83Kxfbu0RMilPylomIdGWoyI4R2Xm3kwyDeud0CZGyqD0
	cJHTiJnaYmitorJ+9YgOjHW9F7VpMhu/xVEK0vImGfUfK3A==
X-Google-Smtp-Source: AGHT+IG0Xnky0HjoJIF+EbsD16Da47nzSyT1OwOgbIW/hacu6rg3KU+v8c3Dpc2+8iF6FZWdCG3ojfdRGLucw01s+pw=
X-Received: by 2002:a81:b60a:0:b0:5ff:44e8:6df5 with SMTP id
 u10-20020a81b60a000000b005ff44e86df5mr1022570ywh.18.1706264162875; Fri, 26
 Jan 2024 02:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <CAK1f24=TfJvsDCEesaTa8rGP7ay62p6UiJem=XWnpFa9yfSA3A@mail.gmail.com>
 <CAK1f24nS8MEA3wcS4za-uSp7ZBxvd+xqMRf8-u=m5uCvTs8yJQ@mail.gmail.com>
In-Reply-To: <CAK1f24nS8MEA3wcS4za-uSp7ZBxvd+xqMRf8-u=m5uCvTs8yJQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 26 Jan 2024 18:15:51 +0800
Message-ID: <CAK1f24kOYDOw26ov5TVpAyNP13hCjm=cDo4rooOTPDuv8L6Pnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>, 
	"Zach O'Keefe" <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>, 
	David Hildenbrand <david@redhat.com>
Cc: songmuchun@bytedance.com, peterx@redhat.com, mknyszek@google.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would like to correct the information provided in my previous
email and also provide some additional information.

On Fri, Jan 26, 2024 at 2:16=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> I=E2=80=99d like to add another real use case.
>
> In our company, we deploy applications using offline-online
> hybrid deployment. This approach leverages the distinctive
> resource utilization patterns of online services, utilizing idle
> resources during various time periods by filling them with
> offline jobs. This helps reduce the growing cost expenditures
> for the enterprise.
>
> Whether for online services or offline jobs, their requirements
> for THP can be roughly categorized into three types:
>
> * The first type aims to use huge pages as much as possible
> and tolerates unpredictable stalls caused by direct reclaim
> and/or compaction.
> * The second type attempts to use huge pages but is relatively
> latency-sensitive and cannot tolerate unpredictable stalls.
> * The third type prefers not to use huge pages at all and is
> extremely latency-sensitive.
>
> After careful consideration, we decided to prioritize the
> requirements of the first type and modify the THP settings
> as follows:
>
> echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> echo defer >/sys/kernel/mm/transparent_hugepage/defrag
>
> With the introduction of MADV_COLLAPSE into the kernel,
> it is no longer dependent on any sysfs setting under
> /sys/kernel/mm/transparent_hugepage. MADV_COLLAPSE
> offers the potential for fine-grained synchronous control over
> the huge page allocation mechanism, marking a significant
> enhancement for THP.
>
> If the kernel supports a more relaxed (opportunistic)
> MADV_COLLAPSE, we will modify the THP settings as follows:
>
> echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> echo madvise >/sys/kernel/mm/transparent_hugepage/defrag

The correct THP settings should be:
echo always >/sys/kernel/mm/transparent_hugepage/enabled
echo madvise >/sys/kernel/mm/transparent_hugepage/defrag

>
> Then, we will use process_madvise(MADV_COLLAPSE, xx_relaxed_flag)
> to address the requirements of the second type.
>
> Why don't we favor madvise(MADV_COLLAPSE) for the first type
> of requirements?
> The main reason is that these requirements are typically for offline
> jobs in the Hadoop ecosystem, such as MapReduce and Spark,
> which run primarily on the JVM. IIRC, the JVM currently does not
> support madvise(MADV_COLLAPSE). The second type of

To add, there are also some offline jobs that rely on PyTorch for
machine learning model training tasks. IIRC, PyTorch also does
not support madvise(MADV_COLLAPSE).

Thanks,
Lance

> requirements is all for our in-house developed online services.
> For us, integrating a more relaxed (opportunistic)
> MADV_COLLAPSE into our online services is relatively
> straightforward.
>
> By introducing various flags to MADV_COLLAPSE, we can offer
> multiple synchronous allocation strategies for applications. This
> fine-grained control may be more suitable for cloud-native
> environments than the widespread settings under
> /sys/kernel/mm/transparent_hugepage in sysfs.
>
> Thanks for your time!
> Lance
>
> On Sun, Jan 21, 2024 at 11:12=E2=80=AFAM Lance Yang <ioworker0@gmail.com>=
 wrote:
> >
> > Hello Everyone,
> >
> > For applications actively utilizing THP, the defrag mode may
> > not be a very user-friendly design. Here are the reasons:
> > 1. Before marking the address space with
> >     MADV_HUGEPAGE,it is necessary to check if
> >     the current configuration of the defrag mode aligns with
> >     their preferences.
> > 2. Once the defrag mode configuration changes, these
> >     applications may face the risk of unpredictable stalls.
> >
> > THP is an important feature of the Linux kernel that can
> > significantly enhance memory access performance.
> > However, due to the lack of fine-grained control over
> > the huge page allocation strategy, many applications
> > default to not using huge pages and even recommend
> > users to disable THP. This situation is regrettable.
> >
> > With the introduction of MADV_COLLAPSE into the kernel,
> > it is not affected by the defrag mode.
> > MADV_COLLAPSE offers the potential for
> > fine-grained synchronous control over the huge page
> > allocation mechanism, marking a significant enhancement
> > for THP.
> >
> > By adding flags to MADV_COLLAPSE, different
> > synchronous allocation strategies can be provided to
> > applications. This can instill confidence in them, allowing
> > them to reconsider using THP and allocate huge pages
> > according to their desired synchronous allocation strategy,
> > without worrying about the defrag mode configuration.
> >
> > BR,
> > Lance
> >
> >
> > On Thu, Jan 18, 2024 at 8:03=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
> wrote:
> > >
> > > This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1]=
.
> > >
> > > Allow MADV_F_COLLAPSE_LIGHT behavior for process_madvise(2) if the ca=
ller
> > > has CAP_SYS_ADMIN or is requesting the collapse of its own memory.
> > >
> > > The semantics of MADV_F_COLLAPSE_LIGHT are similar to MADV_COLLAPSE, =
but
> > > it  avoids direct reclaim and/or compaction, quickly failing on alloc=
ation
> > > errors.
> > >
> > > This change enables a more flexible and efficient usage of memory col=
lapse
> > > operations, providing additional control to userspace applications fo=
r
> > > system-wide THP optimization.
> > >
> > > Semantics
> > >
> > > This call is independent of the system-wide THP sysfs settings, but w=
ill
> > > fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
> > > multiple VMAs, the semantics of the collapse over each VMA is indepen=
dent
> > > from the others.  This implies a hugepage cannot cross a VMA boundary=
  If
> > > collapse of a given hugepage-aligned/sized region fails, the operatio=
n may
> > > continue to attempt collapsing the remainder of memory specified.
> > >
> > > The memory ranges provided must be page-aligned, but are not required=
 to
> > > be hugepage-aligned.  If the memory ranges are not hugepage-aligned, =
the
> > > start/end of the range will be clamped to the first/last hugepage-ali=
gned
> > > address covered by said range.  The memory ranges must span at least =
one
> > > hugepage-sized region.
> > >
> > > All non-resident pages covered by the range will first be
> > > swapped/faulted-in, before being internally copied onto a freshly
> > > allocated hugepage.  Unmapped pages will have their data directly
> > > initialized to 0 in the new hugepage.  However, for every eligible
> > > hugepage aligned/sized region to-be collapsed, at least one page must
> > > currently be backed by memory (a PMD covering the address range must
> > > already exist).
> > >
> > > Allocation for the new hugepage will not enter direct reclaim and/or
> > > compaction, quickly failing if allocation fails. When the system has
> > > multiple NUMA nodes, the hugepage will be allocated from the node pro=
viding
> > > the most native pages. This operation operates on the current state o=
f the
> > > specified process and makes no persistent changes or guarantees on ho=
w pages
> > > will be mapped, constructed, or faulted in the future.
> > >
> > > Use Cases
> > >
> > > An immediate user of this new functionality is the Go runtime heap al=
locator
> > > that manages memory in hugepage-sized chunks. In the past, whether it=
 was a
> > > newly allocated chunk through mmap() or a reused chunk released by
> > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back memor=
y with
> > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)=
[3]
> > > respectively. However, both approaches resulted in performance issues=
; for
> > > both scenarios, there could be entries into direct reclaim and/or com=
paction,
> > > leading to unpredictable stalls[4]. Now, the allocator can confidentl=
y use
> > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of h=
uge pages.
> > >
> > > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec5640=
4faca29a82689c77
> > > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa73337409961=
81268b60a3a
> > > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3b=
e4b3a9bd2af
> > > [4] https://github.com/golang/go/issues/63334
> > >
> > > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gm=
ail.com/
> > >
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > Suggested-by: Zach O'Keefe <zokeefe@google.com>
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > ---
> > > V1 -> V2: Treat process_madvise(MADV_F_COLLAPSE_LIGHT) as the lighter=
-weight alternative
> > >         to madvise(MADV_COLLAPSE)
> > >
> > >  arch/alpha/include/uapi/asm/mman.h           |  1 +
> > >  arch/mips/include/uapi/asm/mman.h            |  1 +
> > >  arch/parisc/include/uapi/asm/mman.h          |  1 +
> > >  arch/xtensa/include/uapi/asm/mman.h          |  1 +
> > >  include/linux/huge_mm.h                      |  5 +--
> > >  include/uapi/asm-generic/mman-common.h       |  1 +
> > >  mm/khugepaged.c                              | 15 ++++++--
> > >  mm/madvise.c                                 | 36 +++++++++++++++++-=
--
> > >  tools/include/uapi/asm-generic/mman-common.h |  1 +
> > >  9 files changed, 52 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/=
uapi/asm/mman.h
> > > index 763929e814e9..22f23ca04f1a 100644
> > > --- a/arch/alpha/include/uapi/asm/mman.h
> > > +++ b/arch/alpha/include/uapi/asm/mman.h
> > > @@ -77,6 +77,7 @@
> > >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lo=
cked pages too */
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but a=
voids direct reclaim and/or compaction */
> > >
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > > diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/ua=
pi/asm/mman.h
> > > index c6e1fc77c996..acec0b643e9c 100644
> > > --- a/arch/mips/include/uapi/asm/mman.h
> > > +++ b/arch/mips/include/uapi/asm/mman.h
> > > @@ -104,6 +104,7 @@
> > >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lo=
cked pages too */
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but a=
voids direct reclaim and/or compaction */
> > >
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > > diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/includ=
e/uapi/asm/mman.h
> > > index 68c44f99bc93..812029c98cd7 100644
> > > --- a/arch/parisc/include/uapi/asm/mman.h
> > > +++ b/arch/parisc/include/uapi/asm/mman.h
> > > @@ -71,6 +71,7 @@
> > >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lo=
cked pages too */
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but a=
voids direct reclaim and/or compaction */
> > >
> > >  #define MADV_HWPOISON     100          /* poison a page for testing =
*/
> > >  #define MADV_SOFT_OFFLINE 101          /* soft offline page for test=
ing */
> > > diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/includ=
e/uapi/asm/mman.h
> > > index 1ff0c858544f..52ef463dd5b6 100644
> > > --- a/arch/xtensa/include/uapi/asm/mman.h
> > > +++ b/arch/xtensa/include/uapi/asm/mman.h
> > > @@ -112,6 +112,7 @@
> > >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lo=
cked pages too */
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but a=
voids direct reclaim and/or compaction */
> > >
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index 5adb86af35fc..075fdb5d481a 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -303,7 +303,7 @@ int hugepage_madvise(struct vm_area_struct *vma, =
unsigned long *vm_flags,
> > >                      int advice);
> > >  int madvise_collapse(struct vm_area_struct *vma,
> > >                      struct vm_area_struct **prev,
> > > -                    unsigned long start, unsigned long end);
> > > +                    unsigned long start, unsigned long end, int beha=
vior);
> > >  void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long=
 start,
> > >                            unsigned long end, long adjust_next);
> > >  spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct =
*vma);
> > > @@ -450,7 +450,8 @@ static inline int hugepage_madvise(struct vm_area=
_struct *vma,
> > >
> > >  static inline int madvise_collapse(struct vm_area_struct *vma,
> > >                                    struct vm_area_struct **prev,
> > > -                                  unsigned long start, unsigned long=
 end)
> > > +                                  unsigned long start, unsigned long=
 end,
> > > +                                  int behavior)
> > >  {
> > >         return -EINVAL;
> > >  }
> > > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/as=
m-generic/mman-common.h
> > > index 6ce1f1ceb432..92c67bc755da 100644
> > > --- a/include/uapi/asm-generic/mman-common.h
> > > +++ b/include/uapi/asm-generic/mman-common.h
> > > @@ -78,6 +78,7 @@
> > >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lo=
cked pages too */
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but a=
voids direct reclaim and/or compaction */
> > >
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 2b219acb528e..2840051c0ae2 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -97,6 +97,8 @@ static struct kmem_cache *mm_slot_cache __ro_after_=
init;
> > >  struct collapse_control {
> > >         bool is_khugepaged;
> > >
> > > +       int behavior;
> > > +
> > >         /* Num pages scanned per node */
> > >         u32 node_load[MAX_NUMNODES];
> > >
> > > @@ -1058,10 +1060,16 @@ static int __collapse_huge_page_swapin(struct=
 mm_struct *mm,
> > >  static int alloc_charge_hpage(struct page **hpage, struct mm_struct =
*mm,
> > >                               struct collapse_control *cc)
> > >  {
> > > -       gfp_t gfp =3D (cc->is_khugepaged ? alloc_hugepage_khugepaged_=
gfpmask() :
> > > -                    GFP_TRANSHUGE);
> > >         int node =3D hpage_collapse_find_target_node(cc);
> > >         struct folio *folio;
> > > +       gfp_t gfp;
> > > +
> > > +       if (cc->is_khugepaged)
> > > +               gfp =3D alloc_hugepage_khugepaged_gfpmask();
> > > +       else
> > > +               gfp =3D (cc->behavior =3D=3D MADV_F_COLLAPSE_LIGHT ?
> > > +                              GFP_TRANSHUGE_LIGHT :
> > > +                              GFP_TRANSHUGE);
> > >
> > >         if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc=
_nmask)) {
> > >                 *hpage =3D NULL;
> > > @@ -2697,7 +2705,7 @@ static int madvise_collapse_errno(enum scan_res=
ult r)
> > >  }
> > >
> > >  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_stru=
ct **prev,
> > > -                    unsigned long start, unsigned long end)
> > > +                    unsigned long start, unsigned long end, int beha=
vior)
> > >  {
> > >         struct collapse_control *cc;
> > >         struct mm_struct *mm =3D vma->vm_mm;
> > > @@ -2718,6 +2726,7 @@ int madvise_collapse(struct vm_area_struct *vma=
, struct vm_area_struct **prev,
> > >         if (!cc)
> > >                 return -ENOMEM;
> > >         cc->is_khugepaged =3D false;
> > > +       cc->behavior =3D behavior;
> > >
> > >         mmgrab(mm);
> > >         lru_add_drain_all();
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 912155a94ed5..9c40226505aa 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
> > >         case MADV_POPULATE_READ:
> > >         case MADV_POPULATE_WRITE:
> > >         case MADV_COLLAPSE:
> > > +       case MADV_F_COLLAPSE_LIGHT:
> > >                 return 0;
> > >         default:
> > >                 /* be safe, default to 1. list exceptions explicitly =
*/
> > > @@ -1082,8 +1083,9 @@ static int madvise_vma_behavior(struct vm_area_=
struct *vma,
> > >                 if (error)
> > >                         goto out;
> > >                 break;
> > > +       case MADV_F_COLLAPSE_LIGHT:
> > >         case MADV_COLLAPSE:
> > > -               return madvise_collapse(vma, prev, start, end);
> > > +               return madvise_collapse(vma, prev, start, end, behavi=
or);
> > >         }
> > >
> > >         anon_name =3D anon_vma_name(vma);
> > > @@ -1178,6 +1180,7 @@ madvise_behavior_valid(int behavior)
> > >         case MADV_HUGEPAGE:
> > >         case MADV_NOHUGEPAGE:
> > >         case MADV_COLLAPSE:
> > > +       case MADV_F_COLLAPSE_LIGHT:
> > >  #endif
> > >         case MADV_DONTDUMP:
> > >         case MADV_DODUMP:
> > > @@ -1194,6 +1197,17 @@ madvise_behavior_valid(int behavior)
> > >         }
> > >  }
> > >
> > > +
> > > +static bool process_madvise_behavior_only(int behavior)
> > > +{
> > > +       switch (behavior) {
> > > +       case MADV_F_COLLAPSE_LIGHT:
> > > +               return true;
> > > +       default:
> > > +               return false;
> > > +       }
> > > +}
> > > +
> > >  static bool process_madvise_behavior_valid(int behavior)
> > >  {
> > >         switch (behavior) {
> > > @@ -1201,6 +1215,7 @@ static bool process_madvise_behavior_valid(int =
behavior)
> > >         case MADV_PAGEOUT:
> > >         case MADV_WILLNEED:
> > >         case MADV_COLLAPSE:
> > > +       case MADV_F_COLLAPSE_LIGHT:
> > >                 return true;
> > >         default:
> > >                 return false;
> > > @@ -1368,6 +1383,8 @@ int madvise_set_anon_name(struct mm_struct *mm,=
 unsigned long start,
> > >   *             transparent huge pages so the existing pages will not=
 be
> > >   *             coalesced into THP and new pages will not be allocate=
d as THP.
> > >   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> > > + *  MADV_F_COLLAPSE_LIGHT - only for process_madvise, avoids direct =
reclaim and/or
> > > + *             compaction.
> > >   *  MADV_DONTDUMP - the application wants to prevent pages in the gi=
ven range
> > >   *             from being included in its core dump.
> > >   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core =
dump.
> > > @@ -1394,7 +1411,8 @@ int madvise_set_anon_name(struct mm_struct *mm,=
 unsigned long start,
> > >   *  -EBADF  - map exists, but area maps something that isn't a file.
> > >   *  -EAGAIN - a kernel resource was temporarily unavailable.
> > >   */
> > > -int do_madvise(struct mm_struct *mm, unsigned long start, size_t len=
_in, int behavior)
> > > +int _do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in,
> > > +               int behavior, bool is_process_madvise)
> > >  {
> > >         unsigned long end;
> > >         int error;
> > > @@ -1405,6 +1423,9 @@ int do_madvise(struct mm_struct *mm, unsigned l=
ong start, size_t len_in, int beh
> > >         if (!madvise_behavior_valid(behavior))
> > >                 return -EINVAL;
> > >
> > > +       if (!is_process_madvise && process_madvise_behavior_only(beha=
vior))
> > > +               return -EINVAL;
> > > +
> > >         if (!PAGE_ALIGNED(start))
> > >                 return -EINVAL;
> > >         len =3D PAGE_ALIGN(len_in);
> > > @@ -1448,9 +1469,14 @@ int do_madvise(struct mm_struct *mm, unsigned =
long start, size_t len_in, int beh
> > >         return error;
> > >  }
> > >
> > > +int do_madvise(struct mm_struct *mm, unsigned long start, size_t len=
_in, int behavior)
> > > +{
> > > +       return _do_madvise(mm, start, len_in, behavior, false);
> > > +}
> > > +
> > >  SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, =
behavior)
> > >  {
> > > -       return do_madvise(current->mm, start, len_in, behavior);
> > > +       return _do_madvise(current->mm, start, len_in, behavior, fals=
e);
> > >  }
> > >
> > >  SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __us=
er *, vec,
> > > @@ -1504,8 +1530,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, co=
nst struct iovec __user *, vec,
> > >         total_len =3D iov_iter_count(&iter);
> > >
> > >         while (iov_iter_count(&iter)) {
> > > -               ret =3D do_madvise(mm, (unsigned long)iter_iov_addr(&=
iter),
> > > -                                       iter_iov_len(&iter), behavior=
);
> > > +               ret =3D _do_madvise(mm, (unsigned long)iter_iov_addr(=
&iter),
> > > +                                       iter_iov_len(&iter), behavior=
, true);
> > >                 if (ret < 0)
> > >                         break;
> > >                 iov_iter_advance(&iter, iter_iov_len(&iter));
> > > diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/inc=
lude/uapi/asm-generic/mman-common.h
> > > index 6ce1f1ceb432..92c67bc755da 100644
> > > --- a/tools/include/uapi/asm-generic/mman-common.h
> > > +++ b/tools/include/uapi/asm-generic/mman-common.h
> > > @@ -78,6 +78,7 @@
> > >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lo=
cked pages too */
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but a=
voids direct reclaim and/or compaction */
> > >
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > > --
> > > 2.33.1
> > >

