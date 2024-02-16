Return-Path: <linux-kernel+bounces-69142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA88584FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C679BB21835
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE91350C2;
	Fri, 16 Feb 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="krim4vH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508F12F377
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107461; cv=none; b=ZTKCmHoHm72KQv07gBPZEimUvLuJmcp96TwBNIHli/fZOXxpCVAxGO+NX9hd1qdlHvaJ9wdc2mNftZg4vsFmx7ZgET0hxbFN6PPr2xWiAnZVEtQp3y2zOAOdUnu93MnbnIesKTBxwv2035uro0d1bE1BvSS7Dt0XJOgyrgfJcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107461; c=relaxed/simple;
	bh=BdEnLjURC2vLeF2UylpFIsRnIjYbTIb+a29A4oK+RJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc3NmTp4Bq+hsVOWpvQBgy9XfjXXzGcarnuad38VZQbglHrXdMq9mGPEYgTOY/H//KPCYggLP+oDHfbjhxSPUvuXPH9HihFNfzA7INaLTtGE1Pfw7Sta4OS+JV1ThCfrvAUmYIvMswJghexQ+Hkq+PIoLOBFxj0hvT8Yr5ZR+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=krim4vH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC2EC43394
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="krim4vH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708107456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdEnLjURC2vLeF2UylpFIsRnIjYbTIb+a29A4oK+RJ4=;
	b=krim4vH8NfJBX8BgCXL7rTZQ/o0DbrS71iXmQoFgjGZkbt1gdm6o58wwztJ/TR5ySJqWOl
	iWoxS0p0oJ3YqURNhKB2OgZNcoi8RIBhNytH98YfbCLxzNeoyFS0nHgzQo++5biUtvitS3
	jgDiuFMXBZDDpawvje72ScdbvQsPhAE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 599735ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Fri, 16 Feb 2024 18:17:35 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607d633381fso9198547b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:17:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaFi9J0ZuLSwZxQ1ma8Y+SnlUpR0Kx3mcyE54lMkxl89bgQNIsX1C6XONH3tv3XjuIcMfGxqJR00SIelPFx/12DxdLB8oBCmnWW5Fw
X-Gm-Message-State: AOJu0YzcvBFk2ElgxrLsCe/hUq6v2Gw6VPTVWXX1ZHkFRr5UVfoiemBe
	5zsdk0e3OTXBV/ekGShC5ba9njET0zXgBu/k8A15Q8oOdPoQWTnxzw2jLOzGIcAzKrfu5nQmlwR
	GTp/nqnYXht0zBhTbrVCCQBIAaiI=
X-Google-Smtp-Source: AGHT+IEFa1FKJOd/8CF4vCK3sfhnhLqK0gxFFvyTjQcv0moRJWaoUKMNv+iUar+wQQfrcMiBgk5Jz5FC84Op365GVmI=
X-Received: by 2002:a81:ac1d:0:b0:608:771:20c0 with SMTP id
 k29-20020a81ac1d000000b00608077120c0mr928994ywh.24.1708107454216; Fri, 16 Feb
 2024 10:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214195744.8332-1-Jason@zx2c4.com> <20240214195744.8332-3-Jason@zx2c4.com>
 <DM8PR11MB57501389AE5518CB26E037D7E74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zc4QMAnrMiiCwkmX@zx2c4.com> <DM8PR11MB57503009DDA05C9F0CD683E7E74C2@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB57503009DDA05C9F0CD683E7E74C2@DM8PR11MB5750.namprd11.prod.outlook.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 16 Feb 2024 19:17:23 +0100
X-Gmail-Original-Message-ID: <CAHmME9oj_LepJfMJHNxbTL+EBYHsnJUf2Q5WTwDotto4S5LrQg@mail.gmail.com>
Message-ID: <CAHmME9oj_LepJfMJHNxbTL+EBYHsnJUf2Q5WTwDotto4S5LrQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo systems
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elena,

On Fri, Feb 16, 2024 at 8:57=E2=80=AFAM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
> So, yes, coco_random_init() happens first, which actually now has a nice
> side-effect that on coco platforms we drop HW CPU output even earlier
> in the entropy pool (Yay!).
> Which at this point would be almost perfect, *if* we could also
> count this entropy drop and allow ChaCha seeding to benefit straight from
> this early drop of entropy.

I addressed this already in my last reply. I wouldn't get too hung up
on the entropy counting stuff. The RNG is going to get initialized
just fine anyway no matter what, and whether or not it's counted,
it'll still be used and available basically immediately anyway.

> How about changing this to use add_hwgenerator_randomness()?

That function is only for the hwrng API. It handles sleep semantics
and that's specific to that interface boundary. It is not for random
drivers and platforms to call directory.

> And adjust cc_random_init() to try rdseed first and only fallback to rdra=
nd
> if it fails?

I guess that's possible, but what even is the point? I don't think
that really more directly accomplishes the objective here anyway. The
whole idea is we want to ensure that RDRAND is at least working for 32
bytes and if not panic. That's *all* we care about. Later on the RNG
will eat rdseed opportunistically as it can; let it handle that as it
does, and leave this patch here to be simple and direct and accomplish
the one single solitary goal of panicking if it can't avoid the worst
case scenario.

Jason

