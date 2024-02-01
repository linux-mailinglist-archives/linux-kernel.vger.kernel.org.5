Return-Path: <linux-kernel+bounces-47589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D433844FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DE728A7AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C013AC34;
	Thu,  1 Feb 2024 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzsfHy7D"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D03A8F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758887; cv=none; b=VsjvPhKvy3Loav1+y/ExHSEdo1DRIL0E84RcLuSiNu8UnmCokMrxIaNrKqN3LiZkmcHRa/I/RmpOgn2Xbxou/O+a+oMLVbneN21Bx61qeP4AIRK9x52TaShm2nQA5vbgEau78JgzxUc8M7YAfea1dZ5yJKw12NB3wRX5t8ROlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758887; c=relaxed/simple;
	bh=pD0qQqzTU6WGAJKcIVfmEDXMQaiBlK+UQHQsdA5kW08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkOeW13gxZPkpx2UOZWKfZVZo+u4EO04H/CxtxZrtpTHvKO/qLFZN8e4nOl2IqZNju0Y6IO971RI/o7sbNqaoG5dIG72zA2pDen5tusBEzVD3Pc4toPrUZ3Uardm62FJa7JopFet5EzuLmVxxGjz+AjQN8Xam9qno7eQvE+Pns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzsfHy7D; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-46b3359f5efso210307137.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706758885; x=1707363685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DGWnf0OzAJDC2ay8IuZMeYL0UHzgLCYpMni5nUB1LM=;
        b=EzsfHy7DUkkC93PtZxny+wG3nv1kf2sRLJKD1etZQQM4eKswacT0QIzXDr/lh+CZlx
         eZbgfEASxMYKQrtUXbHViloCOASlTr5FYPuR0mmd1DajeB979pQ+g8OB1ad0hl88zpRD
         57DcPJVITTutNIPP7/mqzc1gkTKyaATk5EckdgFXm9wUSjoqJ8eUG7+C4VLR4lIZDNpm
         7YOfk/ofz4YSZsky1VK6EdPc09vHNXxdm/8FeWymZfZZ2n6Q2fvzy4snbuYUc91A5zoW
         KoeHvPAvAwIDnX9uzde5gAbC16yIyaoX3EXygy3S730lgwH5Y1zz6+UGQDNjQLGtxahv
         AYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758885; x=1707363685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DGWnf0OzAJDC2ay8IuZMeYL0UHzgLCYpMni5nUB1LM=;
        b=IuVxGsitDA0GRmO8VI42MBY7d05fKTvNk+JZOWLq69lXI7P4WttdICOm9y5GD/ln3U
         t+j1jQS241ZIou48vrHfsLR9Bb0olLquPKvS5ozNVAHsEkjiaN3Y8nqz4uYTISTIZicV
         cscPsMNNSji+I/OVXm045Q7UC/5HiB8qj9am59kQwojCOsRgr7BY61y+KE4JEEIRjqoD
         XdUxZtXm87l15lJWFjmTUw3AA2TvpPMzOn5waTFphSu/cCNZzzpzFq6tFh4TEVdFFX0y
         ifBttwlaZHL8E0YH2v/Q25dMS7RD07nvVZSZYeSa5sa/2OtC+cDn2IeB+EpZc+Vvlqdw
         u8GA==
X-Gm-Message-State: AOJu0YzkoDi7tq8gu+qPomWCLXH7AHACRz8Y1KciLkT5WwJv3F3GqOez
	P6E7qJew3TYrrOSerP5ZeImAWT9X1CdagmIze9Xx/xTbFyB9N87+0f/f+Nqeep5cZjBciUsaCYZ
	gW5bWrB7Z9kqKmFeTHZ89g3B5jYT+nzqvmVEn
X-Google-Smtp-Source: AGHT+IG8cEzY8akfVwuYulwp7fNS1FiJpo8aIaBQKCVk7NWukI6OIqqT1l36q6zX6ceqa4hmH6bIZzQwumwKYy9Qd/U=
X-Received: by 2002:a05:6102:41a2:b0:46c:f354:efbe with SMTP id
 cd34-20020a05610241a200b0046cf354efbemr347871vsb.1.1706758884507; Wed, 31 Jan
 2024 19:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-5-vannapurve@google.com>
 <db477cef-f63b-4950-82b0-275bd10dbe5c@intel.com>
In-Reply-To: <db477cef-f63b-4950-82b0-275bd10dbe5c@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 1 Feb 2024 09:11:11 +0530
Message-ID: <CAGtprH8AymwMJuvsTbGcLgbCOLB8q1M9LGYyPzPUbQQwvB0_eQ@mail.gmail.com>
Subject: Re: [RFC V1 4/5] x86: CVMs: Allow allocating all DMA memory from SWIOTLB
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, kirill@shutemov.name, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:47=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/11/24 21:52, Vishal Annapurve wrote:
> > --- a/arch/x86/mm/mem_encrypt.c
> > +++ b/arch/x86/mm/mem_encrypt.c
> > @@ -112,10 +112,14 @@ void __init mem_encrypt_setup_arch(void)
> >        * The percentage of guest memory used here for SWIOTLB buffers
> >        * is more of an approximation of the static adjustment which
> >        * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> > +      *
> > +      * Extra 2% is added to accommodate the requirement of DMA alloca=
tions
> > +      * done using dma_alloc_* APIs.
> >        */
> > -     size =3D total_mem * 6 / 100;
> > -     size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> > +     size =3D total_mem * 8 / 100;
> > +     size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, (SZ_1G + SZ_256M));
> >       swiotlb_adjust_size(size);
> > +     swiotlb_adjust_alignment(SZ_2M);
>
> FWIW, this appears superficially to just be fiddling with random
> numbers.  The changelog basically says: "did stuff".
>
> What *are* "the requirement of DMA allocations done using dma_alloc_* API=
s"?

dma_alloc_* invocations depend on the devices used and may change with
time, so it's difficult to calculate the memory required for such
allocations.

Though one could note following points about memory allocations done
using dma_alloc_* APIs:
1) They generally happen during early setup of device drivers.
2) They should be relatively smaller in size compared to runtime
memory allocation done by dma_map_* APIs.

This change increases the SWIOTLB memory area by 30% based on the
above observations. Strategy here would be to take a safe enough
heuristic and let dynamic SWIOTLB allocations to handle any spillover.

