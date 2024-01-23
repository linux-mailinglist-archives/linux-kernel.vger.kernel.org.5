Return-Path: <linux-kernel+bounces-34706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0ED838665
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E33C1C24604
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B321FD7;
	Tue, 23 Jan 2024 04:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XblnXFyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831431FA5;
	Tue, 23 Jan 2024 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985123; cv=none; b=c5Q3HvfLGClXmrSOlODQQmHgoUJczy0Fj8Gg5XnQYTZXFIu5I4b3Ej5phPNaMW3QzoJ8fw7ve03gShVLjJ/hNLBR48hdVZyE30TdekinNh4FIDd/f40jAn7IMzn38R62OAts3Ar5D3uA75pohCxRLptiI9WbEJ4BLVL9Dq5WuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985123; c=relaxed/simple;
	bh=iyV0NGmjSVcLNXBLniYpL0ErfhS2sfgENEZaUZo7d+Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZxeX5z1M66uOJ+uOZUl+NwFD8VlE/uf6XK9gPt85uAAMJPGPqwa+tNu/1+65znxCDphLuKedDe32mH0rJ7j3runo2vjXEbP03UI2j48nnNJ8YMvOUyb4SxVOK+cJxrU/j3oXhuHZkeohvIqqNCPdqI9K3pF4g6+I/MZk/2qq9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XblnXFyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC43C433F1;
	Tue, 23 Jan 2024 04:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705985123;
	bh=iyV0NGmjSVcLNXBLniYpL0ErfhS2sfgENEZaUZo7d+Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XblnXFyUhNJ3q3GAUJNNH9L7hrvU/MuaSwBaQ0AtNRF3288YlhVcSNqVdSWhMjZcd
	 myFhrDulhP1lbtP67REK8cV/5EPy5HyIImjz0m1rq3McgoaQG/8wwIXNTCGcrFcjUh
	 9EbW5exvEa6a4s8IWZ9O1e5yruKfapThTFiqeaUc5/+8A4qPR8o42Rha/L7Ga7MK54
	 bpWxdYW7auZ+WYr/FLeTLHXAjmA3CZjlUyH3Hzv5o3SdZQAfevO1WfiNlfZdbqgCzJ
	 IsNj7iQJiZmWriXTNfiHxuhYg1ehHgY7NzGiCdLmin1ZtrC3aqJgVw2B/bJXkBaqQP
	 h+6Aj+XWEuX3A==
Date: Mon, 22 Jan 2024 20:45:22 -0800
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Kees Cook <keescook@chromium.org>
CC: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 Hao Luo <haoluo@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_06/82=5D_overflow=3A_Reintroduce?= =?US-ASCII?Q?_signed_and_unsigned_overflow_sanitizers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CANiq72kWTu_1YcmSP=1sB6CmrdbQcksxFvLci6VC2u8_Bb-Exw@mail.gmail.com>
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-6-keescook@chromium.org> <CANiq72kWTu_1YcmSP=1sB6CmrdbQcksxFvLci6VC2u8_Bb-Exw@mail.gmail.com>
Message-ID: <14B4D24C-4CBA-401E-8111-CF74482CA956@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 22, 2024 6:24:14 PM PST, Miguel Ojeda <miguel=2Eojeda=2Esandoni=
s@gmail=2Ecom> wrote:
>On Tue, Jan 23, 2024 at 1:28=E2=80=AFAM Kees Cook <keescook@chromium=2Eor=
g> wrote:
>>
>> Because the kernel is built with -fno-strict-overflow, signed and point=
er
>> arithmetic is defined to always wrap around instead of "overflowing"
>> (which would either be elided due to being undefined behavior or would
>> wrap around, which led to very weird bugs in the kernel)=2E
>
>By elided I guess you also mean assumed to not happen and thus the
>usual chain-of-logic magic?

Yes=2E We removed this bad behavior by using -fno-strict-overflow, and we =
will want to keep it enabled=2E

>
>> So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
>> CONFIG_UBSAN_UNSIGNED_WRAP=2E Since the kernel has several places that
>> explicitly depend on wrap-around behavior (e=2Eg=2E counters, atomics, =
etc),
>> also introduce the __signed_wrap and __unsigned_wrap function attribute=
s
>> for annotating functions where wrapping is expected and should not
>> be caught=2E This will allow us to distinguish in the kernel between
>> intentional and unintentional cases of arithmetic wrap-around=2E
>
>Sounds good -- it seems to go in the direction of Rust, i=2Ee=2E to have =
a
>way to mark expected wrap-arounds so that we can start catching the
>unintended ones=2E

Yup! That's the plan=2E

>
>> +       depends on !COMPILE_TEST
>> +       depends on $(cc-option,-fsanitize=3Dsigned-integer-overflow)
>
>Maybe this line goes above the other, to be consistent with the
>unsigned case? (or the other way around)

Sure, I can move it around=2E

>
>> +       depends on !X86_32 # avoid excessive stack usage on x86-32/clan=
g
>> +       depends on !COMPILE_TEST
>> +       help
>> +         This option enables -fsanitize=3Dunsigned-integer-overflow wh=
ich checks
>> +         for wrap-around of any arithmetic operations with unsigned in=
tegers=2E This
>> +         currently causes x86 to fail to boot=2E
>
>Is it related to the excessive stack usage? In that case, users would
>not reach the point to see this description, right? If so, I guess it
>could be removed from the `help` and moved into the comment above or
>similar=2E

The stack usage is separate=2E (This may even be fixed in modern Clang; th=
is comes from the original version of this Kconfig=2E) The not booting part=
 is separate and has not been tracked down yet=2E

>
>> +static void test_ubsan_sub_overflow(void)
>> +{
>> +       volatile int val =3D INT_MIN;
>> +       volatile unsigned int uval =3D 0;
>> +       volatile int val2 =3D 2;
>
>In the other tests you use a constant instead of `val2`, I am curious
>if there is a reason for it?

I wondered the same -- they were this way when they were removed, so I jus=
t restored them as they were=2E :)

-Kees

--=20
Kees Cook

