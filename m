Return-Path: <linux-kernel+bounces-99949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2710878FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6147A2823C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A669D0A;
	Tue, 12 Mar 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vzk1TDiB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2D28EB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232139; cv=none; b=JrIWzAPj2M1J/Ar0y52/81vMk82F99tqcgSbn0F+oTXmwyWr+27cyiZZlEEhbIUYWU+hU0FNEvb0zDXK6NJedFbwZCshMG0tUm/MBDN15HWB22IZhURcZjKm+dzf0WgufVDfnOMhh7M4h1PQIwVlJSsGmyEczbGfQHxOTqrpdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232139; c=relaxed/simple;
	bh=psmjbQmPLmfxMmbO4s6LdKehCa8J9E6XiislJN/2Rgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfwSbUfUvctJODi0c2YrLcIMP9mk+S4bW38zMPAI+WpVjkqauZX5jeuFGYNqnir60VTDntzbBERaAe1lb8QsLpXkhYaTTJSl0F5xNROPy06riwE8WsZyvy1yhBQfgXmpXevk9brRirtFCmM+hrrDDRFk72dg7ZEp7mievZV7NTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vzk1TDiB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710232136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb0BqCQLQyXnnm+25Ao0wHPWfcqy9bbgAGmvIGQI/fw=;
	b=Vzk1TDiBoW6W/bLLe4htVHccrfAh76gTcWcpN1ujGJKTKg7C8yK4FbdcOQdv469nH6q0Yf
	zOSn6VrOmMnBFzI0aoZhH+xaEZqPSQ9Zis/row3GWdf+WnQzwAZ+2ZEHR7zy3/svuyWlNX
	Xm0ZJUgHDXD95AwHEmdsYBMYX5Sz37o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-IVS8izIMPqKo_00j3mF82w-1; Tue, 12 Mar 2024 04:28:54 -0400
X-MC-Unique: IVS8izIMPqKo_00j3mF82w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4648e992c4so10036766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710232133; x=1710836933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qb0BqCQLQyXnnm+25Ao0wHPWfcqy9bbgAGmvIGQI/fw=;
        b=aL3ZP/ZELIh+tqNapLGIr20BNsgoLZGojhPmoNfm77r8IXWrO0TbTitTW+vaGqQjZc
         yaCjQJfOi37H1Lolomo5syKHIkm9SUR/aqr5sRR3q+pTrZCf55sQnVF9+GHGw0HzmULM
         FqYFoo+gdLr4OF6EviEQgi51H+pqieSp67raNRpFcjhH27bsk+akvpl+R4nTTtXOC3XE
         2r3T8qm87OamBbJVQqbF8mAH+8meJDKdaGmEW9OObPOj6b6Mzmumrev6SDps/A5tLWAf
         PQKsN/QRQsk19xjJATFlhCzzZMDIvv3O/QQj1RLL8Y+0NgBf2XGA5D3jQwC1FKzbhUX+
         JqCQ==
X-Gm-Message-State: AOJu0Ywy8IgpVJDXUM8lMxX0D51UZTnBn5zqIbOKDX2yjblg6k239cdm
	VoVzvFgtSQTNQeyvdB5u/0egmnH567WAhoNF0ZRtjAyzl/ZtzBpwVrmpgr9S99D+RfQJfvMOjTL
	+4/PqOZByM8qoSGcw0Zh/HfBbZZBd2TJ4p7aPqZ7oDc9ypt/EBBZmkHTDxAZYgcJTceBtWfTLeG
	Lp0bEl3bRpNrMfZGwEc2TMaPWfMtv7SFeM18Jz
X-Received: by 2002:a17:906:6d46:b0:a45:b773:2e14 with SMTP id a6-20020a1709066d4600b00a45b7732e14mr4952053ejt.47.1710232132718;
        Tue, 12 Mar 2024 01:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYswyd1wPoWBc5jpBp8lhgE/fij7GNdIlDnXtCIM8S4lm9vDEf11KTAJZlACuG2dpXsE+Wrv0iXKeVqrVsMTk=
X-Received: by 2002:a17:906:6d46:b0:a45:b773:2e14 with SMTP id
 a6-20020a1709066d4600b00a45b7732e14mr4952039ejt.47.1710232132194; Tue, 12 Mar
 2024 01:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20190205155944.16007-1-dave.rodgman@arm.com> <ZeqFNf6Ay6yNq2kW@localhost.localdomain>
 <AS8PR08MB102898FB26D627E790FE8D4638F272@AS8PR08MB10289.eurprd08.prod.outlook.com>
In-Reply-To: <AS8PR08MB102898FB26D627E790FE8D4638F272@AS8PR08MB10289.eurprd08.prod.outlook.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 12 Mar 2024 16:28:15 +0800
Message-ID: <CAO7dBbUvGRzwJKdcds2sr6T_KXnyubyOHtJe6kGG77eEcT1q0g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3]: lib/lzo: run-length encoding support
To: Dave Rodgman <dave.rodgman@arm.com>, "markus@oberhumer.com" <markus@oberhumer.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Sealey <Matt.Sealey@arm.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "minchan@kernel.org" <minchan@kernel.org>, 
	"nitingupta910@gmail.com" <nitingupta910@gmail.com>, "rpurdie@openedhand.com" <rpurdie@openedhand.com>, 
	"sergey.senozhatsky.work@gmail.com" <sergey.senozhatsky.work@gmail.com>, 
	"sonnyrao@google.com" <sonnyrao@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:32=E2=80=AFPM Dave Rodgman <dave.rodgman@arm.com> =
wrote:
>
> Hi Tao,
>
>
> I don=E2=80=99t see any reason for the upstream LZO library not to pick u=
p the lzo-rle algorithm from the kernel, and I would expect the same perfor=
mance benefit in userspace. This is really a question for Markus (the owner=
/maintainer of that library).
>
Hi Markus,

Is it possible to port the lzo-rle algorithm to the lzo library, so
userspace programs such as crash-utility or drgn can use it to
decompress the kernel data? Thanks in advance!

>
> I think the simplest short-term option would be to pull in the lzo librar=
y as source into crash-utility, and carry a patch against it to add support=
 for lzo-rle.

Hi Dave,

Thanks for the suggestion! I agree with your short-term option, this
is what we are planning to do for now. If lzo-rle has been integrated
into the lzo library, we can then delete the patch from crash-utility
code.

Thanks,
Tao Liu

>
>
> Dave
>
>
> From: Tao Liu <ltao@redhat.com>
> Date: Friday, 8 March 2024 at 03:26
> To: Dave Rodgman <dave.rodgman@arm.com>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, Matt Sea=
ley <Matt.Sealey@arm.com>, davem@davemloft.net <davem@davemloft.net>, gregk=
h@linuxfoundation.org <gregkh@linuxfoundation.org>, herbert@gondor.apana.or=
g.au <herbert@gondor.apana.org.au>, markus@oberhumer.com <markus@oberhumer.=
com>, minchan@kernel.org <minchan@kernel.org>, nitingupta910@gmail.com <nit=
ingupta910@gmail.com>, rpurdie@openedhand.com <rpurdie@openedhand.com>, ser=
gey.senozhatsky.work@gmail.com <sergey.senozhatsky.work@gmail.com>, sonnyra=
o@google.com <sonnyrao@google.com>, akpm@linux-foundation.org <akpm@linux-f=
oundation.org>, sfr@canb.auug.org.au <sfr@canb.auug.org.au>, nd <nd@arm.com=
>
> Subject: Re: [PATCH v5 0/3]: lib/lzo: run-length encoding support
>
> Hi Dave,
>
> On Tue, Feb 05, 2019 at 03:59:59PM +0000, Dave Rodgman wrote:
> > Hi,
> >
> > Following on from the previous lzo-rle patchset:
> >
> > https://lkml.org/lkml/2018/11/30/972
> >
> > This patchset contains only the RLE patches, and should be applied on t=
op of
> > the non-RLE patches ( https://lkml.org/lkml/2019/2/5/366 ).
> >
>
> Sorry for the interruption, since it is an old patchset and discussion.
> I have a few questions on lzo-rle support, hope you can give me some
> directions, thanks in advance!
>
> 1) Is lzo-rle suitable for userspace library? I've checked the current
> userspace lzo library lzo-2.10, it seems no lzo-rle support (Please
> correct me if I'm wrong). If lzo-rle have better performance in kernel,
> then is it possible to implement one in userspace and gain better
> performance as well?
>
> 2) Currently Yulong TANG have encountered problem that, crash utility
> cannot decompress a lzo-rle compressed zram since kernel 5.1 [1], since
> there is no lzo-rle support for current lzo library, crash have to
> import the kernel source code directly into crash, which is not good for
> crash utility code maintainance. It will be better if we can update lzo
> library with lzo-rle support. I guess not only crash, but also other
> kernel debugging tools running in userspace such as drgn may also need
> this feature.
>
> Do you have any suggestions on for these?
>
> [1]: https://www.mail-archive.com/devel@lists.crash-utility.osci.io/msg00=
475.html
>
>
> Thanks,
> Tao Liu
>
>
> >
> > Previously, some questions were raised around the RLE patches. I've don=
e some
> > additional benchmarking to answer these questions. In short:
> >
> >  - RLE offers significant additional performance (data-dependent)
> >  - I didn't measure any regressions that were clearly outside the noise
> >
> >
> > One concern with this patchset was around performance - specifically, m=
easuring
> > RLE impact separately from Matt Sealey's patches (CTZ & fast copy). I h=
ave done
> > some additional benchmarking which I hope clarifies the benefits of eac=
h part
> > of the patchset.
> >
> > Firstly, I've captured some memory via /dev/fmem from a Chromebook with=
 many
> > tabs open which is starting to swap, and then split this into 4178 4k p=
ages.
> > I've excluded the all-zero pages (as zram does), and also the no-zero p=
ages
> > (which won't tell us anything about RLE performance). This should give =
a
> > realistic test dataset for zram. What I found was that the data is VERY
> > bimodal: 44% of pages in this dataset contain 5% or fewer zeros, and 44=
%
> > contain over 90% zeros (30% if you include the no-zero pages). This sup=
ports
> > the idea of special-casing zeros in zram.
> >
> > Next, I've benchmarked four variants of lzo on these pages (on 64-bit A=
rm at
> > max frequency): baseline LZO; baseline + Matt Sealey's patches (aka MS)=
;
> > baseline + RLE only; baseline + MS + RLE. Numbers are for weighted roun=
dtrip
> > throughput (the weighting reflects that zram does more compression than
> > decompression).
> >
> > https://drive.google.com/file/d/1VLtLjRVxgUNuWFOxaGPwJYhl_hMQXpHe/view?=
usp=3Dsharing
> >
> > Matt's patches help in all cases for Arm (and no effect on Intel), as e=
xpected.
> >
> > RLE also behaves as expected: with few zeros present, it makes no diffe=
rence;
> > above ~75%, it gives a good improvement (50 - 300 MB/s on top of the be=
nefit
> > from Matt's patches).
> >
> > Best performance is seen with both MS and RLE patches.
> >
> > Finally, I have benchmarked the same dataset on an x86-64 device. Here,=
 the
> > MS patches make no difference (as expected); RLE helps, similarly as on=
 Arm.
> > There were no definite regressions; allowing for observational error, 0=
1%
> > (3/4178) of cases had a regression > 1 standard deviation, of which the=
 largest
> > was 4.6% (1.2 standard deviations). I think this is probably within the=
 noise.
> >
> > https://drive.google.com/file/d/1xCUVwmiGD0heEMx5gcVEmLBI4eLaageV/view?=
usp=3Dsharing
> >
> > One point to note is that the graphs show RLE appears to help very slig=
htly
> > with no zeros present! This is because the extra code causes the clang
> > optimiser to change code layout in a way that happens to have a signifi=
cant
> > benefit. Taking baseline LZO and adding a do-nothing line like
> > "__builtin_prefetch(out_len);" immediately before the "goto next" has t=
he same
> > effect. So this is a real, but basically spurious effect - it's small e=
nough
> > not to upset the overall findings.
> >
> > Dave
> >
> >


