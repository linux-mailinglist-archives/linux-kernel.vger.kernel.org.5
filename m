Return-Path: <linux-kernel+bounces-43186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE7840D52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2911C23461
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B209715956B;
	Mon, 29 Jan 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZyG41W4t"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243B15AAD5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548083; cv=none; b=ERlcLpCAV9YcDHOJY1uZOnZipsGSSh1EJr04vya8oeq/9jyOXZf8dyu8WVzf/5MGf2u+xnU2jY5FtzVEHYvTA/BVfScwt+usFAn5PcwSO9m2AKp06zEnGAB8p+s/4h/n5jcXnQss+YkNETu5Uhw9IvElCD8pA7nxsKuqPG7y3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548083; c=relaxed/simple;
	bh=0LKrBNn/tdgYxQG5tXJjBvRgb8P6qEb0b3d3tmgiVL4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B09sCF6u9g+SnJzCm09nYmxOamh9uXjuNK77ovUd2xiINilQcit0Hilr47Hwy7tNjboLfN7tBaITwADedNbp4OS3DYJV4EkxJ6JARTivm/ziSlQjV1xuQ3Ebwosq4Qs7N2ZSimBl1MsxVT06AwFTZqpVJc1Zfx9y9NaUQdJbTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZyG41W4t reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40TH7GOG2246529
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jan 2024 09:07:17 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40TH7GOG2246529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706548038;
	bh=5MgQaeiM+/jYwFflXcmFfBk4nscCJV22lLY8J+jZeMM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZyG41W4tgHSLobFqHKGEupEcCs6PB4mbtcLDIHcTPTTwHOWrC6KexJsTVE/ff1ndU
	 5OhAYNEdR0F9PJ8N9QmcyiE/p4a/BsVtg9A3vkhIFlKrmuEPMfzdrOH+WrRUL5ZNAZ
	 XaSakUAOVmfiYPxnQA88cpcdKcvql9+I9IkyajGURzbsa2dFSlvldE7easV1Fr5a28
	 jPTOcYZ+w3RbBq3V9aYJ+pnfqIn+S8o50V4owFWZG/QUB9amNec8PPwVbpGZUlgk4u
	 eDWwBPjI0gtp3sv2rA0YBljxZi6YdWSs9/lDJYj2hjpzoTQZ/caRio78l6o8JJnVGY
	 oEyTNk0vyAYkg==
Date: Mon, 29 Jan 2024 09:07:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
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
In-Reply-To: <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com> <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com> <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7>
Message-ID: <B5BF8A36-DB2C-4CEA-8011-1708F84827D9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 29, 2024 8:41:49 AM PST, "Kirill A=2E Shutemov" <kirill=2Eshutem=
ov@linux=2Eintel=2Ecom> wrote:
>On Mon, Jan 29, 2024 at 08:30:11AM -0800, Dave Hansen wrote:
>> On 1/26/24 05:42, Kirill A=2E Shutemov wrote:
>> > 3=2E Panic after enough re-tries of RDRAND/RDSEED instructions fail=
=2E
>> >    Another DoS variant against the Guest=2E
>>=20
>> I think Sean was going down the same path, but I really dislike the ide=
a
>> of having TDX-specific (or CoCo-specific) policy here=2E
>>=20
>> How about we WARN_ON() RDRAND/RDSEED going bonkers?  The paranoid folks
>> can turn on panic_on_warn, if they haven't already=2E
>
>Sure, we can do it for kernel, but we have no control on what userspace
>does=2E
>
>Sensible userspace on RDRAND/RDSEED failure should fallback to kernel
>asking for random bytes, but who knows if it happens in practice
>everywhere=2E
>
>Do we care?
>

You can't fix what you can't touch=2E

