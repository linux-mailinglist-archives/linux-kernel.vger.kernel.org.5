Return-Path: <linux-kernel+bounces-130147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8328974AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02991C21F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854914A620;
	Wed,  3 Apr 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FQ71sGOk"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F98139CF5;
	Wed,  3 Apr 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159846; cv=none; b=XFxpOFd1imztDD69eB7deNJUvBt0AnfVLJCxEPJYI1n8Me63Pv+aDNmlVtKUWTHqeOuF/CumBU0HKlY02PHX2XSwVkk31dtYyCtcabf9/rqdNpNZGMAxcZan1sHsIOO154tqCigQkTVBo0F+aKzOzG+qmfz9cjnwwDzMyZZwMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159846; c=relaxed/simple;
	bh=IPdeQ17Y6NrMkmAhspaKtFhfNADwjiL3UhLpYVl/ysY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C30l7prz5e91zMVNyhbFD76Z4aGW/LErLBgW25QGTTLZWPKu7Fu/fxlV7w2I6pCXwp+lnNosAEDkKyguIRFAwb2r9eNCzGvedIYl4KKWiqpgxO6gQNiE6HmG5KX5YlGHFiqLgUGFIKtY4tJmLIAamK4XEFS5Zp5INodGBIgjb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FQ71sGOk; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712159843; x=1712419043;
	bh=vPFCHk3OWJBFBi86Y4ogf6lJWvOX/xxZkf9NxLiL/hI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FQ71sGOkbkmoM1BUbkZwPvMqnpYW0GWfO/Xp67RunUGgMnD0FDrp6sYDFaSVyK57k
	 dqAA9GMNjFNYjIkmkv7wzPh2Q6UcaFv0Qhu/ERGWbok4cIqFBTFmqv9JiDquKeWv4I
	 QKYczTD73MxhKcx0/6N8D5EubuLPKS9y0Ha5T2UyVmvpCio4Go1ceb0al5Z+LKBbLh
	 ZYKN4QQmgryZHtOhx7sU7H7+Auv2ErrQ0eRl1hx93a0S1Azbif72ogXPaIOnWPTYmA
	 3mxSBca+/qwQQvBApxsjMBjJYLLxtGJqaLCpN948V+CiB2HgCugLFWXnwLRdrGfgqd
	 bwU3R/U2gEWdQ==
Date: Wed, 03 Apr 2024 15:57:16 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/9] rust: list: add struct with prev/next pointers
Message-ID: <2500d66a-e54e-46d8-97cb-37fd9fc00c45@proton.me>
In-Reply-To: <20240402-linked-list-v1-3-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-3-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:17, Alice Ryhl wrote:
> +/// Implemented by types where a [`ListArc<Self>`] can be inserted into =
a `List`.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that they provide the guarantees documented=
 on the three methods
> +/// below.
> +///
> +/// [`ListArc<Self>`]: ListArc
> +pub unsafe trait ListItem<const ID: u64 =3D 0>: ListArcSafe<ID> {
> +    /// Views the [`ListLinks`] for this value.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// * If there is a currently active call to `prepare_to_insert`, th=
en this returns the same
> +    ///   pointer as the one returned by the currently active call to `p=
repare_to_insert`.

I was a bit confused by the term "active call to `prepare_to_insert`",
since I thought that the function would need to be executed at this
moment. I inferred from below that you mean by this that there has been
a `prepare_to_insert` call, but not yet a corresponding `post_remove`
call.
I did not yet find a better way to phrase this.

I like putting the guarantees on the functions very much.

--=20
Cheers,
Benno


