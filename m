Return-Path: <linux-kernel+bounces-43187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FB840D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82A928CAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF515B964;
	Mon, 29 Jan 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="On+uWy0v"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975615B308
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548121; cv=none; b=uGh54s1MOpC0L+LxxjfQC7I2fh8nP3Eu93J2acGjV8YR7Mupup9ZpCWtq/vua8FXJybPK0xEnuAKklAlcXlabcR0ZH9cZH1awBYjSz4Z/j/nUj3pWkI866M2Ii69vGAzYv1qBxIhqf7aUPv360UPywrKuhRGNX1Ca4oQ0FkN7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548121; c=relaxed/simple;
	bh=UFA2sbZ3Uszgy+yX9T1/72+bJwfqcVAD5CapdxRxgN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0boYOChQdIEGFXKdA4Y2ywBdBr9OAa4EsxC45x1hmQdMcnlok5BeuPY6wmRGdDctqr8OWUHpMFua+CUNVcbB6BPjAFiOu2xzGfjKRrCC8s6w0FqQmDGw/aYqs9Dd7fM9Eit/OqOcgzVYCQNWkfrEn+QSvYQYCBDLrnbQCEOe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=On+uWy0v; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2a78c49d1so1733939241.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706548118; x=1707152918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EytCfCt7Mdn+cYY/W3p5gw2x+cwVqNDRPkfT5+zTUNI=;
        b=On+uWy0vOWV6oVVgcSwFa0WMil8Hqocjk50nCrwJRtMSPGPvQ0Mm7NoGZ42WFprNDn
         n6wT3QBFwFFvoGCVwqt0QTEQO33zIyvvYbAt9BmiZrCghYbF0CumaGv9Mbk/fI3/ZNCN
         9IZK2+tavJf4L9tam7xxEWheZ/uvu5SjuqA0s+wCIWy8Vpb5B7GoAddBr2qD8cWPmGa+
         yj/6yYmxfeDTSpuy3Mg0q2zx5kzQSPXS80VgHm4BkMCOM5Z646JAS4nHBmdt9BuwRKFX
         ug5lliiZHy0WALv2FJFgiarlw3CF6i5FClmblQkcs+KvKOaSRZ16M3KHV+ucoxhE3KkF
         RS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706548118; x=1707152918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EytCfCt7Mdn+cYY/W3p5gw2x+cwVqNDRPkfT5+zTUNI=;
        b=WbksMhg0k0r+fBK6aRsjadZDexL2MLm6P5XRxcS/oC0GHp1LBrUo5Kqul8uArLOwnk
         RmahVzW8+kz3+hVlv1EofL85iqJCELzJXwZwbbeyKj/wCxYouvnsp0c+MNIsNWxaSPFP
         iZQ7V9HbrZ+Aej3C1JXeqXQfzz/R/n9hGV3A0vXdDAvmnWke3adxltnDAMsvZOTEt3UM
         mdKhIR1cn9hPrkCJfVPPUVMuzhpUCqGTkyNzFNnyXRB9jPU6Pq0HJ7MQ299blwAobeEB
         r7nuGUUAs8u6Ibf544lHDh5yRvUfvPdTJ5YyFFeoOP7zGeKIIkd8shUkCLYFjX8F0fY5
         Cmvg==
X-Gm-Message-State: AOJu0YwSf+vphvIUTEpevTY+3meCGq5FIzGy1LKlIEnyfMwiAXDrUo6P
	iSRJVzb95KOVTVsQochaFjXeM9ugfGelAs2WMb+V5+GfvWV3QGXz8vl4khTBf7Xq6nV4cVpJKcN
	FdO3xGEtyPLktsK7yJbU5jCEVAC3RK0aRX4AB
X-Google-Smtp-Source: AGHT+IF9Cu5QQ8w4oZJwiWiMcHW4RaXyLjrg31UTRbHFnVHAFPnrShgJD92nkJB3pF4cIqhqy+YlGQA7E/cQ25bGa4E=
X-Received: by 2002:a05:6122:1799:b0:4b7:57a4:1238 with SMTP id
 o25-20020a056122179900b004b757a41238mr3247799vkf.14.1706548118338; Mon, 29
 Jan 2024 09:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
 <20240118-alice-file-v3-9-9694b6f9580c@google.com> <1ac11c65-7024-41c3-a788-cfcad8fb6c55@proton.me>
In-Reply-To: <1ac11c65-7024-41c3-a788-cfcad8fb6c55@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 29 Jan 2024 18:08:27 +0100
Message-ID: <CAH5fLgjMvh65PXdxnkPAtxNH82UDAwtyXmPK+VJPFTtXfiN2JQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] rust: file: add abstraction for `poll_table`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:11=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 18.01.24 15:36, Alice Ryhl wrote:
> > +/// Wraps the kernel's `struct poll_table`.
> > +///
> > +/// # Invariants
> > +///
> > +/// This struct contains a valid `struct poll_table`.
> > +///
> > +/// For a `struct poll_table` to be valid, its `_qproc` function must =
follow the safety
> > +/// requirements of `_qproc` functions. It must ensure that when the w=
aiter is removed and a rcu
>
> The first sentence sounds a bit weird, what is meant by `_qproc` function=
s?
> Do you have a link to where that is defined? Or is the whole definition t=
he
> next sentence?

Yeah. Does this wording work better for you?

/// For a `struct poll_table` to be valid, its `_qproc` function must
follow the safety
/// requirements of `_qproc` functions:
///
/// * The `_qproc` function is given permission to enqueue a waiter to
the provided `poll_table`
///   during the call. Once the waiter is removed and an rcu grace
period has passed, it must no
///   longer access the `wait_queue_head`.

Alice

