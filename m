Return-Path: <linux-kernel+bounces-55545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64F84BDF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747631C24126
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6C13FE7;
	Tue,  6 Feb 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uMLtbKsy"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A013FF2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246770; cv=none; b=tPaueWTjelzx88x9hOAzbIMjfQEAJi9HPz2xGHXJDmpd/orzBUQKKBxqyNJutp1MIT3zRXPOW87k4LpAzbt9dCvofwVrHFsUQSDH4s+iNi37z13YxRFE6gBkGoUncbBouiK3jsTw/3BXsmr9qrrm0pUF9iEW/SYE8NnKAY1HlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246770; c=relaxed/simple;
	bh=QIX8ThrxEN/63pZ8mRtmW7NV4oz3tc5pqgfER4WuGZQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=q+G3z7XKRa5PVpTXLhyTgGbdInK+d1CzIGWnCzQxUTIebEgrk0aqEFTX7kW78bu+oxcl4NlPhYrxjNYHDatkFWF9A85tWBHIdnI2imnxvbHpXoQhz/HYcJUxpNVE/NRlS23eXA7fV/efZ430C+o7XwI6+2FIUOqUlzTZHzF4vCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=uMLtbKsy reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 416JCCeF2336557
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 6 Feb 2024 11:12:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 416JCCeF2336557
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1707246734;
	bh=/E4fg2gasMcWdntZWwFj38PVFbI5P1u58WKFuSARsxc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uMLtbKsyKS5HG8bI9WVODWUgmtAbiisxY67Yk4/FwkgGt+guW5fPDfogSOkaWZPdV
	 mO8RJ/gvv+KsrSqcFDHrr6MNNzeEctYsgXWVau6wxabhW0wACq9ayptzrXc38hZ6rF
	 jCD5yek3PtSCuphTvbLGl3jTPS25dTCmfK7ZdjXIlVz/Fl/A/r5UC6J622JhfCUQk9
	 AJPUv/BEyjDW3875YK+cNaE2FA88o9nN6XnxdeMNgzfIF5UCZ2uAm/p0lH/LEi/Pfn
	 NlGwfIWTu6WtLSOn/gZNHfwePXvRvNyY7Rj5cJLIoSq/L1Ir296X1LuK7cpP2foBbN
	 CkfBas0vb80dQ==
Date: Tue, 06 Feb 2024 11:12:08 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Theodore Ts'o" <tytso@mit.edu>, James Bottomley <jejb@linux.ibm.com>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
User-Agent: K-9 Mail for Android
In-Reply-To: <20240203143547.GC36616@mit.edu>
References: <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com> <20240131171042.GA2371371@mit.edu> <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com> <20240201045710.GD2356784@mit.edu> <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com> <ad1a131a006bf98a506e767a01f5022358b3e291.camel@linux.ibm.com> <20240202160515.GC119530@mit.edu> <6ccd8c7998542f1ac68514700fb9e31049a3a3c7.camel@linux.ibm.com> <20240203143547.GC36616@mit.edu>
Message-ID: <60465F66-46A6-4A16-97AC-38EAE3FC67DA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 3, 2024 6:35:47 AM PST, Theodore Ts'o <tytso@mit=2Eedu> wrote:
>On Fri, Feb 02, 2024 at 10:28:01PM +0100, James Bottomley wrote:
>>=20
>> My big concern is older cpus where rdrand/rdseed don't produce useful
>> entropy=2E  Exhaustion attacks are going to be largely against VMs not
>> physical systems, so I worry about physical systems with older CPUs
>> that might have rdrand issues which then trip our Confidential
>> Computing checks=2E
>
>For (non-CC) VM's the answer is virtio-rng=2E  This solves the
>exhaustion problem, since if you can't trust the host, the VM's
>security is taost anyway (again, ignoring Confidential Compute)=2E
>
>> The signal for rdseed failing is fairly clear, so if the node has other
>> entropy sources, it should continue otherwise it should signal failure=
=2E
>> Figuring out how a confidential computing environment signals that
>> failure is TBD=2E
>
>That's a design decision, and I believe we've been converging on a
>panic during early boot=2E  Post boot, if we've successfully succeeded
>in initializing the guest kernel's RNG, we're secure so long as the
>cryptographic primitives haven't been defeated --- and if we have,
>such as if Quantuum Computing because practical, we've got bigger
>problems anyway=2E
>
>					- Ted

I also want to emphasize that there is a huge difference between boot (ini=
tialization) time and runtime=2E Runtime harvesting has always been opportu=
nistic in Linux, and so if RDSEED fails, try again later =E2=80=93 unless p=
erhaps a task is blocked on /dev/random in which case it might make sense t=
o aggressively loop on the blocked core instead of just putting the process=
 to sleep=2E

Initialization time is a different game entirely=2E Until we have accumula=
ted about 256-512 bits of seed data, even the best PRNG can't really be con=
sidered "completely random=2E" Thus a far more aggressive approach may be c=
alled for; furthermore, this is the time to look for total failure of the N=
RBG if after some number N attempts (where I believe N should be quite larg=
e, if we spend a full second in the very worst case that is probably better=
 than declaring failure and optionally panic the system) we have not acquir=
ed enough entropy then warn and optionally panic the system=2E

By setting the limit in terms of time rather than iterations, this avoids =
the awkward issue of "the interface to the RDSEED unit is too fast and so i=
t returns failure too often=2E" I don't think anyone would argue that the r=
ight thing would be to slow down the response time of RDSEED for that reaso=
n, even though it would most likely radically reduce the failure rate (beca=
use the NRBG would have more time to produce entropy between queries at the=
 maximum rate=2E)

Let's say, entirely hypothetically (as of right now I have absolutely *no*=
 insider information of the RNG unit roadmap), that we were to implement a =
prefetch buffer in the core, such that a single or a handful of RD* instruc=
tions could execute in a handful of cycles, with the core itself issuing th=
e request to the RNG unit when there is space in the queue=2E Such a prefet=
ch buffer could rather obviously get *very* quickly exhausted because the p=
oll rate could be dramatically increased, and having the core stall until t=
here is data may or may not be a good solution (advantage: the CPU can go t=
o a lower power state while waiting; disadvantage: opportunistic harvesting=
 would prefer a "poll and fail fast" variation, *especially* if the CPU is =
going to fulfill the request autonomously anyway=2E)

