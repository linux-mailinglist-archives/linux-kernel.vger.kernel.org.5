Return-Path: <linux-kernel+bounces-125711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F58892AED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48A828337B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E25364AA;
	Sat, 30 Mar 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DNsvOk2y"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C42F50;
	Sat, 30 Mar 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799226; cv=none; b=n/rIOVhgJLGCOU+uKl8GR5zTC7jtmzO0yLgV9QP1dX23rgCVEU3GGDugSJt7KSjBF/ORzxrG1cXhzHu7iDglTlCXbk9OA/LGqgPyt/mk9E9XyEJgbz7ntBaS9TC/ub9VPI3QtFglDfAQwfQkxYb0xc5aeDSQn53Eca8XUPBuaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799226; c=relaxed/simple;
	bh=y/B/agylf7uKuHNUXIfChqUGT1PsxhcFxHiHH2DMQ6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYXXByTxrtb735jBIlGQ2TnNevtxVOu/v1F+DQfTjOqYK5L2T9mgr2MJebA2N+sC+7s8RUfzuiA0GK09idDtkwGxvWPiXO2JOFMOWVeihmRYM5mUx/WOxPdBDLQV7Ynbol3VKD5lDhpOPKfnK4JiBtVWTtem8YlN1UzN5RbrRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DNsvOk2y; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711799215; x=1712058415;
	bh=rpsvE8XzySfyk6QioK7wTnO1zZ8SiQXa/D4WkxJ5LOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DNsvOk2ypHUl3qn6QD+NPb/+O6tyNEoiKc/BpGoLb4lNfbMH4i0ysbCIz3TntDX5S
	 ZJtLPqRQh5m4YUJzFTW5XtovWcays5cjmZTkXicDSYNGcET6rbDRhDK3GVeTJIbOqs
	 /ZQd2MMaNqL7QieLvs/Y6GUq7hTXxxrlcHysoO1AgZRCreurY/1hhTyuYSGFfaRufa
	 +ZPA5WcO0f9zIQpXTq2Hzk+kfPLlYEt+1rDCku6c+ETSQLBXeo0k2tuPC+Uyk6WTr1
	 Ie0meO2G2SNGktJPc2xvs67+02K19Y6cnGXkK3HXbT32Ru8vltltKxQxxRFWkc4elN
	 9uXy44k7sz2Jg==
Date: Sat, 30 Mar 2024 11:46:52 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 3/5] rust: module: prefix all module paths with `::`
Message-ID: <54bc76b0-8391-4723-9477-f74c4185492c@proton.me>
In-Reply-To: <20240328195457.225001-4-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240328195457.225001-4-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.03.24 20:54, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This prevents the macro-generated code from accidentally referring to
> the wrong symbol if the caller's code happens to have submodules called
> `core` or `kernel`.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/macros/module.rs | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


