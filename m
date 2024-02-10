Return-Path: <linux-kernel+bounces-60291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C18502B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CC81C23337
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835715E9C;
	Sat, 10 Feb 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYuse41w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4B63B3;
	Sat, 10 Feb 2024 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707546025; cv=none; b=YI4kEDaeNWZkc1LrVB/p1zknib4It8ThckoCQY3L1NXyvDABrSYIFiwDcADlO/h87StQ5S4XOJTO9QBVD0LQ0v6t5nrq6FFxIrKXYBnh8X7IXIW42st8IRqPda/saeVqMzbrMnBappVAc1OGxTo5aqhqxALi1uVgPzbUnqUgStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707546025; c=relaxed/simple;
	bh=1Ze5VEPfD5vhZYQmXIpz7v4I8v5CLbO0cbP1JVjlVA0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UraO47bpwTOS6Kc7qAvdLyXkIDF+4N3Aei5485mlcmuv8Zi5QkDHqSl1uOVLCzL2vEMxbckqfpK/FIA4D69fGlGV2bJ18mrlGfcMPs00BN77pPdWTCAOpLeyYAgRDb34rLxCcj92WRstT6eSi5Zbfqt/XHdUYZ8X7d8+VGq/Jn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYuse41w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D013AC433F1;
	Sat, 10 Feb 2024 06:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707546023;
	bh=1Ze5VEPfD5vhZYQmXIpz7v4I8v5CLbO0cbP1JVjlVA0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HYuse41w6uCewE/PnPkzXazcAz/wThGf7m58t9dGnuRqD5IQSZFVa/6/5P4IC5WKP
	 uJu84TY6zqt/spjV+HwipurymdhpvxxEQyvDyCwnSy1QrdCPijt16SVUYT94wOrHJ+
	 1YsFpEj6FnCul09I37BeSLq/oShjwS2XONlU+1oBLrRzwPnCdd5FiA9wHrkr6j1+xf
	 TbWaSFvDH5GhO9zbuuYo6yrlosdF4jwT2JJEzekHsIiLm3fSJ4SGl7CLZbwZJhtven
	 jvHNQJxurXTP90WREQ9DQbJ4+dSnZWDQizOZNtmQY0suTWReVo3IzJMSTEdMakfQNj
	 +j4aBPXwORtXA==
Date: Fri, 09 Feb 2024 22:20:22 -0800
From: Kees Cook <kees@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook <keescook@chromium.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
User-Agent: K-9 Mail for Android
In-Reply-To: <CAH5fLgikdGGdjEUxyMWjkfHbRmvtMavwHFDwRC+4GVt46qmHWw@mail.gmail.com>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com> <20240124-alice-mm-v1-1-d1abcec83c44@google.com> <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com> <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com> <2024020859-lusty-ladylike-29d4@gregkh> <CAH5fLgikdGGdjEUxyMWjkfHbRmvtMavwHFDwRC+4GVt46qmHWw@mail.gmail.com>
Message-ID: <9FD5FF49-6C8D-4073-9CE5-EA19C607FAD2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 8, 2024 7:41:52 AM PST, Alice Ryhl <aliceryhl@google=2Ecom> wr=
ote:
>On Thu, Feb 8, 2024 at 4:35=E2=80=AFPM Greg Kroah-Hartman
><gregkh@linuxfoundation=2Eorg> wrote:
>>
>> On Thu, Feb 08, 2024 at 01:53:20PM +0100, Alice Ryhl wrote:
>> > > Is some sort of `Debug` implementation useful?
>> >
>> > Leaking pointer addresses in logs is frowned upon in the kernel, so I
>> > don't think we should include that=2E
>>
>> s/frowned upon/forbidden/ :)
>
>:)
>
>> Along those lines, you all are tieing in the "I want to print a pointer=
,
>> so hash it properly before I do so" logic from rust like we have in c,
>> right?  Ideally you'd use the same logic if at all possible=2E
>>
>> If not, that probably needs to be done so that you don't accidentally
>> start leaking things=2E
>
>I don't know what the status of this is=2E For anything I've added, I've
>just made it entirely impossible to print addresses, hashed or not=2E

Thank you! That is certainly the preferred[1] approach=2E :)

-Kees

[1] https://www=2Ekernel=2Eorg/doc/html/next/process/deprecated=2Ehtml#p-f=
ormat-specifier

--=20
Kees Cook

