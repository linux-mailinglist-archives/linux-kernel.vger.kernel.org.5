Return-Path: <linux-kernel+bounces-48743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD118846096
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EB5B23637
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04385264;
	Thu,  1 Feb 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lQuIo6xO"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EF84FBF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814196; cv=none; b=SW66uAIuZQf09Gl20NqiR7NdAIWVobJ856Y/kreTLRI9+NMr7lkCjS2pcaxenRNs+mDZ272q5f5k948bEB3Zw2w4XAl80ln1bdUH1oATYNdJxbFb8slDCPPSbmDQ7U91g/RLrSVL26FOHB2SyzNHhNCWH91B/ye5vqtIhBAf1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814196; c=relaxed/simple;
	bh=/k+B1mAjGbVHW0u2oSbT1r0tPCzVnEoOzFJ/awMko9E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pSYmJri4DJIkmVM43s0PfegqUc0k8r55TsNcnGQLTa3xE/R99fZBk9xzPiqioZDeVD1j+e4A7q2X9TSAlNTjVswa2Q9fCrqAvt12vb8ZEF1kRUykV4PnT0fU28ZaCDDPHNid97SymxbjPAM7NO+JErS+M1BTsbzM5I7GhT6EbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lQuIo6xO reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 411J2YGs4164724
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 1 Feb 2024 11:02:35 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 411J2YGs4164724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706814155;
	bh=kTXZyCcIqsNzCBXtIsoCaFjWy3OW00U35UzSwYcLSMo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lQuIo6xOi7oNx4tIHkF1PGZbqvLVDtNXhxS0pj5tZMDm2pJ+X+bmBJjabf5/ual1Y
	 WYSqI2jN7dJEyv0ajkY8IwhSEMiJ+r5412GDFUObznHTY9ZTwvpSbBQHOBnmHAAWO8
	 HiSJf3oFwOkbinYlQ/PqvC/jZfme4xNyeBjQYDGenDBaVJtCMX2+3HAPjmN5oQuRod
	 UJ8V8BCKAnUaQJdw3zUI7KpOMRyw8v9ZgcFvHI6mbARp/7/5QpreEMJUz3t3dxB80p
	 tQf9OE6h8n/dItJvhSYw0MyjmtIePa6aP+EYzLzGVUpghdQ/ywI9+l0xphDlFGpCh0
	 w+ZhbevD4A9eQ==
Date: Thu, 01 Feb 2024 11:02:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
In-Reply-To: <bed77821-1e36-4f92-86c5-e49628431c53@intel.com>
References: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com> <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com> <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com> <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com> <20240131171042.GA2371371@mit.edu> <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com> <20240201045710.GD2356784@mit.edu> <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com> <bed77821-1e36-4f92-86c5-e49628431c53@intel.com>
Message-ID: <52A2842D-AC23-4321-B06B-CDA082183862@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 1, 2024 10:46:06 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom=
> wrote:
>On 2/1/24 10:09, Jason A=2E Donenfeld wrote:
>> Question ii) Just how DoS-able is RDRAND? From host to guest, where
>> the host controls scheduling, that seems easier, but how much so, and
>> what's the granularity of these operations, and could retries still
>> help, or not at all? What about from guest to guest, where the
>> scheduling is out of control; in that case is there a value of N for
>> which N retries makes it actually impossible to DoS? What about from
>> userspace to kernelspace; good value of N?
>
>So far, in practice, I haven't seen a single failure of RDRAND=2E  It's
>been limited to RDSEED=2E  In a perfect world, I'd change the architectur=
e
>docs to say, "RDRAND only fails when the hardware breaks" and leave
>RDSEED defined to be the one that fails easily=2E
>
>Dealing with a fragile RDSEED seems like a much easier problem than
>dealing with a fragile RDRAND since RDSEED is used _much_ more sparingly
>in the kernel today=2E
>
>But I'm not sure if the hardware implementations fit into this perfect
>world I've conjured up=2E  We're going to wrangle up the folks at Intel
>who can hopefully tell me if I'm totally deluded=2E
>
>Has anyone seen RDRAND failures in practice?  Or just RDSEED?
>
>> Question iii) How likely is Intel to actually fix this in a
>> satisfactory way (see "specifying this is an interesting question" in
>> [1])? And if they would, what would the timeline even be?
>
>If the fix is pure documentation, it's on the order of months=2E  I'm
>holding out hope that some kind of anti-DoS claims like you mentioned:
>
>> Specifying this is an interesting question=2E What exactly might our
>> requirements be for a "non-broken" RDRAND? It seems like we have two
>> basic ones:
>>=20
>> - One VMX (or host) context can't DoS another one=2E
>> - Ring 3 can't DoS ring 0=2E
>
>are still possible on existing hardware, at least for RDRAND=2E

The real question is: what do we actually need?

During startup, we could afford a *lot* of looping to collect enough entro=
py before giving up=2E After that, even if RDSEED fails 99% of the time, it=
 will still produce far more entropy than a typical external randomness sou=
rce=2E We don't want to loop that long, obviously (*), but instead try peri=
odically and let the entropy accumulate=2E

(*) We *could* of course choose to aggressively loop in task context if th=
ere task would otherwise block on /dev/random=2E


