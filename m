Return-Path: <linux-kernel+bounces-29633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E60E831104
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBB6B224A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B933D5;
	Thu, 18 Jan 2024 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="By1B/KUt"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C02907
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542449; cv=none; b=U1FNX72vQFxI4qcIKLi0u9y6I9nX8S+eEAbNBnmLWcLFKzo+ihGyUlweL9lfZzMQiavhqDwswSTZwblPYYKSHpBti/yhn9xzJU/Q2V10eUbpuA0WyAp+OAg41JUAonR3q5wDjeuobGimVsK6YNhF3h4GZf8g8RA8BKYD0jvNxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542449; c=relaxed/simple;
	bh=IzCbt6Kn4zEE1yM1iJiCGXyejnVITdsERAAt6Fmoigs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=BZlhpz8vbT0bWNwXNeSd6T4SIiZ0Fk4miebZyjKpTgn36fN/BzGz0xzpVOThz48xho8Y6P5OiaQBdmVfJJzo3v5nIKYQ+nLfNG14c+ts2e+t7WOEGmb5Q0un3IR7+BVeMG1HKLR1cahllFhI7NqsAD11ql9cpFkpUM1tL5esLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=By1B/KUt; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5fc2e997804so53551257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705542446; x=1706147246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSPD4dVB7yQhkt0VaTSNJwmcnifEmy9Ij5Sgpl1CTcc=;
        b=By1B/KUtj8do5OtkHGwzzXyl2s9RwiZoD5Vg/Yk1Ohid8YscVuZNNqZDjCPfNM7Me+
         AaY0Jbwk7g5Zr7/qBsBw5y5FyJ9xSSMiaw3/MrYFg3CQERsPe5RZME90E+HSay8DaEW5
         GQUsoFQcmL8ETyfjPFseypXmLIxCa/3Qv+sas5XWbpPBuGkR6uu/I4mv+0gGseldfKWn
         2lNDyax93cTHE0qnHfNxlN2PMyzM8XqbjFLyKrAWDMQtWPGqLQXcGRr3/LyI6tvj4Ir0
         +QFsf6c4604G+EwgBiDld5MpfWi6MtDkQYoMnlaV8fbQlIG7TInQm5vMbMHfV01XN3yD
         Y+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542446; x=1706147246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSPD4dVB7yQhkt0VaTSNJwmcnifEmy9Ij5Sgpl1CTcc=;
        b=iYPxn2g92zESeMZpoc58P5Hfm4r3BHb6u5rRB1LWd6PJ8ON+5rtLoaL9m9p7F3OdWu
         +iH5n/GVaf0JI7xb2TsI1zgwBsAPLZO4OWge3z6ErcQ1m81r2QQY/FyCwTDvtELUnOb7
         dDb5NQACjD+WQ1of39rMLDGn3nRgiAZsBFILQCVTHQVmGfciTIwRFj8SKIiVtnZcR/+I
         QqTyTkSlO3Q6pq4W1mxJetjtY1vgBKRovmB9rSInFvlcypL5StpaMC3v432tbkJmfMsU
         qr2tMxJMGrOe5qBsZuwILhsJ9jTeQlGHv2wLl6N7UsfWo1pmhIqrrKl6cvKFyJuHUwPO
         emAA==
X-Gm-Message-State: AOJu0YwXkk/JPHmucZIOrCcHfPeWEx8tRFjBMiVGHuo4NYME92NJ3okc
	orgd91Qyb/yGS3Eq47aXKKgH1rW/2FoU27roL5VHgR9OHOIr4hjCbITzH4+G6xErwEK6QXtM6nu
	dJ9yLuYomlvxBxWwVyHinuuWk9K/ouvGkudIDZA==
X-Google-Smtp-Source: AGHT+IFdpoOGBI1qBIxAzKo5lmEL9zYK/Wh3v6+6V/sZxY5+aJ+pxdGKZeFpOjaVByK73f1FBkZyCHg5w859zoq6520=
X-Received: by 2002:a0d:c242:0:b0:5ff:49b8:747c with SMTP id
 e63-20020a0dc242000000b005ff49b8747cmr105605ywd.74.1705542446398; Wed, 17 Jan
 2024 17:47:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116160141.165951-2-kernel@valentinobst.de>
In-Reply-To: <20240116160141.165951-2-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:47:15 -0500
Message-ID: <CALNs47tgvK-3=0CrZ0tUuk91T+k49m_N_BNkwBvaNGFiZnt3UA@mail.gmail.com>
Subject: Re: [PATCH 01/13] rust: kernel: fix multiple typos in documentation
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:06=E2=80=AFAM Valentin Obst <kernel@valentinobst=
de> wrote:
>
> Fixes multiple trivial typos in documentation and comments of the
> kernel crate.
>
> allocator:
> - Fix a trivial list item alignment issue in the last SAFETY comment of
> `krealloc_aligned`.
>
> init:
> - Replace 'type' with 'trait' in the doc comments of the `PinInit` and
> `Init` traits.
> - Add colons before starting lists.
> - Add spaces between the type and equal sign to respect the code
> formatting rules in example code.
> - End a sentence with a full stop instead of a colon.
>
> ioctl:
> - Replace 'an' with 'a' where appropriate.
>
> str:
> - Replace 'Return' with 'Returns' in the doc comment of `bytes_written`
> as the text describes what the function does.
>
> sync/lock/spinlock:
> - The code in this module operates on spinlocks, not mutexes. Thus,
> replace 'mutex' with 'spinlock' in the SAFETY comment of `unlock`.
>
> workqueue:
> - Replace "wont" with "won't" in the doc comment of `__enqueue`.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/allocator.rs          |  2 +-
>  rust/kernel/init.rs               | 16 ++++++++--------
>  rust/kernel/ioctl.rs              |  4 ++--
>  rust/kernel/str.rs                |  2 +-
>  rust/kernel/sync/lock/spinlock.rs |  2 +-
>  rust/kernel/workqueue.rs          |  2 +-
>  6 files changed, 14 insertions(+), 14 deletions(-)

What an excellent commit message :)

Reviewed-by: Trevor Gross <tmgross@umich.edu>

