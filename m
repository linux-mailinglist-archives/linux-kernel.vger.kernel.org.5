Return-Path: <linux-kernel+bounces-47094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8A5844908
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B601C21A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99482383AD;
	Wed, 31 Jan 2024 20:40:31 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41B20DE0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733631; cv=none; b=E+fDmyWJGfrlNdS1XjiqmVFJH4At+RzH+0dBzzrk/hGQLdTphkaUVQm+X+wTvxSiiJusfwi3z3mj7rnencrjUL6WCKK0hAVzUmJ/G1tQYJlnuU1hXa4g0YYEchp01wp/doIzLctwdw3U8dmR8jzNsQp/4juIPj5PNWAxTKctnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733631; c=relaxed/simple;
	bh=fLIPQCnNQ5E/r9b+KCaDi39a1lB6LxyGJhCI6rNLasw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dleUzlb4s57H9cx9xB/OwIlViQ2/S+96PGIYXrvpdG+LFNaIQfzcvRXyyj9/Bxk+Qz1Te1BeRGoDKgtggX4+EHkSm53Qq+jyFWrQXfx+F3u5O68yUq53WrEXdJ3qZDOWjuI8R2tfdS5j1m5wcYjGM+E3T4R+wftnb0DNX3Tbx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 40VKZWY1012224;
	Wed, 31 Jan 2024 14:35:32 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 40VKZWYw012223;
	Wed, 31 Jan 2024 14:35:32 -0600
Date: Wed, 31 Jan 2024 14:35:32 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20240131203531.GA12035@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com> <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 31 Jan 2024 14:35:33 -0600 (CST)

On Wed, Jan 31, 2024 at 02:06:13PM +0100, Jason A. Donenfeld wrote:

Hi again to everyone, beautiful day here in North Dakota.

> On Wed, Jan 31, 2024 at 9:17???AM Reshetova, Elena
> <elena.reshetova@intel.com> wrote:
> > This matches both my understanding (I do have cryptography background
> > and understanding how cryptographic RNGs work)
> > and official public docs that Intel published on this matter.
> > Given that the physical entropy source is limited anyhow, and by giving
> > enough pressure on the whole construction you should be able to
> > make RDRAND fail because if the intermediate AES-CBC MAC extractor/
> > conditioner is not getting its min entropy input rate, it wont
> > produce a proper seed for AES CTR DRBG.
> > Of course exact details/numbers can wary between different generations of
> > Intel DRNG implementation, and the platforms where it is running on,
> > so be careful to sticking to concrete numbers.

> Alright, so RDRAND is not reliable. The question for us now is: do
> we want RDRAND unreliability to translate to another form of
> unreliability elsewhere, e.g. DoS/infiniteloop/latency/WARN_ON()? Or
> would it be better to declare the hardware simply broken and ask
> Intel to fix it? (I don't know the answer to that question.)

I think it would demonstrate a lack of appropriate engineering
diligence on the part of our community to declare RDRAND 'busted' at
this point.

While it appeares to be trivially easy to force RDSEED into depletion,
there does not seem to be a suggestion, at least in the open
literature, that this directly or easily translates into stalling
output from RDRAND in any type of relevant adversarial fashion.

If this were the case, given what CVE's seem to be worth on a resume,
someone would have rented a cloud machine and come up with a POC
against RDRAND in a multi-tenant environment and then promptly put up
a web-site called 'Random Starve' or something equally ominous.

This is no doubt secondary to the 1022x amplication factor inherent in
the 'Bull Mountain' architecture.

I'm a bit surprised that no one from the Intel side of this
conversation didn't pitch this over the wall as soon as this
conversation came up, but I would suggest that everyone concerned
about this issue give the following a thorough read:

https://www.intel.com/content/www/us/en/developer/articles/guide/intel-digital-random-number-generator-drng-software-implementation-guide.html

Relevant highlights:

- As I suggested in my earlier e-mail, random number generation is a
  socket based resource, hence an adversarial domain limited to only
  the cores on a common socket.

- There is a maximum randomness throughput rate of 800 MB/s over all
  cores sharing common random number infrastructure.  Single thread
  throughput rates of 70-200 MB/s are demonstratable.

- A failure of RDRAND over 10 re-tries is 'astronomically' small, with
  no definition of astronomical provided, one would assume really
  small, given they are using the word astronomical.

> > That said, I have taken an AR to follow up internally on what can be done
> > to improve our situation with RDRAND/RDSEED.

I think I can save you some time Elena.

> Specifying this is an interesting question. What exactly might our
> requirements be for a "non-broken" RDRAND? It seems like we have two
> basic ones:
> 
> - One VMX (or host) context can't DoS another one.
> - Ring 3 can't DoS ring 0.
> 
> I don't know whether that'd be implemented with context-tied rate
> limiting or more state or what. But I think, short of just making
> RDRAND never fail, that's basically what's needed.

I think we probably have that, for all intents and purposes, given
that we embrace the following methodogy:

- Use RDRAND exclusively.

- Be willing to take 10 swings at the plate.

- Given the somewhat demanding requirements for TDX/COCO, fail and
  either deadlock or panic after 10 swings since that would seem to
  suggest the hardware is broken, ie. RMA time.

Either deadlock or panic would be appropriate.  The objective in the
COCO environment is to get the person who clicked on the 'Enable Azure
Confidential' checkbox, or its equivalent, on their cloud dashboard,
to call the HelpDesk and ask them why their confidential application
won't come up.

After the user confirms to the HelpDesk that their computer is plugged
in, the problem will get fixed.  Either the broken hardware will be
identified and idled out or the mighty sword of vengeance will be
summoned down on whoever has all of the other cores on the socket
pegged.

Final thoughts:

- RDSEED is probably a poor thing to be using.

- There may be a reasonable argument that RDSEED shouldn't have been
  exposed above ring 0, but that ship has sailed.  Brownie points
  moving forward for an RDsomething that is ring 0 and has guaranteed
  access to some amount of functionally reasonable entropy.

- Intel and AMD are already doing a lot of 'special' stuff with their
  COCO hardware in order to defy the long standing adage of: 'You
  can't have security without physical security'.  Access to per core thermal
  noise, as I suggested, is probably a big lift but clever engineers can
  probably cook up some type of fairness doctrine for randomness in
  TDX or SEV_SNP, given the particular importance of instruction based
  randomness in COCO.

- Perfection is the enemy of good.

> Jason

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

