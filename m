Return-Path: <linux-kernel+bounces-47902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDC845455
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124381C26E09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9620F1;
	Thu,  1 Feb 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/oudCBY"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409E4D9F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780532; cv=none; b=LO4S403vJdv6btWLBJZe4jUR52HCFDvF/7y+xYwxkHLcJ/z3vgRNHB5+ioT6sbgmjvNP/AXrk8Y3xvFfpmdQIgTolxMDpntG87B77Ds0lJ9d7ZkINzqXxKtzeaUUNAq2tipGE2eD/q17EdRlqQom8Nt/oN4lpGiMTW0vpeJsIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780532; c=relaxed/simple;
	bh=RI/xh3KG3rWCEcP4eS2L4B9Piqu6OhdAZcUZ2rjfAy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MspgXRLdFGO43c2XEalwFLcd7eGBc5gzRjFeaLDeP6aTS5/i1jVfC6AC600rprotyRA1myE+K2RjWZ+Ur6G5GFFAlrgmRGCyUVQAcJYQ3eoPlLtLMQeyrFseoWBE+/dCRcAKMdIzDO2cd+oQCsiDwbVWxNX4M/BmSbhb26uxE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/oudCBY; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4bda1df7e35so250867e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706780529; x=1707385329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuPOrdCb6HbBTgaqgsjDT3E2Mco217B1+thjHRyFhms=;
        b=c/oudCBYQbUpkiq2xbEoIFZdtO6CjG5l7EZOxx8GbJZPDYmDjqittyLjIzjtDCDKia
         aKyX4ngVa72r7TZyqCpQ2JSmV7OYyFqAblW05k2+TtYFEPU+99UENoinKatd1ZrVOghn
         +TVSCg9dEIshG7zYSAhiaxn56jnTa4Xi2cehRRYJAIwzSCN2BZIkqpK3jmPnsMlToIHX
         fWQeedSw6+SapD4igDYIvEIvKI2wLrGsXz8dnQZJinWliV8x3uAOO3MWIFxvO14RZPMF
         RX73ekI5dHT//VGI6D9+3S6vKdatSYQLNyYEgwlGsu2UuVBOohST9FV6vV+JQ0fz9XWS
         Otyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780529; x=1707385329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuPOrdCb6HbBTgaqgsjDT3E2Mco217B1+thjHRyFhms=;
        b=PWUvXD0h/hzkARET16ndvy96cFpH50QEhRuR1HSv7dmGL5k43gQfBdW9Yc0A9EbB4m
         Al9UBykjlIl0ezSbugZQAf6deI5jzxf6Zn2R9ZZJhDxblVbWVFyKBI7XGkD9ch9ZAEoM
         sQoJ/mGsAb4fECRCeQcXv/970T2VO3TLaSMDJn9dNRxyuBlYWE01DCIvnBvSJlwxANtE
         Tt0uSx1hPuXYBgnJyyp91rt70gOr2PKGqIjzGi4KS6ToyrAlYB+XUv1GuG6lKQPvLaWE
         LvDbAO0qpLKoBsZzaxdkdm7SEuLQ6y05Hoi9fX7jbhOtbKp7/6DWc+718+GWOv+yL4VU
         ARRw==
X-Gm-Message-State: AOJu0Yx8agp3rwUyaIEsR2Ef99SNVjxXS3uKkDruEd57NiuJDGsYLmeq
	W7bt+lasPd1ycvpDOgeQ/32nOEjnXgJrbKQHBNSY0P8uj6VMREAoFs01KShc4LFb+FOcKI1d/I+
	oKNbeQf/nKCCGedYvWSkQJ539In+tq+rEdc5e
X-Google-Smtp-Source: AGHT+IECDgqCaXC3D95Pns2tEui0S4X58vEeWJ4hsISY8qGpjuY6uBTkGlgBNB8UM/Un2o8+WkkkZboJRfYbLKHc2+8=
X-Received: by 2002:a05:6122:4085:b0:4bd:9cbc:a5d7 with SMTP id
 cb5-20020a056122408500b004bd9cbca5d7mr4603391vkb.13.1706780529128; Thu, 01
 Feb 2024 01:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
 <20240118-alice-file-v3-1-9694b6f9580c@google.com> <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me>
 <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com>
 <84850d04-c1cb-460d-bc4e-d5032489da0d@proton.me> <CAH5fLgioyr7NsX+-VSwbpQZtm2u9gFmSF8URHGzdSWEruRRrSQ@mail.gmail.com>
 <38afc0bb-8874-4847-9b44-ea929880a9ba@proton.me>
In-Reply-To: <38afc0bb-8874-4847-9b44-ea929880a9ba@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Feb 2024 10:41:58 +0100
Message-ID: <CAH5fLghQAn5JYeeG0MDO-acwQHdX7CTkr_-5SzGOzrdFs2SfNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
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

On Thu, Feb 1, 2024 at 10:38=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 01.02.24 10:33, Alice Ryhl wrote:
> > On Thu, Feb 1, 2024 at 10:31=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On 29.01.24 17:34, Alice Ryhl wrote:
> >>> On Fri, Jan 26, 2024 at 4:04=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> >>>>> +///   closed.
> >>>>> +/// * A light refcount must be dropped before returning to userspa=
ce.
> >>>>> +#[repr(transparent)]
> >>>>> +pub struct File(Opaque<bindings::file>);
> >>>>> +
> >>>>> +// SAFETY: By design, the only way to access a `File` is via an im=
mutable reference or an `ARef`.
> >>>>> +// This means that the only situation in which a `File` can be acc=
essed mutably is when the
> >>>>> +// refcount drops to zero and the destructor runs. It is safe for =
that to happen on any thread, so
> >>>>> +// it is ok for this type to be `Send`.
> >>>>
> >>>> Technically, `drop` is never called for `File`, since it is only use=
d
> >>>> via `ARef<File>` which calls `dec_ref` instead. Also since it only c=
ontains
> >>>> an `Opaque`, dropping it is a noop.
> >>>> But what does `Send` mean for this type? Since it is used together w=
ith
> >>>> `ARef`, being `Send` means that `File::dec_ref` can be called from a=
ny
> >>>> thread. I think we are missing this as a safety requirement on
> >>>> `AlwaysRefCounted`, do you agree?
> >>>> I think the safety justification here could be (with the requirement=
 added
> >>>> to `AlwaysRefCounted`):
> >>>>
> >>>>        SAFETY:
> >>>>        - `File::drop` can be called from any thread.
> >>>>        - `File::dec_ref` can be called from any thread.
> >>>
> >>> This wording was taken from rust/kernel/task.rs. I think it's out of
> >>> scope to reword it.
> >>
> >> Rewording the safety docs on `AlwaysRefCounted`, yes that is out of sc=
ope,
> >> I was just checking if you agree that the current wording is incomplet=
e.
> >
> > That's not what I meant. The wording of this safety comment is
> > identical to the wording in other existing safety comments in the
> > kernel, such as e.g. the one for `impl Send for Task`.
>
> Ah I see. But I still think changing it is better, since it would only ge=
t
> shorter. The comment on `Task` can be fixed later.
> Or do you want to keep consistency here? Because I would prefer to make
> this right and then change `Task` later.

What would you like me to change it to?

For example:
// SAFETY: It is okay to send references to a File across thread boundaries=
.

Alice

