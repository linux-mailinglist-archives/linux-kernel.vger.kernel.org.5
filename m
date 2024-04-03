Return-Path: <linux-kernel+bounces-129588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12397896CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB561C27809
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111621420C4;
	Wed,  3 Apr 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KXtsN1gj"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57529433AD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140939; cv=none; b=sEI/TTBEPI9b5SLtcNUoUizKKIN5YTqvDMMJ3gGWXduJ2twL5I16ZhQ/BxEXlsVDa0GJv5KPfuwwCER+d+mA6PTGGVPWoIeTn/2tHy4b3N1QjiDXsTeeXIMK1vSZkZAXVOvFG6AFRffix3igUpMt8bwDyfG1xH2cDdKMkGjBS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140939; c=relaxed/simple;
	bh=iC25lYOBAlQTYOx5EyMwl5mfX3TgCjRjQkwCKtwNzww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIkMKgA7jQe+e/yQHwdSZIvQu+2rgrgDymif4NSvHMcTyvLj7dbB6X3a4yi2ZczNGYmLwvO7Sy7E2ctrUPDZ/cL7UKgUPqjuBZUngiJ0bMuEJ3WbNm7cJhuRxn9SIxNwEYNiZopRBoCoWldGXLqNxlo4MCGRzTbC6WDLHPXRaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KXtsN1gj; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712140935; x=1712400135;
	bh=gmr3sRWwVz1KFJTlsq4t7GqhuRPIjdz9F1vpTU2ecA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KXtsN1gjpwhkuBWpW1Eyt2pTfbGx8FuLHYaNEHy1tMv7zk8N6JtGlhRxXqhNOfbIN
	 2V5NVUnqhw4omwtvF4kltzLHBGQKCK9awNyhrRnCMXEjqfneKhUXJl2BpA8vIBpxgs
	 Mp7NqH9jB5t1P1gmF0KRjV38HZAp3AA82l3zBow5yYPisKh4ZHYsO0OORZeJE+GLgw
	 MvHLFF9OmXkXE9IhyK0P2t4AfYxEhjVcjLoGKDxiktK9QsjTchp3wzBXzELfKmUoMp
	 8CQF1+gQFnfnlPhUPEQ+QFtZEbqFvSZAGleulorWLH1dSDIf1OGhJKQbJqG/ud2OYu
	 rMOzaX0/FUVNg==
Date: Wed, 03 Apr 2024 10:42:06 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 4/9] rust: list: add macro for implementing ListItem
Message-ID: <d0e53273-f2b0-4181-8857-73934b7e4160@proton.me>
In-Reply-To: <20240402-linked-list-v1-4-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-4-b1c59ba7ae3b@google.com>
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
> +/// Declares that this type has a `ListLinks<ID>` field at a fixed offse=
t.
> +///
> +/// This trait is only used to help implement `ListItem` safely. If `Lis=
tItem` is implemented
> +/// manually, then this trait is not needed.
> +///
> +/// # Safety
> +///
> +/// All values of this type must have a `ListLinks<ID>` field at the giv=
en offset.
> +pub unsafe trait HasListLinks<const ID: u64 =3D 0> {
> +    /// The offset of the `ListLinks` field.
> +    const OFFSET: usize;
> +
> +    /// Returns a pointer to the [`ListLinks<T, ID>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at a valid struct of type `Self`=
.
> +    ///
> +    /// [`ListLinks<T, ID>`]: ListLinks
> +    // We don't really need this method, but it's necessary for the impl=
ementation of
> +    // `impl_has_work!` to be correct.
> +    #[inline]
> +    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
> +        // SAFETY: The caller promises that the pointer is valid.

The caller only provides a valid pointer, this also needs the
requirement from the trait that `OFFSET` is correct.

--=20
Cheers,
Benno

> +        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID=
> }
> +    }
> +}


