Return-Path: <linux-kernel+bounces-58372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B900984E55D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4A28EC24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE54823B9;
	Thu,  8 Feb 2024 16:43:59 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136827CF3C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410638; cv=none; b=fWHboYYRGG4wloHrNDrAAPm63QTmyTGI6KWNAYg+Qeud5vb+9SfdQdrmUqWXJCWQuRnyAL6AXebZHwyhFmoUdZew0jPSGwT3YmL2HCw0MhUVQBHXFNC3TYDCgP5RqLOUHKw/w+GBrD5caXEcnsAHnxs3zCzu2mtgHjXokJjElKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410638; c=relaxed/simple;
	bh=YPEyRPac8syDFcX0RCqdZXxvzI7/w3eMNAcrUBxz3pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWkFgw8P9em920BOfQGhyTMRC+y3m3JlXhDbwaqRG5xpNg7hDTlvZGxKUEl6gJAxOYujaHSa5jTdBOHx4Oiz6uAzcRL3zWGr3wfbZU20wfqsmxxnhjXJgOnKfxfIWcHpLWBdcmvxFfWwwNSX/U1eWZNhyF1ImUTtZLuubgV9xqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 418GcrcP026278;
	Thu, 8 Feb 2024 10:38:53 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 418Gcq8h026277;
	Thu, 8 Feb 2024 10:38:52 -0600
Date: Thu, 8 Feb 2024 10:38:52 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Daniel P. Berrang??" <berrange@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <20240208163852.GA25571@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <20240206011247.GA29224@wind.enjellic.com> <ZcHoKUElwXGPzrWb@redhat.com> <20240206120445.GA1247@wind.enjellic.com> <00DF289B-1450-4272-9142-60643FAA852C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00DF289B-1450-4272-9142-60643FAA852C@zytor.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 08 Feb 2024 10:38:54 -0600 (CST)

On Tue, Feb 06, 2024 at 10:49:59AM -0800, H. Peter Anvin wrote:

Good morning HPA, I hope your week is going well, thanks for taking
the time to extend comments.

> On February 6, 2024 4:04:45 AM PST, "Dr. Greg" <greg@enjellic.com> wrote:
> >On Tue, Feb 06, 2024 at 08:04:57AM +0000, Daniel P. Berrang?? wrote:
> >
> >Good morning to everyone.
> >
> >> On Mon, Feb 05, 2024 at 07:12:47PM -0600, Dr. Greg wrote:
> >> > 
> >> > Actually, I now believe there is clear evidence that the problem is
> >> > indeed Intel specific.  In light of our testing, it will be
> >> > interesting to see what your 'AR' returns with respect to an official
> >> > response from Intel engineering on this issue.
> >> > 
> >> > One of the very bright young engineers collaborating on Quixote, who
> >> > has been following this conversation, took it upon himself to do some
> >> > very methodical engineering analysis on this issue.  I'm the messenger
> >> > but this is very much his work product.
> >> > 
> >> > Executive summary is as follows:
> >> > 
> >> > - No RDRAND depletion failures were observable with either the Intel
> >> >   or AMD hardware that was load tested.
> >> > 
> >> > - RDSEED depletion is an Intel specific issue, AMD's RDSEED
> >> >   implementation could not be provoked into failure.
> >
> >> My colleague ran a multithread parallel stress test program on his
> >> 16core/2HT AMD Ryzen (Zen4 uarch) and saw a 80% failure rate in
> >> RDSEED.
> >
> >Interesting datapoint, thanks for forwarding it along, so the issue
> >shows up on at least some AMD platforms as well.
> >
> >On the 18 core/socket Intel Skylake platform, the parallelized
> >depletion test forces RDSEED success rates down to around 2%.  It
> >would appear that your tests suggest that the AMD platform fairs
> >better than the Intel platform.
> >
> >So this is turning into even more of a morass, given that RDSEED
> >depletion on AMD may be a function of the micro-architecture the
> >platform is based on.  The other variable is that our AMD test
> >platform had a substantially higher core count per socket, one would
> >assume that would result in higher depletion rates, if the operative
> >theory of socket common RNG infrastructure is valid.
> >
> >Unless AMD engineering understands the problem and has taken some type
> >of action on higher core count systems to address the issue.
> >
> >Of course, the other variable may be how the parallelized stress test
> >is conducted.  If you would like to share your implementation source
> >we could give it a twirl on the systems we have access to.
> >
> >The continuing operative question is whether or not any of this ever
> >leads to an RDRAND failure.
> >
> >We've conducted some additional tests on the Intel platform where
> >RDSEED depletion was driven low as possible, ~1-2% success rates,
> >while RDRAND depletion tests were being run simultaneously.  No RDRAND
> >failures have been noted.
> >
> >So the operative question remains, why worry about this if RDRAND is
> >used as the randomness primitive.
> >
> >We haven't seen anything out of Intel yet on this, maybe AMD has a
> >quantifying definition for 'astronomical' when it comes to RDRAND
> >failures.
> >
> >The silence appears to be deafening out of the respective engineering
> >camps... :-)
> >
> >> > - AMD's RDRAND/RDSEED implementation is significantly slower than
> >> >   Intel's.
> >
> >> Yes, we also noticed the AMD impl is horribly slow compared to
> >> Intel, had to cut test iterations x100.
> >
> >The operative question is the impact of 'slow', in the absence of
> >artifical stress tests.
> >
> >It would seem that a major question is what are or were the
> >engineering thought processes on the throughput of the hardware
> >randomness instructions.
> >
> >Intel documents the following randomness throughput rates:
> >
> >RDSEED: 3 Gbit/second
> >RDRAND: 6.4 Gbit/second
> >
> >If there is the possibility of over-harvesting randomness, why not
> >design the implementations to be clamped at some per core value such
> >as a megabit/second.  In the case of the documented RDSEED generation
> >rates, that would allow the servicing of 3222 cores, if my math at
> >0530 in the morning is correct.
> >
> >Would a core need more than 128 kilobytes of randomness, ie. one
> >second of output, to effectively seed a random number generator?
> >
> >A cynical conclusion would suggest engineering acquiesing to marketing
> >demands... :-)
> >
> >> With regards,
> >> Daniel
> >
> >Have a good day.
> >
> >As always,
> >Dr. Greg
> >
> >The Quixote Project - Flailing at the Travails of Cybersecurity
> >              https://github.com/Quixote-Project

> You do realize, right, that the "deafening silence" is due to the
> need for research and discussions on our part, and presumably AMD's.

That would certainly be anticipated if not embraced, while those
discussions ensue, let me explain where we are coming from on this
issue.

I have a long time friend and valued personal consigliere who is a
tremendous attorney and legal scholar.  She has long advised me that
two basic concepts are instilled in law school; how to make sense out
of legal writing and don't ask any questions you don't know the answer
to.

CoCo is an engineering endeavor to defy the long held, and difficult
to deny, premise in information technology that if you don't have
physical security of a platform you don't have security.

We value ourselves as a good engineering team with considerable
interest and experience in all of this.  Any suggestion that there may
be some type of, even subtle, concern over the behavior of fundamental
hardware security primitives causes us to start asking questions and
testing things.

In this case the testing, quickly and easily, caused even more
questions to emerge.

> In addition, quite frankly, your rather abusive language isn't
> exactly encouraging people to speak publicly based on immediately
> available and therefore inherently incomplete and/or dated
> information, meaning that we have had to take even what discussions we
> might have been able to have in public without IP concerns behind the
> scenes.

Abusive?

I will freely don the moniker of being a practioner and purveyor of
rapier cynicism and wit, however, everyone who knows me beyond e-mail
would tell you that abusive would be the last definition they would
use in describing my intent and character.

I had the opportunity to sit next to Jim Gordon at dinner, who at the
time ran the Platform Security Division for Intel, at the SGX
Development Outreach Meeting that was held in Tel Aviv.  That was
after a pretty direct, but productive, technical exchange with the SGX
hardware engineers from Haifa.

I told him that I didn't mean to put the engineers on the spot but we
had been asked to voice our concerns as SGX infrastructure developers.
He told me the purpose of the meeting was for Intel to get tough and
demanding questions on issues of concern to developers so Intel could
deliver better and more relevant technology.

Just for the record and to close the abusive issue.  A review of this
thread will show that I never threw out accusations that hardware was
busted, backdoored nor did I advocate that the solution was to find
a better hardware vendor.

You fix engineering problems with engineering facts, hence our
interest in seeing how the question that got asked, perhaps
inadvertently, gets answered, so appropriate engineering changes can
be made in security dependent products.

> Yes, we work for Intel. No, we don't know every detail about every
> Intel chip ever created off the top of my head, nor do we
> necessarily know the exact person that is *currently* in charge of
> the architecture of a particular unit, nor is it necessarily true
> that even *that* person knows all the exact properties of the
> behavior of their unit when integrated into a particular SoC, as
> units are modular by design.

Interesting.

From the outside looking in, as engineers, this raises the obvious
question if the 'bus factor' for Bull Mountain has been exceeded.

Let me toss out, hopefully as a positive contribution, a 'Gedanken
Thought Dilemma' that the Intel team can take into their internal
deliberations.

One of the other products of this thread was the suggestion that a
CoCo hypervisor/hardware contribution could exert sufficient timing or
scheduling control so as to defeat the SDM's 10 try RDRAND
recommendation and induce a denial-of-service condition.

If that is indeed a possibility, given the long history of timing
based observation attacks on confidentiality, what guidance can be
offered to consumers of the relevant technologies that CoCo is indeed
a valid concept.  Particularly given the fact that the hardware that
consumers are trusting is physically in the hands of highly skilled
personnel, who have both the skills and phsyical control of the
hardware needed, to mount such an attack?

This is obviously a somewhat larger question than if RDRAND depletion
can be practically induced, so no need to rush the deliberations on
our behalf.

We will stand by in a quiet and decidedly non-abusive and
non-threatening posture, waiting to see what reflections that Borislav
might have on all of this... :-)

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

