Return-Path: <linux-kernel+bounces-60127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913185002B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2051C20E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0793A36120;
	Fri,  9 Feb 2024 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj+6+PXF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FD16439
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518442; cv=none; b=CrxrGFQ3UomPcSNP1IanK8oK93L6FkBP9cvIqcmqSnl+p4+xzkDTkPx6sPybc6j061saJFY6iBhn3zsHqEqjJ5dFn/JSz1j3Ygo2TkPs7YxevZxTtUzUb2sSZrMSNCS8HWmrRdcV3nV+irwQcC36mHGc+IX+LyVqP7TLYzb0o9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518442; c=relaxed/simple;
	bh=5mTur19Rxbo1EgoDaluJz65rrbAQAX8fLUiZ9Ef5FE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChkDkMdQzAuQuqZ8ebGZcstUD/S62FhP6sF4bhnHyJhF37MW50i/JSwQRBC8z50NeSxpA/C6CAAlDOWJggY6WX01sHcv9LUIygP0AfZZ7fJTrLYAbocoPWNEQNtul/7A8GBfpqFQSFFqnXzHAa1GxeYakKOlEAOLOCEcWogryL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cj+6+PXF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707518439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQrsHUE/LptBa5nKpmriIWMNQMle8yxHNuy/INIktI=;
	b=cj+6+PXFTFSqqTeA+toAxzLkikyxKRoC1dpJk3g173LHTGARa7DPiNFQHuQQ5ogjRdezq7
	qPWlCh7XIGOKGDepgWBIRZKUzrigIfOeIVhYmJFonXxuvnHjN30c2o+VS90tydBPwwQbZ6
	XJ0BOaHVNPop/YBhh5TQ0Bi8hfDEnGo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-_jSmgKYxMZ2zEZIYdOjrEw-1; Fri, 09 Feb 2024 17:40:36 -0500
X-MC-Unique: _jSmgKYxMZ2zEZIYdOjrEw-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7d604e82b38so1133421241.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707518435; x=1708123235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VQrsHUE/LptBa5nKpmriIWMNQMle8yxHNuy/INIktI=;
        b=FGEYMKxQX9sb/k3sRbemSKtc0BPc0WoGSqrdkF6jpg+BP57dwp1ebTjzoql/+bk8ve
         WE0W2gUSbNGXAcDMiRFfkz5uld1QK/0ln+vPIohPtnD7P7+Mp1GQvaWMk+fp4Q6ZECRB
         hCPGqRC0NgVW0SlRoZa79SYFM0vgBDC8uey8YG122w742W4XG5I40BhnsLyllVYqXoR/
         E7k8tv8Xw5Ddmo6Yd1D7l4Wbalc9pktEar6gh03vBEPTlFnBB4ghQIl9QMjT8bfFcjI8
         sELbk4YKDkCr1oWjRuladfloll5D2hiiPkpegU7GlmGu1W342gGcqq3SQwwNfx0xPHTa
         lFlQ==
X-Gm-Message-State: AOJu0YzPKL7aX8grlRMmU4hWLegrmuLAOo1039aEyJD7Eds4FHO399/H
	DtUMf6Xs5VRfhx73XSEPGf4kszvcSGofCW/pMXtqJGGMflf8G4ZWrUl7WF3QId+q1HlnaRLjTu1
	vQlLVZHeK8iLRkc3fuDwEWahLknuVgeroSWmjvMpgWk5ZWSs69oVXqfhn+80rADhM7xmyyUz7XH
	PKObBvw9eTxE/PC1R9zA8f5R0gtWHv5nnuXAg3
X-Received: by 2002:a05:6102:198a:b0:46d:295d:1d9c with SMTP id jm10-20020a056102198a00b0046d295d1d9cmr966948vsb.21.1707518435618;
        Fri, 09 Feb 2024 14:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDT5FseOqjE7EgYc0WV0xo2jicn+bWaOOKx90vB2jZwvCrR/EUTmLrqEEMbxIhn/R3Z0xvt66ZxrXlXADlWgM=
X-Received: by 2002:a05:6102:198a:b0:46d:295d:1d9c with SMTP id
 jm10-20020a056102198a00b0046d295d1d9cmr966937vsb.21.1707518435345; Fri, 09
 Feb 2024 14:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209183743.22030-1-pbonzini@redhat.com> <ZcZ_m5By49jsKNXn@google.com>
In-Reply-To: <ZcZ_m5By49jsKNXn@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Feb 2024 23:40:23 +0100
Message-ID: <CABgObfaum2=MpXE2kJsETe31RqWnXJQWBQ2iCMvFUoJXJkhF+w@mail.gmail.com>
Subject: Re: [PATCH 00/10] KVM: SEV: allow customizing VMSA features
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 8:40=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> On Fri, Feb 09, 2024, Paolo Bonzini wrote:
> > The idea that no parameter would ever be necessary when enabling SEV or
> > SEV-ES for a VM was decidedly optimistic.
>
> That implies there was a conscious decision regarding the uAPI.  AFAICT, =
all of
> the SEV uAPIs are direct reflections of the PSP invocations.  Which is wh=
y I'm
> being so draconian about the SNP uAPIs; this time around, we need to actu=
ally
> design something.

You liked that word, heh? :) The part that I am less sure about, is
that it's actually _possible_ to design something.

If you end up with a KVM_CREATE_VM2 whose arguments are

   uint32_t flags;
   uint32_t vm_type;
   uint64_t arch_mishmash_0; /* Intel only */
   uint64_t arch_mishmash_1; /* AMD only */
   uint64_t arch_mishmash_2; /* Intel only */
   uint64_t arch_mishmash_3; /* AMD only */

and half of the flags are Intel only, the other half are AMD only...
do you actually gain anything over a vendor-specific ioctl?

Case in point being that the SEV VMSA features would be one of the
fields above, and they would obviously not be available for TDX.

kvm_run is a different story because it's the result of mmap, and not
a ioctl. But in this case we have:

- pretty generic APIs like UPDATE_DATA and MEASURE that should just be
renamed to remove SEV references. Even DBG_DECRYPT and DBG_ENCRYPT
fall in this category

- APIs that seem okay but may depend on specific initialization flows,
for example LAUNCH_UPDATE_VMSA. One example of the problems with
initialization flows is LAUNCH_FINISH, which seems pretty tame but is
different between SEV{,-ES} and SNP. Another example could be CPUID
which is slightly different between vendors.

- APIs that are currently vendor-specific, but where a second version
has a chance of being cross-vendor, for example LAUNCH_SECRET or
GET_ATTESTATION_REPORT. Or maybe not.

- others that have no hope, because they include so many pieces of
vendor-specific data that there's hardly anything to share. INIT is
one of them. I guess you could fit the Intel CPUID square hole into
AMD's CPUID round peg or vice versa, but there's really little in
common between the two.

I think we should try to go for the first three, but realistically
will have to stop at the first one in most cases. Honestly, this
unified API effort should have started years ago if we wanted to go
there. I see where you're coming from, but the benefits are marginal
(like the amount of userspace code that could be reused) and the
effort huge in comparison. And especially, it's much worse to get an
attempt at a unified API wrong, than to have N different APIs.

This is not a free-for-all, there are definitely some
KVM_MEMORY_ENCRYPT_OP that can be shared between SEV and TDX. The
series also adds VM type support for SEV which fixes a poor past
choice. I don't think there's much to gain from sharing the whole INIT
phase though.

Paolo


