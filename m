Return-Path: <linux-kernel+bounces-158837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE38B2589
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C71F247B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3622314B09F;
	Thu, 25 Apr 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="c+vZktst"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397C14AD26;
	Thu, 25 Apr 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060002; cv=none; b=DNt04mmvqjtZ92HNBkIUxX2S0Ug0IcR8z/GuC8w4mzrU6IS768BvICPeoyu0CUveuNpbWhVvCmbWxgkQnrAxaCJArCy6um3pTcPAiuA7zIHTv7EVoJSOYkB4D9OFWufFb4KPMPIV6DoBRpY+8X7VwE8Fs8YevS2bkLh3gKzu998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060002; c=relaxed/simple;
	bh=Wyk9bt4qzmsPvR7NHjsvjFtMkQK/718z5azMohImAFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaNUJ70kygufh6muGq6EL4Y4aB5w+98aXiEbJgPRkMm2p6ttdtXHKTnESW7uirnbpn0OTo85bKePlRvg13WdElMWfJQByvWHtw+VhnDPii/AKVoDxzNTuhLzVNBl58JyeqnAV6FSmqCpsEMLhKw7DYByl/91gGN+/QPC0+/TIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=c+vZktst; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714059734; x=1714318934;
	bh=Wyk9bt4qzmsPvR7NHjsvjFtMkQK/718z5azMohImAFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c+vZktstzqmumilwh4SmQsmw/94/34SJn1O2b/KVRNNeStAWCQdZkIrpRdbjHsHwv
	 5vzX+Q3MOcdFLGkA5zjOSjrAihARVkLEaNf/ugG9lvbNiIBDmm7/CVnwQGGLXGdR5v
	 fxqxjZVPSjOaMp2GlviQN5yg4n94c/XywjFe6jXI1tzV9AYxzfQdVPV9TUGBmbr0e4
	 BOZOCUrY1WXBXq6QDW4yru+c0X/Ul2TIN6DYc9RgyZGC23Dyv9h6CNX0j+od1OOtA2
	 lpbmqI3Jpa8+BDhPELNuhT1jIATFHcXQyRdetphKhCj2pLJa5nAFgJVgXTFw8Xy0yx
	 e96rVEXYBFKyw==
Date: Thu, 25 Apr 2024 15:42:06 +0000
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Asahi Lina <lina@asahilina.net>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Danilo Krummrich <dakr@redhat.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] WIP: rust: Add basic KMS bindings
Message-ID: <c28a17d4-ea8e-4d35-9c7a-3b796ef7409d@proton.me>
In-Reply-To: <9fd1fea40f5d053e371bd076d9cb095ba3d77d93.camel@redhat.com>
References: <20240322221305.1403600-1-lyude@redhat.com> <20240322221305.1403600-2-lyude@redhat.com> <0785452f-7714-4384-838b-879e0b224c3c@proton.me> <9fd1fea40f5d053e371bd076d9cb095ba3d77d93.camel@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1e089611015051b5d61a372ac5af4555d099dc5c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.04.24 03:47, Lyude Paul wrote:
> On Wed, 2024-03-27 at 20:50 +0000, Benno Lossin wrote:
>> Hi,
>>
>> I just took a quick look and commented on the things that stuck
>> out to me. Some general things:
>> - several `unsafe` blocks have missing SAFETY comments,
>> - missing documentation and examples.
>=20
> This is really early on - so I had wanted to post a WIP before I
> actually wrote up everything to make sure I'm going in the right
> direction (I'm certainly not planning on leaving things undocumented
> when this is actually ready for submission :).

No worries, I just wanted to point out everything that I found.

One thing that I missed was your "RFC WIP" in your cover letter. I think
that it's a good idea to put "RFC" onto every patch, that way people
without context immediately know that it is not yet ready.

--=20
Cheers,
Benno


