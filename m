Return-Path: <linux-kernel+bounces-50054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAAB8473C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFFC1C22ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2461474A9;
	Fri,  2 Feb 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpJPjleQ"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FBF14690D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889389; cv=none; b=k3IiELdfLAaqcF6xjoY8OV5u5zF5La+aWLm28jfCLMkNz5RHwize2Vgcdcxh+PpVKulAkJqj67aecQGBt05RaizkviuxHOVbrnYknUBqt2JqpLpbY4QuaSoqptOfTeEF0dfMy2HU5I1bk6TaqH+1HlPzj0EpESlX0iY88XtSdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889389; c=relaxed/simple;
	bh=FNDJQ9xh+RWwPD9Nki93GLkLV+DCmLpnpSZYdhe5EYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK7OI5F8oHIfqAQNw9vGJqBNmWnw+UvNyyG2ROhNUA1iKJQPRWVyWd7jA5FaweANdlJxRR80Rf5dupnllMX+uK3zAlYwtbs639l+hHMS1uUCeF5NtQCI5mNHg9jdgkalHe6SE4eS5bLehtWVfAOWSeeFcGJGr7S/pb685fjL0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpJPjleQ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4b7fc7642fcso995577e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706889387; x=1707494187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmJR7Ww8ojzofhT9CYA10sXCxDHSnn8Gqx6UiwVGV8g=;
        b=vpJPjleQQtzxFs6XeeETAEBppD4dE7iPK/ZucSJdqHpC5yiYQcT8gXIaFBeQsA+EyW
         HkI8BKy4Zb8WtX/LC/G98S0pjVR6EfE0/uesIwcw1U5AGhBk91awjtOhrku/uDyWxq5Q
         QoBUhWnlQqp9Y/WdTTwEsL+iszr2if8jEgZyMyINv0aBKWaUkVg+VBOLpvf/1ANXjNW+
         e9vsfAqQVr0z+NQYDLUn0zhNIsz6FfxenjFqOQLdkvXLqibn58H6BpCjYv8jYcZgsdjZ
         r4U3DDjOE1OspcRn2jMHtwrno6UnrQtEHIHB+TZJlQbJx3gP5R0nhvUzamC6KeG5pktF
         dOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889387; x=1707494187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmJR7Ww8ojzofhT9CYA10sXCxDHSnn8Gqx6UiwVGV8g=;
        b=DLJ6gjSkro8qpZ0Whqmx1QXDkbnzGuegMlPRc06yXqqpOiVpxA/BDRkGg2YQwlJ83u
         tcKi0bpx8KrRXT5WJAOnqzSRFplTXpMhjtdANInvHqdmsUgdKtlUe7Zh7rxpkCGuytVR
         Ode8Q8T2BhRk8Kj4amZ4LJDeVpcGF0Z0cw7TJXKf8/0yqQD2mRH6qqA/zoZTu6bmQV6m
         CrtwnIFe0LCcoyhvDbdqr3LI1ua+yCzsd6b3mxsiAVPcKmZhG2ajdkZ6LsRJ7ErRKxvQ
         x+lPpxpz/7TIvlx5jExot76m5IIb6QL+/4kHlN52NsbOppvtLoTEB+XB7U6VfI8BjDj2
         UKgA==
X-Gm-Message-State: AOJu0YzlpdJvZrEc/csmAcH88HdzbpOLHbpHX/2qlVfSdHwVKCrTJgJo
	PEAdqhWllHuES3l4oyULLPxyU8gxOJ/n/uATLs6MzYY7+CWmTHVhZhIQDRceXn8U3l9XnVcIAJ+
	XAjNM2lHTUNP5FFDDDzv6MysnWQouQHzc58zI
X-Google-Smtp-Source: AGHT+IH2Og0a7twSwhicsL764k2gi6eQEWtu6vNVhCfq/Nv88snUC2LLMaOgyqphlIrFstt/i2vCM6+wbYKlaJvFsdQ=
X-Received: by 2002:a1f:7d05:0:b0:4b7:6c2f:fdb0 with SMTP id
 y5-20020a1f7d05000000b004b76c2ffdb0mr2486777vkc.0.1706889386687; Fri, 02 Feb
 2024 07:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
 <20240202-alice-file-v4-7-fc9c2080663b@google.com> <2024020214-concierge-rework-2ac5@gregkh>
In-Reply-To: <2024020214-concierge-rework-2ac5@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 2 Feb 2024 16:56:15 +0100
Message-ID: <CAH5fLgj=m78KdWaxzyy3YkDh3UkxczXsh_i7ekOZDjzuwe10bA@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] rust: file: add `Kuid` wrapper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 02, 2024 at 10:55:41AM +0000, Alice Ryhl wrote:
> > +    /// Returns the given task's pid in the current pid namespace.
> > +    pub fn pid_in_current_ns(&self) -> Pid {
> > +        let current =3D Task::current_raw();
> > +        // SAFETY: Calling `task_active_pid_ns` with the current task =
is always safe.
> > +        let namespace =3D unsafe { bindings::task_active_pid_ns(curren=
t) };
> > +        // SAFETY: We know that `self.0.get()` is valid by the type in=
variant, and the namespace
> > +        // pointer is not dangling since it points at this task's name=
space.
> > +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
> > +    }
>
> pids are reference counted in the kernel, how does this deal with that?
> Are they just ignored somehow?  Where is the reference count given back?

The intention is that it will be used to replicate the following line
of code from C binder:

trd->sender_pid =3D task_tgid_nr_ns(sender, task_active_pid_ns(current));

The context of this is an ioctl where the `trd` struct contains what
will be copied into userspace as the output of the ioctl. So, the pid
here is just a number that is given to userspace immediately, and
userspace can then do with it as it likes. It is true that the pid is
stale immediately, as the remote process could die and the pid could
get reused. But it is up to userspace to handle that properly. Binder
has a different mechanism than pids that userspace can use for a
trusted way of verifying credentials (see the 5th patch).

If this implementation of pid_in_current_ns actually takes a refcount
on the pid, then it is incorrect because it will leak the refcount in
that case.

Alice

