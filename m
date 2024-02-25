Return-Path: <linux-kernel+bounces-80279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F45862CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF91C212BA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33601B81F;
	Sun, 25 Feb 2024 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7UNGzwj"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0083211;
	Sun, 25 Feb 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892925; cv=none; b=AFF7TIbVvvW5fQ4M5vEQjkvtf39enipN0824z+CUpccFTXA8kirydBqOzUTm7wAqhlB1bAY7wsevwJYD0akjsEvV0qprCkJJU9OuWqIvJhg7Twknw1t0mdDsG/TH+hcgY3cDVAYNGgtaxKINR0diIRFUHBS+oIjqkMxEh9QctC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892925; c=relaxed/simple;
	bh=xDW2zECvB9+/D68JF3N95+yirg6sGdrooqWxGaivrYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2p4ZTAaMMqK3VLa6bBtC7L+VgiN0kL4VtVIK25yiAgUyFVe3R986YZjfqXe+kiRHv0QeJpysZx45A6nRMWo2R3h26J1fOJ5V5kIDg4ZlUJmEyd64jqgrpYeW/3t6EV/r1hpo0i1XWhT05dfHkxWp76qaBkbR8JA7pD0EihyutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7UNGzwj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4f45d4369so209696b3a.0;
        Sun, 25 Feb 2024 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708892923; x=1709497723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDW2zECvB9+/D68JF3N95+yirg6sGdrooqWxGaivrYE=;
        b=S7UNGzwjiwyaaXGBup92eSL6cPGUe+WXyxA/8rBt595QQrP5JAKIuJtPSRSTuLIJ+F
         GUMVgBPeD0CLC7loeRR4ZxtILvFVUISzKiqokMWE3rXn0rZegtyhBgGarZknYDsog56W
         +xurb0g9gEkfsWNBrXw165EBqtV6iTLQRAyJS6Fbyvn3uxNrAwrGjIa9ZyRwfXTWFYgI
         aNGMKBH/r2FpfEr/UvxwcjFP2DK3JUAj+86nAqX4FlPpi+akYOsbvFD4ra/rl2ya4kfV
         elK4nLOlkwZlXyTeLy3RBTHU3mkztwaWe4hrfo4sdBS0ZgNX26OWH4lqsaN7ohe11fwA
         SBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708892923; x=1709497723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDW2zECvB9+/D68JF3N95+yirg6sGdrooqWxGaivrYE=;
        b=FH/Ec0NbWLnfW0UQg4HgN4WjxtQceQCpaAq2iO0qhnRiqjj2bqMQoE55//Ppb6xfLE
         AbGqQ5j+Hkn58Qo01FnM+4vpKDymEoyG4Xo0E6pvNAdo1LsRyGc2ZiRN0jUUEqYBZtmB
         eLibdshxcfzJ6ui7Nyobabnxa7F4dq8Cn2p/iTiZ5hGZmXIVj1Cg4zXNNGhfr2+Cx52Y
         4Noz0jb9zo1FWnkGRff12ZduztvFvSjfDP04pDTeZ9zaWBScWroTDVfzIXFxROSP66Xs
         OSuKRiodxLrnPFRT7SP+vvfcTQZ9Wg4gHtHhMglQc8g5RcLXj4iNz6B8cu4EKdSAixFw
         Fr7A==
X-Forwarded-Encrypted: i=1; AJvYcCWvaayBFCkQ9JiRUMgG/LUtJDBizs7BZGbXBo1uUwR4uMAK2X5R7xoOdpoO4Awk5fpSYFda6d+/8JD1ZuEzJcBXacV3ve5a0whQPDjEu4SzLiS5TuxTeV691Fr+/sX9e8u7OOd+DMsb7+bfhAY=
X-Gm-Message-State: AOJu0YzvDPGkLC6XhT2B3nJCFKTF++GxwLjC9IDgwQq9Hnk0vavE/+Y8
	l8TqhHDUnwxh3MSCBDFMXyLL8OgbNdaKQJRO/79mCg5pVmujNQIMCpf8ZehfM6S8hLhqmsX8eFH
	XOrWWkhNGm/uqRb+gfUBHhXP2qRA=
X-Google-Smtp-Source: AGHT+IEWhsGvsij6nv/gr7KSk4TRRXNd4LOgK6RrMtnqVC4ifgZ8bEmMHykxTB5mjktocqpkv8WZUzQyLEsh38cxqXw=
X-Received: by 2002:a05:6a00:2f96:b0:6e4:7a99:1af2 with SMTP id
 fm22-20020a056a002f9600b006e47a991af2mr4278477pfb.29.1708892922983; Sun, 25
 Feb 2024 12:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com> <20240219-b4-rbtree-v2-1-0b113aab330d@google.com>
In-Reply-To: <20240219-b4-rbtree-v2-1-0b113aab330d@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Feb 2024 21:28:28 +0100
Message-ID: <CANiq72mgNDZHxaLvxgTMYBxoemRLrWa8c8RvOzvK6=oKAbv15A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] rust: add `container_of!` macro
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:48=E2=80=AFPM Matt Gilbride <mattgilbride@google=
com> wrote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> This macro is used to obtain a pointer to an entire struct
> when given a pointer to a field in that struct.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

Applied to `rust-next` -- thanks everyone!

I took #1 of this series for the time being so that we have
`container_of!` in already since others were waiting for it.

Cheers,
Miguel

