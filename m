Return-Path: <linux-kernel+bounces-59734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B2E84FB0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709D4B21EB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0A07CF37;
	Fri,  9 Feb 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e6JLmdhx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAA1E486
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499889; cv=none; b=C0JwO74e9ob5X5W+tMojgUAYYHQAYnv8sndq6jZIrIuWYVqSoDXkLu7pgPSBj+M0FWINaPzh46ZsSEhQW/ckIURho31I4leXd3s2kdcPuTX3R35NRfdObw6jur3Smvid0e5i5gGIBUVeu+9N4FzxMa1tm1L8SWbHNOsvKyaFQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499889; c=relaxed/simple;
	bh=ueF/3l/pdEkS8nmlN1GCOrqczipbSy+MacJ/+GVMuHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKWpqdfQiZkQ1mMILhKi/+0tHjdxJBPE1IbBHy5/t5zZcYdmuYvTOPM4FbCG+WKmSmAtRSBbAWntmXtQTop28g/OngSbLalMAygMCa6iowNABH07eE1MhZpohmWD5mkH6NJn+umkfhPj9MT4Svit/MHXb8klfRAH0tdh+YgOXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e6JLmdhx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5AF5B40E00B2;
	Fri,  9 Feb 2024 17:31:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DjG77o1yKKfM; Fri,  9 Feb 2024 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707499882; bh=QJ8IvXe5L7kQUA05kg6s4Kuht0GQjKo92ZVIchIlagU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6JLmdhxkDsBxZfc0bpyjqv1otCTSJtzz7kRKCl/QqUcQK9B7lyn12IvY2J0ibb4j
	 fdiaL8iPnN0nkBu1ImUi/KuedEG5kutYQutKlYK5icev6GoVn+gTGhvyLCx97lBA2p
	 DlYH1aF5ifJOwtOsk2NEF6xj/M8yLSPjuZvpQDBx6SzoSRgakGzbCXsSUW7x5d9afG
	 ATiNBtCuLbM6AXRXuoaEMaQvcZoLP5GAqHwiCJ9oQLNl41aUloVR2ySHrY4sHkGMID
	 vnsCL8vAc/STm9fbP8UtfWSiWoPighc4mfP1z7F9T90jiyEb8AegXhX1UHdieUNUTT
	 2/sun38XtEgq3u+PTVAi469WFKFluvOg92ziZylkgrIjqKEXtg6EBC3bPMDQuoq5YK
	 AWIwDG9zNn0jwnGf8xf6fhPl1LICBaFIWCU4HM/y2EDwGFnBb9R/ipziFkEd2aa4ta
	 SqZ8omV22A+fhgipCGPzvwVkMwZ5bxEVLusdhKp9GktPiZGnK9KLnKRPqav0UA3tNV
	 j/Nx6uJo13HpZT3TLbXgpfvS6GiBb8SvBqPZJpp4Lb9Ns3Rx095TwMBSpQ8ZhTSuv8
	 SK1PtiEqQ4RbT4L5Tp56ub52qYxRATRxzIeDSLEh+fR1UoxtXFbphiOdeeDVRB/gQu
	 ooiyBVxd+sOCMtbYn20KCN58=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 331EF40E0192;
	Fri,  9 Feb 2024 17:31:03 +0000 (UTC)
Date: Fri, 9 Feb 2024 18:31:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Dr. Greg" <greg@enjellic.com>
Cc: "Daniel P. Berrang??" <berrange@redhat.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20240209173102.GBZcZhVuFJZ8JOKTjG@fat_crate.local>
References: <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240206011247.GA29224@wind.enjellic.com>
 <ZcHoKUElwXGPzrWb@redhat.com>
 <20240206120445.GA1247@wind.enjellic.com>
 <20240206153529.GHZcJRwTdDkWXuopOQ@fat_crate.local>
 <20240208114444.GA23164@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208114444.GA23164@wind.enjellic.com>

On Thu, Feb 08, 2024 at 05:44:44AM -0600, Dr. Greg wrote:
> I guess a useful starting point would be if AMD would like to offer
> any type of quantification for 'astronomically small' when it comes to
> the probability of failure over 10 RDRAND attempts... :-)

Right, let's establish the common ground first: please have a look at
this, albeit a bit outdated whitepaper:

https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/white-papers/amd-random-number-generator.pdf

in case you haven't seen it yet.

Now, considering that this is a finite resource, you can imagine that
there can be scenarios where that source can be depleted.

And newer Zen generations perform significantly better. So much so that
on Zen3 and later 10 retries should never observe a failure unless it
is bad hardware. Also, I agree with hpa's note that any and all retries
should be time based.

> Secondly, given our test findings and those of RedHat, would it be
> safe to assume that EPYC has engineering that prevents RDSEED failures
> that Ryzen does not?

Well, roughly speaking, client is a less beefier and less performant
version of server. You can extrapolate that to the topic at hand.

But at least on AMD, any potential DoSing of RDRAND on client doesn't
matter for CoCo because client doesn't enable SEV*.

> Both AMD and Intel designs start with a hardware based entropy source.
> Intel samples thermal/quantum junction noise, AMD samples execution
> jitter over a bank of inverter based oscillators.

See above paper for the AMD side.

> An assumption of constant clocked sampling implies a maximum
> randomness bandwidth limit.

You said it.

> None of this implies that randomness is a finite resource

Huh? This contradicts with what you just said in the above sentence.

Or maybe I'm reading this wrong...

> So this leaves the fundamental question of what does an RDRAND or
> RDSEED failure return actually imply?

Simple: if no random data is ready at the time the insn executes, it
says "invalid". Because the generator is a finite resource as you said
above, if the software tries to pull random data faster than it can
generate, this is the main case for CF=0.

> Silicon is a expensive resource, which would imply a queue depth
> limitation for access to the socket common RNG infastructure.  If the
> queue is full when an instruction issues, it would be a logical
> response to signal an instruction failure quickly and let software try
> again.

That's actually in the APM documenting RDRAND:

"If the returned value is invalid, software must execute the instruction
again."

> Given the time and engineering invested in the engineering behind both
> TDX and SEV-SNP, it would seem unlikely that really smart engineers at
> both Intel and AMD didn't anticipate this issue and its proper
> resolution for CoCo environments.

You can probably imagine that no one can do a fully secure system in one
single attempt but rather needs to do an iterative process.

And I don't know how much you've followed those technologies but they
*are* the perfect example for such an iterative improvement process.

I hope this answers at least some of your questions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

