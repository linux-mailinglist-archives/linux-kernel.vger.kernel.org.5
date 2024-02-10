Return-Path: <linux-kernel+bounces-60337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BFA850354
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C612833EB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3073611A;
	Sat, 10 Feb 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="NnXklna1"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67E33CE7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551007; cv=none; b=OTXpLpn7JN4ejw7X7YjXRlSVDI+4Pcv3ksP1MAznJLeW1eLD4nZc9aA740UmjzgQMKnZXDmzu7jEJxPNGBAs46cOx1MyavaWuiTKEENcNmDkUew1PqaXBctrEO5o8LSLu/mqj/JSeu+g7mKPeQL9Vzvxq0zE7xiwm0BKQiqjyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551007; c=relaxed/simple;
	bh=70bvpWCaiQjXnWwhjEaUPbh89LdTobpAVbcQg6lcPS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU5YHPo0a5rfnHWqwWcVZXAiYBRTfh5EfZKVV/4NEHtMJZEm0Tkwyfj6e+70G6ADJ6RNqDjqJINUvBiAgORW/hyi89Ihz9g5cVwRxIZW7GzyR6v/7tS4+kUH5CTR3K6YRAavDMDwXpfD5hraBagzH6xMw5qJPHuaFrkFbbg1Gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=NnXklna1; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1812134276.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707551005; x=1708155805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeBl8V4xziTqeBvkNb4bBS2gsfVXau2tJAbBS4r5lbM=;
        b=NnXklna110vETvmOXKPtrZLvPfzGMwLGEQg2+L0/gj9+GBUBUV0jkLI5AZ8ebfcFPd
         DUjBkQ5lqrpEnluxJQFOrQHfcFanZS6l9voQVVXSgm81sLgCFCu3U+n2wY1F6x0Koswg
         dX2Uf8X2fDIWCIes7Vq9AeL7tnCJCcmu2cOTmRq4btdLgHOZ5GHBDChllO0yOWU28d0Y
         xTH9iFdJELfY6kgX/b/SqfW9FMUlRTLbcft3LIN//0dhECaNNjR/DzUgO/3s5jOgbMKn
         Ca/+Nygcl2e+6iof2JuQD0+QAPP9uR2fs6XQTMlfh7HoJAAGFyZ01002bWsWVTGJPWj0
         VnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551005; x=1708155805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeBl8V4xziTqeBvkNb4bBS2gsfVXau2tJAbBS4r5lbM=;
        b=cbRHrsjreLhrSJ++r/K0aFlg9l4fXQ+QgX7Eer5sjFwhQ+tZierI8QavlPDIXt//0/
         4l4up4TaisHUSlMVMFT4x/3XaXqnGRTV8RRjMVQ11II4tkdlPgm/txT/7WXNYUDkioVP
         /BjqOMxImruePKKAra0d/mXywr1MVZlxCSANhb8fwSYa38qvTPDbV+TQo3GTevSv71/7
         NMycYUYPm5BJDpP6G6TCbU5vHyCyCbFd57I8fdlRmsKXNKqNBogwMgRyATexXCS1J2nH
         OCjbHTsPbGBbZbkW8rz0EBUA4jiOdvQ6h1EKZsWyyVIfBJSpm/1Xd0nrwWxFDtnc7QRq
         55bg==
X-Gm-Message-State: AOJu0YydZ+N7EBUDJ3x4Ogm8G4MK9QC+Cv0PY+Y4GMl3+boVN1tGwUc2
	j2xghB/SmTeXeIMvj0RG9C0ALbvZ2IV69RPCU79zvGjIIezaAoicikTH4PnoK9Nvyz/mASZe5Pd
	ofpYLge2M598EeydJS1wfsksoDUrKkmdvyCyPuw==
X-Google-Smtp-Source: AGHT+IFl5FcHat1JHQxNryrUO/E/1Hd3XDpn35ldMvTJDgxYyoKpvK33JNJBVWYNNocKEoxL/jwBa6CMYAQDaNVVO3w=
X-Received: by 2002:a5b:c4a:0:b0:dc6:c619:61d8 with SMTP id
 d10-20020a5b0c4a000000b00dc6c61961d8mr1423355ybr.35.1707551004854; Fri, 09
 Feb 2024 23:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com> <20240209-alice-file-v5-7-a37886783025@google.com>
In-Reply-To: <20240209-alice-file-v5-7-a37886783025@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 10 Feb 2024 01:43:14 -0600
Message-ID: <CALNs47tTTbWL3T9rk_ismPT0Bwi8Kcm5aT9k8jfPsh=1wKvrPA@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] rust: file: add `Kuid` wrapper
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

On Fri, Feb 9, 2024 at 5:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
> various operations on kuids such as equality and current_euid. It also
> lets us provide conversions from kuid into userspace values.
>
> Rust Binder needs these operations because it needs to compare kuids for
> equality, and it needs to tell userspace about the pid and uid of
> incoming transactions.
>
> To read kuids from a `struct task_struct`, you must currently use
> various #defines that perform the appropriate field access under an RCU
> read lock. Currently, we do not have a Rust wrapper for rcu_read_lock,
> which means that for this patch, there are two ways forward:
>
>  1. Inline the methods into Rust code, and use __rcu_read_lock directly
>     rather than the rcu_read_lock wrapper. This gives up lockdep for
>     these usages of RCU.
>
>  2. Wrap the various #defines in helpers and call the helpers from Rust.
>
> This patch uses the second option. One possible disadvantage of the
> second option is the possible introduction of speculation gadgets, but
> as discussed in [1], the risk appears to be acceptable.
>
> Of course, once a wrapper for rcu_read_lock is available, it is
> preferable to use that over either of the two above approaches.

Is this worth a FIXME?

> Link: https://lore.kernel.org/all/202312080947.674CD2DC7@keescook/ [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

