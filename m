Return-Path: <linux-kernel+bounces-147653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093C88A76EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F15280217
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354C6EB41;
	Tue, 16 Apr 2024 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlcKyTaD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8E5A104
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303683; cv=none; b=Tcdq9Cd+BfALOR4W1Jp7qzXfaA7Elh5jfw823woDt8vrgBEoAwLldQe9ePC1s9aag2d889G0Gy7fvEq3IqlAbDrHuqSxHbux2FNVwU3yYpwE5bftWe0ZBqxIcQ8URpx2E8oMJX2iKotn8h8eLr8CTtoP5SGYHs8/T8PDTT+upvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303683; c=relaxed/simple;
	bh=IujRY/kXgqJsKcDejH7IzFvm1k7Rt4QD2m5zlqSFFig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuOTCaowtBs+00OcUtvlnOMQ4yM5daky4HHD/DOdsxrRgPUeDdieRvQD5VTOsfP2HlX0an2mbs2cZ1dWckIOvoKEcw0ScfOSoRG77VnQn4+aDBDrkirmffJIKYvvq9QHX4dHS8tMUYDsTYW24auss3EYeAbE7O1dRYyPvJyZ7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlcKyTaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713303681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHU946PMNdBbuPv80hbpFLaJFp6SsPmFqr+fskLRIc4=;
	b=LlcKyTaDokd6lf+xoaLtrGPTpdkkhlOGNEHsvLRj2fzWyBg6kt6DiQ6Kg0dnOB+jcKvmXp
	GRN/Q49m2iPDQDNY4aspq+U31YT2GzhnqCUFDETB6N32dWDW007o2Cvb1iWmxg0aEswF5y
	IuC+WpZukw2tt8clJ3E63w6AEtJnBDs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-Q0-9CUkcMX-evcLnLe2xlw-1; Tue, 16 Apr 2024 17:41:17 -0400
X-MC-Unique: Q0-9CUkcMX-evcLnLe2xlw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-347f92ab882so1280258f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713303676; x=1713908476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHU946PMNdBbuPv80hbpFLaJFp6SsPmFqr+fskLRIc4=;
        b=kjKjEo5kKUeVbP+q029GPKapQpNFxgI23/iXz/JC7T30oifO7139RffpC7Xf3V9RPA
         Dxg+cX1NawPsDLZ7+Qya4qqZqx/WlCotALoAYpkQq2dWAHzTh+m3jazXz2ZNHKhhD2gF
         rQ9/pllMHvi8nUPOu2h1SEgANimC/cdAMfl3LisiyuW5UbeCfWkZhJ/VZkYSfGZCizis
         Rya/Znbcq48xuW/s18AUTWPbu3m/K0GY/SSIRGkqbGUM58BfE3pRPcVrEo1r0yjUZfN8
         pp+q4pwOvCW0N6fOnzW7fj9n/R0wMLaQX0zBrrxe0zfbWyVQjVgu08PDdif6m04qCQvO
         QmVg==
X-Forwarded-Encrypted: i=1; AJvYcCWl5BKoCJoNII8vgjiAy2OJ9+vnGv5WOlWwcLuFZcdM6EiKbBCMseHrhXgOkuZaCyrcQVZwkgI4w8iFA6X9KlXjR4eTTPJmeZEPh6XW
X-Gm-Message-State: AOJu0YzsgFP8qn3bObh5ySWGym0bzswdlwx+GF20Rscs966760HODbi/
	Hss64UNo5nu2KgWENVzfDONvle2VqN9/lrPpf4uzsw+7IDkwKp+0FAEvejG7MH+aJJhfs/NxVwP
	b+I8mNVs43MQ90I4tkzF9dZx273aFxpPhoEzesvjk3eCsM6SG8CpUXbooCrIfCdkae0iOP3J4nO
	QKed0yorEeSuInseQx89o0icPeKJOmBLf/e3rm
X-Received: by 2002:a05:6000:1886:b0:346:f9d8:8492 with SMTP id a6-20020a056000188600b00346f9d88492mr10004130wri.2.1713303676482;
        Tue, 16 Apr 2024 14:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSb3rZSIUrZMkdffMzeh1o3qdQWAgD3S/qcusci/n1Dwl71f1rZV57pwr2NlqdZxn880M/wIjoe8XzqbxtWbQ=
X-Received: by 2002:a05:6000:1886:b0:346:f9d8:8492 with SMTP id
 a6-20020a056000188600b00346f9d88492mr10004117wri.2.1713303676184; Tue, 16 Apr
 2024 14:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712785629.git.isaku.yamahata@intel.com>
 <2f1de1b7b6512280fae4ac05e77ced80a585971b.1712785629.git.isaku.yamahata@intel.com>
 <116179545fafbf39ed01e1f0f5ac76e0467fc09a.camel@intel.com> <Zh2ZTt4tXXg0f0d9@google.com>
In-Reply-To: <Zh2ZTt4tXXg0f0d9@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Apr 2024 23:41:05 +0200
Message-ID: <CABgObfZq9dzvq3tsPMM3D+Zn-c77QrVd2Z1gW5ZKfb5fPu_8WA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] KVM: x86: Always populate L1 GPA for KVM_MAP_MEMORY
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>, 
	"federico.parola@polito.it" <federico.parola@polito.it>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:17=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> On Mon, Apr 15, 2024, Rick P Edgecombe wrote:
> > I wouldn't call myself much of an expert on nested, but...
> >
> > On Wed, 2024-04-10 at 15:07 -0700, isaku.yamahata@intel.com wrote:
> > > There are several options to populate L1 GPA irrelevant to vCPU mode.
> > > - Switch vCPU MMU only: This patch.
> > >   Pros: Concise implementation.
> > >   Cons: Heavily dependent on the KVM MMU implementation.
>
> Con: Makes it impossible to support other MMUs/modes without extending th=
e uAPI.

+1.

> The first question to answer is, do we want to return an error or "silent=
ly"
> install mappings for !SMM, !guest_mode.  And so this option becomes relev=
ant only
> _if_ we want to unconditionally install mappings for the 'base" mode.
>
> > > - Return error on guest mode or SMM mode:  Without this patch.
> > >   Pros: No additional patch.
> > >   Cons: Difficult to use.
> >
> > Hmm... For the non-TDX use cases this is just an optimization, right? F=
or TDX
> > there shouldn't be an issue. If so, maybe this last one is not so horri=
ble.

It doesn't even have to be ABI that it gives an error. As you say,
this ioctl can just be advisory only for !confidential machines. Even
if it were implemented, the shadow MMU can drop roots at any moment
and/or kill the mapping via the shrinker.

That said, I can't fully shake the feeling that this ioctl should be
an error for !TDX and that TDX_INIT_MEM_REGION wasn't that bad. The
implementation was ugly but the API was fine. Sorry about this;
patches 3-5 can still be included in kvm-coco-queue sooner rather than
later.

> And the fact there are so variables to control (MAXPHADDR, SMM, and guest=
_mode)
> basically invalidates the argument that returning an error makes the ioct=
l() hard
> to use.  I can imagine it might be hard to squeeze this ioctl() into QEMU=
's
> existing code, but I don't buy that the ioctl() itself is hard to use.

Nah, I don't think so. With TDX it's just MAXPHYADDR; just invoke it
after KVM_SET_CPUID2 or TDX_INIT_VCPU which is very early.

> Literally the only thing userspace needs to do is set CPUID to implicitly=
 select
> between 4-level and 5-level paging.  If userspace wants to pre-map memory=
 during
> live migration, or when jump-starting the guest with pre-defined state, s=
imply
> pre-map memory before stuffing guest state.  In and of itself, that doesn=
't seem
> difficult, e.g. at a quick glance, QEMU could add a hook somewhere in
> kvm_vcpu_thread_fn() without too much trouble (though that comes with a h=
uge
> disclaimer that I only know enough about how QEMU manages vCPUs to be dan=
gerous).

Hehe :) the machine_done_notifier is probably a better place. /me
checks... yes it's exactly where Xiaoyao did it (tdx_finalize_vm is
the notifier, it calls KVM_TDX_INIT_VCPU, from tdx_post_init_vcpus and
then KVM_MEMORY_MAPPING).

> I would describe the overall cons for this patch versus returning an erro=
r
> differently.  Switching MMU state puts the complexity in the kernel.  Ret=
urning
> an error punts any complexity to userspace.  Specifically, anything that =
KVM can
> do regarding vCPU state to get the right MMU, userspace can do too.
>
> Add on that silently doing things that effectively ignore guest state usu=
ally
> ends badly, and I don't see a good argument for this patch (or any varian=
t
> thereof).

Agreed.

Paolo


