Return-Path: <linux-kernel+bounces-100722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23992879C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6A1F2299D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C06142648;
	Tue, 12 Mar 2024 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="29nE4Knf"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671687A13C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272786; cv=none; b=c0+UWoIGJLegyJhiZSr6ib+YhoZZrQfb26tv2hSm3MV4GdkS8B3+v9sIvZvTva8n7WKQ5+FVqTLYG1wwvIq0HLrO3YzfAX1QuprMyuOr8fOWP4ICJwi5J5gMYRqH5bnHR3V05jkggw/qKI0yb3e/u794J0QfboLP85lJrpPTAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272786; c=relaxed/simple;
	bh=5mUls8Ku27e1Rzkt70Xdh/u8lFDUn59BuyQL45vxSic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7eDC4EB0FCCCqeaUaDrTyZm4+gX82+qBIg+iFHqpbl1+QJSJ5FTgMArfGOl1iA8qUEgnVxcFSktuDpgOFR8JLYkX3y9PBR++LPoOs3llgsoaCBhnfBicBR03VnshKIyOfSrzUcWXTEaWAZHL2vkicUBKt8y1pfY1HL8ox7cVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=29nE4Knf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1e992f069so3019609b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710272783; x=1710877583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k5a1edRWn/GNqW+k0d2uxrg3xuipstfEZ2u0wtLdYU=;
        b=29nE4KnfgRj+O1d0Stww5Y9jFx2MVSis5xWiXOy12T/42qKQKuzj/s+wOkuvI8pOlp
         mTRB2skdRvVWKq6sgW5TMnuMV1Q1jCPCMWvlfbh0fY8V2200u/GivzZr7AGROE+taOlH
         UBnSE2shitIMfmvfAn2pb4/UagY1iJBU0JUTbItcYuWsTnZUgSzRvMMrZJ0D16PLKs9L
         MgnY+fu7olI5TiPmnS/TzOoRPqBKRI2OG79kxjSxcrQ2u8MxTSir+8rdfEusob/9XkeQ
         +Ua6632/659UlJNK/rKAQ3u2AA3trBslLkQ20RHAPQ+G9y4aZ6vFjHBaU0J+TySvi/4g
         y3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710272783; x=1710877583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k5a1edRWn/GNqW+k0d2uxrg3xuipstfEZ2u0wtLdYU=;
        b=ZbUYlDEEEzQZ/Jhu8orpHyWCjz+jENCwpU6LsRmVIVTVmOypHBLZAwgYj9PpQwip0c
         UvltxIuOaDCs67Qz2tDDt1BWZ4547X6/UJ11N9o1Xq0GPU3LeXvzgr7Fw/A+hje2Vl5c
         3zb8FWkHaOzwW4sJQ5yhvZHcwvqcMO/KSnRs0yQM77YK81iPE6P/oEhgu5u8Ng+zP+LM
         bS/RF1scxgMTdR2k1TqWN/X2Pk96xwQqVQisYMxLx0wIi/KdwUCtoxaggQUuymazumYb
         Eu86YWUY0BH5DwjxWWbzrEOdIKQl8VBFH6A7E3KsJXjd9Alp+kZMnMLz2+snr6jCOhmP
         ztRg==
X-Gm-Message-State: AOJu0YxDQcXgVaKoKqdzhaXycpg3UZsakGszK/B/rnyXg+Gmkro4PFTU
	J1m0mot0exjzTCvSoIjahXAMg/k7P4AtaOb2uOHPPo2pUS3FbBuPUPaH1v6leYI9hhUpgPyX6LF
	pa/x+tl77yoDJtZfQb+et0jLk0Tavga2JXFwAaw==
X-Google-Smtp-Source: AGHT+IFCSecG9JVro32J9SgF6VVa2fZX7giCOM+EunUYFBUZXmDzBkZ/0+GBTOC0v9b6/Zvw5GomwU16QkYU+z1k1Eg=
X-Received: by 2002:a05:6808:1528:b0:3c2:1792:105b with SMTP id
 u40-20020a056808152800b003c21792105bmr13478223oiw.43.1710272782623; Tue, 12
 Mar 2024 12:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com> <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
In-Reply-To: <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 12 Mar 2024 15:45:44 -0400
Message-ID: <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, jacob.jun.pan@linux.intel.com, 
	jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kent.overstreet@linux.dev, kinseyho@google.com, 
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org, 
	mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com, 
	mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com, 
	peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com, 
	rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de, urezki@gmail.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 1:19=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
>
>
> On 3/11/24 09:46, Pasha Tatashin wrote:
> > This is follow-up to the LSF/MM proposal [1]. Please provide your
> > thoughts and comments about dynamic kernel stacks feature. This is a WI=
P
> > has not been tested beside booting on some machines, and running LKDTM
> > thread exhaust tests. The series also lacks selftests, and
> > documentations.
> >
> > This feature allows to grow kernel stack dynamically, from 4KiB and up
> > to the THREAD_SIZE. The intend is to save memory on fleet machines. Fro=
m
> > the initial experiments it shows to save on average 70-75% of the kerne=
l
> > stack memory.
> >
> > The average depth of a kernel thread depends on the workload, profiling=
,
> > virtualization, compiler optimizations, and driver implementations.
> > However, the table below shows the amount of kernel stack memory before
> > vs. after on idling freshly booted machines:
> >
> > CPU           #Cores #Stacks  BASE(kb) Dynamic(kb)   Saving
> > AMD Genoa        384    5786    92576       23388    74.74%
> > Intel Skylake    112    3182    50912       12860    74.74%
> > AMD Rome         128    3401    54416       14784    72.83%
> > AMD Rome         256    4908    78528       20876    73.42%
> > Intel Haswell     72    2644    42304       10624    74.89%
> >
> > Some workloads with that have millions of threads would can benefit
> > significantly from this feature.
> >
>
> Ok, first of all, talking about "kernel memory" here is misleading.

Hi Peter,

I re-read my cover letter, and I do not see where "kernel memory" is
mentioned. We are talking about kernel stacks overhead that is
proportional to the user workload, as every active thread has an
associated kernel stack. The idea is to save memory by not
pre-allocating all pages of kernel-stacks, but instead use it as a
safeguard when a stack actually becomes deep. Come-up with a solution
that can handle rare deeper stacks only when needed. This could be
done through faulting on the supported hardware (as proposed in this
series), or via pre-map on every schedule event, and checking the
access when thread goes off cpu (as proposed by Andy Lutomirski to
avoid double faults on x86) .

In other words, this feature is only about one very specific type of
kernel memory that is not even directly mapped (the feature required
vmapped stacks).

> Unless your threads are spending nearly all their time sleeping, the
> threads will occupy stack and TLS memory in user space as well.

Can you please elaborate, what data is contained in the kernel stack
when thread is in user space? My series requires thread_info not to be
in the stack by depending on THREAD_INFO_IN_TASK.

> Second, non-dynamic kernel memory is one of the core design decisions in
> Linux from early on. This means there are lot of deeply embedded
> assumptions which would have to be untangled.
>
> Linus would, of course, be the real authority on this, but if someone
> would ask me what the fundamental design philosophies of the Linux
> kernel are -- the design decisions which make Linux Linux, if you will
> -- I would say:
>
>         1. Non-dynamic kernel memory
>         2. Permanent mapping of physical memory

The one and two are correlated. Given that all the memory is directly
mapped, the kernel core cannot be relocatable, swappable, faultable
etc.

>         3. Kernel API modeled closely after the POSIX API
>            (no complicated user space layers)
>         4. Fast system call entry/exit (a necessity for a
>            kernel API based on simple system calls)
>         5. Monolithic (but modular) kernel environment
>            (not cross-privilege, coroutine or message passing)
>
> Third, *IF* this is something that should be done (and I personally
> strongly suspect it should not), at least on x86-64 it probably should
> be for FRED hardware only. With FRED, it is possible to set the #PF
> event stack level to 1, which will cause an automatic stack switch for
> #PF in kernel space (only). However, even in kernel space, #PF can sleep
> if it references a user space page, in which case it would have to be
> demoted back onto the ring 0 stack (there are multiple ways of doing
> that, but it does entail an overhead.)

My understanding is that with the proposed approach only double faults
are prohibited to be used. Pre-map/check-access could still work, even
though it would add some cost to the context switching.

Thank you,
Pasha

