Return-Path: <linux-kernel+bounces-106279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A7E87EBD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B0028349A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E14EB5C;
	Mon, 18 Mar 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ZGdzNh+J"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D64AEDC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774849; cv=none; b=r+YrBjgia5Pt0afoaU3oleBnbm9JhoXS9+Q3ma449pdyhinnUibbWrJq7lbJ+NVNWZ+k2C1rINMFEMxjT57Gd/DGTcLQUg7vefDSSFvYxAPq9qcYZljFwtZX6aiqOcikOAnV2gLKPe1SdqNeaSH+LSEKf0x8c89oF18B0hXmKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774849; c=relaxed/simple;
	bh=LXvEujEET7FElIJpyeBKvuJR6SpKTeJdzoGnQ0mSCIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtwBKQzSqPi57f716r5t52Yv1uKxKAdxbEMvuC7aBBEqFYxTWdu/f8QRTvedDe6rb7VyM4yv7GfA7jFquac9D1Z9VUWHrtlyLRynvuZ4RgJEX/zw4+wLT9omxFAfXEMCNl9sRig5Snql26rux1uVqKEyZnUOg+BH+e4oB+QuGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ZGdzNh+J; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c38f4e18eeso212664b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710774847; x=1711379647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLoVguopjyYAO2Q+3Njnwr3an/oqQmvYaecgs71HWf0=;
        b=ZGdzNh+JSql1VavFeLw53omnL5SJ8KTIpWmyxqNVz2rSV76JcAsAkGzxeLR8CxQpiz
         jNIQPwL6+9B7JCXbHchLvS4rt0t/pg12mZvndzcy2ZjB6CMUQjXK1bqvZEBE2DJYNEbM
         F6hABv9dsddt6kDYvPaUOhYKmGBRkjW/7nKqnxpnLqvzOzRTe65aL+inTSV8npGkZK+4
         NqhAYUXBqQ284vMCfwc13qyDVR72DIhxOtkXgvlFFqIz62EMczqFU1CQQJ9UmJM7MKzH
         vjAetLYRZBaPk6ZBr/KR8pR90MPKkSC6oXWISkcHw/ag4wXyt916uWcWD05R4nTjgiSu
         LzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710774847; x=1711379647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLoVguopjyYAO2Q+3Njnwr3an/oqQmvYaecgs71HWf0=;
        b=ffrY8n/BeF3KSX0hMG4kKfLCL1/BoniNHnBkdmu8QyXqcFlocT7drMZ7e4ABRDFBiq
         /L00awFZiL4CeVB3TLB3Zi5h8z3n/oIc2TDfnapWkQ1G1wenYwjp06Ig1WW/hJ9i000g
         Ojp6z/lVBFmScnDYFebi+0ZzqhLfXi2s+sv43zEXG3hySdzddNo8d9Q9E4745GcCybVZ
         b1Kw2fU20HvRQWx79sMkkk7jBoG8iwiJaIX77NkonbiC2SG5lnu3+DkIX4ROtshHfqPM
         u0S33sx0SoN+txupsZcp0i8r4bF/6ssoeSYFR++G01NeI1cJnS0ZxYs6WnXcI3SkjGcQ
         mQCg==
X-Forwarded-Encrypted: i=1; AJvYcCX1eSZTLNzU7kGUy04Ka+nuaG3+JE6MndOAN4zspoZrMNBRGWuGgmnv+kyQzwIaDTf4J0vRFmkLCqr+BjHgiNeHDk7I32D79HEHr2Uw
X-Gm-Message-State: AOJu0Yx5LGWzzvhr8M8EnnG1Pd3EztmRuFUjiQwb+ta/ZNbWfJDPqUia
	cGep1ZTD0aur5ltIWnP7EdceuNxtk9Aw/zUTf4iWb/QKDCt3kYpIpZSj15F0m8PqvXFP2V2zqyO
	i+PsJMO0OHTb7JyNnsFNJBgmM/gyLGK0m5pZrDQ==
X-Google-Smtp-Source: AGHT+IFe2glZzBoZL8XMsEbuSaNNgwqIgMuZ7g3ZjrppV1dgbS8Zr/7hhHIubBtbFYWuKVM+wODY+w8s7aNZp+D2xMM=
X-Received: by 2002:a05:6808:1718:b0:3c2:1891:eb18 with SMTP id
 bc24-20020a056808171800b003c21891eb18mr13938572oib.57.1710774847467; Mon, 18
 Mar 2024 08:14:07 -0700 (PDT)
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
 <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com> <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>
In-Reply-To: <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Mar 2024 11:13:30 -0400
Message-ID: <CA+CK2bCpg9ND7FbbA7R_BK5FjR+rMA6DUoaCXmre70xNQXZoLw@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: David Laight <David.Laight@aculab.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>, 
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com" <bsegall@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dianders@chromium.org" <dianders@chromium.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"eric.devolder@oracle.com" <eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "kinseyho@google.com" <kinseyho@google.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"luto@kernel.org" <luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net" <mic@digikod.net>, 
	"michael.christie@oracle.com" <michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>, 
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"pmladek@suse.com" <pmladek@suse.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"surenb@google.com" <surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"urezki@gmail.com" <urezki@gmail.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:09=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sun, Mar 17, 2024 at 2:58=E2=80=AFPM David Laight <David.Laight@aculab=
com> wrote:
> >
> > From: Pasha Tatashin
> > > Sent: 16 March 2024 19:18
> > ...
> > > Expanding on Mathew's idea of an interface for dynamic kernel stack
> > > sizes, here's what I'm thinking:
> > >
> > > - Kernel Threads: Create all kernel threads with a fully populated
> > > THREAD_SIZE stack.  (i.e. 16K)
> > > - User Threads: Create all user threads with THREAD_SIZE kernel stack
> > > but only the top page mapped. (i.e. 4K)
> > > - In enter_from_user_mode(): Expand the thread stack to 16K by mappin=
g
> > > three additional pages from the per-CPU stack cache. This function is
> > > called early in kernel entry points.
> > > - exit_to_user_mode(): Unmap the extra three pages and return them to
> > > the per-CPU cache. This function is called late in the kernel exit
> > > path.
> >
> > Isn't that entirely horrid for TLB use and so will require a lot of IPI=
?
>
> The TLB load is going to be exactly the same as today, we already use
> small pages for VMA mapped stacks. We won't need to have extra
> flushing either, the mappings are in the kernel space, and once pages
> are removed from the page table, no one is going to access that VA
> space until that thread enters the kernel again. We will need to
> invalidate the VA range only when the pages are mapped, and only on
> the local cpu.

The TLB miss rate is going to slightly increase, but very slightly,
because stacks are small 4-pages with only 3-dynamic pages, and
therefore only up-to 2-3 new misses per syscalls, and that is only for
the complicated deep syscalls, therefore, I suspect it won't affect
the real world performance.

> > Remember, if a thread sleeps in 'extra stack' and is then resheduled
> > on a different cpu the extra pages get 'pumped' from one cpu to
> > another.
>
> Yes, the per-cpu cache can get unbalanced this way, we can remember
> the original CPU where we acquired the pages to return to the same
> place.
>
> > I also suspect a stack_probe() is likely to end up being a cache miss
> > and also slow???
>
> Can you please elaborate on this point. I am not aware of
> stack_probe() and how it is used.
>
> > So you wouldn't want one on all calls.
> > I'm not sure you'd want a conditional branch either.
> >
> > The explicit request for 'more stack' can be required to be allowed
> > to sleep - removing a lot of issues.
> > It would also be portable to all architectures.
> > I'd also suspect that any thread that needs extra stack is likely
> > to need to again.
> > So while the memory could be recovered, I'd bet is isn't worth
> > doing except under memory pressure.
> > The call could also return 'no' - perhaps useful for (broken) code
> > that insists on being recursive.
>
> The current approach discussed is somewhat different from explicit
> more stack requests API. I am investigating how feasible it is to use
> kernel stack multiplexing, so the same pages can be re-used by many
> threads when they are actually used. If the multiplexing approach
> won't work, I will come back to the explicit more stack API.
>
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)

