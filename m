Return-Path: <linux-kernel+bounces-6824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1F819E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B61C25C18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F962137C;
	Wed, 20 Dec 2023 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lecIb3gz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DC21358;
	Wed, 20 Dec 2023 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1703071972; x=1703331172;
	bh=wY3jU3FbByIfLUACfIHBmNS2cVGtxbGw94BOjG8I3wE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lecIb3gzq3o0k9XNQ0qFEvRdz6/kwTysT8BMsZJYPJovJN3pxDoLl4eOsW9HmHJXx
	 BqFUVBBmWvT7/onEM12C3Gfv8fEOM2hblhbVuucilMmFJIevTKLpNWugApQYEQjSJW
	 jO1YHxqNLXtRlWS5bR/btcfPEus3GGTGrrvsMTNWIb6seO2gXWuqGXsll9z9w1YbdS
	 gxLACIX7cTaGcVmgN6vAxD+hTv20yAyAA3bQRcwh9XYcYxu7Z0LsQ75lyzX5g+M4Zd
	 RRBdAkPUu0MJ72Cmd6e9LRfl8ojuFa+EnTGLirAzW3+8k6Ga+8m0iO52BxVWph9vGg
	 OviQTKorw5LTw==
Date: Wed, 20 Dec 2023 11:31:05 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
Message-ID: <3fba196a-8cb6-4ce9-9e67-bfb716a2d171@proton.me>
In-Reply-To: <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com> <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
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
> @@ -102,7 +105,12 @@ pub fn new(name: &'static CStr, key: &'static LockCl=
assKey) -> impl PinInit<Self
>          })
>      }
>=20
> -    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guar=
d: &mut Guard<'_, T, B>) {
> +    fn wait_internal<T: ?Sized, B: Backend>(
> +        &self,
> +        wait_state: u32,
> +        guard: &mut Guard<'_, T, B>,
> +        timeout: c_long,
> +    ) -> c_long {
>          let wait =3D Opaque::<bindings::wait_queue_entry>::uninit();
>=20
>          // SAFETY: `wait` points to valid memory.
> @@ -113,11 +121,13 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait=
_state: u32, guard: &mut Guar
>              bindings::prepare_to_wait_exclusive(self.wait_list.get(), wa=
it.get(), wait_state as _)
>          };
>=20
> -        // SAFETY: No arguments, switches to another thread.
> -        guard.do_unlocked(|| unsafe { bindings::schedule() });
> +        // SAFETY: Switches to another thread. The timeout can be any nu=
mber.
> +        let ret =3D guard.do_unlocked(|| unsafe { bindings::schedule_tim=
eout(timeout) });

I am not sure what exactly the safety requirements of `schedule_timeout`
are. I looked at the function and saw that the timout should not be
negative. But aside from that only the the context switching should be
relevant. What things are not allowed to do when calling `schedule`
(aside from the stuff that klint catches)?
Because if there are none, then I would put the "switches to another
thread" part into a normal comment.

--=20
Cheers,
Benno

>=20
>          // SAFETY: Both `wait` and `wait_list` point to valid memory.
>          unsafe { bindings::finish_wait(self.wait_list.get(), wait.get())=
 };
> +
> +        ret
>      }


