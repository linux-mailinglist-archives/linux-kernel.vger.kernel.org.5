Return-Path: <linux-kernel+bounces-46569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E915844167
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813A01C220B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E111E80C17;
	Wed, 31 Jan 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="L6G1T/Sp"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D179DA0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710140; cv=none; b=E9VwOmzhpH7O8aUKouFHvnz8JzmQJ4thEAyg2EAoBqlk//od6CN2alfUifr2gJY6/KqAZceXetUlsj+od6CE0kbQCdJtQbMkWElWD9b2XY8C21eTU1KZODXpQCk6euh4JB3n2f+6b9D6QPx0gw8mTsZKUQTuog86x06Tc/hQCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710140; c=relaxed/simple;
	bh=hJTI6Oqt+tvrDrRCKdy4Fv4/v/exHoBoefP7wGq2GPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptil/yM9ux/AZluxnVidSVVOHLRNBI4iXkhYKo/AGiyjIBYfYXrPGYTeFHWxBW/u+Ih9T6oqymdZRpauGl53By0qAwoCWnrDR4Q/QkYCWa+iYXu7y4Iau+WUVXArhyxy5+Kw/VLMVbsLLfsR10FfrhAR8nnm6hL+lt2T9JsNcY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=L6G1T/Sp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40VE7u72016816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 09:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706710083; bh=3jBxU9JGxDt+piXZr4pBKK0kAm/pYnikufO2RLtXeAM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=L6G1T/SpkbuN99nevYXm2O9FspvsdZWzSBUmHtyziTUUOC8ZGozpeC4J+UE2j7blo
	 GKhQx+DpJEKT2lE2S9NiUt8tckt8Za5Mj7AHUP2Jn8z5xAaE8cV9ga3i7+hGqbfw2p
	 LUJ0ug7Fi3yFZkM3DcNsdivyLraGFNVLeKgLhLblAxffEux+yb2lZZyqLPKjQv46rq
	 MzyxXf0jneqVNrHe5HYEMIS+MsZfchuD4GE6iO8BDdJ4ye7wwuQvU6m155FAUsXax1
	 ut4S6IvT+kHVmrmSi3ejB9cJYwgE5bNXzhlRVE1kwBetkZ231gQMVkmxmZHJGVH7lL
	 4jgq6EMGBKmSg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C5F0D15C0667; Wed, 31 Jan 2024 09:07:56 -0500 (EST)
Date: Wed, 31 Jan 2024 09:07:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <20240131140756.GB2356784@mit.edu>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>

What about simply treating boot-time initialization of the /dev/random
state as special.  That is, on x86, if the hardware promises that
RDSEED or RDRAND is available, we use them to initialization our RNG
state at boot.  On bare metal, there can't be anyone else trying to
exhaust the on-chip RNG's entropy supply, so if RDSEED or RDRAND
aren't working available --- panic, since the hardware is clearly
busted.

On a guest OS, if confidential compute is enabled, and if RDSEED and
RDRAND don't work after N retries, and we know CC is enabled, panic,
since the kernel can't provide the promised security gaurantees, and
the CC developers and users are cordially invited to sharpen their
pitchforks and to send their tender regards to the Intel RNG
engineers.

For non-confidential compute guests, the question is what is the
appropriate reaction if another VM, possibly belonging to a different
user/customer, is carrying out a RDRAND DOS attack.  I'd argue that in
these cases, if the guest VM is using virtio-random, then the host's
/dev/random should be able to cover for cases of Intel RNG exhaustion,
and allowing other customer to be able to prevent other user's VM's
from being able to boot is the the greater evil, so we shouldn't treat
boot-time RDRAND/RDSEED failures as panic-worthy.

						- Ted

