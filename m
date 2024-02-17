Return-Path: <linux-kernel+bounces-69653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2099858CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000931C21F13
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC3A1B7F4;
	Sat, 17 Feb 2024 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFvRBMOy"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFFC17BB9
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134055; cv=none; b=RjzxPkmqbHbRUQtNJa9LQu3AxWIKaUoCNuaATPLkKXqOdjP1VqOVyOP4eNy7En+iONWoQ9ouUpgPN07VhbbH+S2Ol7ZciF+awJB0iTnou7EWMJrL7bNk+5TCCQmZOXadST9d9IKRU3/YntTi97AH3si2S+KoWdOtfuzRbcRMrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134055; c=relaxed/simple;
	bh=WZhqQDBeYhNc482c7VxqGDqUzFUPH+/HUWY5cBltVFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXNcldt/RbZnmICLhEoAHiBwk2VygLdYpsfcj1ELuei39cjFsPZlIH87I6DZDvZdUrcHNpwoQQdUmiYnH/XMBjXRV7i4BsGGL9hf4OZjBZo5PSBspa/JhvGbzFWwZHqYr7zb1QYL3fIDlrv2fA9BdLiJ6U7TWT6+SfPz3/CRcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFvRBMOy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e0a3067989so2673508b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708134053; x=1708738853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UyWsHrP5h/aqLoNzYARDniuxeUImZgOEiBo3TmFOEo=;
        b=FFvRBMOyH37i+Ik7zscfIG1imlvJYOg7KJIw0q/xQJWNqUm+ycrh601JRBIsbQRpyX
         OcjlFh32E+OzFGlI77PP6/DdF78ii1CflX39R1O9L0ZVf1jDm3Np33G5tAWvgU+od7D/
         LNcm/VaLwFAV/wyJj8wzCguvfERfmusjF+gN3JMywPnrh+iOjUSAev2fIbHJCaFDaf14
         kFW6Pmy1LrQOBc9rH+p3ZRquL39xCrjomHDbZ1UIcQ9gGWbC/YWjELAaH+WOszTBkfW+
         baQHMEGdH98P+CvimAbN7cHUoHGLhEn/k0lsX6/ToN1ym9hutNxpgSOoOWwJyDiI48Hk
         hYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708134053; x=1708738853;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/UyWsHrP5h/aqLoNzYARDniuxeUImZgOEiBo3TmFOEo=;
        b=Cvl3jVWZ2JHmbwSdaBxoxkOJh003yo3/xx5CjQZ4YFoODgZ7fE609Eas/e3gUd3HyD
         FPuSc/bS2cgq1R//k8A3xq83N95ILayM0MU3ii3tqpCKLpZGTwa+BhHsm2qPzkqoGaD+
         aQz+lRxuJCjcTZ0k/LbCCcjs5quO61BK23JYadAKJ/SVTe8grNL/a0foNQMfEzQKfxTf
         /P767gxJWmo0z7AyDTqouTbNvuGh9VmQuO2nxqjgV6xA4gNkuEqS+YDBkWNzcuVKaZGr
         6G8Z0V5/lvWmIRBOvkLTQB1GHtc9dD3x2wNj1eo3BOPhtU+77kYqwV3mlRfEkUxB26qv
         oo1w==
X-Gm-Message-State: AOJu0YyghQ/qrnms6HNBjLSv8oIYiTOVfb56YQxSHDwl9NAuy3kvLJgo
	7H+20OSMEYXTCWL1+kKKaWFpxGR0iWF1o4qwJUU3X9Wf/gZAo9RAbThKHMC02GCpmPCpZinf0Yr
	w3g==
X-Google-Smtp-Source: AGHT+IEy1EPClrFTjgqONbxqfpCoYeMU9NFcYI6rzsv700TT4HDoTIeVV7dg80ZktDfS7qpZgZ/O9tRpD/I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1956:b0:6e0:42e0:5e7e with SMTP id
 s22-20020a056a00195600b006e042e05e7emr411026pfk.5.1708134052897; Fri, 16 Feb
 2024 17:40:52 -0800 (PST)
Date: Fri, 16 Feb 2024 17:40:51 -0800
In-Reply-To: <CABgObfY=aGJNMk4CYb7nvauBWLJVbwVaA69bOK4bLteH7YyBNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209183743.22030-1-pbonzini@redhat.com> <ZcZ_m5By49jsKNXn@google.com>
 <CABgObfaum2=MpXE2kJsETe31RqWnXJQWBQ2iCMvFUoJXJkhF+w@mail.gmail.com>
 <ZcrX_4vbXNxiQYtM@google.com> <CABgObfY=aGJNMk4CYb7nvauBWLJVbwVaA69bOK4bLteH7YyBNA@mail.gmail.com>
Message-ID: <ZdAOo2AAm_NrTdOe@google.com>
Subject: Re: [PATCH 00/10] KVM: SEV: allow customizing VMSA features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024, Paolo Bonzini wrote:
> On Tue, Feb 13, 2024 at 3:46=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >   __u32 flags;
> >   __u32 vm_type;
> >   union {
> >         struct tdx;
> >         struct sev;
> >         struct sev_es;
> >         struct sev_snp;
> >         __u8 pad[<big size>]
> >   };
> >
> > Rinse and repeat for APIs that have a common purpose, but different pay=
loads.
> >
> > Similar to KVM_{SET,GET}_NESTED_STATE, where the data is wildly differe=
nt, and
> > there's very little overlap between {svm,vmx}_set_nested_state(), I fin=
d it quite
> > valuable to have a single set of APIs.  E.g. I don't have to translate =
between
> > VMX and SVM terminology when thinking about the APIs, when discussing t=
hem, etc.
> >
> > That's especially true for all this CoCo goo, where the names are ridic=
ulously
> > divergent, and often not exactly intuitive.  E.g. LAUNCH_MEASURE reads =
like
> > "measure the launch", but surprise, it's "get the measurement".
>=20
> I agree, but then you'd have to do things like "CPUID data is passed
> via UPDATE_DATA for SEV and INIT_VM for TDX (and probably not at all
> for pKVM)". And in one case the firmware may prefer to encrypt in
> place, in the other you cannot do that at all.
>=20
> There was a reason why SVM support was not added from the beginning.
> Before adding nested get/set support for SVM, the whole nested
> virtualization was made as similar as possible in design and
> functionality to VMX. Of course it cannot be entirely the same, but
> for example they share the overall idea that pending events and L2
> state are taken from vCPU state; kvm_nested_state only stores global
> processor state (VMXON/VMCS pointers on VMX, and GIF on SVM) and,
> while in guest mode, L1 state and control bits. This ensures that the
> same userspace flow can work for both VMX and SVM. However, in this
> case we can't really control what is done in firmware.
>=20
> > The effort doesn't seem huge, so long as we don't try to make the param=
eters
> > common across vendor code.  The list of APIs doesn't seem insurmountabl=
e (note,
> > I'm not entirely sure these are correct mappings):
>=20
> While the effort isn't huge, the benefit is also pretty small, which
> comes to a second big difference with GET/SET_NESTED_STATE: because
> there is a GET ioctl, we have the possibility of retrieving the "black
> box" and passing it back. With CoCo it's anyway userspace's task to
> fill in the parameter structs. I just don't see the possibility of
> sharing any code except the final ioctl, which to be honest is not
> much to show. And the higher price might be in re-reviewing code that
> has already been reviewed, both in KVM and in userspace.

Yeah, I realize I'm probably grasping at straws.  *sigh*

