Return-Path: <linux-kernel+bounces-47884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185E84541F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49861F2A94C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176AB15D5B0;
	Thu,  1 Feb 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqmvH/WL"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12AD15D5C2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780011; cv=none; b=MYsPmVLZ/1cm2DqN4scIzqJkG/Mt6xlXNPUJievAo+/wG+tPHPnJfszd2iIPEDNV33bKS/lvt/85UgGlbwmWMEaN51n4Bs3MfyB4QKdx04cm3IdWwME5vcCwfcg8DoUsNdhwpSTaxZP/N+OJxry12APIGF6nCJ/NUxthFa5+3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780011; c=relaxed/simple;
	bh=YLiuwzxJK7z4LnYgttvR2Sapn5bCDOX4mzVFpvVjXmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvGOySnk7M/yAnLdk7D9I0XnAe7Ri4UJetB4LyzVrVjyRAheDNVcaR2jKl31m9EQ8riH263n11KkziULVmA3HFVpo4R36wt6cXOYzav71b3+LZr1AUMemmyIHFuWMZei6xwC0UA6zXiUk+SGrXCd7rGuTcfMcv2t7F7TY2BfBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqmvH/WL; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d6275d7d4dso161331241.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706780008; x=1707384808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql4C5VbwVafB+HuiCeKv/ZB0OwAPB3Y+qFC6HwShTwY=;
        b=rqmvH/WLCsQIhWZhL/bRkkndq4aN4muZngCEt8ASRkRVJ/IgSRN6KNjdmsZAa6Fm0N
         GzRCeUdezedOe7FnIXf+SBPEusRia+9WPNdKbR4jRYreif+1C45VtjwFvpm53uWsDhet
         LQ4DSGd/bDR0CkoaSZ6lfsxTVGvgnHEOxCnTZpIx17969cKp4+ozHyF/Q25hoWeEgRR0
         L0WjDYRP3ttIKvgaHkws6BTB5wNt9mrX3VwuTgLP2fMdJNOgk8t2a60vAKGpHtzfa6xF
         tlvD0Mw6S/b9op1CMvBDxfyRPfU/CHblmTnTuuPvd+9z6L/tDCRNVfaAlptLGG0EtuYQ
         FJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780008; x=1707384808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql4C5VbwVafB+HuiCeKv/ZB0OwAPB3Y+qFC6HwShTwY=;
        b=G7B3NGcEPN7z5lf4jUGAwA9kN2x6J9OW6JZ/1o1jia/Vk+yr4nTetj34tIj5JIUKp9
         YmvzOf0ZFD3uMjWftR+tjuLZiXsFtPMJFC+n4+odeM785boTmluvFP71yRanTWyeRKLq
         ELmqsbRf8j7oI5XMMTDaYL/sDU2TSkMxMnEE/d/J5B/PvlkPhfSRb+t83QyiRhpRI5yI
         JKyqKiu1KWx+GPEtY9L8pw4vF8myEjpmWJtZzGFBlE9GiO8zLzrpmPqK0rkUKoSCJ2fn
         1K3fdgu/WjHxoKqSbDwmdhxeS12NOmCPwukxHvZNMDcsdEZYwUmHQ9hKVInfk7vymKEL
         L3KQ==
X-Gm-Message-State: AOJu0YwAwAjWofcdbgwhUqia8qjw8Qd0txjEGoja9zgmJFutM88AC36y
	cN+GAbVpWxbr65FZCAWbkCZcsk+xYPyWBROntGggf4r1vqoDEZ3HuhFv9XsvWpvb7w85+wTkR6s
	sV3S2dYsAfX2q1hxqsZ8WYoVfu07i35bIkqE7
X-Google-Smtp-Source: AGHT+IHj7VQQODUtt8W233cgecG5pRHU950m/YrPbX/8p8zsdkQm+M41oUqBJNRvDqpTEesJYRB6/NjUo6U3PL68imc=
X-Received: by 2002:a05:6122:368e:b0:4b7:8d7c:346f with SMTP id
 ec14-20020a056122368e00b004b78d7c346fmr3589907vkb.9.1706780008274; Thu, 01
 Feb 2024 01:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
 <20240118-alice-file-v3-1-9694b6f9580c@google.com> <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me>
 <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com> <84850d04-c1cb-460d-bc4e-d5032489da0d@proton.me>
In-Reply-To: <84850d04-c1cb-460d-bc4e-d5032489da0d@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Feb 2024 10:33:17 +0100
Message-ID: <CAH5fLgioyr7NsX+-VSwbpQZtm2u9gFmSF8URHGzdSWEruRRrSQ@mail.gmail.com>
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

On Thu, Feb 1, 2024 at 10:31=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 29.01.24 17:34, Alice Ryhl wrote:
> > On Fri, Jan 26, 2024 at 4:04=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>> +///   closed.
> >>> +/// * A light refcount must be dropped before returning to userspace=
.
> >>> +#[repr(transparent)]
> >>> +pub struct File(Opaque<bindings::file>);
> >>> +
> >>> +// SAFETY: By design, the only way to access a `File` is via an immu=
table reference or an `ARef`.
> >>> +// This means that the only situation in which a `File` can be acces=
sed mutably is when the
> >>> +// refcount drops to zero and the destructor runs. It is safe for th=
at to happen on any thread, so
> >>> +// it is ok for this type to be `Send`.
> >>
> >> Technically, `drop` is never called for `File`, since it is only used
> >> via `ARef<File>` which calls `dec_ref` instead. Also since it only con=
tains
> >> an `Opaque`, dropping it is a noop.
> >> But what does `Send` mean for this type? Since it is used together wit=
h
> >> `ARef`, being `Send` means that `File::dec_ref` can be called from any
> >> thread. I think we are missing this as a safety requirement on
> >> `AlwaysRefCounted`, do you agree?
> >> I think the safety justification here could be (with the requirement a=
dded
> >> to `AlwaysRefCounted`):
> >>
> >>       SAFETY:
> >>       - `File::drop` can be called from any thread.
> >>       - `File::dec_ref` can be called from any thread.
> >
> > This wording was taken from rust/kernel/task.rs. I think it's out of
> > scope to reword it.
>
> Rewording the safety docs on `AlwaysRefCounted`, yes that is out of scope=
,
> I was just checking if you agree that the current wording is incomplete.

That's not what I meant. The wording of this safety comment is
identical to the wording in other existing safety comments in the
kernel, such as e.g. the one for `impl Send for Task`.

> > Besides, it says "destructor runs", not "drop runs". The destructor
> > can be interpreted to mean the right thing for ARef.
>
> To me "destructor runs" and "drop runs" are synonyms.
>
> > The right safety comment would probably be that dec_ref can be called
> > from any thread.
>
> Yes and no, I would prefer if you could remove the "By design, ..."
> part and only focus on `dec_ref` being callable from any thread and
> it being ok to send a `File` to a different thread.

