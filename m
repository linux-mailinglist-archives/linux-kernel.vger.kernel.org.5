Return-Path: <linux-kernel+bounces-83921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD7B86A08C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D034B33854
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CA14EFCE;
	Tue, 27 Feb 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJlZDLZB"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73F14DFF8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061817; cv=none; b=c6PF1udm/H0H+v1XlDqiQlxZHYs/Bukc9gv2sf6ZRhua0jkGmBRY5SHWQrEskfPkFQt5/+ShFmm7rrTLKyMXAVxbKDDJcENVASzNGc5rUGMylUfAWNU1sydjyPMOj+wy3uNfMvGciWrlM4wEtmBTudRIfFieRfIbWanN5TtVFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061817; c=relaxed/simple;
	bh=iUHZtWXEIPRQ6Ma/j664NlwzSYFrV9+QjldWV5GlKB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/MpPNsCC3gAXSKU1aSS/oWdJDuLN2oDRkzNuRkznU1iJjWFS33su+v+ioGeyhzFZQOWo0XOUnnwfyIunXrPS7gP6hS7xN1+sGfCpAawqwIQ2W0p2fpSYIdHk5lW/wZAXeXCt7pxlflKoyMPg85TuCiLLygfMzG2jbfwdm6RbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJlZDLZB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29ade776a78so1252338a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709061815; x=1709666615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQm8Zb2eEUI++sf+ZNG6yB6/9kYVZiXrT/+TWXr9Bcs=;
        b=bJlZDLZB5gjIehKctKMB76/qtB+rZaiDJRLUeDL/N1pk6HVWHHhA65NT3ZmM6ZmLnm
         MHNQbLeMO9PI7zExYqIGimeYWuAvVUlaNtAkXMU7A4RKzT2dbVQtnq1hzoxNYF8T5hTo
         ouRTSnx7YGG8ZqxdOOhLDkzJmAzCzr/oNGMQFdpJR08mZbdDeJXc9cSceHhuEaE4X4Wv
         HsH8/bDsGaooF05FlmKKnCXgUi/L9dgzXK27YCnSQFn95i0Hu+tdS1Djkrhhx93Pl7rc
         e9JAcxiZpUmXkrR19Bp3F+WKCqyAqW2/OcF/mrJOJMioeQ3zMH0rGZJaXauyBN54HGsS
         ONRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061815; x=1709666615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQm8Zb2eEUI++sf+ZNG6yB6/9kYVZiXrT/+TWXr9Bcs=;
        b=qyTyTQ2v26CIHuSnp3T9oQpXGMqIPpDlySr92vozE4zNpK5fv2e59E66JsdlvSzmyB
         bLBTaLuV7gZQNinMEuhTI5IVvhq9Cfi4tOJ7iE1XnuLjjc85WwYZywNgMDiIlpY2szqn
         HMKLyi2BnMDbfxs7l69GNsPx7oIKndYTQsYhgVOjoPAH+Zduteh9Dl6SSKz1WnkJMYAZ
         1GI0gJUvWrMi3kZ2rPx56cWvk9de4sOohg1fmL3yF8K50C8X2mn2lZH4Erp+Xf+HV9pu
         /LcY5wKv1WganOdkJxlyH9epFuaO50YP7ZGGBwGIeHgYdWKHInxspR6RqDc1OnDHPI3U
         MQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRSy70mb6h/UP41BlVkOPu7f+J1jtXrfY5RgIUYtxROlruBAHUnBTrUNyW1BZJIe66ekC+7jKgtK9rabzCsN+HrxYEQ1L4F81Wyfic
X-Gm-Message-State: AOJu0YyxRV5sgEPhGS+RJeC1+VdazxYyU5g5xtpwznmaakGv7jv46gDp
	rOaZzkZP4vSSHCvfgTgQy3fMc3juceqss2YWl02vfL+zpzYq1kVbAlqxQHeOE1X+qskQRyLGGx7
	Vow==
X-Google-Smtp-Source: AGHT+IHQM3OuyGdNrGgF6VU7AUXmtt6ZLy5uimzBb7a1wYaXunne/K0UvMyi9rtV3k9uBtqsVuOxwr6hGok=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1fd0:b0:29a:aae9:d5aa with SMTP id
 st16-20020a17090b1fd000b0029aaae9d5aamr79808pjb.7.1709061815013; Tue, 27 Feb
 2024 11:23:35 -0800 (PST)
Date: Tue, 27 Feb 2024 11:23:33 -0800
In-Reply-To: <Zd41wDpl4K6j+iU+@AUS-L1-JOHALLEN.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226213244.18441-1-john.allen@amd.com> <20240226213244.18441-6-john.allen@amd.com>
 <Zd4mf5Z1N4dFjFU7@google.com> <1f95281e-f8a9-4ff2-8959-162a192e48bd@amd.com> <Zd41wDpl4K6j+iU+@AUS-L1-JOHALLEN.amd.com>
Message-ID: <Zd42tc61Epo3REK0@google.com>
Subject: Re: [PATCH v2 5/9] KVM: SVM: Rename vmplX_ssp -> plX_ssp
From: Sean Christopherson <seanjc@google.com>
To: John Allen <john.allen@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, weijiang.yang@intel.com, 
	rick.p.edgecombe@intel.com, bp@alien8.de, pbonzini@redhat.com, 
	mlevitsk@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 27, 2024, John Allen wrote:
> On Tue, Feb 27, 2024 at 01:15:09PM -0600, Tom Lendacky wrote:
> > On 2/27/24 12:14, Sean Christopherson wrote:
> > > On Mon, Feb 26, 2024, John Allen wrote:
> > > > Rename SEV-ES save area SSP fields to be consistent with the APM.
> > > > 
> > > > Signed-off-by: John Allen <john.allen@amd.com>
> > > > ---
> > > >   arch/x86/include/asm/svm.h | 8 ++++----
> > > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> > > > index 87a7b917d30e..728c98175b9c 100644
> > > > --- a/arch/x86/include/asm/svm.h
> > > > +++ b/arch/x86/include/asm/svm.h
> > > > @@ -358,10 +358,10 @@ struct sev_es_save_area {
> > > >   	struct vmcb_seg ldtr;
> > > >   	struct vmcb_seg idtr;
> > > >   	struct vmcb_seg tr;
> > > > -	u64 vmpl0_ssp;
> > > > -	u64 vmpl1_ssp;
> > > > -	u64 vmpl2_ssp;
> > > > -	u64 vmpl3_ssp;
> > > > +	u64 pl0_ssp;
> > > > +	u64 pl1_ssp;
> > > > +	u64 pl2_ssp;
> > > > +	u64 pl3_ssp;
> > > 
> > > Are these CPL fields, or VMPL fields?  Presumably it's the former since this is
> > > a single save area.  If so, the changelog should call that out, i.e. make it clear
> > > that the current names are outright bugs.  If these somehow really are VMPL fields,
> > > I would prefer to diverge from the APM, because pl[0..3] is way to ambiguous in
> > > that case.
> > 
> > Definitely not VMPL fields...  I guess I had VMPL levels on my mind when I
> > was typing those names.
> 
> FWIW, the patch that accessed these fields has been omitted in this
> version so if we just want to correct the names of these fields, this
> patch can be pulled in separately from this series.

Nice!  Can you post this as a standalone patch, with a massage changelog to
explain that the vmpl prefix was just a braino?

Thanks!

