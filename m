Return-Path: <linux-kernel+bounces-145990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061B8A5DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E298AB215E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A15158D61;
	Mon, 15 Apr 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaFvlV/Z"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D8158859
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221954; cv=none; b=tT3Hz3E6BB7EOMKmp0rvDC90KwRoDxWdUoa52Bf4kYaXiItfWZNPqaLubfTqZebNZ2Q5Y7gM4vBYoQp84ZvfXIKS2uC1uXVX3V+MSnJptLghmAXIJdZ+rTZyPxiGTTymOzupPkaKtYw1/wrwfF0N94626ZC09O+I8y+DXCb8FUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221954; c=relaxed/simple;
	bh=DdFbcDWupdbZq3MIrDoyTUGR/ypiyEhsqthCvxrfA/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JcQCv6jUhcnJITWfLmLEzh3doT3jPyo5f5aZbWoY2HLLF0852oNE1S49gKeMH9gcwqKoCUIIuir8w7OpbJXadJo7GWMuZ7EhwhWYUqD0kfvFNSrdJbJ6nY4k3ELzL25esNF3Gi6C2uECrCIKVsRcNLpix1y1BFumyDH1uaqw+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaFvlV/Z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso3464869a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713221953; x=1713826753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+6RmiqHl0vlEhWm7Grv4WhfQxc8gtLrnCV+6pwVYvc=;
        b=IaFvlV/ZSQ+ANIBVsbZ6FhZc7skfu4a5M8B6h4IAb4H994t043HqVfiwpRvOXy8Icb
         3XSjs2skgiC3g7n6pVjflrMfwhrFonw7DrZ0jfMj4oEZBkcxrL4Uo8F7a/aP8FnxXS2M
         cvtRhRgJrUY5BcGM4G9P6nUVEK7709eskQRjB0UBatGgu3PCdKWJq/ZU/sB7yYVI7nIa
         a4ckUYDdw4EzwV5J4+OV4FXMtVpEOY4uIYd8hacYeggEFQF1j2WNfRqJCt2sNxlDMoBO
         10EXk2D1fu9qErUT+e/YfGTlJZUYE7oIsjWi99axwiFvt3534/J7jQ+uik++01f+mk00
         hAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713221953; x=1713826753;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+6RmiqHl0vlEhWm7Grv4WhfQxc8gtLrnCV+6pwVYvc=;
        b=IuOjYFxBwZWYxD7UAfucl0C+s5iqZW2fQbfJhg+pqGTz/dtGFixxDkuHv3+Cxjw0vV
         dYWPzj1KZ7zAbk9ayTLS9McbTqT6B5+eCT/4jRLfa0NmUJj2V18/BcONzECY23aSTpU5
         yQZGSbzfw5GN1SAvtyWIkGkdg7miKLB4fzbPLjAFdGMU2O1Uovg54AlY2+cSpJQOunfU
         FvTLHYz83JuDvq6vM3SYOIXRcmCMgZC65zRB2xnepHHhCbQ2tOxnu4wiBLck11G0C3UH
         IObq+isv3dSKsMpzd8iiJMCiCO/NVXI5kdDhXoeROjvKU4Lyo5mTj1Cs7kQPViUWGBaH
         vZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTzsloP0gFlFCkShl4hSPTf/j8ROqx29pmSB6BQIyr48W590ItIRIXPtjvXB77ENGmG1WAUZmkscIfxy0Sdp5BTYPSZhiO6MS1pjIF
X-Gm-Message-State: AOJu0YymGfXk4hEif3W1PnybqD4istEOopxsCE4BNTNkwf7TiyTyHFxh
	uik/EisRi4BgOO/4AlGXdlPsiPtmmRicL6PxDCLldRcElOZtGT66SPpZGbrOZMtyxo/k8HLLSn6
	X0Q==
X-Google-Smtp-Source: AGHT+IHIN3c3KafZKwbjYEO7XDxNUeKMgXMoQNPwQ3zXEtyUK633NACFAHkTnhqp9fuH4PP86bf5/43ShhI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e618:b0:2a1:f7af:887c with SMTP id
 j24-20020a17090ae61800b002a1f7af887cmr3469pjy.4.1713221952870; Mon, 15 Apr
 2024 15:59:12 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:59:11 -0700
In-Reply-To: <8959c330e47aa78b97bdca6e8beae11697c15908.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1712785629.git.isaku.yamahata@intel.com>
 <2f1de1b7b6512280fae4ac05e77ced80a585971b.1712785629.git.isaku.yamahata@intel.com>
 <116179545fafbf39ed01e1f0f5ac76e0467fc09a.camel@intel.com>
 <Zh2ZTt4tXXg0f0d9@google.com> <8959c330e47aa78b97bdca6e8beae11697c15908.camel@intel.com>
Message-ID: <Zh2xPwGAMMgqKeYV@google.com>
Subject: Re: [PATCH v2 07/10] KVM: x86: Always populate L1 GPA for KVM_MAP_MEMORY
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, 
	"federico.parola@polito.it" <federico.parola@polito.it>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmatlack@google.com" <dmatlack@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024, Rick P Edgecombe wrote:
> On Mon, 2024-04-15 at 14:17 -0700, Sean Christopherson wrote:
> > > But doesn't the fault handler need the vCPU state?
> >=20
> > Ignoring guest MTRRs, which will hopefully soon be a non-issue, no.=C2=
=A0 There are
> > only six possible roots if TDP is enabled:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. 4-level !SMM !guest_mode
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. 4-level=C2=A0 SMM !guest_mode
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. 5-level !SMM !guest_mode
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. 5-level=C2=A0 SMM !guest_mode
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5. 4-level !SMM guest_mode
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6. 5-level !SMM guest_mode
> >=20
> > 4-level vs. 5-level is a guest MAXPHYADDR thing, and swapping the MMU
> > eliminates the SMM and guest_mode issues.=C2=A0 If there is per-vCPU st=
ate that
> > makes its way into the TDP page tables, then we have problems, because =
it
> > means that there is per-vCPU state in per-VM structures that isn't
> > accounted for.
> >=20
> > There are a few edge cases where KVM treads carefully, e.g. if the faul=
t is
> > to the vCPU's APIC-access page, but KVM manually handles those to avoid
> > consuming per-vCPU state.
> >=20
> > That said, I think this option is effectively 1b, because dropping the =
SMM
> > vs.  guest_mode state has the same uAPI problems as forcibly swapping t=
he
> > MMU, it's just a different way of doing so.
> >=20
> > The first question to answer is, do we want to return an error or
> > "silently" install mappings for !SMM, !guest_mode.=C2=A0 And so this op=
tion
> > becomes relevant only _if_ we want to unconditionally install mappings =
for
> > the 'base" mode.
>=20
> Ah, I thought there was some logic around CR0.CD.

There is, but it's hopefully going the way of the dodo, along with full MTR=
R
virtualization:

https://lore.kernel.org/all/20240309010929.1403984-1-seanjc@google.com

