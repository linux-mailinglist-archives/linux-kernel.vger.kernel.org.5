Return-Path: <linux-kernel+bounces-131638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A9898A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A528BBD6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9566B1BF3B;
	Thu,  4 Apr 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XKdTzwkM"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBA11B964
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241712; cv=none; b=qjwQpQPRX70vFSQ7nvAi0b81ZdnRxlvqnJt2m5rqgQw9KjU8CwKMm8SLZSx1pBmriWVEEhYFrKfPTiLC6Ry6kCtQe5+4uzKj8EklkgK7kZMObYn0bRdGhhH9zZUbFu4T8DwOarhOcADvpH360jKnyvZX3InsCMm5DZ7PI3N5T7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241712; c=relaxed/simple;
	bh=c2FcGaMs92bL0DW+4qQKped7KrfVqul8MtmSpvK1eno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYc+ichltNJYWXq/dU8TIPxS85p2rGLGwbx89dTguaMpYkTcFS/kgG8bqc99htzrtyaF0UN4HzMgYDdRdUzD1laf7hmBINNFwU1awKHJ6XHytoOE+2DRFvw4XzL52V6LbGa4xCkySiIc7CoqgRa7ich7fB5iTNWgJK3o809hZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XKdTzwkM; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712241706; x=1712500906;
	bh=1QVEMvbvy2roz2lqgS24Q8cvcM+QzhUJa+rGii5XAPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XKdTzwkMHugQPI19Ye5RMZ4bdXUCX+VLl48GQcwLIxO6YBg80Cjj+sgfSfdZbngNg
	 L9F5t9xc+1l16VskyW9UDUcCYa9kULtrqo9H+m9wTgMN4mQnxV2bu5+ajvxbSi3T62
	 eSHDOqzrdSPPbyZwi4nyV5nzBJU/mTlXqjz3koXu1JOUK5eWjh2G2Q/C/NRbKczFAy
	 JFKnKh5NvHD1BILK66X9uDipRnuYmybuCgfSE9GEkwkZYy/GUwNf88XXLiTCegBOoZ
	 eBVfQS3cYMf4Ql6AQEL8xg9Dw7DM4vS2l7mso4JlAnbWjr1KGtemezD1BPesMRLUAP
	 5sNF1ELEJzYiA==
Date: Thu, 04 Apr 2024 14:41:40 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/9] rust: list: add tracking for ListArc
Message-ID: <69c87a65-59a4-4f65-8b93-a1dafef36d31@proton.me>
In-Reply-To: <CAH5fLghHmuHxw1BL1F2-VF5KUXQLOwMqW6PfiAoLBXRE0Gyu=g@mail.gmail.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-2-b1c59ba7ae3b@google.com> <36306930-0390-4342-830d-03c11ec4a3a7@proton.me> <CAH5fLghHmuHxw1BL1F2-VF5KUXQLOwMqW6PfiAoLBXRE0Gyu=g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 16:14, Alice Ryhl wrote:
> On Wed, Apr 3, 2024 at 5:52=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> On 02.04.24 14:16, Alice Ryhl wrote:
>>> +                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on=
_create_list_arc_from_unique(
>>> +                        &mut *field
>>> +                ) };
>>
>> Formatting? rustfmt gives me this:
>>
>>                   unsafe {
>>                       <$fty as $crate::list::ListArcSafe<$num>>::on_crea=
te_list_arc_from_unique(
>>                           &mut *field
>>                       )
>>                   };
>>
>> (maybe the `;` should be inside the `unsafe` block in this case?)
>=20
> I can make the change, but rustfmt does not affect macros.

I think we still should try to format macros correctly, it increases
readability. I take the in-macro code, remove all `$` and other
macro-only symbols, then use rustfmt and then manually format the code
accordingly. I also find it tedious, but the unformatted code also
doesn't look good :)

--=20
Cheers,
Benno


