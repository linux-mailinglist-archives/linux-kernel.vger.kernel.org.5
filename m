Return-Path: <linux-kernel+bounces-57991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9A84E004
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A08283FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E571B54;
	Thu,  8 Feb 2024 11:49:45 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F16EB54
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392985; cv=none; b=lMYpSmv3HVItDj8ZKLsyn90bNYJb+WsOro5T7A+RXCcOEkdSvEfT/UC123gkPf7cxgscO8VGgSs3I91BvcQ9QSueC3ZuQZn6FVhanXaQAdQ4ksycTib4CiT2KueJVvyWsB9iz+v9uKq7GITVa3CF2OEB6UES2sSv/x74XEltp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392985; c=relaxed/simple;
	bh=W8hh8SVXTKvD7eEwi7WV4j5y4uSnRC+F/4neJBDMh5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf3Dons3usBZ1kKwoUrnE78bxUfZzzgDkOrdiPLBARFTrJQ6yULqSOQ+qUKHBw2+xh6VZlnCLiX114aLGisnFRoL4HxUsH1NyI7050xgPhNIGwREqA2pFC8qHuP8SsUSjF1oWu7PzFIkrX1dzopjrLbdxSBD/TYZPplEpPY3pOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 418BijxE023873;
	Thu, 8 Feb 2024 05:44:45 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 418BiiQW023872;
	Thu, 8 Feb 2024 05:44:44 -0600
Date: Thu, 8 Feb 2024 05:44:44 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Daniel P. Berrang??" <berrange@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <20240208114444.GA23164@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <20240206011247.GA29224@wind.enjellic.com> <ZcHoKUElwXGPzrWb@redhat.com> <20240206120445.GA1247@wind.enjellic.com> <20240206153529.GHZcJRwTdDkWXuopOQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206153529.GHZcJRwTdDkWXuopOQ@fat_crate.local>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 08 Feb 2024 05:44:45 -0600 (CST)

On Tue, Feb 06, 2024 at 04:35:29PM +0100, Borislav Petkov wrote:

Good morning, or perhaps afternoon, thanks for taking the time to
reply.

> On Tue, Feb 06, 2024 at 06:04:45AM -0600, Dr. Greg wrote:
> > The silence appears to be deafening out of the respective engineering
> > camps... :-)

> I usually wait for those threads to "relax" themselves first. :)

Indeed, my standard practice is to wait 24 hours before replying to
any public e-mail, hence the delay in my response.

> So, what do you wanna know?

I guess a useful starting point would be if AMD would like to offer
any type of quantification for 'astronomically small' when it comes to
the probability of failure over 10 RDRAND attempts... :-)

Secondly, given our test findings and those of RedHat, would it be
safe to assume that EPYC has engineering that prevents RDSEED failures
that Ryzen does not?

Given HPA's response in this thread, I do appreciate that all of this
may be shrouded in trade secrets and other issues.  With an
acknowledgement to that fact, let me see if I can extend the
discussion in a generic manner that may prove useful to the community
without being 'abusive'.

Both AMD and Intel designs start with a hardware based entropy source.
Intel samples thermal/quantum junction noise, AMD samples execution
jitter over a bank of inverter based oscillators.  An assumption of
constant clocked sampling implies a maximum randomness bandwidth
limit.

None of this implies that randomness is a finite resource, it will
always become available, with the caveat that a core may have to stand
in line, cup in hand, waiting for a dollop.

So this leaves the fundamental question of what does an RDRAND or
RDSEED failure return actually imply?

Silicon is a expensive resource, which would imply a queue depth
limitation for access to the socket common RNG infastructure.  If the
queue is full when an instruction issues, it would be a logical
response to signal an instruction failure quickly and let software try
again.

An alternate theory would be a requirement for constant instruction
time completion.  In that case a 'buffer' of cycles would be included
in the RNG instruction cycle allocation count.  If the instruction
would need to 'sleep', waiting for randomness, beyond this cycle
buffer, a failure would be returned.

Absent broken hardware, astronomical then becomes the probability of a
core being unlucky enough to run into these or alternate
implementation scenarios 10 times in a row.  Particularly given the
recommendation to sleep between attempts, which implies getting
scheduled onto different cores for the attempts.

Any enlightenment along these lines would seem to be useful in
facilitating an understanding of the issues at hand.

Given the time and engineering invested in the engineering behind both
TDX and SEV-SNP, it would seem unlikely that really smart engineers at
both Intel and AMD didn't anticipate this issue and its proper
resolution for CoCo environments.

> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

All the best from the Upper Midwest.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

