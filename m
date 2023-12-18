Return-Path: <linux-kernel+bounces-4211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FB817924
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F061F28103
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2672045;
	Mon, 18 Dec 2023 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PrBOoSbt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CA5D75F;
	Mon, 18 Dec 2023 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702921565; x=1703180765;
	bh=l74qLactwzIVrq/B9kOv8F974+1rgtU+2NAFHFv2u0Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PrBOoSbtVidBr8qVRqgwiiF2kZM4qxQbG9UHEVLk8gHXz+JVsd+Wkf4QqajFU5RDB
	 dD9K8l1kUDM1+bpiYSlxHjIsIp0e/Um5RsiSh7al6eD6mNYyMtPzK1ok0322hIvG5I
	 wthGfuHsSKVl/M6m+tuWDGAa08jVtAqhS0dwTira6waYvwwkzU8ETWvwssU13r7YW7
	 2bZHAYXaEAMSPpUJRjb94r7BvT5Xs9juVySw5SgtHzFR/mgIndVaW/rfXbfxQIGOfo
	 t/UNj4BgZiWX4I9cocLZeGdTadH6rffqrksn82qx+7OJxC2RoSM2D/Sdo3z8vqQKNw
	 lHnEqMigNubDQ==
Date: Mon, 18 Dec 2023 17:45:54 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: sync: update integer types in CondVar
Message-ID: <caefaf00-bf59-4ad9-bec5-9d095754354c@proton.me>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com> <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/16/23 16:31, Alice Ryhl wrote:
> Reduce the chances of compilation failures due to integer type
> mismatches in `CondVar`.
>=20
> When an integer is defined using a #define in C, bindgen doesn't know
> which integer type it is supposed to be, so it will just use `u32` by
> default (if it fits in an u32). Whenever the right type is something
> else, we insert a cast in Rust. However, this means that the code has a
> lot of extra casts, and sometimes the code will be missing casts if u32
> happens to be correct on the developer's machine, even though the type
> might be something else on a different platform.
>=20
> This patch updates all uses of such constants in
> `rust/kernel/sync/condvar.rs` to use constants defined with the right
> type. This allows us to remove various unnecessary casts, while also
> future-proofing for the case where `unsigned int !=3D u32`.
>=20
> I wrote this patch at the suggestion of Benno in [1].
>=20
> Link: https://lore.kernel.org/all/nAEg-6vbtX72ZY3oirDhrSEf06TBWmMiTt73Ekl=
MzEAzN4FD4mF3TPEyAOxBZgZtjzoiaBYtYr3s8sa9wp1uYH9vEWRf2M-Lf4I0BY9rAgk=3D@pro=
ton.me/ [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


