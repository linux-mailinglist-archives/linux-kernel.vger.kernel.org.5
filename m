Return-Path: <linux-kernel+bounces-60336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2092850350
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B851F212B1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AEC2B9D0;
	Sat, 10 Feb 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="gb9FrysG"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757927471
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550900; cv=none; b=WCttqGEeVhotXJ9dNaORjkSStEKl2D4DetQIHgc+tyOxEwThuyQ9vHJE98G4VDI1PrKr7tkQW9Uz/N90zyGhzhzVH6bBgM2y1jq9m2UXrpIKkQK8+tVOMfRfSmvTQqdPdbVXeZnr8B4YfWdpkdy4iDr91/Lr83FMfcC/5XVot34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550900; c=relaxed/simple;
	bh=B5Al9ZnS7QlBXv3l9vo86GjjY0RgUDiapvTDHOJYJTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNTjJw/owICQssTC4YsAXvLPjKSEUk380VzHtq9w+FrJS3HAiMhuDygqQZjUAsZ0Wof/2WREzFMryJdMOXwp0NCbAto7B8/CtSP6zR85cUYwU3ylvZlvZwen8au0PA9CjtPgbIXAUqOdNYpVhJo5gY2jG+CMIq8PxGZpD40vW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=gb9FrysG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so1670195276.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707550897; x=1708155697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5Al9ZnS7QlBXv3l9vo86GjjY0RgUDiapvTDHOJYJTw=;
        b=gb9FrysGKkvT19tkjG2QIs8WkRCoiMR9LfseiFCMAYUUztoCET0nbec3vQGCKHtdhG
         rNnaHyzLtt3XdiWpm94mhBNO9B8gdU03eI1Mgs2Mx47ryF9+vT/B/HhE4UPuWaFiHe7K
         s5Y0SNeM0w1ecZAPtnABVx3pS5u0/bFkSWwph0mmcRfo3bT7pmVhluBdr9pFFzxyuQil
         nhV42JfzGDvxJ2btM4cmK0OPcAGjEpxWn8Vf1LvgSH8XRPv6l33yPxcPA9AufSh6rqHm
         WSKA4VpsUkBKm9/ZDE+IR/pZL47OiAPskrxiA0mLwBa5Q/2rHzIcqgzXLMdg1Ral4djn
         uy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707550897; x=1708155697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5Al9ZnS7QlBXv3l9vo86GjjY0RgUDiapvTDHOJYJTw=;
        b=hjx029cqSkL/qzPWFP3NI0CE7+zrycBY09q50cxJuVpxqZv8TZV5Cx0TWdJizWZeME
         qS9PaZOa5RKbhlGqjVjNJ5vJmJWbcCP3utGxDtvyv8DTaIccZvAWdhJ3St6qQuTqKqro
         laW+LV+4IJbDz9CTq5SxGIdM+OIBsnwTN2ayElvZaeWxtJCJhSIotJFFwnvv2m8zvfN2
         ZzkMyQTqyqkAfwVA4fQIYBUknYSObzaltrf4Wdev4rJPnwH3SQ2jkhHOBTmp7tDNpeyx
         Qfr0jBXxLY/9PmnkITC5bk1xbnkWTW9sPbFo4PHRKkIB4h4h8EZKM0LGQNaEFd9dGsrW
         h0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXsKnyPklGTSUROZoxykoQIC8ItdZRhpVzZolheWexzVCRE5V+a4jQaSINC5LCHykgK9yIhrqpP+p5Di93ufyKrCB/BuYQYQjdER8RW
X-Gm-Message-State: AOJu0Yx9igxhu/I4AhynrIYTEnczDSZGQOqFN49th8zKa/t+dR3G5gTt
	lYW1jdXQplnz/+JZ/bKJfpypTfvVRgGdxQmJGgH9PQvQt2DEGagPPEBRSUd8Mfg27d+CeLlbnN6
	VzlkoBhFLNCmaH26BqyoynwbCeVt30SZTiGpQAw==
X-Google-Smtp-Source: AGHT+IHnlbSj0FDHgzJpeBPkGo7B3cT6BizUO+df4LqH/hYdfFmyafJnmzZ3R2Vcwt0bJ+2DTH/8T9e1RbiMTDAM9QY=
X-Received: by 2002:a05:6902:542:b0:dc6:6307:d188 with SMTP id
 z2-20020a056902054200b00dc66307d188mr1258983ybs.25.1707550897730; Fri, 09 Feb
 2024 23:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com> <20240209-alice-file-v5-6-a37886783025@google.com>
In-Reply-To: <20240209-alice-file-v5-6-a37886783025@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 10 Feb 2024 01:41:27 -0600
Message-ID: <CALNs47vbaMgsJLwLZ0QJFQ=ckaihhYfueV4tRAFhk7jjEhOjKw@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] rust: file: add `FileDescriptorReservation`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> Allow for the creation of a file descriptor in two steps: first, we
> reserve a slot for it, then we commit or drop the reservation. The first
> step may fail (e.g., the current process ran out of available slots),
> but commit and drop never fail (and are mutually exclusive).
>
> This is needed by Rust Binder when fds are sent from one process to
> another. It has to be a two-step process to properly handle the case
> where multiple fds are sent: The operation must fail or succeed
> atomically, which we achieve by first reserving the fds we need, and
> only installing the files once we have reserved enough fds to send the
> files.
>
> Fd reservations assume that the value of `current` does not change
> between the call to get_unused_fd_flags and the call to fd_install (or
> put_unused_fd). By not implementing the Send trait, this abstraction
> ensures that the `FileDescriptorReservation` cannot be moved into a
> different process.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

