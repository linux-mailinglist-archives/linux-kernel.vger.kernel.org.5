Return-Path: <linux-kernel+bounces-148855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DFD8A882C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF1BB25519
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664F1487DC;
	Wed, 17 Apr 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+UV7Gg3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E1147C7B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369142; cv=none; b=rbAdakJQN/xLQ0+nFI22BRmP8wwdBt/4y9Okp0L7etHO9G1FTzcEurDu+obfoAPdwwIZQSnl7XEW31cb8lI9hgJXUzbh44H31clzrT0CtVUCubw/EFaI/4x78C4cZ+wV1hWLm1jGbu8iTzSwQSVka+KtnM5EZktsD4GGH4rm06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369142; c=relaxed/simple;
	bh=d6wYdf8GBT2sfnqVX9ehWmUTyi1CnG5W0K3/E5HKxbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu6eUIz9oR4t35Eh4wrAcbkIjhPxUwa/Bf/yJpb8PgPeGuDR/6wceqyETeWiJudd2HQ/27bgWZ91th9dgJjCWBWaGR91ouecdDMl8EfNk4p+LlSMW9JtlOYr1WjHflwsauQ8WFR0kxm5gTOAG1JVLfHaX01mbwdKif3r7fuBLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+UV7Gg3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713369140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6wYdf8GBT2sfnqVX9ehWmUTyi1CnG5W0K3/E5HKxbs=;
	b=f+UV7Gg3/VenUeIISClz47UNNGEKA9wAo9mhSNv5/KAn7YJsl1yKnOdirnIz9ErOVuFien
	oQVKq43rOmosDib/pqitvZMHnRQHoQjbNoOGnmivro0Zv519WR9yH5KiUXZimMewPXkzAR
	PkGSN59e/jlXDeZtmScNHBnu5egPWd0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297--wW9VX3qNR2PVIs-8QCgVA-1; Wed, 17 Apr 2024 11:52:18 -0400
X-MC-Unique: -wW9VX3qNR2PVIs-8QCgVA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a2c4a28e43so5118490a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713369137; x=1713973937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6wYdf8GBT2sfnqVX9ehWmUTyi1CnG5W0K3/E5HKxbs=;
        b=clg8XaZDkh/SG3AtsHv+eUpdq0zixb3Xr2miv73NbxZqWJ4Nh3vFTpLtT1Kx7ZFqrB
         mYdtd5A3km5vZeN4VMkvb6+Od8qdZhnBHuGlcf5O4askAVXeKPDOYtuyaTS03QnMsx9R
         JK/xr+/ePP3U3fH7aAPRysEChHmSjFXT/JGXtx8rRjgVqBOSbs1wE0lbq1ZfoxH1cL/Q
         yKGaiKoYbvXVmwfshF3tiHc7Rm0Ohd3q3QC3BMcH02jLdMLW0RGAoOYF/8wlGORAJeL2
         7U8fBBbvMmLciWa/Kituow3YJq7O5sBohhx9JTDhzXKN4Fm+Ynj5E6IiYQfJU/aP5xbr
         a0zA==
X-Forwarded-Encrypted: i=1; AJvYcCXXVFJe8VGDBa/5crL6vd8hxZ6B6gUnqoVLurr44MeiPtZAthX0ew0sAUZuVe1ODDQiP1JFzfT3BF35MHpamhcsMQOOQPWZRbmh2WeB
X-Gm-Message-State: AOJu0YxPgaMwEfagyeGrDUEdIz8x+pWJQ3Klz0DIeKDjDx8Hk7bsF4SC
	6QQ7wbPxXMYXneC5DSC7yHBnmQEGE7etLn7p1fApB3yWnLbpY0vcKPydhcr9VRXgeYfetTFw+V6
	pe5lo3xXapsBvGEw+hYBt0SrWP5NWbIyJ4NfzH60YikUTJ9uhVhIDY8HO+Qv00a8dlzHxAj372n
	mXFHj2QAUPStPt2z8dri5FfBAqydcaet2ZZjcf
X-Received: by 2002:a17:90a:f507:b0:2a2:bc9d:f44f with SMTP id cs7-20020a17090af50700b002a2bc9df44fmr13568204pjb.13.1713369137261;
        Wed, 17 Apr 2024 08:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrwgkJpJ6yrADjqJeDHRbvSm/QmomCjDCukl/vp4hRX+B1cOq6oqnam+PyQ/LHk6FBukBta+2ZpaJGDJsgFtw=
X-Received: by 2002:a17:90a:f507:b0:2a2:bc9d:f44f with SMTP id
 cs7-20020a17090af50700b002a2bc9df44fmr13568177pjb.13.1713369136809; Wed, 17
 Apr 2024 08:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d10cd73-2ae7-42d5-a318-2f9facc42bbe@alu.unizg.hr>
 <20240318202124.GCZfiiRGVV0angYI9j@fat_crate.local> <12619bd4-9e9e-4883-8706-55d050a4d11a@alu.unizg.hr>
 <20240326101642.GAZgKgisKXLvggu8Cz@fat_crate.local> <8fc784c2-2aad-4d1d-ba0f-e5ab69d28ec5@alu.unizg.hr>
 <20240328123830.dma3nnmmlb7r52ic@amd.com> <20240402101549.5166-1-bp@kernel.org>
 <20240402133856.dtzinbbudsu7rg7d@amd.com> <20240403121436.GDZg1ILCn0a4Ddif3g@fat_crate.local>
 <Zg1QFlDdRrLRZchi@google.com> <20240404134452.GDZg6u1A-mPTTRqs6d@fat_crate.local>
In-Reply-To: <20240404134452.GDZg6u1A-mPTTRqs6d@fat_crate.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 17:52:03 +0200
Message-ID: <CABgObfYkMjbY3_PFKmEJPf4BiNk5ueGWmUowDwax7k+=LTG3Gw@mail.gmail.com>
Subject: Re: [BUG net-next] arch/x86/kernel/cpu/bugs.c:2935: "Unpatched return
 thunk in use. This should not happen!" [STACKTRACE]
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, bp@kernel.org, bgardon@google.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, hpa@zytor.com, 
	kvm@vger.kernel.org, leitao@debian.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, mingo@redhat.com, mirsad.todorovac@alu.unizg.hr, 
	pawan.kumar.gupta@linux.intel.com, peterz@infradead.org, shahuang@redhat.com, 
	tabba@google.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 3:45=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Wed, Apr 03, 2024 at 05:48:22AM -0700, Sean Christopherson wrote:
> > I'm guessing a general solution for OBJECT_FILES_NON_STANDARD is needed
>
> Yeah.
>
> > but I have a series to drop it for vmenter.S.
> >
> > https://lore.kernel.org/all/20240223204233.3337324-9-seanjc@google.com
>
> Cool, ship it.

Applied for 6.9.

Paolo


