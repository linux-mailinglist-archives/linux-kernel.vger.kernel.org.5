Return-Path: <linux-kernel+bounces-106413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD387EE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F831C21192
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE454BFA;
	Mon, 18 Mar 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="d2pC0zQ/"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BE54BC8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781293; cv=none; b=fvaCLpUtM0Sd9xbirFPSSSRf5PXqeLPtqwN8jCJtY04r8ezfn6zAwWXsJ69sOALJR8Ygtc8HL0fwGxtUmCKecZoMOrE3Al5FRyKwTBmeoidHyR0o4ExQDj2qQintKsQJeboIWBQnz31tOINiGLGRa6m4cDfMrq7STarpEMx7Xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781293; c=relaxed/simple;
	bh=w7GgSb9S2Enoq5taIUw0h1ISrSxBQIt+nkuhzqbWFhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPD5bdhNbVKd4S/M2UmyLlOWSt0fLQ8VS+0V68sOdQNatNfrYh5kVCWoEVJIrFf5vOxr8g6ebcudMGZDQVF2FrMGH0XZWaccTDHyhoj9zhZ81mDeJ+QRFCPkzknYo32gMSyGlQ1UND4WuVHIVDNcek7HOGcB4rEuJsbvphCSLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=d2pC0zQ/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430c45ab240so11527261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710781291; x=1711386091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n33MLXZoglDyHrWKjv9agU9CQY4n6w7XF7nYX+56vfA=;
        b=d2pC0zQ/Pvr/OPXRZfNkz7mEVs1yYGTR4Xin5rZ84xtEukWv0S3SQbQEWZDKOHtlpt
         LEovb85BBUJkw4EAeK0Qli29kaTGslKlFZ1vRVT0Nijtn2y8x3AXf+Urmraoyn6tQNFj
         CNPM4aPkj6NCpg8nv7k4HNae+cWoX+MZ1V5WiI5h4GY9ULmwmU25EoF9b2bG0CDknBFM
         304Ad3wcENmtAu7f4pEru+YrkwLdDhc9pZLSx4HcVbvx4CYDPua7EfkHfLgChOm1LmKP
         PTwCPp/D9PyWnZ7RoiZ5BFq9eyi7CCPdLP+Npi/Y/E6/29X2vMI3L1U/uYQydaGqfgVo
         l7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781291; x=1711386091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n33MLXZoglDyHrWKjv9agU9CQY4n6w7XF7nYX+56vfA=;
        b=nniy3kNjFdcdPCRB+kbMlC2xcyUCjQE99Keq0S5xgZj577ljS1pHJf8PASnDY1lIuz
         v12rjmFFK4oJHbeHpYihux4CVUAIRjz42PQX/L4VM+zg+2mwCdyptUS1itHBztqis+Gv
         43hcwBZ9yhHxsK7+mD9nP0zfmZc25XaohYctuN89msYYn417NvHpurkaBPUffA5WStIu
         9f9wmwO14V11Myos3fovnoYg5oq7ihrrxVkRIVj6r+WuikqmozYjtWyFYVNyAMCBpXDZ
         FsJiCnnKAzmpgAk7RmId1/s7kTjYDTGQgGe7KgBncM4cHPfRXQoNKJ2m7YBp/WT7MzLx
         zUoA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Z3JmH9wH2CYJluIzAN/wCD16tjVpOrQga/qKB31TgYdLdSfoNq7laDYjDyala+mSluJn/LoT6wd27nVsP9wkWks4V+TCdhUzFfwx
X-Gm-Message-State: AOJu0YyiegVIkuNXdaRm/97NIV0S0IzXOGztCv5SOGCFudqEZHUO/J4w
	C6ZWzw26oy9V/7gjFVxsffe3yfKtKx6pZtJ9eji4sSBYfTdZIt1xyV8JuWZopAE5MAXh181z9J4
	iN7vujTuOJCWiV5+Bq8mT04I/eqiislHA4S1VKQ==
X-Google-Smtp-Source: AGHT+IHLgPlajLx2pVxBiY+uW2kN+jbOqLvMD5j+Bx9XsZ8LoAl/WbjfKey1Lf18oYec9BuA1muX2WLIhYnEVfIYfSs=
X-Received: by 2002:ac8:5cc3:0:b0:430:c1e4:2cb7 with SMTP id
 s3-20020ac85cc3000000b00430c1e42cb7mr8266936qta.43.1710781291061; Mon, 18 Mar
 2024 10:01:31 -0700 (PDT)
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
 <74c82d8a6b5f490784cc8f16fa7d2c12@AcuMS.aculab.com>
In-Reply-To: <74c82d8a6b5f490784cc8f16fa7d2c12@AcuMS.aculab.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Mar 2024 13:00:52 -0400
Message-ID: <CA+CK2bCksQyhNWh-ZonMQSdcr95dDCfe4W0VNVhG+0i7et1fiw@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 11:39=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> ...
> > - exit_to_user_mode(): Unmap the extra three pages and return them to
> > the per-CPU cache. This function is called late in the kernel exit
> > path.
>
> Why bother?
> The number of tasks running in user_mode is limited to the number
> of cpu. So the most you save is a few pages per cpu.
>
> Plausibly a context switch from an interrupt (eg timer tick)
> could suspend a task without saving anything on its kernel stack.
> But how common is that in reality?
> In a well behaved system most user threads will be sleeping on
> some event - so with an active kernel stack.
>
> I can also imagine that something like sys_epoll() actually
> sleeps with not (that much) stack allocated.
> But the calls into all the drivers to check the status
> could easily go into another page.
> You really wouldn't to keep allocating and deallocating
> physical pages (which I'm sure has TLB flushing costs)
> all the time for those processes.
>
> Perhaps a 'garbage collection' activity that reclaims stack
> pages from processes that have been asleep 'for a while' or
> haven't used a lot of stack recently (if hw 'page accessed'
> bit can be used) might make more sense.
>
> Have you done any instrumentation to see which system calls
> are actually using more than (say) 8k of stack?
> And how often the user threads that make those calls do so?

None of our syscalls, AFAIK.

Pasha

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

