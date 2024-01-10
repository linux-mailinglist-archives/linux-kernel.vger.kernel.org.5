Return-Path: <linux-kernel+bounces-21936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8753C8296D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37417289FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9C3F8E3;
	Wed, 10 Jan 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DzFr2lcK"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5563D967;
	Wed, 10 Jan 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1704880882; x=1705140082;
	bh=ciT5Z7UQzFkWQl2p+TUA4UNBF3JN/rFYRvA4zsaEyS4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DzFr2lcKc5ouNjnYYyApVW/hXgnVdtfGdsAfW6k5pZXQKoC20SDg9jVHkOfj67ha6
	 /m2+3e+BtxvsfiO3YimIlxTiGCkaeQAZav924moFIdmIyVu/2glEb+dn+CjbdZdHUM
	 tnFlVAJ6YYHri1pARt6dO4asRkk2D5E1q1Fi0qz1MAcHZFH5CjbllySwg2ePaq/dak
	 Pl2Bf//d0dJGkOozrqiEemrPJlY241ouUtC8u5+iXV0qga73I0J5srmTqDvKd1rCAy
	 PC6V58R+WfCDuisPR2pmZWRJpnV9m0N/lM5gxl8BA94/Qykw0ZUPD3hbJBSsJil+gD
	 +VKz5md/JhTCg==
Date: Wed, 10 Jan 2024 10:01:13 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] rust: sync: add `CondVar::wait_timeout`
Message-ID: <8c1b98e8-a1e4-4466-a9ca-72b9923bb2e2@proton.me>
In-Reply-To: <20240108-rb-new-condvar-methods-v4-3-88e0c871cc05@google.com>
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com> <20240108-rb-new-condvar-methods-v4-3-88e0c871cc05@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.01.24 15:49, Alice Ryhl wrote:
> Sleep on a condition variable with a timeout.
>=20
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
>=20
> Note that it is not enough to avoid jiffies by introducing a variant of
> `CondVar::wait_timeout` that takes the timeout in msecs because we need
> to be able to restart the sleep with the remaining sleep duration if it
> is interrupted, and if the API takes msecs rather than jiffies, then
> that would require a conversion roundtrip jiffies->msecs->jiffies that
> is best avoided.
>=20
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Tiago Lam <tiagolam@gmail.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/sync/condvar.rs | 60 ++++++++++++++++++++++++++++++++++++++=
++-----
>   rust/kernel/sync/lock.rs    |  4 +--
>   rust/kernel/task.rs         |  5 +++-
>   3 files changed, 60 insertions(+), 9 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--
Cheers,
Benno


