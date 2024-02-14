Return-Path: <linux-kernel+bounces-65882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB9C85533D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024BE1F21E59
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3713B78C;
	Wed, 14 Feb 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gsNuB3Ux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557011E4B7;
	Wed, 14 Feb 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939169; cv=none; b=nMF6/sK4d7+9tFC+D3JdQoxtuhMUVg7PCSbn/JOMAgGGBkGpX8jTdi0TY/75LKjHZxPYg5KFrl0i4wT6K7v18vYhRLMErfZ8ZDvuTeFaTpnso13BiP1W0vd/TxuXOVs21SiUSYUAdOuW6S89ZyUlXkLYXip9cblb/DsCr2yKg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939169; c=relaxed/simple;
	bh=g7FzNbsA7kaLt5NE4kJFxAnSgJBqlSpYvd11O517SGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1t0NDDoo7kDHHqeSMK4fNLZ/epB9+ff5QvRbyuufXo1MfoZ1x2jtGSYPE8IKTV9aN9KvCNh5ztvtV6COfpFpOsDs54rle3OT7EvlKb0gGiwZsKmN+wYTSTpjaOgI0uQQ1dwKh8pgmtg+AAOuhCjg+NUyZt2IoIlUM8/n8W4Wyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gsNuB3Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D9C433F1;
	Wed, 14 Feb 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gsNuB3Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707939165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwgrX1+QxYG9gCbE66T01ZHvAMhNVdg0g1e0DyMk9OY=;
	b=gsNuB3Uxyj/QmmpzZFlyW+ETrhX7nkRGAS+QN7k2uqd2o8wxP+Jtn40lfWYkcmoPE8YNb5
	CIT7+Sw/xspMUNUN/ZZy11ej4EFHmFvFYIM6md2H5rhoQdPSFhzCBQ/TvNnjFiQAK657ZS
	2lqGzzII36M7lMZfBxqzk6T75+Q1XNE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d00ca391 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Feb 2024 19:32:44 +0000 (UTC)
Date: Wed, 14 Feb 2024 20:32:43 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <Zc0VW_NQGLWCSJwF@zx2c4.com>
References: <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zcz2r51Tbb44ywjl@zx2c4.com>
 <DM8PR11MB57503E654C8A0E9A41CB68AFE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB57503E654C8A0E9A41CB68AFE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>

Hi Elena,

On Wed, Feb 14, 2024 at 05:59:48PM +0000, Reshetova, Elena wrote:
> > 
> > In other words, is the following a reasonable patch?
> > 
> > diff --git a/arch/x86/include/asm/archrandom.h
> > b/arch/x86/include/asm/archrandom.h
> > index 02bae8e0758b..2d5bf5aa9774 100644
> > --- a/arch/x86/include/asm/archrandom.h
> > +++ b/arch/x86/include/asm/archrandom.h
> > @@ -13,22 +13,16 @@
> >  #include <asm/processor.h>
> >  #include <asm/cpufeature.h>
> > 
> > -#define RDRAND_RETRY_LOOPS	10
> > -
> >  /* Unconditional execution of RDRAND and RDSEED */
> > 
> >  static inline bool __must_check rdrand_long(unsigned long *v)
> >  {
> >  	bool ok;
> > -	unsigned int retry = RDRAND_RETRY_LOOPS;
> > -	do {
> > -		asm volatile("rdrand %[out]"
> > -			     CC_SET(c)
> > -			     : CC_OUT(c) (ok), [out] "=r" (*v));
> > -		if (ok)
> > -			return true;
> > -	} while (--retry);
> > -	return false;
> > +	asm volatile("rdrand %[out]"
> > +		     CC_SET(c)
> > +		     : CC_OUT(c) (ok), [out] "=r" (*v));
> > +	WARN_ON(!ok);
> > +	return ok;
> >  }
> 
> Do you intend this as a generic rdrand change or also a fix for CoCo
> case problem?

I was thinking generic, since in all cases, RDRAND failing points to a
hardware bug in the CPU ITSELF (!), which is solid grounds for a WARN().

> I personally don’t like WARN_ON from security
> pov, but I know I am in minority with this. 

I share the same opinion as you, that WARN_ON() is a little weak and we
should BUG_ON() or panic() or whatever, but I also know that this ship
has really sailed long ago, that in lots of ways Linus is also right
that BUG() is bad and shouldn't be used for much, and this just isn't a
hill to die on. And the "panic_on_warn" flag exists and "security guides"
sometimes say to turn this on, etc, so I think WARN_ON() remains the
practical compromise that won't get everyone's feathers ruffelled up.


By the way, there is still one question lingering in the back of my
mind, but I don't know if answering it would divulge confidential
implementation details.

You said that RDRAND is faster than the bus, so failures won't be
observable, while RDSEED is not because it requires collecting entropy
from the ether which is slow. That makes intuitive sense on a certain
dumb simplistic level: AES is just an algorithm so is fast, while
entropy collection is a more physical thing so is slow. But if you read
the implementation details, RDRAND is supposed to reseed after 511
calls. So what's to stop you from exhausting RDSEED in one place, while
also getting RDRAND to the end of its 511 calls, and *then* having your
victim make the subsequent RDRAND call, which tries to reseed (or is in
progress of doing so), finds that RDSEED is out of batteries, and
underflows? What's the magic detail that makes this scenario not
possible?

Jason

