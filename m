Return-Path: <linux-kernel+bounces-61280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D985104A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2632826FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F32517C77;
	Mon, 12 Feb 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iC1o0ssq"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F017BCA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732300; cv=none; b=ZVsCdiWP8dtMyQBkgHDV5ELQVu5cdMp8WEsODT1PA3lFPjoyQZVjN4MrmwWZhqj9Z4mriHR/4l8qYhSpL2QrVts7ejqED/omNDW1Bgd9OLzo+6FTIzQkpqVSrLfVkNbVqqSjiD3njHrGkoidMM7JQGuZ5ypUS8OzfT8vG2jtM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732300; c=relaxed/simple;
	bh=ggduzU9L1RUTLLiPLM4EOtwsbNI4tWctUrmL552s1jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4IFhUAgYO0ORUkWzQYRJsHTvXbjCinoFgMGFd3WiqRVLIBLak9hIXk17Ggx1R7jaRz3+8M+JY9ea/utN9nVdkByafMzYrUZqvqMHQ12d12h+onnYim8WPoKY1jmgdnyNoGpSSHqiKyP+kqh481WJATdkC2nmtbW93cbtc1wPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iC1o0ssq; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so1735962241.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707732298; x=1708337098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggduzU9L1RUTLLiPLM4EOtwsbNI4tWctUrmL552s1jo=;
        b=iC1o0ssqIXRXXD8GfJHqXimLiw/iVWyakgdgApwtkSjSLJSZuDxmYqDVFaROpR6znS
         c9I+mwoUjARm+lO5dGG9ROKrZveRQXbxhPByIlnitJSC+nhrWs2lrhpwkpY7lqi2fqfb
         XDsODwFuZH+2GbaSbSmHiad95ciCHNekTm7rWhduAhcTxhPlK+zHLcDqGeCYgDFYgQjZ
         b321VahMNBNj65aiJxr5Hr6K/pi2SIV9bnFgqDjI9DoDe6faOrXczdkgeTo/3LxgwRNq
         NaFH5ASoeVqVYicvLcpB6zKfzJutUwT1Zd0UWXaWYGY3kky9ap6WNwUhWo705sBrzJQ1
         QmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707732298; x=1708337098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggduzU9L1RUTLLiPLM4EOtwsbNI4tWctUrmL552s1jo=;
        b=ltsT2URWLHmjxIPkUsT23gsWoijsVdobBJBB3D9tSQNNHD65/7PqppuzMt63H93kKo
         6xTdK/xaU7PErc5m/UjFwXw0bI1v3F5TGXElto4C4A+1Tm5KFj54JOH6OUvMLx5EMKIe
         eOHazgfULpNBQEqAVtBFYnBxJcCXgsy7x4pYn8lJH2LN+7MHEpVTy/ogbt4MxqQpVqAS
         fEwKkAYhKt51iZXWVkQG0AU+4/RYV14KZ8StqHL3tY3OdkfzVRiGsaAfbKjdc7ND1oeK
         /gL1xIkDLE5u7CuZJy+uCpWP5mEnw6/iLi08LG8bIauOp/A1rFUJfddK23u/tbED2gv7
         ckKA==
X-Forwarded-Encrypted: i=1; AJvYcCVX8i/dsQ/hRowTnmLapZm26PQyn6S9AbR3NSeBu4QZd46RdWg3HARqBrlvi8RNosXDZhQsftPsXzXmRoMZL4nv3lAgLBl2eIkhmi+r
X-Gm-Message-State: AOJu0YwSTJ2APuIC+meDgxnQlZXRpqjWf6f/G9tSUnLT9LW/y2LbRDvy
	bqdvTgMZmYmw+YUT1HL/PJOE7rOFsu0zTiqnfcUDbBvvLiwwOGMR86Qh6Z6EoOvQIMjpijysQoQ
	RHWRaTTFFnpmLxK8exzFKT9UFCpCt1UjefT6L
X-Google-Smtp-Source: AGHT+IEd49py4OLNX4mf5CeRvn2sftXgoKqJgVKe0kGtx19XgPRbHY6OUXT+lpg/lNJ+Ows2+YxSA63IQJz7omMeAsc=
X-Received: by 2002:a05:6102:2a59:b0:46d:61e8:46a with SMTP id
 gt25-20020a0561022a5900b0046d61e8046amr3708124vsb.28.1707732297773; Mon, 12
 Feb 2024 02:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-7-a37886783025@google.com> <CALNs47tTTbWL3T9rk_ismPT0Bwi8Kcm5aT9k8jfPsh=1wKvrPA@mail.gmail.com>
In-Reply-To: <CALNs47tTTbWL3T9rk_ismPT0Bwi8Kcm5aT9k8jfPsh=1wKvrPA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Feb 2024 11:04:47 +0100
Message-ID: <CAH5fLgj8u925_5qW3n7OBd3tPxxdy4=BR=yWvzhyLN6TT6M+dQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] rust: file: add `Kuid` wrapper
To: Trevor Gross <tmgross@umich.edu>
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

On Sat, Feb 10, 2024 at 8:43=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Fri, Feb 9, 2024 at 5:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > Of course, once a wrapper for rcu_read_lock is available, it is
> > preferable to use that over either of the two above approaches.
>
> Is this worth a FIXME?

Shrug. I think a patch to introduce rcu_read_lock would go through the
helpers as a matter of course either way. But it also doesn't hurt.

Alice

