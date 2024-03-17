Return-Path: <linux-kernel+bounces-105399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A487DD64
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB58B20AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43771BF33;
	Sun, 17 Mar 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="LjMbi3Pz"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEC8BEF
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710685190; cv=none; b=bsIQt6Xwgfk+Gnnkbc9mum/MhSakuz5ZbFkCRhXaE6HLItoMBxSW/uXrbxTGcLdWVfvkwRieGERRaKRym5kUWb1SpnMNcLmXM/k9g6+5gBkI97CqEM5LexcygfSSAWA1xyA0L7j0gG42lWY+sNRZYBEQMH1smFPO/CWG8TGNyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710685190; c=relaxed/simple;
	bh=UNjMPJ0IT9mZHeFiSvOawzYn8XuykYs5YZfITsRhjR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijkfH0H3JJ3b1xyxSmL37zrXlLBSBVpWrLOVf/6nCMBi0bWQaGVwfHRO77hms0CaiTFnxIAZiavchWdhJurTYFjCM9XCZ249y8OHVGGsaBZwKM1QIOF/+zwm5dnls5W880DRjH51aofxPYU9625Ez+ak0hkR1mu+9R2t0u3DLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=LjMbi3Pz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430b7b22b17so12964861cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710685187; x=1711289987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwNuNaKlBH+E/NiBRxGLeVBhU4zNhjLmRdGvzie+mxI=;
        b=LjMbi3Pz94wxrdDsVsod5F4zNUUd0RrSSEIKcZ9J/SLC1OaMQFrHsinGtiH7Xfy3rz
         ZNN3CFaIeih3bQrTl30sfgKNE//qI7I4kO/cFUsXW1aEnhX+GozcvRuqkbkJwcPj1l5y
         Gm9Gwm6DyagxkcpXH7hzK3zfknMt5Tz+E2wsACMevQRN+3OhNAnxr+bnPrzkWRhHOwoV
         e4stYa3s5Yoy76PgEkslgBLf2idrJR9WstN3Ley4+X9ceBcu80lGB+HCltU+Hw5kGZ7d
         SHlf1X6bDpzb69TvZkljoBIuFEPryOh79gm7CbiX4OzkJFo2j5HLVZ5D2ma5nrSAeRC0
         I26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710685187; x=1711289987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwNuNaKlBH+E/NiBRxGLeVBhU4zNhjLmRdGvzie+mxI=;
        b=A0FZfzo3fCxJs4QXBsAeUVS1JFbJXP6Qd1Gi1hh1nrJQs0XMFS5Zd0XzriJIlwK9C3
         UkdUGBEOCwZdT+mIAwvZXOVCuX2TQMpVl7xtrYhbr6uI1Jv4d/LaJPZ7vkXHg/XMeH7w
         Y74/Ybbe+UDspsy/3a+q0dz7PyB1+9+Jh9NSKGh5VOaSzjS53WCUGV0/GCOvugU+n/Ct
         oLvySc4JRCNGHWgDNuLIVqCqkgJLvLly+kmMHXMbPGWH/eq4zvR8xZcbTeCgtkjrgup4
         doPxVlN76FCSpHGqHOmVHyQiy64jheJ1O/fA+6PFxLIV0Ueh7NvHC5fQhDaGvvnEKEr4
         gYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK7IyRBpTXfyujBdUYq4qrDOnMTiTttUOT7Sks9TDj6pQ3k0PeKQlP9NjsyXUs3z6/AtkLZao0642izKfelKdeagWuTo7ZzNF+na1U
X-Gm-Message-State: AOJu0YxUhegD0g3CAgmMuhj7VgE4/4Jz8FnsQoAYWikX9a/n13y6ze3k
	RLS3CdVKvY7tgAJp9nfoS9PdlY/cDrelIjc2EVAnpeAAANTO7OD6hp/tgBu8oswcwU4IR37EShe
	uTLgR0NxT6AMRyRpDQK9ibqixvuqY8h/HB83jbA==
X-Google-Smtp-Source: AGHT+IE9nw94WlJTzj6ZoYKzVYmteg9oBLIfDGKl8BLN9y+nmWzFcBjqSPzBHzwvwC7FwgsvLZAe0ORBAOWm4Q3emGs=
X-Received: by 2002:ac8:5c03:0:b0:42e:db36:ad2e with SMTP id
 i3-20020ac85c03000000b0042edb36ad2emr13697654qti.26.1710685187151; Sun, 17
 Mar 2024 07:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com> <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <ZfY8PSnsLtkHBBZF@casper.infradead.org>
In-Reply-To: <ZfY8PSnsLtkHBBZF@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 17 Mar 2024 10:19:10 -0400
Message-ID: <CA+CK2bATJ7_EUszq4nr0AuZXG76nUhDs9osbxPUs=mLPFtW8Zg@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Matthew Wilcox <willy@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	x86@kernel.org, bp@alien8.de, brauner@kernel.org, bristot@redhat.com, 
	bsegall@google.com, dave.hansen@linux.intel.com, dianders@chromium.org, 
	dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com, 
	hch@infradead.org, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, 
	jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 8:41=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Mar 16, 2024 at 03:17:57PM -0400, Pasha Tatashin wrote:
> > Expanding on Mathew's idea of an interface for dynamic kernel stack
> > sizes, here's what I'm thinking:
> >
> > - Kernel Threads: Create all kernel threads with a fully populated
> > THREAD_SIZE stack.  (i.e. 16K)
> > - User Threads: Create all user threads with THREAD_SIZE kernel stack
> > but only the top page mapped. (i.e. 4K)
> > - In enter_from_user_mode(): Expand the thread stack to 16K by mapping
> > three additional pages from the per-CPU stack cache. This function is
> > called early in kernel entry points.
> > - exit_to_user_mode(): Unmap the extra three pages and return them to
> > the per-CPU cache. This function is called late in the kernel exit
> > path.
> >
> > Both of the above hooks are called with IRQ disabled on all kernel
> > entries whether through interrupts and syscalls, and they are called
> > early/late enough that 4K is enough to handle the rest of entry/exit.
>
> At what point do we replenish the per-CPU stash of pages?  If we're
> 12kB deep in the stack and call mutex_lock(), we can be scheduled out,
> and then the new thread can make a syscall.  Do we just assume that
> get_free_page() can sleep at kernel entry (seems reasonable)?  I don't
> think this is an infeasible problem, I'd just like it to be described.

Once irq is enabled it is perfectly OK to sleep and wait for the stack
pages to become available.

The following user entries that enable interrupts:
do_user_addr_fault()
   local_irq_enable()

do_syscall_64()
  syscall_enter_from_user_mode()
    local_irq_enable()

__do_fast_syscall_32()
  syscall_enter_from_user_mode_prepare()
    local_irq_enable()

exc_debug_user()
  local_irq_enable()

do_int3_user()
  cond_local_irq_enable()

With those it is perfectly OK to sleep and wait for the page to become
available when we are in a situation where the per-cpu cache is empty,
and alloc_page(GFP_NOWAIT) does not succeed.

The other interrupts from userland never enable IRQs. We can have
3-pages per-cpu reserved for handling specifically IRQ-never enable
cases, as there cannot be more than one ever needed.

Pasha

