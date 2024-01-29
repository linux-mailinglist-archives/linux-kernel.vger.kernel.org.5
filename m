Return-Path: <linux-kernel+bounces-43632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCB88416EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F8AB21758
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C12524B4;
	Mon, 29 Jan 2024 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WYbVoSWU"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA52C6B0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571219; cv=none; b=t31SzzbnPf/Y5eZefV12Izic0SMRBdAbEdOyyypbMirnn8Ij0daBgmdBVdRU02dhZ99dJTXR/Pur9sUhQBVQrInWJ5ebM45jyj4Ostt6Imr2vgt5YZZDgSk08XPlZMJI43p2YeIuJ0mZfZTNjWDhYlLHUT13j2VspHFxnilYKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571219; c=relaxed/simple;
	bh=YjwfMXWZsf+XqE4Tw9Kf9JKK1SZ7QehrSXajKRuMlMU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k7iAG4e+t5Hg21cHncV4Hw/oIoiHO70mZ4KdOkGAn45ZVEYHS5AGwA8b3EOBqivMg9Rq7s1KBDuSxXWRheTfUO6rP6VkZPmm8eqs4BOCw2FNT+a3WQb7ss8AGY7DIY5YhRPreubjHFOlwWtnD2SLUyxpHimJLT9Z7ysBxIWHpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WYbVoSWU reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40TNWtEG2398380
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jan 2024 15:32:56 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40TNWtEG2398380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706571178;
	bh=dMdxJcUP8c3cDYLuvHfVw+2PnigP9QSwGBLu/phk4io=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WYbVoSWUCVa0XSn6inNrYE19r8IJncWYZS3Mw6nN1tkOJPN2bKLoBJxf1SxJhwaI1
	 nXfCwMs4T4+mLwifphUG1QlIHFjoSKuGWXpn4vBRxP+hirIDWxINMRnsnOVGtmVhYo
	 Yg9uoa1TfE7kmwVlrRao9kQED+bdrQslwpG6DGOhjGDHpvqr7gK7JIhZ/4mq/2wfdH
	 il0jEXj41XQ8pAPWoWbMai8neRcul9sp8AqCNrKBoPthDNG2DmmCyrwlJ40As4QZbq
	 yTr4q4IsvNSA1PniQsZ2e1swPk5Ju2ub9MCujLYT6Tb9g4d9PFAWwTH4GURRMvb9Ie
	 pT4RwWTJl17mA==
Date: Mon, 29 Jan 2024 15:32:52 -0800
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
In-Reply-To: <b3f48f9c-c1c0-47b5-b55a-d9cd63d86951@intel.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com> <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com> <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7> <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com> <dlhffyn7cccn5d4uvubggkrmtyxl4jodj5ukffafpsxsnqini3@5rcbybumab4c> <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com> <v6maadzwtke3z5ejp2mavsnm4mvmjbu7demvldzpobqeva74rx@r6y5fwxsyoep> <b3f48f9c-c1c0-47b5-b55a-d9cd63d86951@intel.com>
Message-ID: <5861735E-8DE0-42D4-B7CE-E69F129CA7C8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 29, 2024 2:18:50 PM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 1/29/24 13:33, Kirill A=2E Shutemov wrote:
>>> Let's assume buggy userspace exists=2E  Is that userspace *uniquely*
>>> exposed to a naughty VMM or is that VMM just added to the list of thin=
gs
>>> that can attack buggy userspace?
>> This is good question=2E
>>=20
>> VMM has control over when a VCPU gets scheduled and on what CPU which
>> gives it tighter control over the target workload=2E It can make a
>> difference if there's small window for an attack before RDRAND is
>> functional again=2E
>
>This is all a bit too theoretical for my taste=2E  I'm fine with doing
>some generic mitigation (WARN_ON_ONCE(hardware_is_exhausted)), but we're
>talking about a theoretical attack with theoretical buggy software when
>in a theoretically unreachable hardware state=2E
>
>Until it's clearly much more practical, we have much bigger problems to
>worry about=2E

Again, do we even have a problem with the "hold the boot until we have ent=
ropy"option?

