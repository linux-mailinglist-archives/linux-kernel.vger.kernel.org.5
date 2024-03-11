Return-Path: <linux-kernel+bounces-99491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A230A878925
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1059EB214E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A6C5644B;
	Mon, 11 Mar 2024 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Hys0txg+"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D254206B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186945; cv=none; b=e5Qgpj8YkGoyJir2pr56PgCnrXhzrjMwc5HbtaSZLle0ydYU30jNG6oVmkydHL3AyhBsGzPxdiiQusWjHUWdGfQeoV40MeJ53vb4sg1JeNSSAcDFP4/zaaMu9wiKCwvQorHYmnu7O4Cs9scOzL9EbSZEED5CS9yXMQm+DfGcj1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186945; c=relaxed/simple;
	bh=A1aBHw5gQ1J5Bs32lBVEKHzkNuxIPKT5rP8UBnpACOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgSu7I4fCWaD6/UI3yPvFotlzanS1q5Dz+Tm/8UWuo6sdTMsS76Tbb2LNxt7rBCO4P/m6kYygBQ7OyLG8kOM9gpFG7vFG/Z2Ywx/sah3j9657EMdAvhbfmsKA2ospUOCxWEL48uPJ91f8+tVUu6bZrWiUSdpodBZuo6KZGGqGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Hys0txg+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42f2009e559so34898281cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710186943; x=1710791743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1aBHw5gQ1J5Bs32lBVEKHzkNuxIPKT5rP8UBnpACOM=;
        b=Hys0txg+j9BsIjjTIoc7PjeaAl5M0kn28MMLfeW5G/X1VUu1uYwMbK8KjeBOpr1AZk
         +3CmtwgZFZTCghh0ezmYRmu4FEYMKSSF8xvR6wCK/iSEVqzjjZTRXRitAsNvSOsFey5G
         6oRSR5LGRexFwSlwMTrmeLMBG9aytHfW4V9MQkLInWIBpjTIHuktxnBNxZDtJqfJw6at
         zwO8k3gz8Krc5jiCk1b21ManAgFFaXNkTXMaf3Dt67l66M07xYVdjotCEPGrVF7IE08c
         Npwj9EE6dCT5WZVrDYp90DhD2ctns/nRtUI9azdbGkx+/eqvYGN6ERbwte+jV6jo/bqZ
         xs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710186943; x=1710791743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1aBHw5gQ1J5Bs32lBVEKHzkNuxIPKT5rP8UBnpACOM=;
        b=E6fgCk0W9/09J/Lbk7b2mS8DmBPJPRzvLKLaWiOK/FZXykrADdgpGdJLveBZCFD8kY
         7v6p8LGumAqnL039BYeeW9hrdz6IXqHxTWuhP8231YCv0bmOgaFrACcGaJ+nmT6Y3cmH
         U96QHPDmWodg1DjLEMFexZYTxlSovfpAltmPUygEbxzos8f3BjgB20HP3UNkHI8aVUiH
         kDjFt8LFi2NXhOEZiZ1ryDO/PN6LuU9un0u15NKP6Q5p8EFPU/hX+0FAzVAXokTiOR7l
         JbaKzdiXHC1dRO4doJpEMocmi/vObkyGpOJHUYO6Mj+tkkg4NtIbJxJ5jb0hmgtDaP7K
         /Qzg==
X-Gm-Message-State: AOJu0YxhgCLtRUfpcYPnU6JFpVFa6/CvHOrgYezxrJ1MRUYdKALXpjWD
	sgIR+sn0yyFau2AZ3oOV0TvOt/TSZQFEoen7EIoI3yKF94c5hx5CXungr2dMh4Pqg8I+RSDyMaA
	uK4d4Npk5KvE327BRX/SMehZN1eM67tQQH8Vi9g==
X-Google-Smtp-Source: AGHT+IEbhAQGXiaViORgMJfrvqB5zS4m9SUE1Hq6townGOyxh3VvGdyGHv0NuToNp++Lep6CKcjI4w+N2or15yqECU8=
X-Received: by 2002:a05:622a:4cf:b0:42f:201c:d4e3 with SMTP id
 q15-20020a05622a04cf00b0042f201cd4e3mr12570375qtx.13.1710186942817; Mon, 11
 Mar 2024 12:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <CAGudoHERLX=X1r0q7yHM22O9udsR=6M+geix7TR3f8ZzHkb-hQ@mail.gmail.com>
 <CA+CK2bBr2wH4=L39ZthRPUnAjVxMqt80bsZj0NPx9xdH=_Mn0Q@mail.gmail.com> <CAGudoHHFQPiYkpHrBqSUVDtxaWXLbSc3ZJDOwMEzheBLO8E6Lw@mail.gmail.com>
In-Reply-To: <CAGudoHHFQPiYkpHrBqSUVDtxaWXLbSc3ZJDOwMEzheBLO8E6Lw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 11 Mar 2024 15:55:06 -0400
Message-ID: <CA+CK2bC5Q9cUH8WkOU0FCYC-XE9JJ52QdrXLbUTR3zLBK5Ah=Q@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, hca@linux.ibm.com, 
	hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, 
	jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kent.overstreet@linux.dev, kinseyho@google.com, 
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org, 
	mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com, 
	mingo@redhat.com, mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, 
	pmladek@suse.com, rick.p.edgecombe@intel.com, rostedt@goodmis.org, 
	surenb@google.com, tglx@linutronix.de, urezki@gmail.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:21=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On 3/11/24, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > On Mon, Mar 11, 2024 at 1:09=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> >> 1. what about faults when the thread holds a bunch of arbitrary locks
> >> or has preemption disabled? is the allocation lockless?
> >
> > Each thread has a stack with 4 pages.
> > Pre-allocated page: This page is always allocated and mapped at thread
> > creation.
> > Dynamic pages (3): These pages are mapped dynamically upon stack faults=
.
> >
> > A per-CPU data structure holds 3 dynamic pages for each CPU. These
> > pages are used to handle stack faults occurring when a running thread
> > faults (even within interrupt-disabled contexts). Typically, only one
> > page is needed, but in the rare case where the thread accesses beyond
> > that, we might use up to all three pages in a single fault. This
> > structure allows for atomic handling of stack faults, preventing
> > conflicts from other processes. Additionally, the thread's 16K-aligned
> > virtual address (VA) and guaranteed pre-allocated page means no page
> > table allocation is required during the fault.
> >
> > When a thread leaves the CPU in normal kernel mode, we check a flag to
> > see if it has experienced stack faults. If so, we charge the thread
> > for the new stack pages and refill the per-CPU data structure with any
> > missing pages.
> >
>
> So this also has to happen if the thread holds a bunch of arbitrary
> semaphores and goes off cpu with them? Anyhow, see below.

Yes, this is alright, if thread is allowed to sleep it should not hold
any alloc_pages() locks.

> >> 2. what happens if there is no memory from which to map extra pages in
> >> the first place? you may be in position where you can't go off cpu
> >
> > When the per-CPU data structure cannot be refilled, and a new thread
> > faults, we issue a message indicating a critical stack fault. This
> > triggers a system-wide panic similar to a guard page access violation
> >
>
> OOM handling is fundamentally what I was worried about. I'm confident
> this failure mode makes the feature unsuitable for general-purpose
> deployments.

The primary goal of this series is to enhance system safety, not
introduce additional risks. Memory saving is a welcome side effect.
Please see below for explanations.

>
> Now, I have no vote here, it may be this is perfectly fine as an
> optional feature, which it is in your patchset. However, if this is to
> go in, the option description definitely needs a big fat warning about
> possible panics if enabled.
>
> I fully agree something(tm) should be done about stacks and the
> current usage is a massive bummer. I wonder if things would be ok if
> they shrinked to just 12K? Perhaps that would provide big enough


The current setting of 1 pre-allocated page 3-dynamic page is just
WIP, we can very well change to 2 pre-allocated 2-dynamic pages, or
3/1 etc.

At Google, we still utilize 8K stacks (have not increased it to 16K
when upstream increased it in 2014) and are only now encountering
extreme cases where the 8K limit is reached. Consequently, we plan to
increase the limit to 16K. Dynamic Kernel Stacks allow us to maintain
an 8K pre-allocated stack while handling page faults only in
exceptionally rare circumstances.

Another example is to increase THREAD_SIZE to 32K, and keep 16K
pre-allocated. This is the same as what upstream has today, but avoids
panics with guard pages thus making the systems safer for everyone.

Pasha

