Return-Path: <linux-kernel+bounces-43552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54571841569
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57161F24A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C3159591;
	Mon, 29 Jan 2024 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SY5M6LiB"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14E159571
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566400; cv=none; b=YRUJYXVCWHid/prbvW2Lu/FUuQwBFpdVk9Xl+3B0SLjmMdzBW+PMO4Mqi4LuHLz1gwyk3gD2uXQp6sj+7aBVjaa3Rrp1qkIivcuj4lcFn21e0bnMkkEotmYCyWLCCAqS3Gnw7qxwKAgxzQYgEWeUNbTzHngp0pMZIJR/DSz78jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566400; c=relaxed/simple;
	bh=nSLKu2t6GgeiI8HRpX8Lq8m3dUaKQaQRRTPAKivBNEQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tdngufnB/9DhZkCHiZo4UmC2QhGdaRbPXMztWi9p8RcsSEk/1gXgHYhAP8tTng131O6K2z8jMCSIKMnxfKbseld0ezTg+6cCpb/UOdpCr6lpV+Wmmdk2jVoVDUSQBR5mFnjAMSZtYDSuJWvN8/ltXy8PnZznoXpFMikCO4fppmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SY5M6LiB reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40TMCRZl2363387
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jan 2024 14:12:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40TMCRZl2363387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706566349;
	bh=gpJw5FwCNuj7MiUegNuTIOJWYystXX40HW9rUaj/KaE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SY5M6LiBwCI6+K0Oba8EFNosxeAkE2IuOtv8qiWosLobfCaKkpXkOcxtl50EPZxpw
	 kLYIrXRro6nnGI5DwC/MYmhqv7XWiQuH8O5qAhQwUhWFb1TLC8LTd/55mc/Ey/4lMA
	 92UuS8Yg6qQOACYo+Q7ZwHdjT90TOyiG1tPs3AouL/UdPe9vwa2whNM+/12nfXAdjf
	 ZP0qLQ/MoMHMTDu7r199LRG4DrM4oA3gnM6JyLTJgMAyn2ryANhsUvqOhQAG/kvVsH
	 fbYCuSXIFIFnkr1r+AL8sergSQs9400bPaqpqnus0XcQEz4uAh8U9QQlUNRg/7QDQ7
	 M5H24kFy50h+Q==
Date: Mon, 29 Jan 2024 14:12:26 -0800
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
Message-ID: <A9C23B76-490C-4DDA-A420-EA6F75E820EA@zytor.com>
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

So as far as I understand, the uncore bus (at least at the time RDRAND/RDS=
EED was designed) is a single-transaction bus; once a read transaction has =
been accepted by the bus the bus is locked until the reply is sent (like PC=
I=2E) As such, the RNG unit simply doesn't have to option of not returning =
a response without holding the whole uncore bus locked=2E However, I believ=
e that if another core is waiting for the bus, that request will be served =
before the other core can return for more=2E

If the RNG bit source is crippled for some reason to the point of being ne=
ar failure, it is certainly possible for a livelock to happen, but at least=
 as far as I understand the likelihood of that happening enough to cause 16=
 failures in a row is so close to a total failure that it might be as well =
treated as one=2E

*Any* security sensitive application that doesn't take total RNG failure i=
nto account is fundamentally broken=2E *Any* hardware random number generat=
or is inherently an analog device, and as such has a nonzero probability of=
 failure=2E It has an integrity monitor, but all it can do is say "no" and =
not credit entropy, thereby slowing down and eventually stopping the unit (=
even RDRAND has a minimum seeding frequency guarantee, unlike /dev/urandom=
=2E)


