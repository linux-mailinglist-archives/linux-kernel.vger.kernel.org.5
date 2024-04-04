Return-Path: <linux-kernel+bounces-132175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450508990A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82EE1F237D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9E813C3CE;
	Thu,  4 Apr 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVeD7uVu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F7131BDB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267724; cv=none; b=fSUJECWUUubck6gQc/6hwvrJBM3f5e0R2vtyLDKNbkak+s/PL9yGXBQr5SFIN4QldC7CMuFkdvlgYvphDh6sWFM1Wse479s1Ku5BCMpPLJGEyUakO855ZFR1tycp2okMiy/xCW9bI3Mf90JB0hB/yaNhpH2HcDktbUWayWaXlMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267724; c=relaxed/simple;
	bh=IieES/8bKEnHvAQMRqX27a8bScdjVFPXGYhKImvWWFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+Ciu2Mq32yqe0n3RxxSt3Ys+/ztNifbO1R2Jx+jKJMTtwsSDNtDs/NDQ7Dgs8zEdCU1kUtmCIl+ovnHk5hYml0hRZpuG++VLflDQS3cHh4Wqq4vpK9nqvSRYYrdoWxwD8S/Qmql2TFJOJEWsrNYGNBwQGbk2fKlc53k9JCoRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVeD7uVu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61504a34400so24742657b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712267722; x=1712872522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxIVyv7cNyTq2vNYoeJOtNz8nXPv634GBs939JAmlHY=;
        b=sVeD7uVuJbyoexOu57Tvec7+Bz+LNkUFJg/5gFSrkeqToA4ljJGRbruwoKtVj6abIS
         PdQ6mXQVOY70NHIOSHqG0KMnI0LSm9/9XyUlZUjZ9jk2MC+OdTNPC4oOI989d3YZWr1g
         o6Z/Zx2OnMA/hiKDez6tiwjFr6O1907HGXXVmHa2RFHCXVf4PbEOahsIkVb3noPE8uxC
         YRcwiQ/ZsDUZjeE/JodFsxemppGggCDp/70qpUqHC+RwueuAMVAHZG/W1UPUbSzBYf/Y
         8THXTVyzS5VAVhyZo+sG/lzCcmROHP56OXNfU3fqQ4lTlgmfzQvH5VmGxIFeXt3q5yvB
         00Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712267722; x=1712872522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxIVyv7cNyTq2vNYoeJOtNz8nXPv634GBs939JAmlHY=;
        b=OOuxFdfPtbOR/PSCWIXpFbUnTKs7zyPIdK3xQhRZiELPZYqE3HUOr/3mpmjIJ9thHr
         XS+1G9cX3dsW9GppxIqk68c9DjusshRQTTNQfQtQjUtzQKlDioIDHb8tDG+3tAbLsgPh
         COLrDeD0Usk7EByKdbK8azMEBln0FgLp0deM7ebau/gw+vvy5SsJ6/3UC/xjkQGW65v4
         7s8JwRGuKbjdpaydygc6bYmi8DCjI1ASyKFm6vk4H9IZXUphcK6m6HtsZa7uaYK3df8S
         KZGWCEzsJ4KPk0gFIi65gD3PAMdal9oQ8scJJij7q53xwGnKz169r5g47T4l0IIOY7d8
         bsqg==
X-Forwarded-Encrypted: i=1; AJvYcCUSsCSodho5E9h1HVmrAF96nVr1WzEYQMSBWVluoPeDrOfkMIzPaCgBaSMqGecIH1CKDC0BAPChiM2NS/kEbPjiYiK1RC8nq/2TaXFX
X-Gm-Message-State: AOJu0YxUM8DT/UnFKf+qBtx2qUjAbGqPTuIFRbx5ExdYnQyyzL+b0qqJ
	hOmdQvmShNvqcogkbuaFQL70VI8YUsEiE0WaallDaWkEMnxe+3r8rWoLcmy0fGlbdOrW/rWpWhA
	Ekw==
X-Google-Smtp-Source: AGHT+IF9Zl8pcwn3qOKy6dWDe6D4qOtPFtvzTeU/xZJRH+srpGCJd87O6gHNWcMqlXRBzdQ0o1Y5uo2NHKw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c94:b0:615:ca8:6058 with SMTP id
 cm20-20020a05690c0c9400b006150ca86058mr187971ywb.5.1712267722107; Thu, 04 Apr
 2024 14:55:22 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:55:20 -0700
In-Reply-To: <8ae52273-7b79-46b7-9cd5-2a0c401311c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
 <20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu> <8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
 <20240402192314.a9b4e05637444314f47557e4@otheo.eu> <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
 <20240403175407.f81ebc5cc3300ffa0c39f597@otheo.eu> <7db8d0a8-c668-44be-a348-58120a97fc2b@intel.com>
 <Zg7GpY0_U_7yhe6P@google.com> <8ae52273-7b79-46b7-9cd5-2a0c401311c3@intel.com>
Message-ID: <Zg8hyG__NJZrB-ju@google.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t
 to avoid split locks
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Javier Pello <devel@otheo.eu>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 04, 2024, Dave Hansen wrote:
> On 4/4/24 08:26, Sean Christopherson wrote:
> > In other words, practically speaking this isn't about supporting a new hardware
> > feature on 32-bit kernels, it's about preserving performance in real world
> > scenarios when running 32-bit kernels on new hardware.
> 
> Realistically, most of the 32-bit kernels in the world are going to be
> *OLD* distros, right?  Old CentOS/RHEL/SLES kernels from before the
> kernel had split lock detection, or split lock fixes.  Those trip over
> VMM split lock detection now, and presumably will forever.
> 
> I suspect new CentOS/RHEL/SLES kernels that have split lock detection
> all happened after 32-bit support was dropped from those distros.
> 
> I think that basically leaves Debian.  Someone would need to:
> 
>  1. Make a *new* 32-bit Debian distro install (or one of the other
>     less common distros that still do 32-bit)
>  2. Run it on hardware with split lock detection
>  3. On a VMM that enables split lock detection
>  4. Stay close enough to mainline to get split lock fixes (like from
>     this thread)
>  5. Care about performance, despite *ACTIVELY* choosing a 32-bit distro
>     on 64-bit hardware in 2024
>
> Those steps are certainly possible.  I'm just not sure how much trouble
> we want to go to in 2024 to support people that choose new 32-bit
> distros and desire performance.

I'm worried about a scenario where the throttling is so bad that it's not a perf
issue, but a functional issue ("performance" was a bad choice of word).

I do agree that the probability of this being a real problem is super low, but at
the same time it doesn't seem too onerous to clean up.  And in the unlikely case
that this does cause a problem, the pain on our end can be quite high.

> It feels to me to be approaching "I want a pony" territory.
> 
> Or am I just lacking empathy today? :)

Nah, I'm probably asking for a pony, but AFAICT it's a pretty cheap pony.

