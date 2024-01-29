Return-Path: <linux-kernel+bounces-43529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E121B84152F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78361C22EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D51586E8;
	Mon, 29 Jan 2024 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="PJnpcwBA"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EE266D4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564350; cv=none; b=UXb3bExE+bIp667StrIb6neUaIAxbdIgSBTu0DwGE4c3nAbnaueEWl5UHbk5MnnYd8FhKSzGkEOD47A1GJAacBeSDdu9U2ThvQsxUGgRcQuzvFggZ8e81yIe9wPIgl+MEpcA+6FMIR+6fv6PvK1uexyDEv1WxHvLbwiRtWc4bwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564350; c=relaxed/simple;
	bh=ogg20et2iq65Lw43aBq/H1Xbh8RROR9TNaO43aP826M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hFH0XFNIrgqxMGLlN3cSBRHGDJXUqFgzPNY8AK/5sSsN5R8FxBCNonWHNv00jvY9fWqavKzeplVGwkTCi71mjBBW+EhMkQnQv/e0jFvUnd7MyWeeqr0OkQUXJJg4wIVg5qwD8LtRUgbcVRK4oPQamJfN0hG+EYsaUR2pxzb04UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PJnpcwBA reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40TLcXBH2349627
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jan 2024 13:38:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40TLcXBH2349627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706564314;
	bh=QJYMHBD/bmYs+dj9muQqH/5bDeBVzbMM80yiJCupDLo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PJnpcwBAwwXR99Ezq39ER4qLZ5Vtvxu/KvPqloozL1dtoQS9EdjqHoIgRhz3Ufo5Y
	 A2iwaH0nqf4c/Xyo74+Mf2/M3SXY8aDgWJ2Qzt+fziz7LOefduWZtQYLBfB0ptL6mo
	 ckr2a8VJjZzvEwWU8Gc4Uw84hjm20nDEGAOL50+9ogkVMirjdX3Ij8Q/YUnny3At4p
	 ufXuKSWGuGF2+yG5skIVzYaV/Ou1ge8KH/jOWXriIPErvTiZKtXhaeidydoANTlRGM
	 WddMJrf7dK8ohQRvrc4sqvEO8SVZaM+QGv+IQPckz0vILDgnU0uk423MemU9aWJDyB
	 77dDkwuAM27LA==
Date: Mon, 29 Jan 2024 13:38:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Randomness on confidential computing platforms
User-Agent: K-9 Mail for Android
In-Reply-To: <CC681F94-469C-4225-A075-C5F9129E7D96@zytor.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com> <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com> <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7> <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com> <dlhffyn7cccn5d4uvubggkrmtyxl4jodj5ukffafpsxsnqini3@5rcbybumab4c> <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com> <CC681F94-469C-4225-A075-C5F9129E7D96@zytor.com>
Message-ID: <CA4D4182-8D65-4CEB-A173-68B92B04641B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 29, 2024 1:17:07 PM PST, "H=2E Peter Anvin" <hpa@zytor=2Ecom> wr=
ote:
>On January 29, 2024 1:04:23 PM PST, Dave Hansen <dave=2Ehansen@intel=2Eco=
m> wrote:
>>On 1/29/24 12:26, Kirill A=2E Shutemov wrote:
>>>>> Do we care?
>>>> I want to make sure I understand the scenario:
>>>>
>>>>  1=2E We're running in a guest under TDX (or SEV-SNP)
>>>>  2=2E The VMM (or somebody) is attacking the guest by eating all the
>>>>     hardware entropy and RDRAND is effectively busted
>>>>  3=2E Assuming kernel-based panic_on_warn and WARN_ON() rdrand_long()
>>>>     failure, that rdrand_long() never gets called=2E
>>> Never gets called during attack=2E It can be used before and after=2E
>>>=20
>>>>  4=2E Userspace is using RDRAND output in some critical place like ke=
y
>>>>     generation and is not checking it for failure, nor mixing it with
>>>>     entropy from any other source
>>>>  5=2E Userspace uses the failed RDRAND output to generate a key
>>>>  6=2E Someone exploits the horrible key
>>>>
>>>> Is that it?
>>> Yes=2E
>>
>>Is there something that fundamentally makes this a VMM vs=2E TDX guest
>>problem?  If a malicious VMM can exhaust RDRAND, why can't malicious
>>userspace do the same?
>>
>>Let's assume buggy userspace exists=2E  Is that userspace *uniquely*
>>exposed to a naughty VMM or is that VMM just added to the list of things
>>that can attack buggy userspace?
>
>The concern, I believe, is that a TDX guest is vulnerable as a *victim*, =
especially if the OS is being malicious=2E
>
>However, as you say a malicious user space including a conventional VM co=
uld try to use it to attack another=2E The only thing we can do in the kern=
el about that is to be resilient=2E
>
>Note that there is an option to the kernel to suspend boot until enough e=
ntropy has been gathered that predicting the output of the entropy pool in =
the kernel ought to be equivalent to breaking AES (in which case we have fa=
r worse problems=2E) To harden the VM case in general perhaps we should con=
sider RDRAND to have zero entropy credit when used as a fallback for RDSEED=
=2E
>

It is probably worth pointing out, too, that in reality the specs for RDRA=
ND/RDSEED are *extremely* sandbagged=2E The architect told me that it is ex=
tremely unlikely that we will *ever* see a failure due to exhaustion, even =
if it is executed continuously on all cores =E2=80=93 the randomness produc=
tion rate exceeds the bandwidth of the bus in uncore=2E

