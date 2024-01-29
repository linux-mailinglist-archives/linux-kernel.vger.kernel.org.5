Return-Path: <linux-kernel+bounces-43129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B3840BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341D428340E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8115AACD;
	Mon, 29 Jan 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lnbTimrl"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740A155A59
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546278; cv=none; b=rB0YGAokvAiJUb6NVGk7GY8gvoBAmdwaxA4POV7Ni/cvKof3+pNKHclJahfzdyAArZb7EQwPRotn/+qzMsIdg7iqchTrkHSeV2bHiNP29U3rvmO9Uk3nzUDBxh8dGZ7SR5hMZ1nQNIFVeArHMD1yEJOdQtPkqi9RYy6i98vFrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546278; c=relaxed/simple;
	bh=Vv0bghzWikF0hRqV3J+Zqtj67Ynj9bVIOzXQeSr1MR0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UemR8676G9kF3yCUDUIzw8SgM5bo7kk3FK1HsxJodFNGq2IWbaQltKQN9snbmMULe9GkyW3G36iG559AttP0/UWXji3zj+rrV0/qElPKJ894t/w9dpb6eKtjYpp9Y6Nj6fQNc8Pk/8qtobN8x1ZGqTGtbzYeqTpfrWi2gSy2C/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lnbTimrl reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40TGbI5I2234742
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jan 2024 08:37:18 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40TGbI5I2234742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706546240;
	bh=jnhiHc2vJcf7shopPtxezoFGdpgQ4x3ykCkhtXB1nVg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lnbTimrlMHWAIptNbJLJlsWk/ZzejlJYo7i0NhbqKX9pzTjQwc1sC18gGk04/K1Vx
	 ZQoNUJVCAsPQDcfuiVOMC+hHMvmcHNR4gV30x3Reh/GArk3M0GuqP9J7HFMXw8ROrW
	 WDJIE4tPLzANlznjDrUZzesM7aG8dCKOk0avC3eQJesc3AZesr8FOoh+aWpeuRcF1R
	 1uwPPJQbs0aMUuaROMcO1xBvlD4dWvMjvHjWxiUQFBzRZem/0i5tZSs2ZZbjC2jfzw
	 ksMDFTp1rRWnnYhS0c3AA3Q408uLhT9kulckKPMW65ZJZefIQtXt37V/3hxCR9c/fw
	 pHH7xjAennTcw==
Date: Mon, 29 Jan 2024 08:37:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Randomness on confidential computing platforms
User-Agent: K-9 Mail for Android
In-Reply-To: <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com> <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>
Message-ID: <82842879-FD34-4652-9714-AEE1F237EFF4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 29, 2024 8:30:11 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 1/26/24 05:42, Kirill A=2E Shutemov wrote:
>> 3=2E Panic after enough re-tries of RDRAND/RDSEED instructions fail=2E
>>    Another DoS variant against the Guest=2E
>
>I think Sean was going down the same path, but I really dislike the idea
>of having TDX-specific (or CoCo-specific) policy here=2E
>
>How about we WARN_ON() RDRAND/RDSEED going bonkers?  The paranoid folks
>can turn on panic_on_warn, if they haven't already=2E

That would be good anyway=2E

