Return-Path: <linux-kernel+bounces-4180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3628178E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B411F24158
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989345BFB8;
	Mon, 18 Dec 2023 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mJdbOJRw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945455BF8C;
	Mon, 18 Dec 2023 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702921170; x=1703180370;
	bh=aZzxHDmfiWc7TV6vdPZR5ei+gKZrSzglYAPPwpG2IEI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mJdbOJRw3Y60aaMYrgEoLVwxR36O2JDxMegOU6hYci7Pxq/jjT80t0fWelfJtjQG0
	 Up/4KKhycafYjFXeddnugvdY0C0vWMi7nrBU9xSTfmsZ7loiIr+kwp7fDFDSUta4dx
	 cR4hAB5YaqZOAEe/W8ynvdUitrU7D/ni2gaRpNre+1dDI4mB/jZ0VsI9ezhyG0067m
	 5+GuHl/qnJF+hh9otMMqIBG2VIxeFFyAOmjezLtNnnNkJvKsQlVGKy1qYYUdnPI+05
	 Lxnl9Cj+/3kkuWF/BL7l2S/fFZIOr6PcXWoJBe8Q/OhnankN9QKc5QxChPM78pGHML
	 TpxfbYQWB9rPg==
Date: Mon, 18 Dec 2023 17:39:14 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible wait
Message-ID: <b2d69a27-d791-4455-843b-d946512beb78@proton.me>
In-Reply-To: <ZXzlGM1xV-VlUkeh@boqun-archlinux>
References: <ZXtebif2S1CyJRik@boqun-archlinux> <20231214200421.690629-1-boqun.feng@gmail.com> <CAH5fLggriMBLWVx5i1efHdiNveVutvRfcA6mydNV9egzEFnnxw@mail.gmail.com> <ZXzlGM1xV-VlUkeh@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/16/23 00:45, Boqun Feng wrote:
> On Fri, Dec 15, 2023 at 11:27:56AM +0100, Alice Ryhl wrote:
>> On Thu, Dec 14, 2023 at 9:04=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>>>
>>> Currently, `CondVar::wait()` is an interruptible wait, and this is
>>> different than `wait_event()` in include/linux/wait.h (which is an
>>> uninterruptible wait). To avoid confusion between different APIs on the
>>> interruptible/uninterruptible, make `CondVar::wait()` an uninterruptibl=
e
>>> wait same as `wait_event()`, also rename the old `wait()` to
>>> `CondVar::wait_interruptible()`.
>>>
>>> Spotted-by: Tiago Lam <tiagolam@gmail.com>
>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>
>> The diff is a bit hard to read because you swapped the order of the
>> functions, but LGTM.
>>
>=20
> Yeah, I did that because `wait_interruptible` metioned `wait`, so I had
> to make `wait` still before `wait_interruptible`.

What do you mean? If you are talking about the doclink, then
that should not matter.

--=20
Cheers,
Benno


