Return-Path: <linux-kernel+bounces-85426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA286B5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7C71F26E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D3159573;
	Wed, 28 Feb 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TN8NZ902"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD453FB82
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140848; cv=none; b=OQLaq+xtGuI6FK4EgsRJ60qLDiQsu8GX/LLe2Ivz7H+e7x5J2ZwYZchHDf5Bpf5wg41HDICUIpkOrvntdVJKS1hm0smHLe8emIcaXP+ylx4i0ZqPtsPPdFDf+7Ss3LR/02z6eShvIshAReP7Lbtx89pUL3291lXweAVpuZNzcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140848; c=relaxed/simple;
	bh=n0exr615nC5EZEeM0EsZy8UeaK59EIm1bYINM1HeqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW1uVCzPVGxzMfT1Ss2camBqlhoO9vCR6MP7y28f6WEYimp/ZxodioJVqxvVUSPPWCehdGRaGh1fOYawOeKtKgMH3w4YmGUPcRvB0xikfl+yH4BEyO5rTD3idOPRcs9SkulQr4CT3t9qx1wXq1IG90GWDwjyubHS/xvKgj2PMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TN8NZ902; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709140846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dycmzOR3/TdQOeG/y2ISWS/eLdq44stW8h6+F3A1yk8=;
	b=TN8NZ902xeHbInJdTOLe+s3BljdgCvB00RuGi2bRx6L0HS/AvIs5LUAAo43sjSZk1gVymW
	LKp5/Qrzl5/47Hu00Uvfa9/pMtB0dd7WSpfrAbO7W1VzRlzUlH84ddBFh3/bx+L2dtl8Ka
	TE6vF9igOp4iWyOj+2cTpHU+sWmv29E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-C0sVPE3bOjShBs-iO-K31w-1; Wed, 28 Feb 2024 12:20:41 -0500
X-MC-Unique: C0sVPE3bOjShBs-iO-K31w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d8b4175dbso10628f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140840; x=1709745640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dycmzOR3/TdQOeG/y2ISWS/eLdq44stW8h6+F3A1yk8=;
        b=lNzrIM+pv+1e/EDRvLf2O8X1x8Btvjh5gi358lq6Nq8FL/eGBbGMc31AtqSEXtLvZV
         pCr68Qdca6e+ArtRQ+1Jrq7aSppoivduJJCY4/u5tCz4qGB0nzJPR+A2cJtj7M/NE8sX
         nGXm3h9pdR2dsMbLByNZvyf43eSva7JwNC5nzqINzf1gPVvCLFR/orytWczZX7uxY3su
         /1akevDNSlqiYOCGz/CLBQKIsg0nCtdmSFaubmuC4BJb9RP1f798ogfYSNXFeKNm+bel
         fJE3aTyTYEIbawt3xycJknQ/wXvEvINXtP0ASLtMUT/SwANzfteWvMUtZ1j/+ygPBSgI
         HzrA==
X-Gm-Message-State: AOJu0YwUPWWgiYGujAMYSqw51g+ou48KGsIzGwx0050YAzcVWd1Cpz3x
	/BN8xjwnqBHvRCtga7cAdcY2M9kuc42KBWQrdXRdvhRWKGQSY9X5+SwtPbWavfydQMkzbx2JLXD
	p4GTSHY9OjiWApIG7GsQV3mVzL1i421IQ/ZLJtbQVok9NMqe8MxPI8O/6lKYu2kLMI6+w50SBoO
	GxuhvCQ1ASaZx8feZ9kBrXcp8lBrblGqQQCeDc
X-Received: by 2002:a5d:4f08:0:b0:33d:52f:a2a8 with SMTP id c8-20020a5d4f08000000b0033d052fa2a8mr132882wru.61.1709140840238;
        Wed, 28 Feb 2024 09:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrJxfnFvdAvyPZHwu1Poyv4u42Rgqf2slyitZ0GtBvFbjP6kttzzRXOZulX4AgXNXT/citq9hS8BivlWCOl4c=
X-Received: by 2002:a5d:4f08:0:b0:33d:52f:a2a8 with SMTP id
 c8-20020a5d4f08000000b0033d052fa2a8mr132869wru.61.1709140839873; Wed, 28 Feb
 2024 09:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <Zd6LK7RpZZ8t-5CY@google.com>
 <CABgObfYpRJnDdQrxp=OgjhbT9A+LHK36MHjMvzcQJsHAmfX++w@mail.gmail.com> <Zd9hrfJ5xRI6HeZp@google.com>
In-Reply-To: <Zd9hrfJ5xRI6HeZp@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Feb 2024 18:20:27 +0100
Message-ID: <CABgObfaPRpEnndHwkZpOZ=JOZjJPyh2KXYLh5ZGMFMSboZqj9w@mail.gmail.com>
Subject: Re: [PATCH 00/21] TDX/SNP part 1 of n, for 6.9
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:39=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > > This doesn't work.  The ENC flag gets set on any SNP *capable* CPU, w=
hich results
> > > in false positives for SEV and SEV-ES guests[*].
> >
> > You didn't look at the patch did you? :)
>
> Guilty, sort of.  I looked (and tested) the patch from the TDX series, bu=
t I didn't
> look at what you postd.  But it's a moot point, because now I did look at=
 what you
> posted, and it's still broken :-)
>
> > It does check for has_private_mem (alternatively I could have dropped t=
he bit
> > in SVM code for SEV and SEV-ES guests).
>
> The problem isn't with *KVM* setting the bit, it's with *hardware* settin=
g the
> bit for SEV and SEV-ES guests.  That results in this:
>
>   .is_private =3D vcpu->kvm->arch.has_private_mem && (err & PFERR_GUEST_E=
NC_MASK),
>
> marking the fault as private.  Which, in a vacuum, isn't technically wron=
g, since
> from hardware's perspective the vCPU access was "private".  But from KVM'=
s
> perspective, SEV and SEV-ES guests don't have private memory

vcpu->kvm->arch.has_private_mem is the flag from the SEV VM types
series. It's false on SEV and SEV-ES VMs, therefore fault->is_private
is going to be false as well. Is it ENOCOFFEE for you or ENODINNER for
me? :)

Paolo

> And because the flag only gets set on SNP capable hardware (in my limited=
 testing
> of a whole two systems), running the same VM on different hardware would =
result
> in faults being marked private on one system, but not the other.  Which m=
eans that
> KVM can't rely on the flag being set for SEV or SEV-ES guests, i.e. we ca=
n't
> retroactively enforce anything (not to mention that that might break exis=
ting VMs).
>


