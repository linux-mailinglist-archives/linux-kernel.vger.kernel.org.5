Return-Path: <linux-kernel+bounces-43513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21D841504
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DB62874E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FCB157E8F;
	Mon, 29 Jan 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hzl0pbQs"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C913157E7C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563091; cv=none; b=CN4QGb/BMRP3VP1pwY0sm5+3xoWak8Zzh1y2aOqoyoGNfJvv01yKtFOfXSQFTtCOyHfjf+lsfI228LEmCKwHwKTgyQQlccbCFHu0QW9BAk6lSkqC03wDtke4Pes5aqODqplvBpmWjSubw30ETdVSswGW1l/YgDHK9d7dn/sT++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563091; c=relaxed/simple;
	bh=iMnLWZpXGWZO6f778duq9Mp4OZb1fe9L6qPadvah6Sk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Al6JNT9kuIQCHVI419jCGWZT3FWAJhK4ILV9mFWpQArJg9DNs/CwjfXp+6dhax6BFahblB/ykdKnutilV9TXS+IJjPxgGILMz8jrH3XRP6yXH0vKaur2fvmWGy+m0uWdGLraqlnHD0/GR3LX/upVeyAn6wBAC6oP8x8kqvGM3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Hzl0pbQs reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40TLHAL32340808
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jan 2024 13:17:11 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40TLHAL32340808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706563032;
	bh=dMGw3Un7uxvzazwAB1e4UsYVGTCXNpV2yIiZzPYUZ88=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Hzl0pbQs2JzqaFXU86XAApSZQljy1HnasnQfsFh+D6k1BOmC/clVBPNDAqPIy24zp
	 9IpMMzLDZeCaMcoeyhTi10v4sruul+RIhe9PbMs6Ks8W/dbOgnxajY7jJ27zXeL33v
	 uTtfTI5DsnNwXpOeWOJm2ki4CkunI4MEF5nHN6mNngBIAB4X63zcF19/I53l/XtKMR
	 mETS7v4De+POA/WGxqx/AUC3bQ/LxdLuMIRwY6IUqVc2mkKjB7LifBfL65VuPL9D9E
	 sVhnxq4JsdOJPoaFiOmV9xodzB9TAz4JlusGgx8f2dfnu/lP7AY8GELznRfFDUWZXT
	 o4Zr+j95Nk+nQ==
Date: Mon, 29 Jan 2024 13:17:07 -0800
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
In-Reply-To: <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com> <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com> <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7> <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com> <dlhffyn7cccn5d4uvubggkrmtyxl4jodj5ukffafpsxsnqini3@5rcbybumab4c> <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com>
Message-ID: <CC681F94-469C-4225-A075-C5F9129E7D96@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 29, 2024 1:04:23 PM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 1/29/24 12:26, Kirill A=2E Shutemov wrote:
>>>> Do we care?
>>> I want to make sure I understand the scenario:
>>>
>>>  1=2E We're running in a guest under TDX (or SEV-SNP)
>>>  2=2E The VMM (or somebody) is attacking the guest by eating all the
>>>     hardware entropy and RDRAND is effectively busted
>>>  3=2E Assuming kernel-based panic_on_warn and WARN_ON() rdrand_long()
>>>     failure, that rdrand_long() never gets called=2E
>> Never gets called during attack=2E It can be used before and after=2E
>>=20
>>>  4=2E Userspace is using RDRAND output in some critical place like key
>>>     generation and is not checking it for failure, nor mixing it with
>>>     entropy from any other source
>>>  5=2E Userspace uses the failed RDRAND output to generate a key
>>>  6=2E Someone exploits the horrible key
>>>
>>> Is that it?
>> Yes=2E
>
>Is there something that fundamentally makes this a VMM vs=2E TDX guest
>problem?  If a malicious VMM can exhaust RDRAND, why can't malicious
>userspace do the same?
>
>Let's assume buggy userspace exists=2E  Is that userspace *uniquely*
>exposed to a naughty VMM or is that VMM just added to the list of things
>that can attack buggy userspace?

The concern, I believe, is that a TDX guest is vulnerable as a *victim*, e=
specially if the OS is being malicious=2E

However, as you say a malicious user space including a conventional VM cou=
ld try to use it to attack another=2E The only thing we can do in the kerne=
l about that is to be resilient=2E

Note that there is an option to the kernel to suspend boot until enough en=
tropy has been gathered that predicting the output of the entropy pool in t=
he kernel ought to be equivalent to breaking AES (in which case we have far=
 worse problems=2E) To harden the VM case in general perhaps we should cons=
ider RDRAND to have zero entropy credit when used as a fallback for RDSEED=
=2E


