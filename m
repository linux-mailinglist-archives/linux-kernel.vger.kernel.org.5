Return-Path: <linux-kernel+bounces-60049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410F84FF17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D641C22287
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A71A71B;
	Fri,  9 Feb 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ML9EVBEr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766863B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515161; cv=none; b=MSbKlRP2dAikfyfUmLz6bmI9Uj08OSxL+tU63FdsMQk14Pd84FEsvba7jnCN1PnJjPMWLzTGUKF1AKRzD8N2jiyOmChxuRgNZh8m+U71J0rMIGJUkH4K+rx+tEcHNCR0YZ8CrRzG7NcoRJazlccLWkF5feo2whBa4YarBD82Moo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515161; c=relaxed/simple;
	bh=IzWePX/ZJ0w9+rNw3CNHVwk2pomHe3LNDlLM3p4bBzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPVb3BO23BgQHyVTLL5sElWcnDL+yPjT8X5GmzA7LIK7Pc9AJ3NsvOZuDgDxqR0YvTPbgwRc7uP6O/Pp6ynJNUO3S9qXB+YrtYUwfH+6wm8riKDhimGxYAxKHnhf7HmsqixQHXXgpj+AINjumpitzXmXKbsVcVH62ImE/i2tGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ML9EVBEr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6438140E0192;
	Fri,  9 Feb 2024 21:45:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id atzOmG1WQk2S; Fri,  9 Feb 2024 21:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707515155; bh=Izb9VrjrQN99KBaeXAFpTV/QWIehiDTxAioQ8anV9cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ML9EVBErA6mKQf9uIhtPWZq8mAoHHeUEqS17KticVh37YtoWQRg9EMHrhgoYqJTBX
	 mmb1VnIIce23u2a//citXFxZAKHzMcIY0TFvkPU5aE7KFjHBAmkAIbBMZcl7M0j4ha
	 UUbehEkjLbYMg1Zw/+9sIDLKdsee5GW2nTJmJYxwX3+NmCT1tHN0D/mxej6FcQfgqK
	 LHFu24MtLf1Fv7V7smlJZojXS1DVzBUBf63/7qzyMc9sSH+lUBG2A/nHZ0+4GJizB8
	 CGzdm630UFqfaciFmNXiuPc/c3oEZ41xrN8h7PVTWiFTUL80FScWFu4rnZOZs/cy14
	 7CsTewghPhVRsMnLPPwwjUiNo+5GUhlUlGPen9YTUe3k3AvZEKRPEFlxlCiPeYIlbr
	 PMM89rop64NRcSIuvrMEWqJLguNuyAXef/EhHcvMznoR73XZr0F5lPO7XEV3yGWFCj
	 W39ZBJs6HccUfAPj8wNGriopO786UH9+cf+A1cNB30ERI47MorSUWhgV9GCjY6pDOU
	 y1OYbLkgjwtm4CsEeAGbfbQtRre1Asu8KHeG4oVN3CR1GtjNWZKiLPCvmJaLRCefvm
	 MqqeC6ehMT2LtNa3ZKLrWEJXCoEGgNaL82skmi6ff9cbTsg+GiPxrLXJiYh5qHPwQJ
	 D8ZkA5rG+gc8UvcHk2EnjPmQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BED8740E01A9;
	Fri,  9 Feb 2024 21:45:35 +0000 (UTC)
Date: Fri, 9 Feb 2024 22:45:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Dr. Greg" <greg@enjellic.com>,
	"Daniel P. Berrang??" <berrange@redhat.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <20240209214530.GHZcac-vOym8k3IuJm@fat_crate.local>
References: <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240206011247.GA29224@wind.enjellic.com>
 <ZcHoKUElwXGPzrWb@redhat.com>
 <20240206120445.GA1247@wind.enjellic.com>
 <20240206153529.GHZcJRwTdDkWXuopOQ@fat_crate.local>
 <20240208114444.GA23164@wind.enjellic.com>
 <20240209173102.GBZcZhVuFJZ8JOKTjG@fat_crate.local>
 <CAHmME9pEVNM6UVW+pKbTZEhsnrGvq5ERMOSC1ezdrCn96q36kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pEVNM6UVW+pKbTZEhsnrGvq5ERMOSC1ezdrCn96q36kA@mail.gmail.com>

On Fri, Feb 09, 2024 at 08:49:40PM +0100, Jason A. Donenfeld wrote:
> While you're here,

I was here the whole time, lurking in the shadows. :)

> Is it actually possible to make RDRAND usage "fair" between different
> security contexts? Or am I totally delusional and this is not how the
> hardware works or can ever work?

Yeah, I know exactly what you mean and I won't go into details for
obvious reasons. Two things:

* Starting with Zen3, provided properly configured hw RDRAND will never
fail. It is also fair when feeding the different contexts.

* My hardware engineers tell me that this is tough to do for RDSEED

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

