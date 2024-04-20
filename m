Return-Path: <linux-kernel+bounces-152256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C703E8ABB80
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA581F213ED
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320BE38388;
	Sat, 20 Apr 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL4kBGZ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEFB2C68F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713615260; cv=none; b=Y6A2az6jZr/5ZJaX5T75YOVbvwunQAydf1N8kofIQvUhLm36NFzGvPhvfv8fZ+GMvGkIl34kjwwdV5rnAeDdG/vHKpjrEOekVtC2xn68PatRI2nRF6kRZQ0ym14pe3s/n2xNxlPHdxvqpIhe8BKkjrYFeADsPyLuwOPuxurDB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713615260; c=relaxed/simple;
	bh=mLBFQwnGnEbJCwQmCAtkZajQQO0VrrORdBE2V5gqR/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKmNidC+AF2QCQNp+6E+iNnpzK48Vm2O4p8ijqHg7Zf2NNaxq34/FULAIW/cbDbfAjTJDG0vt3DvEGFOKKPWGd/SP5AFCtO74TMw5F0yLOJArBgX11+Bpey1XzvzUli2AKUygatkFQ65u0Lgez9ujxWlaW3Jwfi1xiwntsxG1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YL4kBGZ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713615257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/+AXP/+cMsv1gB1pDa+er++RK/74cS8hOJWb41Gq1U=;
	b=YL4kBGZ3nfsQ2DyI4ngAH7LdJPoTR8zCyTgUSam5QlGHcDu5zIuAARaTa+kbLaqTCD8s/P
	AzfUG5MfVwBKnqBNPFcTYFUc4ZVFmsOqoZXIi9qv9sX4WlkW75VjX8Uv2Bjbzii2PmsRIE
	De638qjvjUuLSSNEPAGkzlURYZ2k9qQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-IdlA0NxANya8inYrnPFiLw-1; Sat, 20 Apr 2024 08:14:16 -0400
X-MC-Unique: IdlA0NxANya8inYrnPFiLw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a4b4418a69so3338182a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 05:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713615255; x=1714220055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/+AXP/+cMsv1gB1pDa+er++RK/74cS8hOJWb41Gq1U=;
        b=lppFdUO4Fm0PcncN8DxgJx2bUlk96VtIrUeBMeGD5c3R1WCTra/dvaJrRC/omGN4KS
         YXvdAVFgUMc1bfTDAMg1w7L0xikrytQrQKpwjfTx36Nvf8MJp3UzDKXwkDjDGTEL93/P
         jgS7R9ljA05kUDt+ykThgmMWXQDphUgM8oRcxG1rulKVNbGiy/y0eLmoBp9sQ16W+ajd
         bsOONohRJZQEmiYagyOSV8bqCzNb5HxUzLGnlQTfDg8NJ/oeccEd/1I1ZB0CEQSr/clp
         Kcw/gZuLIRMbUfSWje1myPU8uNl0HKW+CIhmHqpCUEieuXlE2JP7xsPSqplAWlGr4biZ
         cKdw==
X-Forwarded-Encrypted: i=1; AJvYcCVXysn5SBShrQLJeyjEq8XVpOQS7rgnlNdKl8qkIf/5OyfQ6VuibNlHY9Sdg1zSnFVnXTbRNrzKsrmljhMVZBpWvaSSWXyeInxlFI/h
X-Gm-Message-State: AOJu0YyzIbAxMlBWjcYs01kTUm6X4lSOa3txa+tbdNjsTRjbbsofxqhL
	N7R4wLJhg2afcOBqCQXmeAOTJ8GDzjeP0Bi66G611ht9TbGyWniVPS7hSDbRgP0dBXZmNxuEpYK
	rw3m//fuHcGu9zhKNvblU+vmXDvROx+51OXHh5NLxIEnXIaqANdGxVcG/N8mchszD9FB3bau7G1
	lWsYirsJrRm/crgsIlvDgTb0B1a0RCDUxuyiTX
X-Received: by 2002:a17:90b:4f8f:b0:2a0:9b66:8e22 with SMTP id qe15-20020a17090b4f8f00b002a09b668e22mr3868930pjb.24.1713615254969;
        Sat, 20 Apr 2024 05:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsHuOB/oNQk6rhvlabCIKccBuvsNSSpeF7mDscQ/D/nU4o7qvI+9aQIV6/VOpH63JMXbU3K2Hm1ot18E6cj9A=
X-Received: by 2002:a17:90b:4f8f:b0:2a0:9b66:8e22 with SMTP id
 qe15-20020a17090b4f8f00b002a09b668e22mr3868910pjb.24.1713615254613; Sat, 20
 Apr 2024 05:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-tso-v1-0-754f11abfbff@marcan.st> <20240411132853.GA26481@willie-the-truck>
 <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st> <20240419165809.GA4020@willie-the-truck>
In-Reply-To: <20240419165809.GA4020@willie-the-truck>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 20 Apr 2024 13:13:38 +0100
Message-ID: <CAOgh=Fykg3Xb8Y59R_tJ7_jXe-ozXRMQjU+qVy5DdmFn3pkcPw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Will Deacon <will@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Zayd Qumsieh <zayd_qumsieh@apple.com>, Justin Lu <ih_justin@apple.com>, 
	Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>, 
	Christoph Paasch <cpaasch@apple.com>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>, 
	Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, Florent Revest <revest@chromium.org>, 
	David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
	Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>, 
	Zev Weiss <zev@bewilderbeest.net>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Asahi Linux <asahi@lists.linux.dev>, 
	Sergio Lopez Pascual <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 18:08, Will Deacon <will@kernel.org> wrote:
>
> On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
> > On 2024/04/11 22:28, Will Deacon wrote:
> > >   * Some binaries in a distribution exhibit instability which goes away
> > >     in TSO mode, so a taskset-like program is used to run them with TSO
> > >     enabled.
> >
> > Since the flag is cleared on execve, this third one isn't generally
> > possible as far as I know.
>
> Ah ok, I'd missed that. Thanks.
>
> > > In all these cases, we end up with native arm64 applications that will
> > > either fail to load or will crash in subtle ways on CPUs without the TSO
> > > feature. Assuming that the application cannot be fixed, a better
> > > approach would be to recompile using stronger instructions (e.g.
> > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> > > true that some existing CPUs are TSO by design (this is a perfectly
> > > valid implementation of the arm64 memory model), but I think there's a
> > > big difference between quietly providing more ordering guarantees than
> > > software may be relying on and providing a mechanism to discover,
> > > request and ultimately rely upon the stronger behaviour.
> >
> > The problem is "just" using stronger instructions is much more
> > expensive, as emulators have demonstrated. If TSO didn't serve a
> > practical purpose I wouldn't be submitting this, but it does. This is
> > basically non-negotiable for x86 emulation; if this is rejected
> > upstream, it will forever live as a downstream patch used by the entire
> > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
> > explicitly targeting, given our efforts with microVMs for 4K page size
> > support and the upcoming Vulkan drivers).
>
> These microVMs sound quite interesting. What exactly are they? Are you
> running them under KVM?

It's the magic of libkrun. This is one of the git repos in the family
of libkrun, it has a wide array of use cases, which I personally won't
do much justice explaining all then, this is just one
repo/tool/usecases:

https://github.com/containers/krunvm

https://sinrega.org/running-microvms-on-m1/

CC'ing @Sergio Lopez Pascual the lead of krun in general.

Is mise le meas/Regards,

Eric Curtin

>
> Ignoring the mechanism for the time being, would it solve your problem
> if you were able to run specific microVMs in TSO mode, or do you *really*
> need the VM to have finer-grained control than that? If the whole VM is
> running in TSO mode, then my concerns largely disappear, as that's
> indistinguishable from running on a hardware implementation that happens
> to be TSO.
>
> > That said, I have a pragmatic proposal here. The "fixed TSO" part of the
> > implementation should be harmless, since those CPUs would correctly run
> > poorly-written applications anyway so the API is moot. That leaves Apple
> > Silicon. Our native kernels are and likely always will be 16K page size,
> > due to a bunch of pain around 16K-only IOMMUs (4K kernels do boot
> > natively but with very broken functionality including no GPU
> > acceleration) plus performance differences that favor 16K. How about we
> > gate the TSO functionality to only be supported on 4K kernel builds?
> > This would make them only work in 4K VMs on Asahi Linux. We are very
> > explicitly discouraging people from trying to use the microVMs to work
> > around page size problems (which they can already do, another
> > fragmentation problem, anyway); any application which requires the 4K VM
> > to run that isn't an emulator is already clearly broken and advertising
> > that fact openly. So, adding TSO to this should be only a marginal risk
> > of further fragmentation, and it wouldn't allow apps to "sneakily" "just
> > work" on Apple machines by abusing TSO.
>
> I appreciate that you're trying to be constructive here, but I don't think
> we should tie this to the page size. It's an artifical limitation and I
> don't think it really addresses the underlying concerns that I have.
>
> Will
>


