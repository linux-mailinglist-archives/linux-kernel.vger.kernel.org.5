Return-Path: <linux-kernel+bounces-45085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFB842B88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885AE1F264FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD7155A4D;
	Tue, 30 Jan 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C31AAD4E"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485688612D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638593; cv=none; b=DJzv3KkOgbFzhLbIVP+3VDfSV+5j72Q7V1rQww3+jhuVOdF6txIyn2L+RduK68gTbk/N3RLnaNLgFn1moyAQPR9EqmUZcNhl3cTu4bKhE1OLy2iCTgABRO8ZKWqwc3XR9LNXFrPkagUtniK/Vg7CW5XwcloLE+/PCp9cJcdwnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638593; c=relaxed/simple;
	bh=BWz9kVK6FQQXS4Oex4gIWgI2L66Jwn/K/GmLw7QRAnw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cphskZBJTFrStwg4GTtV+BcljQ1YEmYMgu4sk/p4MIpw6a51OuF4VdoOVXyEl50JuvUxPkOGMAgHq9HydteyBink6ClNogxwHGZnFKemtnwSMOJxsDcF4tHx6V1wSKrC0tfwvJ6ErhmdA93UiNuuxZM1xewj6710uBnUlE1+/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=C31AAD4E reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.209.1])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40UIFiuJ2936932
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Jan 2024 10:15:46 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40UIFiuJ2936932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706638548;
	bh=9IuvDqCWA9K7ZVPtRnI6fsYZK2Jw9p0d3gEJ4ggS8YI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=C31AAD4EoQAiz5Ane2ovYzxIrT8tPkyWV3KgIJaA0ACqKrToJxWMqtOfzmRXRIBAo
	 skSTGfxG0QiJ8e8t4wwu3RyyziiE+LupJQKNIMPT6O+dBdwEbDsWS6xBDpnS4yB99X
	 xVhptuGSCKCCWqxwmkv/6wNzirsRh9ydyuoBrp7g8aov5sxC2iLd5G2/ev2ILCYWvW
	 TCznr22vtE0t/Puo95c/gEODoo/31ihKivNcHSSSpg8TFUw1Dj68owhfd26E5OOk/c
	 3wY7tOG2eAZQbaopAZK0FCUFvsxxvxZmkUu8oyRqx0Ke0sfn/+VSf2nPT2sdiC+N7d
	 bPDuRfXvlLa8Q==
Date: Tue, 30 Jan 2024 10:15:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
User-Agent: K-9 Mail for Android
In-Reply-To: <a076974c-e2c7-43c9-9858-71c913361cea@intel.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com> <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <a076974c-e2c7-43c9-9858-71c913361cea@intel.com>
Message-ID: <81359B1E-5293-4919-B319-59483C1EA12E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 30, 2024 9:58:09 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 1/30/24 09:49, Jason A=2E Donenfeld wrote:
>>> Anybody disagree?
>> Yes, I disagree=2E I made a trivial test that shows RDSEED breaks easil=
y
>> in a busy loop=2E So at the very least, your statement holds true only
>> for RDRAND=2E
>
>Well, darn=2E :)
>
>Any chance you could share some more information about the environment
>where you're seeing this?  It'd be good to reconcile what you're seeing
>with how the hardware is expected to behave=2E

What CPU is this and could you clarify exactly how you run your busy loop?

