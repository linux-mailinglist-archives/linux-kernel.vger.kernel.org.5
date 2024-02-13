Return-Path: <linux-kernel+bounces-64523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BF9853FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD7B2CDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4663100;
	Tue, 13 Feb 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RuXQ03U6"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826D862A12
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866090; cv=none; b=TfJ0on8lbhCW/F2jInr62BLz/P9eQyIDne+N1kYf6sZbJsQQ2xb8INF62ksqTnp71R/v2xf7UXwrWCxoseWYEROkb7ZC5/6RP9VsOBPbEKSCzF5uigsnO81rJsSzXtG9yTWQm5ityQfSuvxnTXgTHNaz0qQGRpGVrjhFuL5YWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866090; c=relaxed/simple;
	bh=tm9bh5WYq9qFOSmpNFY5tnSe6fXVetze1S53nUYpGLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj/0njfmUcPAVHhAVQOg4cT1t22accH6IAfOiel/t/iAwfwItc0ywZIDHDLOyR3mk4bIh4lj9FoaXEM5Z/9k/RA4aLocCyHN6ozUsWOCr23gKzu00f2HFvYl7sAfq5s3oIYMc8hOKt5EEqmJT3kcV1ZmRIANC7Wu4MOplkZNpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RuXQ03U6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-68.bstnma.fios.verizon.net [173.48.116.68])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41DNDfdn018753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707866026; bh=wwrGC1FNnOW190/1wKhOVWxjmtFKCbQRLRYMM3aJ8JY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=RuXQ03U6F0BbF3jEXwi+edV15YcD1YUV4rf+CpvWMs17CNDbwPTXIWAB5k4mfJh7Y
	 L3p31VGYjVY2XGFmfUVz3AWGue7leXoBkmzqrkt0PpIV20cXUXFabcuz6fO47gXmNn
	 AeHegxXbvNIyGUxlKKusqTYeU5xNrOZ/TQ3dMY+FzFFRgCMdPjHmjYsqcLH8yf1Dhc
	 sDl9/s2f+LTURc8xxgi8H3YG/C81J5g9TOJ72+FvvZfB1ydAUsDYhbCZ0PUZerbvnD
	 wvK0JtHhX4ljNcR+rKk1ya+HqIjciNDej+OLG2liLiy2a1gs5H8D6Oc7LFuLyjll2s
	 LTPMdfQET8J1g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 824A915C0336; Tue, 13 Feb 2024 18:13:41 -0500 (EST)
Date: Tue, 13 Feb 2024 18:13:41 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20240213231341.GB394352@mit.edu>
References: <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
 <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240212163236.GA444708@mit.edu>
 <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Mon, Feb 12, 2024 at 11:28:31PM -0800, Dan Williams wrote:
> Sure there is, that is what, for example, PCI TDISP (TEE Device
> Interface Security Protocol) is about. Set aside the difficulty of doing
> the PCI TDISP flow early in boot, and validating the device certficate
> and measurements based on golden values without talking to a remote
> verifier etc..., but if such a device has been accepted and its driver
> calls hwrng_register() it should be added as an entropy source.

How real is TDISP?  What hardware exists today and how much of this
support is ready to land in the kernel?  Looking at the news articles,
it appears to me like bleeding edge technology, and what an unkind
person might call "vaporware"?  Is that an unfair characterization?

There have plenty of things that have squirted out of standards
bodies, like for example, "objected base storage", which has turned
out to be a complete commercial failure and was never actually
deployed in any real numbers, other than sample hardare being provided
to academic researchers.  How can we be sure that PCI TDISP won't end
up going down that route?

In any case, if we are going to go down this path, we will need to
have some kind of policy engine hwrng_register() reject
non-authenticated hardware if Confidential Compute is enabled (and
possibly in other cases).

				- Ted

