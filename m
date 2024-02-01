Return-Path: <linux-kernel+bounces-47994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D578455DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F653289D71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A5215B990;
	Thu,  1 Feb 2024 10:57:56 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC84D9EC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785076; cv=none; b=GxBXA/OVM2ZC3VZLRrpM+eg/6fst5D5zTutTp/lMS8nk71i6O34EOEQaLvmMfHTdIN5vszPPsm96p+mgICFkjuy8tXhdF9uz9+9geOdm8E6Xb4KDss2zngo2mPp7gZ2pT+9aA8IjoUXllaIS7UB+KuEUgiBfhg7CO2AVsSnVn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785076; c=relaxed/simple;
	bh=z+tD5pWFN5jz+qp55YaYahO9z6v+XGOpjnMoRHg7OqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi0oToWqoMF81scup59MS0VGWjbm19+476Okb77klhfWF4/kxie/FYfsiqyXYMVo+6XMLtilR6QVpMX1OY5tK/ByZ0t26R49kZ3uKvhhOGxaR1REwp/ONkgg8UtJOBZbuQaedg2S68+KqNyuNHNq9lV+awlDkbCz0R1jgeOPJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 411AqvaH018437;
	Thu, 1 Feb 2024 04:52:57 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 411AquTL018436;
	Thu, 1 Feb 2024 04:52:56 -0600
Date: Thu, 1 Feb 2024 04:52:56 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Daniel P. Berrang??" <berrange@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20240201105256.GB17612@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com> <20240131203531.GA12035@wind.enjellic.com> <DM8PR11MB5750FDC379F54F8591246DF0E7432@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750FDC379F54F8591246DF0E7432@DM8PR11MB5750.namprd11.prod.outlook.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 01 Feb 2024 04:52:57 -0600 (CST)

On Thu, Feb 01, 2024 at 07:26:15AM +0000, Reshetova, Elena wrote:

Good morning to everyone.

> > On Wed, Jan 31, 2024 at 02:06:13PM +0100, Jason A. Donenfeld wrote:
> > 
> > Hi again to everyone, beautiful day here in North Dakota.
> > 
> > > On Wed, Jan 31, 2024 at 9:17???AM Reshetova, Elena
> > > <elena.reshetova@intel.com> wrote:
> > > > This matches both my understanding (I do have cryptography background
> > > > and understanding how cryptographic RNGs work)
> > > > and official public docs that Intel published on this matter.
> > > > Given that the physical entropy source is limited anyhow, and by giving
> > > > enough pressure on the whole construction you should be able to
> > > > make RDRAND fail because if the intermediate AES-CBC MAC extractor/
> > > > conditioner is not getting its min entropy input rate, it wont
> > > > produce a proper seed for AES CTR DRBG.
> > > > Of course exact details/numbers can wary between different generations of
> > > > Intel DRNG implementation, and the platforms where it is running on,
> > > > so be careful to sticking to concrete numbers.
> > 
> > > Alright, so RDRAND is not reliable. The question for us now is: do
> > > we want RDRAND unreliability to translate to another form of
> > > unreliability elsewhere, e.g. DoS/infiniteloop/latency/WARN_ON()? Or
> > > would it be better to declare the hardware simply broken and ask
> > > Intel to fix it? (I don't know the answer to that question.)
> > 
> > I think it would demonstrate a lack of appropriate engineering
> > diligence on the part of our community to declare RDRAND 'busted' at
> > this point.
> > 
> > While it appeares to be trivially easy to force RDSEED into depletion,
> > there does not seem to be a suggestion, at least in the open
> > literature, that this directly or easily translates into stalling
> > output from RDRAND in any type of relevant adversarial fashion.
> > 
> > If this were the case, given what CVE's seem to be worth on a resume,
> > someone would have rented a cloud machine and come up with a POC
> > against RDRAND in a multi-tenant environment and then promptly put up
> > a web-site called 'Random Starve' or something equally ominous.
> > 
> > This is no doubt secondary to the 1022x amplication factor inherent in
> > the 'Bull Mountain' architecture.
> > 
> > I'm a bit surprised that no one from the Intel side of this
> > conversation didn't pitch this over the wall as soon as this
> > conversation came up, but I would suggest that everyone concerned
> > about this issue give the following a thorough read:
> > 
> > https://www.intel.com/content/www/us/en/developer/articles/guide/intel-digital-
> > random-number-generator-drng-software-implementation-guide.html
> > 
> > Relevant highlights:
> > 
> > - As I suggested in my earlier e-mail, random number generation is a
> >   socket based resource, hence an adversarial domain limited to only
> >   the cores on a common socket.
> > 
> > - There is a maximum randomness throughput rate of 800 MB/s over all
> >   cores sharing common random number infrastructure.  Single thread
> >   throughput rates of 70-200 MB/s are demonstratable.
> > 
> > - A failure of RDRAND over 10 re-tries is 'astronomically' small, with
> >   no definition of astronomical provided, one would assume really
> >   small, given they are using the word astronomical.

> As I said, I want to investigate this properly before stating
> anything.  In a CoCo VM we cannot guarantee that a victim guest is
> able to execute this 10 re-try loop (there is also a tightness
> requirement listed in official guide that is not further specified)
> without interruption since all guest scheduling is under the host
> control. Again, this is the angle that was not present before and I
> want to make sure we are protected against this case.

I suspect that all of this may be the source of interesting
discussions inside of Intel, see my closing question below.

If nothing else, we will wait with baited breath for a definition of
astronomical, if of course, the definition of that value is
unprivileged and you would be free to forward it along... :-)

> > > > That said, I have taken an AR to follow up internally on what can be done
> > > > to improve our situation with RDRAND/RDSEED.
> > 
> > I think I can save you some time Elena.
> > 
> > > Specifying this is an interesting question. What exactly might our
> > > requirements be for a "non-broken" RDRAND? It seems like we have two
> > > basic ones:
> > >
> > > - One VMX (or host) context can't DoS another one.
> > > - Ring 3 can't DoS ring 0.
> > >
> > > I don't know whether that'd be implemented with context-tied rate
> > > limiting or more state or what. But I think, short of just making
> > > RDRAND never fail, that's basically what's needed.
> > 
> > I think we probably have that, for all intents and purposes, given
> > that we embrace the following methodogy:
> > 
> > - Use RDRAND exclusively.
> > 
> > - Be willing to take 10 swings at the plate.
> > 
> > - Given the somewhat demanding requirements for TDX/COCO, fail and
> >   either deadlock or panic after 10 swings since that would seem to
> >   suggest the hardware is broken, ie. RMA time.

> Again, my worry here that a CoCo guest is not in control of its own
> scheduling and this might make an impact on the above statement,
> i.e. it might theoretical be possible to cause this without
> physically broken HW.

So all of this leaves open a very significant question that would seem
to be worthy of further enlightenment from inside the bowels of
Intel engineering.

Our discussion has now led us to a point where there appears to be a
legitimate concern that the hypervisor has such significant control
over a confidential VM that the integrity of a simple re-try loop is
an open question.

Let us posit for argument, that confidential computing resolves down
to the implementation of a trusted computing platform that in turn
resolves to a requirement for competent and robust cryptography for
initial and ongoing attestation, let alone confidentiality in the face
of possible side-channel and timing attacks.

I'm sure there would be a great deal of interest in any information
that can be provided that this scenario is possible, given the level
of control that is being suggested that a hypervisor would enjoy over
an ostensibly confidential and trusted guest.

> Best Regards,
> Elena.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

