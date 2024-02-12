Return-Path: <linux-kernel+bounces-61989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75F8519AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4321F236A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E14597C;
	Mon, 12 Feb 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fVDCymGL"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5D3D566
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755611; cv=none; b=KLoXTOX0/hq9vhzrOcnnxxUBeTrr7dRl/vAeCBtoTX0BsQnwAo72hElI+F1Z1U2gvPp/aZ33daM+xgy/zBaRvIMlzbiPsrcpoBI43THLxdFIsoZrnfTkF3stRX1e6sA/G410xQrfuAAtlAffJurWOZ6fmxOMAPi6gs2SMrPv+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755611; c=relaxed/simple;
	bh=y0rQ7md8dSpziIPwq351580LwTvSO5cMAtMGhD2sD4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+xb/ON1eqV7XRHzdp0CRiX9MiyIRaD+hDoL9fGtj72XKNUioUjRB35wiAKfv1QfC21pf9jPf8+u44oZx8phEDYAv9I5hHOeYmbsGiAzWXiBYg/fYWyxLZ6tdbrCvj0dLGSfrOWWaxICpAurOiQNambLhUa3q5s+VHTuvm+s0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fVDCymGL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-68.bstnma.fios.verizon.net [173.48.116.68])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41CGWaFt017659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707755561; bh=dQeklz7XleQ5cWK9tnOkGna6cm/Ji39W7G3AvRTDy+0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fVDCymGL76+YwEh2v7DrscPA0mjbKOyrxO+8OGo8720Uh6qpG0+FptkkJpErxIjyn
	 Tn5RtmfOwKe7Syq6ViHb+qspjyXAs205iKkzHMuknxsLRyqum9TeBkC+L0LnLm+Zx0
	 u6BpKwUp7xWfJr88EdcKc2I5jZmapwhEyaJ+GDYD2BEknlveGK4LRZb40EqZSvf30r
	 rmIcE0anqTRcMy0n5kml8jBH4JMCqtduNnKMqhmq1O3lT4pU0NBmB7tsI5RaYfOpVC
	 L68FGPizpap9TJ09qTbaO1YgsH7F0j+zmOtqrtZBhl7YT9q+aodYiaLbpzjAMNQhtw
	 tQVB0X3ep/7Vw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BEA7915C0336; Mon, 12 Feb 2024 11:32:36 -0500 (EST)
Date: Mon, 12 Feb 2024 11:32:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <20240212163236.GA444708@mit.edu>
References: <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
 <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>

On Mon, Feb 12, 2024 at 08:25:33AM +0000, Reshetova, Elena wrote:
> What if we instead of doing some special treatment on rdrand/seed, we
> try to fix the underneath problem of Linux RNG not supporting CoCo threat
> model. Linux RNG has almost set in stone definition of what sources contribute
> entropy and what don’t (with some additional flexibility with flags like trust_cpu).
> This works well for the current fixed threat model, but doesn’t work for
> CoCo because some sources are suddenly not trusted anymore to contribute
> entropy. However, some are still trusted and that is not just rdrand/rdseed,
> but we would also trust add_hwgenerator_randomness (given that we use
> TEE IO device here or have a way to get this input securely). So, even in
> theoretical scenario that both rdrand/rdseed is broken (let's say HW failure),
> a Linux RNG can actually boot securely in the guest if we have enough
> entropy from add_hwgenerator_randomness.

So the problem with this is that there is now way we can authenticate
the hardware RNG.  For example, the hypervisor could claim that there
is a ChaosKey USB key attached, and at the moment, unlike all other
hardware random number generators, the Linux kernel is configured to
blindly trust the ChaosKey because it was designed by Keith Packard
and Bdale Garbee, and "It Must Be Good".  But the only way that we
know that it is a ChaosKey is by its USB major and minor id numbers
--- and a malicious hypervisor could fake up such a device.

And of course, that's not unique to the hypervisor --- someone could
create a hardware USB key that claimed to be a ChaosKey, but which
generated a fixed sequence, say 3,1,4,1,5,9,2,6,... and it would pass
most RNG quality checkers, since it's obviously not a repeated
sequence of digits, so the mandated FIPS required check would give it
a thumbs up.  And it doesn't have to be a faked ChaosKey device; a
hypervisor could claim that there is a virtual TPM with its hardware
random number generator, but it's also gimmicked to always give the
same fixed sequence, and there's no way the guest OS could know
otherwise.

Hence, for the unique requirements of Confidential Compute, I'm afraid
it's RDRAND/RSEED or bust....

						- Ted

