Return-Path: <linux-kernel+bounces-4207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F190A81791C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B9A1C2597A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365455D753;
	Mon, 18 Dec 2023 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QxEwqZXa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B265D742
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702921420; x=1703180620;
	bh=AMsd/DeY8JjSzCht1IKdSI8OtsIMJA5U5odDT72i3pA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QxEwqZXa0tmDYud7wF9bUqEciSqWNsCKG5H4jkqMK2AIbbEZT0NpnaSYr0dFDsivK
	 UVp1IDbDS+3+e1BMrU8i3Bx6CBZUUd3DVv3/SnHOKK4hQ+kVw5jvp4wzRYNG1vWRBE
	 m2rC1ZvlVmEC7pvRECnsADhgKAV7bQJfKfLCwIiHRM98/lzfPelI6lEDpMcFA3GBaz
	 3D5UkTLo/3OJmOcFiogUTjZiHkRrAtDFwKffyA9TxnX48NTOtd//wz/S8wkYUMRp2/
	 ayroAPvjYgceiKxN8YHovvXuyQdz4vIjN+NgcjCB7iYQIPiJ85pRfmTi4pWm9shBkR
	 R0qxYDGb/OzrA==
Date: Mon, 18 Dec 2023 17:43:32 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rust: time: add msecs to jiffies conversion
Message-ID: <1ee0ed2f-fc1f-4fad-9faf-8cc4e8b47819@proton.me>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com> <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com>
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
> Defines type aliases and conversions for msecs and jiffies.
>=20
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
> The freeze timeout is supplied in msecs.
>=20
> Note that we need to convert to jiffies in Binder. It is not enough to
> introduce a variant of `CondVar::wait_timeout` that takes the timeout in
> msecs because we need to be able to restart the sleep with the remaining
> sleep duration if it is interrupted, and if the API takes msecs rather
> than jiffies, then that would require a conversion roundtrip jiffies->
> msecs->jiffies that is best avoided.
>=20
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


