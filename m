Return-Path: <linux-kernel+bounces-74657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B020C85D75A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D35D1F23775
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A247F7A;
	Wed, 21 Feb 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/tiHVVf"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31947A5D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516059; cv=none; b=VM5IEMjpOTXtecuFGvykDVZJS44thPzv6BJGze+4unwN4SV4mZ3wAOWLdVpPXzy3WiaFIb/O6bjrlFaBSdJ1R7StGB/BbVlWdurZyjOlm6apIFOruWy7Psai1hQaILuWTmpjHuhciGGYaxeuglu+xcSUukmwc/+3Zj3zFdDYGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516059; c=relaxed/simple;
	bh=vRt/FdxzDOQ4l3rxiit+Wes79HUFmm1mgOJQtV+4Bcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccaKOQZLCMURvUaexZ9es0OSn6lDhR2B+80bbrF0FuUpqR49rMMckTKXTyaJ/qXmWqmZ5uRtlU7MqHVXgJuy4pBFqcohy8V10T81WrRoe6nUG3oOTgNIJCX0FBYOdu04OmqD1r6Xvft+sqvTsuAX7o51aObfGzfu7C5TKzGtLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/tiHVVf; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so247299241.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708516049; x=1709120849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyovQl5iGkP+14IRCuKTQAaTQ48NTlw9CloKE2arYCM=;
        b=T/tiHVVfCLOxXrj6ZM5mdpGBEX4GAZrjjqLFx7iK0UI6fGTJ/ppU7LQFvKvDV+wE5s
         QiFhPiKEgYya/tJRt48lGp4H1xr6gYQt7CxoZVAX+Tv5g22/bPGk8TuILoPMSFFX/tgv
         s1fBeV8MbnM3NN+AHADQPS9hY3bznH0hEjl9DSFMoYAjnW2f2DjdpMRX16Th4Ue7V3Ad
         5tE1r/rhIBv8VVMXTBcSkXJUrSC+51hcIZFL+0ZfecK3B9SYT2AspBjiY0cTLB8Rr2i2
         FYd8r9A0rl8WikK8JipBA5aBfimNVLLNF1pqiKO1SkxeB+W9BCN/bzCu4cej0XOkqrqi
         CWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708516049; x=1709120849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyovQl5iGkP+14IRCuKTQAaTQ48NTlw9CloKE2arYCM=;
        b=Ouo9x7/5XYbFZm7fhinrOVqhW16YBLGZ/sAEodaMsk6C0oIH/yUTeBdfyW8Hzxwvuz
         RQLj5hAkLyPR0cpXiGvqB2uE/kA+TZzlmKiUp3QeRyWAfQ7qQHv1CTdHDnaVVOc9jHjH
         KYMQQx7VOc0QxhOfxWXckXjfC26rphI536Fa4hqSwlXgwcli3tFz1AG7S998CsB2y+Rj
         Vewh4uK+Id+0VU3qapP2O0I94yeIwGLo+FA4WXe985KjfwTP4N7y+vznCws4cEnlvqL0
         xKyVR9A62EOq6K037DGFY8Ir/BoPOVBidqfm/zFEJKjXWtiWtRrkmk4qyK7D/mU12OQh
         zenQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVLDFpbvDj04WqYTal8vfsG5EgjdEZ4NLns21cpzZwx+QbdEkTXYLT1Wl0RH4y8rBnlbCjWy4c/c5rR0i4JxCzWd1GUOkBs5k8d21p
X-Gm-Message-State: AOJu0YwZSn9dm575Zd+xWB6yZu2yxdp/uuiED5Z0Rvy6qa3ehCbl+tEx
	+EEN7uQAFk4q/J1CmqxnkAh88BSaN/8/DHE4W2yGlRDdlm98cxcM+ZeE8+n8rd/Bl7z87xTUzye
	BW4DQ3ofKqaAZlgnG3SELu0C/rhqBQZ+F6Arq
X-Google-Smtp-Source: AGHT+IFREF8kvbTfb7FArPLNxdynrye+E4NyVJO79v3NLR63gQtBpIS8c78KubOOLkY7m7sLG2Vnzy1bZof20xJryj8=
X-Received: by 2002:a67:ee08:0:b0:470:a138:78f2 with SMTP id
 f8-20020a67ee08000000b00470a13878f2mr1527074vsp.4.1708516048942; Wed, 21 Feb
 2024 03:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com> <20240208-alice-mm-v2-1-d821250204a6@google.com>
In-Reply-To: <20240208-alice-mm-v2-1-d821250204a6@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 21 Feb 2024 12:47:18 +0100
Message-ID: <CAH5fLgj--WrkLJLG69P59mxBjZvMqTMHjVCcbk3Q4z7ZFTeTRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] rust: uaccess: add userspace pointers
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 4:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> +    /// Reads the entirety of the user slice, appending it to the end of=
 the
> +    /// provided buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.
> +    pub fn read_all(mut self, buf: &mut Vec<u8>) -> Result<()> {
> +        buf.try_reserve(self.length)?;
> +
> +        // SAFETY: The call to `try_reserve` was successful, so the spar=
e
> +        // capacity is at least `self.length` bytes long.
> +        unsafe { self.read_raw(buf.spare_capacity_mut().as_mut_ptr().cas=
t(), self.length)? };
> +
> +        // SAFETY: Since the call to `read_raw` was successful, so the n=
ext
> +        // `len` bytes of the vector have been initialized.
> +        unsafe { buf.set_len(buf.len() + self.length) };
> +        Ok(())
> +    }

There's a bug here, since read_raw changes self.length. It will be
fixed in the next version.

Alice

