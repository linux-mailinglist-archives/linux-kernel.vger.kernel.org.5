Return-Path: <linux-kernel+bounces-129642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB11896DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62871F28DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653E142E82;
	Wed,  3 Apr 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2hlPrje"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7E141991
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142509; cv=none; b=F0PwNv1zaIMMGlb9g7CMNLr4hIOKM350qf/X0cQ43K7ob9bc3RT3824xDKR5YtByRpTEEklTpg1BGOHc0RQq3cnDOH2OZpUWtCtGVn1HFS5bEAMAVuFLshePUt7W4z1m5P3n6RaatKQU5zdyjk6dhRzMRk//rkogmlC7/bImw5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142509; c=relaxed/simple;
	bh=hiIT3clFcgU9vE4wJgrZPwRZoScmwgKwTtsvRWs6kco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj52WDjqHOJ/fezsMd7T0V3N4DRivX8eODm9yLgnGZ5/xcmupFAoQWhM1AMSznd6jxj8k3LLfzEYWJBsNzMzD+iW/i2W924VeO8Wm3lNgKmM13RvMUjqW5Ss/aZuB3DwAAtzT0QuvP3b72Btq/XPe8Gfv5KAsEa/p0TGdeppe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2hlPrje; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d700beb6beso73475631fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712142506; x=1712747306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trfdpWJkC5DXb381MOQraiurhasFHWLHrzwFwCxgCKo=;
        b=N2hlPrjeiSRS9iWNHU13UffzoYZO7FxZA8aEjp5O5d10XwfcNqDQ2VgIGCxp458Dub
         R1TycSOsKqYjy8rcgIJkc6nhFKoXF/w+tp1VJo5Q1jQ0rnlNaQkE8ctu4yE6G8SHSCSZ
         WG6ouVYcOsqyqqIQ840IeMowtEPzdkRxetMP9Z4BMg+q8n5igX3m2s/+gKL7usLj8JJh
         +cR9CMudAnYudF5M9xcc8pIX53kHRhevlHWUMHgSIlR7JauAAVPt7VheWuO1Bsga3RMA
         3rilS3mQhUSQpNmoudskRyGkgFxSBynu5g/+biMMcZd990ZZrrFSHGwImaC1sKVVhBiK
         Ta/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142506; x=1712747306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trfdpWJkC5DXb381MOQraiurhasFHWLHrzwFwCxgCKo=;
        b=HKS2jn7mE8QUPU1B4J9W2BDX1EXY48bLuBks9gvKkw4ixNmrjrSTJeE9BT3g6Jr3Ey
         3GD+zZ5DX5JAQ0FN5LPpzW1dnRtakxT0jwrALycU5vcIJ/cLPr1ONyJxYxamVG0z6kAg
         ynZL+K82ObfZLXL8tgxuvyHm+xN68WkKUAMzaxa5OsZdJ5D24L85ty4Z4I6pJ5wzDmnJ
         SIpnptycrzBlOaXPHBsv/Dz8AnbzGHt9J2Bmudmw8/HqGcsIrCt1xipiKoFMlG/K5waq
         6+YH7nvK0hcmcxEmfo5OfUGY8o714EBr+3IFVaCBmDQVZVb4x9KQg2jsJOn4ZapT7XpV
         myDg==
X-Forwarded-Encrypted: i=1; AJvYcCXnxqURWWG+Qy2ry7Rkd5JYI7L6Ermonct1NH7aOnWByZxoYWnW2LAkUAMijWi69+z+Sc1UzqVn5gV5bZ+uskIOaKSec6KeIIfuo7sR
X-Gm-Message-State: AOJu0YwlrDkwpTCmHEQkQmHA30tULj6CfVvOLAXtUNL/jrh9arUDDeRa
	rPobHZkg4+pVkZwLEhNx7epz2tREK2UvdedRIjfyHzIKr3My8+4k8MsLb9wyVkLeuKzqab6UgnJ
	XD9s9/UcUW+Lvy3DDX/SSEICOHA==
X-Google-Smtp-Source: AGHT+IEFIbWWAQsDQ5vEOQ3MihgXong3IeyNELCKQLfFvWQgj0s7v3pEpO1tc7mu9p2goTF6sfr4zP75/3T1B7H/IVM=
X-Received: by 2002:a2e:3c05:0:b0:2d6:b8cf:58af with SMTP id
 j5-20020a2e3c05000000b002d6b8cf58afmr8573141lja.15.1712142506049; Wed, 03 Apr
 2024 04:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
 <20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu> <8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
 <20240402192314.a9b4e05637444314f47557e4@otheo.eu> <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
 <Zg0L/OfuQtVgFSsG@gmail.com>
In-Reply-To: <Zg0L/OfuQtVgFSsG@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 3 Apr 2024 07:08:12 -0400
Message-ID: <CAMzpN2iK0+okEKnX_EgfmdLSg9Gze_BVO4fEG3TBuzwD-yj8bA@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t
 to avoid split locks
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Javier Pello <devel@otheo.eu>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:00=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Dave Hansen <dave.hansen@intel.com> wrote:
>
> > On 4/2/24 10:23, Javier Pello wrote:
> > > On Mon, 1 Apr 2024 10:56:14 -0700 Dave Hansen wrote:
> > >> First of all, how is it that you're running a PAE kernel on new,
> > >> 64-bit hardware?  That's rather odd.
> > >
> > > I got this motherboard and cpu fairly recently to replace old
> > > hardware, and I just plugged my old hard disk and went along with
> > > it, because I did not feel like bootstrapping a 64-bit system.
> >
> > Fair enough.  I can totally understand wanting the convenience.  But
> > you're leaving _so_ much performance on the floor that split locks are
> > the least of your problems.
> >
> > >> The case that you're hitting is actually an on-stack pmd_t.  The
> > >> fun part is that it's not shared and doesn't even _need_ atomics.
> > >> I think it's just using pmd_populate() because it's convenient.
> > >
> > > I see. So just annotating the variable on the stack with
> > > __aligned(8) should do it? But the code is under mm/, so it should
> > > be arch-agnostic, right? What would the correct fix be, then? I take
> > > from your message that using atomics through pmd_populate() here is
> > > not needed, but what accessors should be used instead? I am not
> > > familiar at all with this part of the kernel.
> >
> > I don't think there's a better accessor.
> >
> > >> I'd honestly much rather just disable split lock support in 32-bit
> > >> builds than mess with this stuff.  You really shouldn't be running
> > >> 32-but kernels on this hardware.
> > >
> > > Why? Is it unsupported?
> >
> > Yes, it's effectively unsupported.  We're not adding new hardware
> > features to 32-bit.  The fact that split lock detection got enabled
> > was an accident.
>
> We do accept well-tested fixes and minor enablement patches though,
> within reason - but indeed this page table entry alignment quirk added
> for the sake of a split-lock debugging false positive doesn't seem to
> be worth it.

What would happen if you ran a 32-bit VM on such hardware?  If the
split lock detection on the guest were disabled, would the host get
the fault instead?

> > It's not a technical reason.  It's a practical one: I don't want to
> > spend time reviewing the fixes and dealing with the fallout and
> > regressions that the fixes might cause.
>
> Yeah, so it's an indirect technical argument: fixes *with tradeoffs*
> like this one have a future maintenance & robustness cost. Fixes
> without tradeoffs are fine of course.

What tradeoffs are there with this patch?  This would not affect the
page tables, since those are already properly aligned.  Forcing
alignment of stack variables is only a problem if it tickles a
compiler bug.

Brian Gerst

