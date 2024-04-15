Return-Path: <linux-kernel+bounces-144482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA58A46DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D07DB20D66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A5134A5;
	Mon, 15 Apr 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Wfh3cBf0"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A881171C;
	Mon, 15 Apr 2024 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147603; cv=none; b=aVDQN3/hwD7pfBZq74lZHm/FsunK+tHIkQyIypd8E4P2Fr5K97U5deHSDl0WjJRuUdawBjjs8Q732qFL2byBhL813Pm/Yn9MXTKf29kj58cU9brzr/caDKAykmMR86f5WVxHE3OVxcYeZq/svT/ewINb3JL+jfuAG4oKFbTIYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147603; c=relaxed/simple;
	bh=3oU2p1In4W0koqh6Uc5YWekxPtYLC4K4W2NNnFMhURg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zija+UX4+NovIuO79+qsNwT9xPRsaBdQ6eKC7wDaU4YK8H/MeMaO4yorlv2ubpmzhM0/CLg4OSoGHaev5OU2qX2xy1gQ7H0fHFkH67ajNnju0FoG8MFPOObzw6YH1D2ChbrumWU4IHt2lv/Jyqa7wCySEStQJZA8NtV4BfcONGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Wfh3cBf0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713147597;
	bh=8o4K5dRyl8sIUjU0EgivmjJC3lGXyfUukYQCR3Ov8pA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Wfh3cBf0QS/1UiJCGd9wNTsg4Z3JgU/S53A7sXuE66QjWbiVD9T5UErj+qdU+566N
	 hjbiVLnV+ds0WJ+Ev+xRCLWWsYkNs/ydYleOUGiOgEvXor3j+0XD5ZTGMx7r9XyYx5
	 jn2svY0f1Sry8eWSJqE0BMCHAzNMPGqqW0t7XdRo/lDxhdZw7wJ9e8/OC/PSiEPyk7
	 59A2AycixIle915lKXR/ZEVvbbDPyQIwTiMKuZDpZGbvMmBz2pFKC82F8PzOQcpTbi
	 j7+dgyBZn3vKLSDfhQN2vQw0ZU/QKf2x+gGzusuyAGdNvKz8OxQs5aM4xz/lfB0l96
	 UWGlHWQT/t0iQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHrV23GDlz4wcr;
	Mon, 15 Apr 2024 12:19:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Adrian Hunter <adrian.hunter@intel.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, John Stultz <jstultz@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, "x86@kernel.org" <x86@kernel.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
In-Reply-To: <dd6653b2-3a88-4b95-af13-c6fda5b27b39@app.fastmail.com>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
 <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
 <a434248a-1e9f-4f4f-8f90-d36d8e979f53@csgroup.eu>
 <ff9d7032-a3b6-4ecd-ac26-d7d4a06a5c7f@csgroup.eu>
 <4d429a10-eb45-4262-8e74-69af810ef1ac@intel.com>
 <dd6653b2-3a88-4b95-af13-c6fda5b27b39@app.fastmail.com>
Date: Mon, 15 Apr 2024 12:19:50 +1000
Message-ID: <875xwjcqpl.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Arnd Bergmann" <arnd@arndb.de> writes:
> On Thu, Apr 11, 2024, at 11:27, Adrian Hunter wrote:
>> On 11/04/24 11:22, Christophe Leroy wrote:
>>> Le 11/04/2024 =C3=A0 10:12, Christophe Leroy a =C3=A9crit=C2=A0:
>>>>
>>>> Looking at the report, I think the correct fix should be to use=20
>>>> BUILD_BUG() instead of BUG()
>>>=20
>>> I confirm the error goes away with the following change to next-2024041=
1=20
>>> on powerpc tinyconfig with gcc 13.2
>>>=20
>>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>>> index 4e18db1819f8..3d5ac0cdd721 100644
>>> --- a/kernel/time/timekeeping.c
>>> +++ b/kernel/time/timekeeping.c
>>> @@ -282,7 +282,7 @@ static inline void timekeeping_check_update(struct=
=20
>>> timekeeper *tk, u64 offset)
>>>   }
>>>   static inline u64 timekeeping_debug_get_ns(const struct tk_read_base =
*tkr)
>>>   {
>>> -	BUG();
>>> +	BUILD_BUG();
>>>   }
>>>   #endif
>>>=20
>>
>> That is fragile because it depends on defined(__OPTIMIZE__),
>> so it should still be:
>
> If there is a function that is defined but that must never be
> called, I think we are doing something wrong.

It's a pretty inevitable result of using IS_ENABLED(), which the docs
encourage people to use.

In this case it could easily be turned into a build error by just making
it an extern rather than a static inline.

But I think Christophe's solution is actually better, because it's more
explicit, ie. this function should not be called and if it is that's a
build time error.

cheers

