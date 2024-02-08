Return-Path: <linux-kernel+bounces-58267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1F84E3BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E991F24D34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D97BAE9;
	Thu,  8 Feb 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKT4NrCV"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1B7B3DF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404887; cv=none; b=bKYmrjLOeYYXYDGsB6InGeYIQi6b5rVeY5PiK4Ie4kkiRUVmrsutRVcqAFcS8WhR1otaO1gbCH8YrmDlmU2jQu1dRi5j+xv3867ZL3MbAmHUg4CM2Z6bKP/IogLjJLQlNb9Qj9i+h7k7KyYhPyMYoKTasEb7kSb7RaQcpyHzGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404887; c=relaxed/simple;
	bh=B2X73Y7KSDr68vQod+XguhQ6ZTVc/cqFBBByyo+cBs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBWRycuKf9xQdbzypvoHGhLWlsaveyOYHqx6XiKAs3SfneVEW7QiCyCb+smilKAZiTYjQpoIeW6Wu0AzGSUuxwh74GTDhZ9BT1//H551BxVMLM+WbYwWtX8TjxZrl/iKX3x8+ew/rm8/uJqyN3Gai4hW+Mcc/kiYqyCRtpRJZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKT4NrCV; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7ce4512d308so541803241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707404884; x=1708009684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaZbU6qRlbhHeLigMFgS8QR4NIPfAZTvoIj/0tP4h70=;
        b=JKT4NrCVNu3FaOn28qUwje2/2IwBjqUkvaEZiBPrX71a4Y0Gj+2xXIJJpo89D2bieO
         PQlV4bJp+RcS47y/yq9LzZv0JB33YyWwIpcpBYZN9OH97aXkyi5a5NxU+XOufNkAQFTj
         Ey93AgZcPvXmBGtTzBRiwbBBrUWjzqNeAhVmTdfa37/f8y3HGuH5QYJQKHF/7R3UYSyP
         YqGeRNjK+5eATFheGBHfNylkCTRZH75I/BA9bEtoYhJ+7PAsXF+F2DhelhuTnsA7BnoT
         gwbh5I3oKy+E9FAole3uRxuQacVyORavKp/5NP6tkMogI/k3r3UKQ6FjFYsef2INkRtL
         hFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404884; x=1708009684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaZbU6qRlbhHeLigMFgS8QR4NIPfAZTvoIj/0tP4h70=;
        b=A5HnUyxYYXzLnTaHkAqpDA2+Z61s2nEuRpp/o4yKUo3ZJvsHcwPlT90zn5mdN/shFX
         aX3UDyun/+znfc54Huh63rkY2aiIIaTnfItH3egaDUEVSnYwqNkkHw0X+BK18oBNn4l+
         79kK4SWKbO+Cgls1qtQ17MAUlOPda/JXRUsKNs23d/Evtgo1ERmdfZt4chY/gxW8Lf7P
         PRw8/7/S48hqA5KEYXDN6b0T7bBwBoMyIFS58au8JS99wMSZfC34/cW81DYXKjrkX7Qa
         ERriw+1mw592lLQNrUrVhuKrT4CSgf1N3ZV50EYUIi22DjYqD+ibRvKPAVRFtRidF3uQ
         TYyQ==
X-Gm-Message-State: AOJu0YyWqjwCGTQ+sgTSdWbZMzx9vgmt8t2MQhr2b7OyASk+KthIuYr4
	L8RDsS0L7ZLCafOFQqg7vCprYag1UmEheXi0kvC3YQH+Ps1d4VEXzqLGcASMFYGag5Kkuy2sCB4
	xPdG2E6BzjTz3ec29SMkvJ7UAkR1vxBvQoBzC
X-Google-Smtp-Source: AGHT+IHRBHGiMYdETZJWhiDfatCwp6EiPOCd1EdasWWmU96+qO4/SEihD/aYGvlNdCKSFurCtCK7GjYrAYvXLPvVOdw=
X-Received: by 2002:a05:6122:208a:b0:4b7:49f9:c6f4 with SMTP id
 i10-20020a056122208a00b004b749f9c6f4mr2534429vkd.4.1707404884308; Thu, 08 Feb
 2024 07:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
 <20240202-alice-file-v4-4-fc9c2080663b@google.com> <aa0f46bc-6bed-4a4e-9dcd-e34cc2563a37@gmail.com>
In-Reply-To: <aa0f46bc-6bed-4a4e-9dcd-e34cc2563a37@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 16:07:53 +0100
Message-ID: <CAH5fLgjSr9bbGc02gDdfFAUTyGiR__6K8qZYQNZLRe_E=Cypjw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] rust: cred: add Rust abstraction for `struct cred`
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:35=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 2/2/24 07:55, Alice Ryhl wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > Add a wrapper around `struct cred` called `Credential`, and provide
> > functionality to get the `Credential` associated with a `File`.
> >
> > Rust Binder must check the credentials of processes when they attempt t=
o
> > perform various operations, and these checks usually take a
> > `&Credential` as parameter. The security_binder_set_context_mgr functio=
n
> > would be one example. This patch is necessary to access these security_=
*
> > methods from Rust.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > [...]
> > +    /// Returns the credentials of the task that originally opened the=
 file.
> > +    pub fn cred(&self) -> &Credential {
> > +        // SAFETY: It's okay to read the `f_cred` field without synchr=
onization because `f_cred` is
> > +        // never changed after initialization of the file.
> > +        let ptr =3D unsafe { (*self.as_ptr()).f_cred };
>
>  From what I can see `file.f_cred` is valid from the moment `file` was
> initialized, worth to notice too IMO.

That's what it says?

Alice

