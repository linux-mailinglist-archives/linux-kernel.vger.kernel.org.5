Return-Path: <linux-kernel+bounces-108079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE98805A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16F5B213F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647C3A1C7;
	Tue, 19 Mar 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTX7v9mA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9439FCE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877696; cv=none; b=YO/QKPGqulRTHUozw7RjGV5ymN4CFO3DA7b0lTGSqlI/3NK4NiCXgBrA1GWYzA1958UwL0uuJDl45s07OKWi3Dn1hmmsi9Dbco9bGQH4dQzTUEVwmDdq3qq7v9eeEMpCLA8B/0DQVedqvnZg2k+1469YHLWLARdm70FVFcAXTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877696; c=relaxed/simple;
	bh=mYlKk2l0BwlOcMPHHRe9Lu1kct0DV6YFCdPeelfZ340=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NC8YXfIvfdvA2QyWw1SVa6b2DjFw8wDun/GuEUmwKS83b1SFXUXg5+bsQTNXtqKjgPAoOem8bb2z03QR6TTjUG4zSt2eFtlVpDhBECHHPnwKDmFG/Hc2PfFDeroqDPvAv/r7+UTKICQrfJbXpZ+3Rz9hjWUgE1SpeqofF59X5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTX7v9mA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710877694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0tBZy10sixK8JirSxxlugqPqYcAtueR8XsprCYR2ss=;
	b=FTX7v9mAOogsKXI/6UMZKpQqz7yEpJIMDlPxFLU/VQxzwBTtbhD3eAlm3A6/jbLODnkIsC
	rJRiphbKftC2DFcBgHwhYnd7Dx1Td4HukKSombPLs835RStpZYB0uLArBIAzhLe7TcP0r5
	GGkHrHrEbByj5yM1lAMCIX4FiIiXOvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-0CbYmYpRNMS-aSmgigRlrg-1; Tue, 19 Mar 2024 15:48:11 -0400
X-MC-Unique: 0CbYmYpRNMS-aSmgigRlrg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-414105984aeso14109745e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710877690; x=1711482490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0tBZy10sixK8JirSxxlugqPqYcAtueR8XsprCYR2ss=;
        b=c7wbPwTA+LtxihmUdcFD58mcKKmrU8JORul4KZ8eHSRQRPgbG6511NZykn+Tc/TTwm
         F2K8bRdIt35R/HSiVAGarGBLEPP5bwUYgFZFXbJcuLTKIYCk5snnjeI/d+RUD1hCKvA7
         hZ2Gy0sw0/XG8pGiJrYYsqWQDUpwtbXlZl4XOr+KOq+WVG6Cl+iu1ukAFEaMMT0HVWbQ
         L+0YcYZNlt994CY2PVKFBTUAOVlrjQaeUXbJeJUSnw+5U+hZZEdxf0r5uB3dJcYEIBR3
         Rfmp57npG43L2bWe7jGTiODlW+LTR2zaUsV/b9Rnr+Ca3+wm7cMKhiRp4YUEwCbh6EfP
         2BsQ==
X-Gm-Message-State: AOJu0YwyJLD1W7Chm9t5G1I2ElBxeE5TgMRhrPu4BnhrAe+kOhV+Da9j
	ql9kvLakcXRFFvLeLjJEheHDirGKH/nMzo55RzdyWkLgbS/eiDXjw/jO5nsH6rvlXG5dIz8mbXu
	RZMu9CvdDL8bO8vJe9W6B3dTgIxxh5TS8NeItSSs9kFxflsHdeWpquxWA6FrOmhSZqILXL7lIad
	Qg9Szt4326WxPbDqy3ahq8EJy6+AP7+IcNPIzg
X-Received: by 2002:a5d:58c2:0:b0:33e:bc7e:cadb with SMTP id o2-20020a5d58c2000000b0033ebc7ecadbmr2385776wrf.41.1710877690726;
        Tue, 19 Mar 2024 12:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+QvIljcIX0kbSi4NZsFu/hQLTEFLR7591e9VToTE2vLVQvCgVTTc/SfmfHIllDHxysuZVuJO3Wj60wKhPk2E=
X-Received: by 2002:a5d:58c2:0:b0:33e:bc7e:cadb with SMTP id
 o2-20020a5d58c2000000b0033ebc7ecadbmr2385767wrf.41.1710877690419; Tue, 19 Mar
 2024 12:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318233352.2728327-1-pbonzini@redhat.com> <20240318233352.2728327-10-pbonzini@redhat.com>
 <20240319134219.evphel2bmyopdz75@amd.com>
In-Reply-To: <20240319134219.evphel2bmyopdz75@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Mar 2024 20:47:58 +0100
Message-ID: <CABgObfaGT6MBX_0XHmmJzDxFo4pRHED6-U=oGrH24PAqDGrk1A@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] KVM: SEV: sync FPU and AVX state at
 LAUNCH_UPDATE_VMSA time
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, seanjc@google.com, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:42=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> > Since the XSAVE state for AVX is the first, it does not need the
> > compacted-state handling of get_xsave_addr().  However, there are other
> > parts of XSAVE state in the VMSA that currently are not handled, and
> > the validation logic of get_xsave_addr() is pointless to duplicate
> > in KVM, so move get_xsave_addr() to public FPU API; it is really just
> > a facility to operate on XSAVE state and does not expose any internal
> > details of arch/x86/kernel/fpu.
> >
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/include/asm/fpu/api.h |  3 +++
> >  arch/x86/kernel/fpu/xstate.h   |  2 --
> >  arch/x86/kvm/svm/sev.c         | 36 ++++++++++++++++++++++++++++++++++
> >  arch/x86/kvm/svm/svm.c         |  8 --------
> >  4 files changed, 39 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/=
api.h
> > index a2be3aefff9f..f86ad3335529 100644
> > --- a/arch/x86/include/asm/fpu/api.h
> > +++ b/arch/x86/include/asm/fpu/api.h
> > @@ -143,6 +143,9 @@ extern void fpstate_clear_xstate_component(struct f=
pstate *fps, unsigned int xfe
> >
> >  extern u64 xstate_get_guest_group_perm(void);
> >
> > +extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr=
);
>
> I get a linker error if I don't add an EXPORT_SYMBOL_GPL(get_xsave_addr)

Indeed, and also the format for the 10-byte x87 registers is... unusual.

I sent a follow up at the end of this thread that includes a fixup for
this patch and the FPU/XSAVE test for SEV-ES.

Paolo


