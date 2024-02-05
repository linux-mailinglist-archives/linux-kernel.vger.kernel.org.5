Return-Path: <linux-kernel+bounces-54079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E584AA6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0567F1F2560D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43048793;
	Mon,  5 Feb 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSqSdG/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908914CB46;
	Mon,  5 Feb 2024 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175302; cv=none; b=UA7sov1aJtXRMdgP/I4M9JTepK621mB1JQXbE9GThqJh3h2Xy29reQF4kAtZqASb/i4QIUIouc22y8tWr1Q0CSOFa9vyTInJ/KgV988Dg6X003AOQBuV6AdVoWYuZc2WKE1X+ewWPjjyl6pNWLXXX5CHenG4T1UUKXcObopEjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175302; c=relaxed/simple;
	bh=keU4XeIPQYtLjYA+XUF5R/i+XtY804wbrg0XFEEawuQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rfMRvE+j1ghCXVAxT4kCzjW+E9eKl9cLmM262NzmsqGLNxQ4qZ3TZhHD+LyZpUOVgSBLAd+BAI81QpEG0hqrnDfnJS4SdiwrbaTuv0vKBUwRO249g/ju6VxLjo64TVt3ht+fM9TopIhjh+3NokSDG6MAba4LYH/y6w/1kGLlzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSqSdG/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B5FC433F1;
	Mon,  5 Feb 2024 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707175302;
	bh=keU4XeIPQYtLjYA+XUF5R/i+XtY804wbrg0XFEEawuQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BSqSdG/+IjNeLZT/yobOpOKgLLYBqZkW+p0i3Y5hBJsOcLSVJ0QWyTzrLMR5fZHRF
	 HQnRjSwC5YSnwrtdURFazT9j8y1X/eDb0y0jSbqhAkFtY4XlWFDo9ZcWaLEdmfq2j3
	 0H+I2+moWyzUZgaXyU257N+Q8WQVRfiFxTqB0hknNxKRfdEjdBP4Tp1kx99jSWOCFB
	 1uZs5QZV10stLq/q6vJ2YEYsGlSwhmgUj7nmFjIIdW79YLeThoeRhhR4CN1dvK3Mm+
	 GA6KHvugi8hOO2wUyCOVn6uiQzJ1clzzNHH8jKVrCliFqPTq8hKXxY6LHKbwZSkHcn
	 dNAdq6liJ+uBQ==
Date: Mon, 05 Feb 2024 23:21:41 +0000
From: Kees Cook <kees@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, Kees Cook <keescook@chromium.org>
CC: linux-hardening@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Mark Rutland <mark.rutland@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/3=5D_overflow=3A_Introduce?= =?US-ASCII?Q?_add=5Fwrap=28=29=2C_sub=5Fwr?= =?US-ASCII?Q?ap=28=29=2C_and_mul=5Fwrap=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240205231712.GC2220@sol.localdomain>
References: <20240205090854.make.507-kees@kernel.org> <20240205091233.1357377-2-keescook@chromium.org> <20240205202145.GB2220@sol.localdomain> <202402051443.A813E4D@keescook> <20240205231712.GC2220@sol.localdomain>
Message-ID: <51025C22-0FEF-4047-BC36-EA7ED7A3BD62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 5, 2024 11:17:12 PM GMT, Eric Biggers <ebiggers@kernel=2Eorg> =
wrote:
>On Mon, Feb 05, 2024 at 02:44:14PM -0800, Kees Cook wrote:
>> On Mon, Feb 05, 2024 at 12:21:45PM -0800, Eric Biggers wrote:
>> > On Mon, Feb 05, 2024 at 01:12:30AM -0800, Kees Cook wrote:
>> > > Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wra=
p(), and mul_wrap()
>> >=20
>> > Maybe these should be called wrapping_add, wrapping_sub, and wrapping=
_mul?
>> > Those names are more grammatically correct, and Rust chose those name=
s too=2E
>>=20
>> Sure, that works for me=2E What bout the inc_wrap() and dec_wrap() name=
s?
>> I assume wrapping_inc() and wrapping_dec() ?
>>=20
>
>Yes, though I'm not sure those should exist at all=2E  Maybe a +=3D b sho=
uld just
>become a =3D wrapping_add(a, b), instead of wrapping_inc(a, b)?
>wrapping_inc(a, b) isn't as self-explanatory=2E  Likewise for wrapping_de=
c=2E

It was to avoid repeating type information, as it would go from:

var_a +=3D var_b;

to:

var_a =3D wrapping_add(typeof(var_a), var_a, var_b);

Which repeats "var_a" 3 times=2E :|


--=20
Kees Cook

