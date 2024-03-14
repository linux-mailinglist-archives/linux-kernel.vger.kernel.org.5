Return-Path: <linux-kernel+bounces-103182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005E87BBFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD97286E89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3F6EB74;
	Thu, 14 Mar 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FuzkioDZ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64C6E61E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415917; cv=none; b=GoijeELsWeivurQtm/7B3GgnFonqfxizYrPyOJxNgi+mOAT10zWCeUG+r2N1Je0llEnFhYbOksQv8vwjSeS5RVNu+50VzhkNdC9p6qRFz1a3/tWJszradU0YNTS2jMdauDij1kghyJTWFP1Aqg7BB+HDvGVKQIsleO+08aOIpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415917; c=relaxed/simple;
	bh=DkGmVrrfdoYHC3Jz/8H/PUrLj/0yjctqv7dzZzPfV+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GucxUWe+mmmUvGcSfUIikoL06Wl/SVGK8O4MNizkLTXdd4xXa+dcMoCAPDph7dP9so+ZcvnsDx1BoAcigLS84i0cC9RbsLc28qQaCiCkxQAK8H57NDa52NqHcBEYP6SN2OZahhDJpMBTi2dhdCcRk7r148yaC6XgZfjJktl2pKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FuzkioDZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513d3e57518so261911e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710415914; x=1711020714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz8VDnDE+R4/3GaE6xKTtBRvYNqP8oWy3j0hIR9rH5E=;
        b=FuzkioDZVDEfy02Wjbp+qt9UikHK1mY4ygoVkQK9hArXxixcKT4GRrwCCwWkSgvNie
         DFWYbiVlUQ1U+vC2S7um4dv4IcV97nZmWfCI6jFPcA2sxlo2jzF7cu6CHvaGIh8d+pYI
         lcYWkuOYGviGExHzDA2AEZUxgDCCZ2LG21AgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710415914; x=1711020714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz8VDnDE+R4/3GaE6xKTtBRvYNqP8oWy3j0hIR9rH5E=;
        b=subfLV4CPyBFF7DGeDIoJn83OVrt04WSKjq05PhWSsotHxmov6a5zrxt1hCLRuyjsW
         N4FnR2+GritZDlRfDHRRg54GOqKx25RaViBz8ilck0audG8s3AXBp5TSBYM+3islrDSR
         mMLQpkp8apBUyHYbMlhqyuIGicdaAr1seCQeM0MOeZ/EtjoBX+J5yQxDHU82/bekXACI
         n0/97dQIDieCftwgGqMriqo8VRl8OdASakbTd5VMnRFd5M3s4lLbxVxOa4fabb9OQEue
         J7tCUgu8bg9+sAmGT/nnvg3cV4m/0vRhkjr8NAPDHEayeArpbL+63vvqTJjS1DI2H6oT
         93nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrDv2j7T+iBqbxUkhgxtc8hYGCTAavJrA1ueNLOVhAu8CfzEGplNQiKi9S4X40hzKDTNEFSONbeDhw6u3jnMRxkLyG04jdPTEInGWt
X-Gm-Message-State: AOJu0YxuRRkN5kxTf4SgrG4O7lRhDX0dKLrxfriUjbWD/WVqqT2YlMj8
	2qWk6omRdKpupzvy9ygoftc+c80xW0E11A/QkDXaJIGou9pi/D0g//n4oU9Cc8cyjSnjfURLu5x
	QbaThWor5eve9S9y/qLE2RkVgR0qS81oKzUW5
X-Google-Smtp-Source: AGHT+IEErLnsUpPSn5OuQW0nErSoEkxGmLTnTNLjr47z9ypWv0NCJP0c5okv782N6eOZdUJQb14YhAgzE39EMvVWqU0=
X-Received: by 2002:ac2:4acd:0:b0:513:cf5a:f872 with SMTP id
 m13-20020ac24acd000000b00513cf5af872mr828006lfp.69.1710415913826; Thu, 14 Mar
 2024 04:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229025759.1187910-1-stevensd@google.com> <ZeCIX5Aw5s1L0YEh@infradead.org>
 <CAD=HUj7fT2CVXLfi5mty0rSzpG_jK9fhcKYGQnTf_H8Hg-541Q@mail.gmail.com>
 <72285e50-6ffc-4f24-b97b-8c381b1ddf8e@amd.com> <ZfGrS4QS_WhBWiDl@google.com>
 <0b109bc4-ee4c-4f13-996f-b89fbee09c0b@amd.com> <ZfG801lYHRxlhZGT@google.com>
 <9e604f99-5b63-44d7-8476-00859dae1dc4@amd.com> <ZfHKoxVMcBAMqcSC@google.com>
 <93df19f9-6dab-41fc-bbcd-b108e52ff50b@amd.com> <ZfHhqzKVZeOxXMnx@google.com>
 <c84fcf0a-f944-4908-b7f6-a1b66a66a6bc@amd.com> <d2a95b5c-4c93-47b1-bb5b-ef71370be287@amd.com>
In-Reply-To: <d2a95b5c-4c93-47b1-bb5b-ef71370be287@amd.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 14 Mar 2024 20:31:42 +0900
Message-ID: <CAD=HUj5k+N+zrv-Yybj6K3EvfYpfGNf-Ab+ov5Jv+Zopf-LJ+g@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] KVM: allow mapping non-refcounted pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, Christoph Hellwig <hch@infradead.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 6:20=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Sending that out once more since the AMD email servers have converted it
> to HTML mail once more :(
>
> Grrr,
> Christian.
>
> Am 14.03.24 um 10:18 schrieb Christian K=C3=B6nig:
> > Am 13.03.24 um 18:26 schrieb Sean Christopherson:
> >> On Wed, Mar 13, 2024, Christian K=C3=B6nig wrote:
> >>> Am 13.03.24 um 16:47 schrieb Sean Christopherson:
> >>>> [SNIP]
> >>>>> It can trivially be that userspace only maps 4KiB of some 2MiB piec=
e of
> >>>>> memory the driver has allocate.
> >>>>>
> >>>>>> I.e. Christoph is (implicitly) saying that instead of modifying KV=
M to play nice,
> >>>>>> we should instead fix the TTM allocations.  And David pointed out =
that that was
> >>>>>> tried and got NAK'd.
> >>>>> Well as far as I can see Christoph rejects the complexity coming wi=
th the
> >>>>> approach of sometimes grabbing the reference and sometimes not.
> >>>> Unless I've wildly misread multiple threads, that is not Christoph's=
 objection.
> >>>>   From v9 (https://lore.kernel.org/all/ZRpiXsm7X6BFAU%2Fy@infradead.=
org):
> >>>>
> >>>>     On Sun, Oct 1, 2023 at 11:25=E2=80=AFPM Christoph Hellwig<hch@in=
fradead.org>   wrote:
> >>>>     >
> >>>>     > On Fri, Sep 29, 2023 at 09:06:34AM -0700, Sean Christopherson =
wrote:
> >>>>     > > KVM needs to be aware of non-refcounted struct page memory n=
o matter what; see
> >>>>     > > CVE-2021-22543 and, commit f8be156be163 ("KVM: do not allow =
mapping valid but
> >>>>     > > non-reference-counted pages").  I don't think it makes any s=
ense whatsoever to
> >>>>     > > remove that code and assume every driver in existence will d=
o the right thing.
> >>>>     >
> >>>>     > Agreed.
> >>>>     >
> >>>>     > >
> >>>>     > > With the cleanups done, playing nice with non-refcounted pag=
ed instead of outright
> >>>>     > > rejecting them is a wash in terms of lines of code, complexi=
ty, and ongoing
> >>>>     > > maintenance cost.
> >>>>     >
> >>>>     > I tend to strongly disagree with that, though.  We can't just =
let these
> >>>>     > non-refcounted pages spread everywhere and instead need to fix=
 their
> >>>>     > usage.
> >>> And I can only repeat myself that I completely agree with Christoph h=
ere.
> >> I am so confused.  If you agree with Christoph, why not fix the TTM al=
locations?
> >
> > Because the TTM allocation isn't broken in any way.
> >
> > See in some configurations TTM even uses the DMA API for those
> > allocations and that is actually something Christoph coded.
> >
> > What Christoph is really pointing out is that absolutely nobody should
> > put non-refcounted pages into a VMA, but again this isn't something
> > TTM does. What TTM does instead is to work with the PFN and puts that
> > into a VMA.
> >
> > It's just that then KVM comes along and converts the PFN back into a
> > struct page again and that is essentially what causes all the
> > problems, including CVE-2021-22543.

Does Christoph's objection come from my poorly worded cover letter and
commit messages, then? Fundamentally, what this series is doing is
allowing pfns returned by follow_pte to be mapped into KVM's shadow
MMU without inadvertently translating them into struct pages. If I'm
understand this discussion correctly, since KVM's shadow MMU is hooked
up to MMU notifiers, this shouldn't be controversial. However, my
cover letter got a little confused because KVM is currently doing
something that it sounds like it shouldn't - translating pfns returned
by follow_pte into struct pages with kvm_try_get_pfn. Because of that,
the specific type of pfns that don't work right now are pfn_valid() &&
!PG_Reserved && !page_ref_count() - what I called the non-refcounted
pages in a bad choice of words. If that's correct, then perhaps this
series should go a little bit further in modifying
hva_to_pfn_remapped, but it isn't fundamentally wrong.

-David

