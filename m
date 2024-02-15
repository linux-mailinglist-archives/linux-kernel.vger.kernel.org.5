Return-Path: <linux-kernel+bounces-67676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DC856EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8D1F261C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B713B798;
	Thu, 15 Feb 2024 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L09ZpbTP"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC6013AA42
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030543; cv=none; b=S0NXbwfKFcDChDa8IR04Fyut88Ep+SRNCFdjVff8niuSfSXeo66tqD/3DLM3qb/zhQXcSlK5UiMH4yadps9O/vvuY5bDGkc5ofoPSBU5MONijjHJVzbBU1MCqPVsuXHahP0uW9mZrCp6TA3k2q4PPX0riGKszg7i1ipz5mXt4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030543; c=relaxed/simple;
	bh=KIzclAEwIBOpeiVA2+aczTSaIGRAkzsbbq/mkVVWP3w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhJ+yUezwYhaBezFz8kgs99pBggMEBj09KIz4HKHDZtcvrsparToCJYdzll0la3uPwp9gM6wCRCV3VkIC1Yso3Y0w7aLX0E7aem+NtIxJUNkrxOyX3J+sHYcsABCnaeRMK4JSdJSGEfIT7zeaayynChGF2C5+IylYs+/hVl9R6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L09ZpbTP; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1708030531; x=1708289731;
	bh=I2h/y93EAF/twExyQBodY/TNxbTPVRXIQA2iO81nDHM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L09ZpbTPW4NhqOgttk85t9GN/cPdz5IspaAs/NTTA8hHGGxf+7MN+acZ08CWhbenJ
	 VJNAirwqu98ppKBKAkGI0ghy0YyX3vCck9y+4cAwi1BwqWXv4oZzwGpfvZMgEDtFoZ
	 6OpU9wUKVkCmszaJwIVYwi+cVkKhs+HijEWBp6+x834wBbpOOJ1c3qusCCRZpLqyum
	 DahMNNA6LNsRSF5bauuEI3jdvA9240zKdpQItQS3smvegNHXyCsHh0pJ//oNs+dZEO
	 iV5pQvJ/c7eRueI9lHwJkbBRughouLgPpjD1s4tPlSI6bQ9gJ1/BQ7FbZgG+D6dy8T
	 kKswLbYzOgqiA==
Date: Thu, 15 Feb 2024 20:55:11 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: mathys35.gasnier@gmail.com, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2] rust: locks: Add `get_mut` method to `Lock`
Message-ID: <ff06ddd4-808a-44fd-9230-f60aa43ec1de@proton.me>
In-Reply-To: <CANeycqqwGE_eyFSDWkmHCBOMZ6+Ty-XK_hKixMtOYqc9_46j2A@mail.gmail.com>
References: <20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com> <CAH5fLghTKpLs=Wb03cjx0LRQbZgmXRoMNy1cyheb7cQRL0mjsw@mail.gmail.com> <CANeycqqwGE_eyFSDWkmHCBOMZ6+Ty-XK_hKixMtOYqc9_46j2A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.02.24 17:50, Wedson Almeida Filho wrote:
> On Mon, 12 Feb 2024 at 11:22, Alice Ryhl <aliceryhl@google.com> wrote:
>>
>> On Mon, Feb 12, 2024 at 3:13=E2=80=AFPM Mathys-Gasnier via B4 Relay
>> <devnull+mathys35.gasnier.gmail.com@kernel.org> wrote:
>>> +    /// Gets the data contained in the lock
>>> +    /// Having a mutable reference to the lock guarantees that no othe=
r threads have access to the lock.
>>> +    /// Making it safe to get a mutable reference to the lock content.
>>> +    pub fn get_mut(&mut self) -> &mut T {
>>> +        self.data.get_mut()
>>> +    }
>>
>> It's impossible to call this method. You can never have a mutable
>> reference to a Linux mutex because we pin our locks. At most, you can
>> have a Pin<&mut Self>.
>=20
> Perhaps you meant to say that it's impossible to call this method
> without unsafe blocks? From a `Pin<&mut T>`, we can call
> `get_unchecked_mut` to get an `&mut T`.

That is the wrong way to design this, since it forces an extra
`unsafe` call. Instead this function's receiver type should be
`self: Pin<&mut Self>`.

--=20
Cheers,
Benno


