Return-Path: <linux-kernel+bounces-54933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C125384B522
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35210B253A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F4C13398B;
	Tue,  6 Feb 2024 12:09:46 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E8153BDE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221386; cv=none; b=EjlsgAEbyLY459xJnvlCstUK9a2k6Iv5ZsJW3x2Q5slOshdtPh6qX7GgnPxBPN5Oo9FwpQiXvyh9x5QMbXwJ7UamL5CXDrUdGoyX7SPoN9dcrKZFmaJPvCHk2m4NadBmsXKSzlj0sZQ1Xeeto07ykPFeIAGf9huaa7Ewhb9puvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221386; c=relaxed/simple;
	bh=EGtKM5D1Vb04Le+B1pWopgp/oS3U/Hrc4JxPx+8xT5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt2vzvn56SxxcHnW/gR3oaPHth/KFtIwB6dUk9D7yD/qYBOcTSSUg9YZQtz0TxeDPdc7MCE7Fo/mM3I90RUhGh7MmqwXxKmPAIOuHkOiW68zBBa5Kmrk4McBJBSDgaOaWCliWc7VWJFIVeRxungvrN4RjT8Eo4NHY6Ta93Mls7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 416C4knk001762;
	Tue, 6 Feb 2024 06:04:46 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 416C4jTD001748;
	Tue, 6 Feb 2024 06:04:45 -0600
Date: Tue, 6 Feb 2024 06:04:45 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "Daniel P. Berrang??" <berrange@redhat.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20240206120445.GA1247@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com> <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <20240206011247.GA29224@wind.enjellic.com> <ZcHoKUElwXGPzrWb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcHoKUElwXGPzrWb@redhat.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 06 Feb 2024 06:04:46 -0600 (CST)

On Tue, Feb 06, 2024 at 08:04:57AM +0000, Daniel P. Berrang?? wrote:

Good morning to everyone.

> On Mon, Feb 05, 2024 at 07:12:47PM -0600, Dr. Greg wrote:
> > 
> > Actually, I now believe there is clear evidence that the problem is
> > indeed Intel specific.  In light of our testing, it will be
> > interesting to see what your 'AR' returns with respect to an official
> > response from Intel engineering on this issue.
> > 
> > One of the very bright young engineers collaborating on Quixote, who
> > has been following this conversation, took it upon himself to do some
> > very methodical engineering analysis on this issue.  I'm the messenger
> > but this is very much his work product.
> > 
> > Executive summary is as follows:
> > 
> > - No RDRAND depletion failures were observable with either the Intel
> >   or AMD hardware that was load tested.
> > 
> > - RDSEED depletion is an Intel specific issue, AMD's RDSEED
> >   implementation could not be provoked into failure.

> My colleague ran a multithread parallel stress test program on his
> 16core/2HT AMD Ryzen (Zen4 uarch) and saw a 80% failure rate in
> RDSEED.

Interesting datapoint, thanks for forwarding it along, so the issue
shows up on at least some AMD platforms as well.

On the 18 core/socket Intel Skylake platform, the parallelized
depletion test forces RDSEED success rates down to around 2%.  It
would appear that your tests suggest that the AMD platform fairs
better than the Intel platform.

So this is turning into even more of a morass, given that RDSEED
depletion on AMD may be a function of the micro-architecture the
platform is based on.  The other variable is that our AMD test
platform had a substantially higher core count per socket, one would
assume that would result in higher depletion rates, if the operative
theory of socket common RNG infrastructure is valid.

Unless AMD engineering understands the problem and has taken some type
of action on higher core count systems to address the issue.

Of course, the other variable may be how the parallelized stress test
is conducted.  If you would like to share your implementation source
we could give it a twirl on the systems we have access to.

The continuing operative question is whether or not any of this ever
leads to an RDRAND failure.

We've conducted some additional tests on the Intel platform where
RDSEED depletion was driven low as possible, ~1-2% success rates,
while RDRAND depletion tests were being run simultaneously.  No RDRAND
failures have been noted.

So the operative question remains, why worry about this if RDRAND is
used as the randomness primitive.

We haven't seen anything out of Intel yet on this, maybe AMD has a
quantifying definition for 'astronomical' when it comes to RDRAND
failures.

The silence appears to be deafening out of the respective engineering
camps... :-)

> > - AMD's RDRAND/RDSEED implementation is significantly slower than
> >   Intel's.

> Yes, we also noticed the AMD impl is horribly slow compared to
> Intel, had to cut test iterations x100.

The operative question is the impact of 'slow', in the absence of
artifical stress tests.

It would seem that a major question is what are or were the
engineering thought processes on the throughput of the hardware
randomness instructions.

Intel documents the following randomness throughput rates:

RDSEED: 3 Gbit/second
RDRAND: 6.4 Gbit/second

If there is the possibility of over-harvesting randomness, why not
design the implementations to be clamped at some per core value such
as a megabit/second.  In the case of the documented RDSEED generation
rates, that would allow the servicing of 3222 cores, if my math at
0530 in the morning is correct.

Would a core need more than 128 kilobytes of randomness, ie. one
second of output, to effectively seed a random number generator?

A cynical conclusion would suggest engineering acquiesing to marketing
demands... :-)

> With regards,
> Daniel

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

