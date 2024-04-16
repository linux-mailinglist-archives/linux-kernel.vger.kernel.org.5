Return-Path: <linux-kernel+bounces-147330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB08A729C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD681F21C45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06EB1339B1;
	Tue, 16 Apr 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="eUDKjTlB"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E217FC1F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289691; cv=none; b=cClQ2hxpDJ2sx/ED1RuP1Sv7QqE7QajZBpV5HOwSMng+zsAHHbYnToKZ5Nr1+NyUcfMSKXedGlIwx0q74jDtBzLzyrhFijTDqqMmjya73PEw6d4vn5taUmC3Lp3vY9qPYOZVnNP/+ChO8kZNKYgyE1/Xo24e39u8trSxswl4oYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289691; c=relaxed/simple;
	bh=CFLPbaTqHgy35LCkZ8/WIR4fdR8dupvDJeKom1cb3Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+08vVsPOnt/WUF45H7Z+uzmzQLxfbowlYAIv40q90rP1RGWnhJMw8KkNNxmJK8QtNPL6a1mb+9p+VtZ0k3AEo6aMiPsRQj/aYo3bBgtDukOoAjS1MCMTX1MOWLseezMash+X4DFBiJPQ7ZmX7pX8fUDdj7SXmXnpGKqcPE4LXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=eUDKjTlB; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4636369276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713289688; x=1713894488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgxo59IYhnHPL9WU4YKhZaxzeo3fMP1MrECdS5RGdv8=;
        b=eUDKjTlBT29qfAlDcoUy2U1r+7cY8RglJ/6AU7pb+GfackqEn8tjBT63fCwXj8r6ph
         vIHzVswQ1aD1xiHv3jXV5FyJALVltYXvFK8pgG/Ym5HtTIZHS++PW5hZah87Wml7yFqC
         b+ai5iO//SnTNatl1C9pDoSOlvT+H28FDhW0HH5ET4iHKkgFrg8EtXaQdyCG4Brk0rVw
         GGlB04Mij1r/0jNX2/DBE3PYmw5kSLimADJz4MjfJkwumGoGhb7HiAHFI+oih90oPeDW
         h9EkLvDAH3lmGV09U8//u6YmLnZk6eWYVlgDGIge1PQ0xs8gv8whaCKZ5MbPaI6SKCEb
         Kx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289688; x=1713894488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgxo59IYhnHPL9WU4YKhZaxzeo3fMP1MrECdS5RGdv8=;
        b=dDMzyS1AVRLKBTCj4BkBV2DDxcyJbTqZV1a5iKhAJ6AowkZxKn14xmYZBOYEgYzxvL
         sXHZedbEWjb0Ze/JHI6dENMEBJujuR/ir7Z6ziqRG6AooZbOci6EV+64Kfq2zSUwII9d
         aneMwCBOL85j+qiS8IIVlifBFEqwbZovvNzjk3zAT28uv2SHIOl8ePIGos6qLVsCNxZm
         AIR7h9sqpFftVgN9Sl7iS/MoUbWXcuGQlfU3Yzc17uYDrK6v8Bpeyxd6rDyxVBMzB+R+
         IRK+vrkCb9yi79W+76SO+uSTcu8H0hwlsXRdTRPS5/0znQfIdNMxE3hSugtzkZjwrTAx
         LdSg==
X-Forwarded-Encrypted: i=1; AJvYcCWIIcd+/eRwf4gd9MiIvwVkpWgMhQJgg2apodSDZc+1pqzMmrXrrwB5JzHvDxnpbbCv+lvzp0Xypl3NnQGwTM96/L3oM4B3v1WVVxf5
X-Gm-Message-State: AOJu0YzxwBlOstkOtNMayTgpNOFjuQ1smtV76CEXOdRcsdWPwJ4u17Os
	CoBhFj465yHB8+q0HKmbu+5G0nlxVnWHtkvnKYaviYW2E1xIgkhAg/UXA1aTU7R36ZmGkLbBsXL
	mVp5HZaWwZIYGSahbQvgzLOKIoeY5x54bvDuhYg==
X-Google-Smtp-Source: AGHT+IFEcewgx6K0H5JoHC0s7S4uCrcrKg0tuesPZ6/XjGUTZZkpFY+pctxrZr4MfL7ku3gK9QgVdIyhlEaUIc8tLro=
X-Received: by 2002:a25:2f0f:0:b0:de0:d728:1b21 with SMTP id
 v15-20020a252f0f000000b00de0d7281b21mr10940224ybv.54.1713289688081; Tue, 16
 Apr 2024 10:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALNs47tEZqL201jsExfF1j7m+yW37YRAws-NTF6hwsxohSKoQA@mail.gmail.com>
 <20240416095333.1108884-1-aliceryhl@google.com>
In-Reply-To: <20240416095333.1108884-1-aliceryhl@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 16 Apr 2024 13:47:56 -0400
Message-ID: <CALNs47vUXA9z8+bM4TOU-Q_NY3wbux3OA4nBVxegAWykzTd2zQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] rust: add abstraction for `struct page`
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	arnd@arndb.de, arve@android.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:53=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> >> +/// Flags for the "get free page" function that underlies all memory =
allocations.
> >> +pub mod flags {
> >> +    /// gfp flags.
> >
> > Uppercase acronym, maybe with a description:
> >
> >     GFP (Get Free Page) flags.
> >
> >> +    #[allow(non_camel_case_types)]
> >> +    pub type gfp_t =3D bindings::gfp_t;
> >
> > Why not GfpFlags, do we do this elsewhere?
> >
> >> +    /// `GFP_KERNEL` is typical for kernel-internal allocations. The =
caller requires `ZONE_NORMAL`
> >> +    /// or a lower zone for direct access but can direct reclaim.
> >> +    pub const GFP_KERNEL: gfp_t =3D bindings::GFP_KERNEL;
> >> +    /// `GFP_ZERO` returns a zeroed page on success.
> >> +    pub const __GFP_ZERO: gfp_t =3D bindings::__GFP_ZERO;
> >> +    /// `GFP_HIGHMEM` indicates that the allocated memory may be loca=
ted in high memory.
> >> +    pub const __GFP_HIGHMEM: gfp_t =3D bindings::__GFP_HIGHMEM;
> >
> > It feels a bit weird to have dunder constants on the rust side that
> > aren't also `#[doc(hidden)]` or just nonpublic. Makes me think they
> > are an implementation detail or not really meant to be used - could
> > you update the docs if this is the case?
>
> All of this is going away in the next version because it will be based
> on [1], which defines the gfp flags type for us.
>
> [1]: https://lore.kernel.org/rust-for-linux/20240328013603.206764-1-wedso=
naf@gmail.com/

Great, thanks for the link.

> > Could you add an example of how to use this correctly?
>
> This is a private function, you're not supposed to use it directly.
> Anyone who is modifying this file directly can look at the existing
> users for examples.

Ah you're right, missed this bit.

Thanks for the followup.

Trevor

