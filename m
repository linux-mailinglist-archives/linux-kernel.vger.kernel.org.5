Return-Path: <linux-kernel+bounces-160213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58878B3AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E171C24E57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E28149004;
	Fri, 26 Apr 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iLZZeVgt"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8026149005
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144081; cv=none; b=LKGoDrp91M0f5ls5islItMMmvtTxStShkYdBTAN7cFrxYHnePlRdr3F3mqy5GCDv9hV9I/UWWDIjCI3UbR2+GQUR8UA8GzshP08Nhlc6qboSk6GDOR1Xa4bm2illDT2KyiYPWYiAuM42wvbyobA1imQq/7tUaSgrTKKyyIdBfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144081; c=relaxed/simple;
	bh=74+h833F7KuE3CU2RLXDIMhEZbS3VhL/7P0V9RoRcNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9v3tJVKxfK8Hmz3E7571VYeV9JMUcnFI0XzDtt9kAOk6w50HexN6FWqrlwqn20m6JZu3t5OknKlAYhAaf5o+eKBZKwGCpz3ibM3tdxdlaqHPTvr0+eMsrD1nJvexHLl0XySRgYSeEdbXYV9RyAgFavnZ/k0hLtlnPMpoljLCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLZZeVgt; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de467733156so2429194276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714144078; x=1714748878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AshHIINCHfrEJ1aw52tTBKusLV1VbfsknGj7LmigqNg=;
        b=iLZZeVgt/GtbbiRrsRAvyBYY+zoVLddOpCsRNNdj8hykwPY5hxk77gJ2ThK52/o9GG
         ZXRwq6eVnDYWQyM+y6n5Ln77mMnFFglq/owtbQWhZPotQej/5QH7U3PnX7GRpAnLxE/A
         Q/Myj5Uq+OK9gfIc/ASZL6zj8BZ1DYFQICFE64SguECBHRBf1wJN8gu1JQMN7uI8+0j2
         OCmm7FFrdcqGKeIhWNVURS2MseCYvJrmCvsq1RoKC6KP6juhLpgSV9ie1OZXpwrReKWZ
         Sf9KeWNB/Da1mc4TTfPx/S2ICGk2/+8s3R384kZW4VJfAUVzXl/P3HSAGirnw+ubg3SQ
         lZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144078; x=1714748878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AshHIINCHfrEJ1aw52tTBKusLV1VbfsknGj7LmigqNg=;
        b=CmyGYG7It3N64iyp/Zsu8oHtwtdM7U8n1oux14TdbJskk+UG5AvilHqescpzcf0wGy
         X68BwvlT7jTsSchHfsFujxxRRsoWnc02Ur/YFqcl+zPHnHRmzTxDFNbvk2x10lt9s06u
         4ixh1/SmnPLknXWEm8kF4kEPTNIRNAf/+BgVEELPiSGgbpO6cVZhjxzeN0tzosSJvlLl
         EYICfHxB8enPL6Vf01HeM03+Z77RpTyV0ftODWXCfvGzxBIMC0+GKvG+R2JOejTBPzlF
         YgmitgYnhr+4g75KnsIbakTKfK1SH6GCaMVXWS1XqkqttCo0PrjgQJRI8hAYSo40gDwf
         ajRA==
X-Forwarded-Encrypted: i=1; AJvYcCVRxsJhwmM3711e0K5OR7kg0Nkqyfdoc4cn1amLWn58P5JrM6EYNNjmm2fRuCqa/rlJw7FFsWoRzro+wyxs+MEUEfno+wIZWS6N1KXE
X-Gm-Message-State: AOJu0Yyz5owr+eYUv5qcO7VASKdKwCv0QVQ8jnevGQWoFiz9cDRMFzpJ
	goSMHlSnZ2AZZxfeIP8OBsbGwYY6KDSs4mjIPNgtAry/VSS5hsQseDLTA8NyOuyLa3/niF1LbNr
	KZo5NEZlsbgNwkUfSVTpA+mCOo+qXbxXgj76T
X-Google-Smtp-Source: AGHT+IEPdJOCECpQwgyW7T9g2AjIKgZqrtGF5uj7NmaxDYMgsp9CKHbIVdePT4Mz8xBUIi2KaQJh+V9suKlsaqMKDKE=
X-Received: by 2002:a25:8487:0:b0:dcd:3172:7269 with SMTP id
 v7-20020a258487000000b00dcd31727269mr3662087ybk.2.1714144078186; Fri, 26 Apr
 2024 08:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170621.2011171-1-peterx@redhat.com> <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n> <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n> <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org> <ZiuzikG6-jDpbitv@casper.infradead.org>
In-Reply-To: <ZiuzikG6-jDpbitv@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Apr 2024 08:07:45 -0700
Message-ID: <CAJuCfpH+O0NYtTrGKSY6FjBOcWpyKXB+_4rsSRjcewSXUWVfCQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:00=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 12, 2024 at 04:14:16AM +0100, Matthew Wilcox wrote:
> > Suren, what would you think to this?
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6e2fe960473d..e495adcbe968 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5821,15 +5821,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct=
 mm_struct *mm,
> >         if (!vma_start_read(vma))
> >                 goto inval;
> >
> > -       /*
> > -        * find_mergeable_anon_vma uses adjacent vmas which are not loc=
ked.
> > -        * This check must happen after vma_start_read(); otherwise, a
> > -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate t=
he VMA
> > -        * from its anon_vma.
> > -        */
> > -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> > -               goto inval_end_read;
> > -
> >         /* Check since vm_start/vm_end might change before we lock the =
VMA */
> >         if (unlikely(address < vma->vm_start || address >=3D vma->vm_en=
d))
> >                 goto inval_end_read;
> >
> > That takes a few insns out of the page fault path (good!) at the cost
> > of one extra trip around the fault handler for the first fault on an
> > anon vma.  It makes the file & anon paths more similar to each other
> > (good!)
> >
> > We'd need some data to be sure it's really a win, but less code is
> > always good.
>
> Intel's 0day got back to me with data and it's ridiculously good.
> Headline figure: over 3x throughput improvement with vm-scalability
> https://lore.kernel.org/all/202404261055.c5e24608-oliver.sang@intel.com/
>
> I can't see why it's that good.  It shouldn't be that good.  I'm
> seeing big numbers here:
>
>       4366 =C4=85  2%    +565.6%      29061        perf-stat.overall.cycl=
es-between-cache-misses
>
> and the code being deleted is only checking vma->vm_ops and
> vma->anon_vma.  Surely that cache line is referenced so frequently
> during pagefault that deleting a reference here will make no difference
> at all?

That indeed looks overly good. Sorry, I didn't have a chance to run
the benchmarks on my side yet because of the ongoing Android bootcamp
this week.

>
> We've clearly got an inlining change.  viz:
>
>      72.57           -72.6        0.00        perf-profile.calltrace.cycl=
es-pp.exc_page_fault.asm_exc_page_fault.do_access
>      73.28           -72.6        0.70        perf-profile.calltrace.cycl=
es-pp.asm_exc_page_fault.do_access
>      72.55           -72.5        0.00        perf-profile.calltrace.cycl=
es-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
>      69.93           -69.9        0.00        perf-profile.calltrace.cycl=
es-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_f=
ault.do_access
>      69.12           -69.1        0.00        perf-profile.calltrace.cycl=
es-pp.down_read_killable.lock_mm_and_find_vma.do_user_addr_fault.exc_page_f=
ault.asm_exc_page_fault
>      68.78           -68.8        0.00        perf-profile.calltrace.cycl=
es-pp.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma.do_u=
ser_addr_fault.exc_page_fault
>      65.78           -65.8        0.00        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read_killable.lock_m=
m_and_find_vma.do_user_addr_fault
>      65.43           -65.4        0.00        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_s=
lowpath.down_read_killable.lock_mm_and_find_vma
>
>      11.22           +86.5       97.68        perf-profile.calltrace.cycl=
es-pp.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
>      11.14           +86.5       97.66        perf-profile.calltrace.cycl=
es-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap=
_pgoff.do_syscall_64
>       3.17 =C4=85  2%     +94.0       97.12        perf-profile.calltrace=
cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_wr=
ite_killable.vm_mmap_pgoff
>       3.45 =C4=85  2%     +94.1       97.59        perf-profile.calltrace=
cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killa=
ble.vm_mmap_pgoff.ksys_mmap_pgoff
>       0.00           +98.2       98.15        perf-profile.calltrace.cycl=
es-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hw=
frame
>       0.00           +98.2       98.16        perf-profile.calltrace.cycl=
es-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>
> so maybe the compiler has been able to eliminate some loads from
> contended cachelines?
>
>     703147           -87.6%      87147 =C4=85  2%  perf-stat.ps.context-s=
witches
>     663.67 =C4=85  5%   +7551.9%      50783        vm-scalability.time.in=
voluntary_context_switches
>  1.105e+08           -86.7%   14697764 =C4=85  2%  vm-scalability.time.vo=
luntary_context_switches
>
> indicates to me that we're taking the mmap rwsem far less often (those
> would be accounted as voluntary context switches).
>
> So maybe the cache miss reduction is a consequence of just running for
> longer before being preempted.
>
> I still don't understand why we have to take the mmap_sem less often.
> Is there perhaps a VMA for which we have a NULL vm_ops, but don't set
> an anon_vma on a page fault?

I think the only path in either do_anonymous_page() or
do_huge_pmd_anonymous_page() that skips calling anon_vma_prepare() is
the "Use the zero-page for reads" here:
https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L4265. I
didn't look into this particular benchmark yet but will try it out
once I have some time to benchmark your change.

>

