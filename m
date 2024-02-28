Return-Path: <linux-kernel+bounces-85503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D7D86B6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598071F21AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7E40859;
	Wed, 28 Feb 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMbaYMtV"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481379B84
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143491; cv=none; b=S8lD3xQWEOyulPH2OnvockLqIAHzWG35RhsyXr6ZDP3doW2Lr7/uPZ/KPx9QKW5IJu1M9wgyrChgR74n+7xZBNbFBUfXIm90sZte0Ntedli4vHiV4m9vlvZ+XHFkFlonUVhDoJjQ2GddmpQC+u6FT1nQh4a5wD6e2zDAt94y8jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143491; c=relaxed/simple;
	bh=cAtzSvWv7K7fiLSfVH8FUwSa3irTcvGO/xFIgu5yfdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FrB/0QLTMweAxnbG8VrUsH8C9NP9arAjZPE9gi7lXQ3KH5ooxJk5lVBtpndYrg/0vVfr1EkKSIw8kZ2s1/CgzWu897waiTfaqmJ+dMWx54F4ZpnIXIa5TrlMTIAfFI6HjmM5UehT8Swujecdz8QfoCSSzgfsZp1w6oKL0bZ7gyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMbaYMtV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29aa7b63ab8so2811272a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143489; x=1709748289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2czoKr7OC4zJi+ThYCtqOrTxsgjgImB45RATN9D+Vc=;
        b=LMbaYMtVhfVoriHSfDW8VhztbmT94W3AzfMk81koOxlqEIO+dWmR8BWBKBNvIsAIZk
         CPKUIHEKOfoAW7BFAXJEqohVovsjiq5DvpDw5hZbZ3+bpSveNFqn1KbtE1JveIeuKAz6
         Wi9xzZ8AdcXlYLeYYfTZWQMgemFuyxrkNqg7NKPinlXlVNmf7RxS7bPUppJjtgUOSdoP
         ugU/nSofyWlJwB9deo6p603NxYN4fctYDFtrfcQdE0+n/IIuGyvHz9g1Isl6tpgSFAZ7
         c2xpUGkCY2G8G5d7VHENM3eCD68IiADDlumeRB5HHVTArUsWWBZPh49bJmPU919XRXBq
         VFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143489; x=1709748289;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H2czoKr7OC4zJi+ThYCtqOrTxsgjgImB45RATN9D+Vc=;
        b=bYt8mvDMtgbzB9ukpXxkagdVMuDFznL1iv6bTA/9buVGaaeYnaKgMwfoiNrv7lHCsF
         9nkkC5YYMUrVazErtj2uOp/AchvonivtEW82SFZN1M0J+zg7JC1vFUfdqgRiwFAo3iPu
         2mnbtwjdJm3dTWfQju6GwazdApPXQsfKYiAindNk3SgrYnlwzgkbGowBU4bxGxkyUXjL
         lxMjBFGb2mZ4+aDuWOPB2TDp1PmoQ0UC5qN/bv+rVIUyyiPsESbnKpIuhmo0hc6f7o0N
         nf7YHP6Tug6itdRNaaMchcVLIMCkRra4FSIKU9ER2CyHe45Ei52bIfnGMAEmrxeqdCFy
         DyIA==
X-Gm-Message-State: AOJu0YxkpF+9ADG4tEaay2o9E+2ORQ68XHY6MiA4oy7aDbYCzxUmHcA/
	acHeqvNWb4zb1gGpoVPsjcqN2u27JBx1S/oUPFZrMYDY/5AufEkgFvIgSu9/0VkgQQxG1ydzYYV
	whw==
X-Google-Smtp-Source: AGHT+IGQXQpg1lzJxOxrSR4obqC5XBMX2J89v+ruIoiBwX4V9kcCB9H6ZRf7VtTSnV9ZKhvLvvEOqkd9+Lc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1bcd:b0:29a:98ab:a346 with SMTP id
 oa13-20020a17090b1bcd00b0029a98aba346mr1210pjb.9.1709143489280; Wed, 28 Feb
 2024 10:04:49 -0800 (PST)
Date: Wed, 28 Feb 2024 10:04:47 -0800
In-Reply-To: <CABgObfaPRpEnndHwkZpOZ=JOZjJPyh2KXYLh5ZGMFMSboZqj9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <Zd6LK7RpZZ8t-5CY@google.com>
 <CABgObfYpRJnDdQrxp=OgjhbT9A+LHK36MHjMvzcQJsHAmfX++w@mail.gmail.com>
 <Zd9hrfJ5xRI6HeZp@google.com> <CABgObfaPRpEnndHwkZpOZ=JOZjJPyh2KXYLh5ZGMFMSboZqj9w@mail.gmail.com>
Message-ID: <Zd91v2DeQmV0yQ1R@google.com>
Subject: Re: [PATCH 00/21] TDX/SNP part 1 of n, for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024, Paolo Bonzini wrote:
> On Wed, Feb 28, 2024 at 5:39=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > > This doesn't work.  The ENC flag gets set on any SNP *capable* CPU,=
 which results
> > > > in false positives for SEV and SEV-ES guests[*].
> > >
> > > You didn't look at the patch did you? :)
> >
> > Guilty, sort of.  I looked (and tested) the patch from the TDX series, =
but I didn't
> > look at what you postd.  But it's a moot point, because now I did look =
at what you
> > posted, and it's still broken :-)
> >
> > > It does check for has_private_mem (alternatively I could have dropped=
 the bit
> > > in SVM code for SEV and SEV-ES guests).
> >
> > The problem isn't with *KVM* setting the bit, it's with *hardware* sett=
ing the
> > bit for SEV and SEV-ES guests.  That results in this:
> >
> >   .is_private =3D vcpu->kvm->arch.has_private_mem && (err & PFERR_GUEST=
_ENC_MASK),
> >
> > marking the fault as private.  Which, in a vacuum, isn't technically wr=
ong, since
> > from hardware's perspective the vCPU access was "private".  But from KV=
M's
> > perspective, SEV and SEV-ES guests don't have private memory
>=20
> vcpu->kvm->arch.has_private_mem is the flag from the SEV VM types
> series. It's false on SEV and SEV-ES VMs, therefore fault->is_private
> is going to be false as well. Is it ENOCOFFEE for you or ENODINNER for
> me? :)

*sigh*, ENOCOFFEE.

