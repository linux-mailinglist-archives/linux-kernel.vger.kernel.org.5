Return-Path: <linux-kernel+bounces-55498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD31584BD6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D91C253D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76118175B4;
	Tue,  6 Feb 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XHMvD5Km"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC7175AE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245469; cv=none; b=tLEGWFIY4//4T9vcLsTWdsn5hf0fYLeS2SxWRGqIXY0EVjXqnu3oWnI2mNucp37N4BnsH+KRXNNVdOJqhTKxH3D99UuwmNZ/eHqaQF+/G3uRqFM7uz8Ew16B6hFDl2PmMS+Cp1HTMUMgcfrbfoQFGwwQdnmGsKKXCMQCrmAw3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245469; c=relaxed/simple;
	bh=9QXK7yv8qwXOa/XpUnLXjJTOiYjo+NdrQAQTzhXy5oo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GnnsX0lqnGuvRZG8YKuQSrRcT1BuhRiQ5x0fQAJ4dpkUiH9egwaEVcOeT2m6g/eabp9e2jIgY/GcJl2RsvlH+iPKIgTAP6YCYoR0pKZOX0PpfwqQ0z/H4cb5KTv1537Sr+V91BCcZysAMYzME3o/42U0cSxCU4dfOdernyc4ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XHMvD5Km reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 416Io1fA2330850
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 6 Feb 2024 10:50:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 416Io1fA2330850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1707245403;
	bh=M9cPKezRp+PquE4lEOvKR5VGh1H+MJcDJYB8rjUwjF0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XHMvD5KmB/JGmNoLhKhu9eFAdWBrJ2LJO7AsVoWADhSyBwK5RTlqRWN9q111AeVIW
	 huxXqFA6SzLDVNuK+HLltNMbFGlGc5RqSVPGGvNKnEms+xtg+pcB80qymSRVIejvvn
	 mD7fCO5Mg3SVf3schSJzZdtXNAn80Fr04ZAa1KCUTb7y2WrkrkHpxs5vHpX+55/lH6
	 pU8gCgDfksq38ojCWS+qFw9t4HMkTJMdSdz35j4SBH1NT84O5mELE5MF/vRKuq95sN
	 rMSM7FXTJkG6IrT7TClbE737Y4iN2YyuQN/y1gJW4XQ1P4u8xuKy8dfIcvuVmkc4tH
	 STVj9WMl6pjfw==
Date: Tue, 06 Feb 2024 10:49:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Dr. Greg" <greg@enjellic.com>,
        "Daniel P. Berrang??" <berrange@redhat.com>
CC: "Reshetova, Elena" <elena.reshetova@intel.com>,
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
User-Agent: K-9 Mail for Android
In-Reply-To: <20240206120445.GA1247@wind.enjellic.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com> <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <20240206011247.GA29224@wind.enjellic.com> <ZcHoKUElwXGPzrWb@redhat.com> <20240206120445.GA1247@wind.enjellic.com>
Message-ID: <00DF289B-1450-4272-9142-60643FAA852C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 6, 2024 4:04:45 AM PST, "Dr=2E Greg" <greg@enjellic=2Ecom> wrot=
e:
>On Tue, Feb 06, 2024 at 08:04:57AM +0000, Daniel P=2E Berrang?? wrote:
>
>Good morning to everyone=2E
>
>> On Mon, Feb 05, 2024 at 07:12:47PM -0600, Dr=2E Greg wrote:
>> >=20
>> > Actually, I now believe there is clear evidence that the problem is
>> > indeed Intel specific=2E  In light of our testing, it will be
>> > interesting to see what your 'AR' returns with respect to an official
>> > response from Intel engineering on this issue=2E
>> >=20
>> > One of the very bright young engineers collaborating on Quixote, who
>> > has been following this conversation, took it upon himself to do some
>> > very methodical engineering analysis on this issue=2E  I'm the messen=
ger
>> > but this is very much his work product=2E
>> >=20
>> > Executive summary is as follows:
>> >=20
>> > - No RDRAND depletion failures were observable with either the Intel
>> >   or AMD hardware that was load tested=2E
>> >=20
>> > - RDSEED depletion is an Intel specific issue, AMD's RDSEED
>> >   implementation could not be provoked into failure=2E
>
>> My colleague ran a multithread parallel stress test program on his
>> 16core/2HT AMD Ryzen (Zen4 uarch) and saw a 80% failure rate in
>> RDSEED=2E
>
>Interesting datapoint, thanks for forwarding it along, so the issue
>shows up on at least some AMD platforms as well=2E
>
>On the 18 core/socket Intel Skylake platform, the parallelized
>depletion test forces RDSEED success rates down to around 2%=2E  It
>would appear that your tests suggest that the AMD platform fairs
>better than the Intel platform=2E
>
>So this is turning into even more of a morass, given that RDSEED
>depletion on AMD may be a function of the micro-architecture the
>platform is based on=2E  The other variable is that our AMD test
>platform had a substantially higher core count per socket, one would
>assume that would result in higher depletion rates, if the operative
>theory of socket common RNG infrastructure is valid=2E
>
>Unless AMD engineering understands the problem and has taken some type
>of action on higher core count systems to address the issue=2E
>
>Of course, the other variable may be how the parallelized stress test
>is conducted=2E  If you would like to share your implementation source
>we could give it a twirl on the systems we have access to=2E
>
>The continuing operative question is whether or not any of this ever
>leads to an RDRAND failure=2E
>
>We've conducted some additional tests on the Intel platform where
>RDSEED depletion was driven low as possible, ~1-2% success rates,
>while RDRAND depletion tests were being run simultaneously=2E  No RDRAND
>failures have been noted=2E
>
>So the operative question remains, why worry about this if RDRAND is
>used as the randomness primitive=2E
>
>We haven't seen anything out of Intel yet on this, maybe AMD has a
>quantifying definition for 'astronomical' when it comes to RDRAND
>failures=2E
>
>The silence appears to be deafening out of the respective engineering
>camps=2E=2E=2E :-)
>
>> > - AMD's RDRAND/RDSEED implementation is significantly slower than
>> >   Intel's=2E
>
>> Yes, we also noticed the AMD impl is horribly slow compared to
>> Intel, had to cut test iterations x100=2E
>
>The operative question is the impact of 'slow', in the absence of
>artifical stress tests=2E
>
>It would seem that a major question is what are or were the
>engineering thought processes on the throughput of the hardware
>randomness instructions=2E
>
>Intel documents the following randomness throughput rates:
>
>RDSEED: 3 Gbit/second
>RDRAND: 6=2E4 Gbit/second
>
>If there is the possibility of over-harvesting randomness, why not
>design the implementations to be clamped at some per core value such
>as a megabit/second=2E  In the case of the documented RDSEED generation
>rates, that would allow the servicing of 3222 cores, if my math at
>0530 in the morning is correct=2E
>
>Would a core need more than 128 kilobytes of randomness, ie=2E one
>second of output, to effectively seed a random number generator?
>
>A cynical conclusion would suggest engineering acquiesing to marketing
>demands=2E=2E=2E :-)
>
>> With regards,
>> Daniel
>
>Have a good day=2E
>
>As always,
>Dr=2E Greg
>
>The Quixote Project - Flailing at the Travails of Cybersecurity
>              https://github=2Ecom/Quixote-Project

You do realize, right, that the "deafening silence" is due to the need for=
 research and discussions on our part, and presumably AMD's=2E

In addition, quite frankly, your rather abusive language isn't exactly enc=
ouraging people to speak publicly based on immediately available and theref=
ore inherently incomplete and/or dated information, meaning that we have ha=
d to take even what discussions we might have been able to have in public w=
ithout IP concerns behind the scenes=2E

Yes, we work for Intel=2E No, we don't know every detail about every Intel=
 chip ever created off the top of my head, nor do we necessarily know the e=
xact person that is *currently* in charge of the architecture of a particul=
ar unit, nor is it necessarily true that even *that* person knows all the e=
xact properties of the behavior of their unit when integrated into a partic=
ular SoC, as units are modular by design=2E

