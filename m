Return-Path: <linux-kernel+bounces-29613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0C8310C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2FA284D75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B7186C;
	Thu, 18 Jan 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="T+XjZGVY"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3520F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540697; cv=none; b=orPLr6L7fkSqXbrGKrKOEWf7jqZMLmM1ExM1rD9dhOfkGwk+i0fzRxUnn/1rGKxBwVNNeX1bsFF/QbwQq4PubTlWhFDU2ltzO2qOba1xUllmrS5vy81vnnbYgg2AB785zDR/yz84lnT4tD0WIcr5lpq6p3OHh7Zw4MkahCcTqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540697; c=relaxed/simple;
	bh=u/YnBkW6zd6R6ZWQMtZLf8qbt6kTXp+PIIhG4J4cvFo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Y0LRqe+OYh8OhMVGUcIxYboZOaB3LDMCfHnRl/IC+GgslFM/+fOVGbQ9PWygg/CQfDfWRCSTEjqO+NBzgkrSsdRonXQsGLk8E24kNw9Y++KNDd5ntfKzSbT3dTi0ho+uJ6t0pkbTdZp6rr0alscKmCJIyBrVBYnrD2PhxKiTAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=T+XjZGVY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff7a8b5e61so7554587b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705540693; x=1706145493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AX4LbV5uPhoJXb6NYoB1tT93xN7GEGSEV+S3853JSk=;
        b=T+XjZGVYjSxTqlXj+Tf/GjYdolAKWrMHiZ5cye0PzggZV6VIEYM67AASUWC21pSkDQ
         sr11f54qTIE0PZLUCFEkT0wNJqlX0bgeNAGxgfhrvLE0+dRGPKEI1+6iymxGla9kkax5
         KCnAtI4SbdIoJZT5bIirbrpNZR770BKKHFgYXZ52kirqPefOSHvGVATUaq7nW6IqewFA
         IZXM/Y3kIWDWHnzLZ3lE8VeOqKBR9pfjjQhoQsUf3XUt/kITzaBI0O/n3EcW90OQ1rd0
         LR13MSAI90hZO1AU2hoUnjGQ/oD9ZkG3RQCXtqy4cSuSUbiOyY8otj7INpd5OShakKx8
         JowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705540693; x=1706145493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AX4LbV5uPhoJXb6NYoB1tT93xN7GEGSEV+S3853JSk=;
        b=qyfLXH6r2ToRa0c4zDkbcveD5AgQx8e6W4JvClo7QzB2xFgaYciN847Mmuq0verG4V
         iYfJsj9WtNT5VVDMDUR9/5yNyfmicMPNjIcSHbkqOmVtaIBVZcc2RIy0w/7qcv0CPcek
         81fdk6jwqyD6Y0r8EUhbql/ZkVt53FBmrYqGpe7TobrIzrgtH3EYLEPK1M4/bcXyf0Zs
         DqytBf/3pU9vkQBLyBdnHFOcpSJyoXKq/PCOAHF2aK0anNxIxhNRqjFTvpwLMj2FJBZq
         wa8Jd/OXQQqQZSqZP1+5NhSkm7sUKriSrJLwq1xanCusMWW6xZyggUIRiqcoULDuBIzj
         L8OQ==
X-Gm-Message-State: AOJu0Yz/gAoLVNKM1jEId5YVIDFH6mmlyIxXtoTSv4t8nEhqLL/W0RLu
	ELVcdBfbPjNSJ/iFmVSgocU5e566CfzDNSYnVhqG2t15XT4u8jYMp0j3lWahHji9OXTp33rrOK9
	lUOYm+BZgv9/CWCSW60plpMWJOqDLsbb34ZEJPQ==
X-Google-Smtp-Source: AGHT+IE9SXjQc3NJI5V1qcE7/qqHNEw+hj9SYk8h0/c1Pjl7fy1Fa5puOYV/Dh6ZNjyy3WqXPcLcBftA5DUg5Sdfep8=
X-Received: by 2002:a0d:ea0d:0:b0:5ff:5fe5:407a with SMTP id
 t13-20020a0dea0d000000b005ff5fe5407amr88472ywe.86.1705540693724; Wed, 17 Jan
 2024 17:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240117001613.169177-1-kernel@valentinobst.de>
In-Reply-To: <20240117001613.169177-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:18:02 -0500
Message-ID: <CALNs47sg6Y5FmHi4tyJbkK7Kxn1xYzSQta026YpY56qNRfpbAw@mail.gmail.com>
Subject: Re: [PATCH 13/13] rust: locked_by: shorten doclink preview
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:17=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Increases readability by removing `super::` from the link preview
> text.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/sync/locked_by.rs | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.r=
s
> index b17ee5cd98f3..22c38993bf63 100644
> --- a/rust/kernel/sync/locked_by.rs
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -9,7 +9,7 @@
>  /// Allows access to some data to be serialised by a lock that does not =
wrap it.
>  ///
>  /// In most cases, data protected by a lock is wrapped by the appropriat=
e lock type, e.g.,
> -/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for c=
ases when this is not
> +/// [`Mutex`] or [`SpinLock`]. [`LockedBy`] is meant for cases when this=
 is not
>  /// possible. For example, if a container has a lock and some data in th=
e contained elements needs
>  /// to be protected by the same lock.
>  ///
> @@ -17,6 +17,9 @@
>  /// when the caller shows evidence that the 'external' lock is locked. I=
t panics if the evidence
>  /// refers to the wrong instance of the lock.
>  ///
> +/// [`Mutex`]: super::Mutex
> +/// [`SpinLock`]: super::SpinLock
> +///
>  /// # Examples
>  ///
>  /// The following is an example for illustrative purposes: `InnerDirecto=
ry::bytes_used` is an
> --
> 2.43.0
>
>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

