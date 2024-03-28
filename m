Return-Path: <linux-kernel+bounces-122935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3488FFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98A4293B90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356337F492;
	Thu, 28 Mar 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgOmWPFW"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769112D792;
	Thu, 28 Mar 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630830; cv=none; b=QeT2eL4Q9gwpkZ1InHZlazedrooRfK3xYO9y0EuNbZcrGQp/Z114/qqZ6JGbJ/uNFLB9L66uFKtkCIdP74U6z0Dr7/nQQZdKNZpDyvLOz+ML7haXuOtLzzo5EtOE/9mFwL5osLeK3PpnBQ5U18/LdV51By5aAeWC3WW7xg/CBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630830; c=relaxed/simple;
	bh=ytlDWQ3r0yK5DRXkZh2+9C09CjyHTWVJS0gSnhKeG1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuogrpNjQbyE1X9PPQdUe2nmtAiARhGD9epsyCs++uJQoDL+1hszumH0JTV37Ej4bB4RYHNwm+qlIDPD7ZxzeNxbCTGfsKIAJUAQ13m/SvMinN/4ACNSBQ/lbLessbYvBm3+JgX5Z/BeilOeHFAVAGJH7ExqP5XazG4CCIQn2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgOmWPFW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61149e50602so7254057b3.0;
        Thu, 28 Mar 2024 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711630827; x=1712235627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/AjMOT3HT8tt2clqaveH3JYtGktFT3MJvxhAn7/WUU=;
        b=EgOmWPFWrFER7QZhHz9BkULp2rvqocyUBeeNn6BomHeaaAZlogpYPjyIBTRMzPGJLN
         kV8vJlfCb/mk+vQjBFCVR9VRWUOdh0QczuLWZ8Yf9VQqbQjZiH2ERegMc+7LsT7AiKyc
         SOq9tPXjerqK2JRM2HMBAve9+XXLdFeNapdHIVyymGYEsGvfKxMEUSLJ4SKHSIY3B3rN
         B6yRbqS8OpYdsAl1K2fPPqGdfY0lqYJ7jQC/D74eYYXzmuCVxUXT2ULPFb1TJGHATWcC
         jhklbHryB5oD18cBXhttn/ZjyVrrR8BQaj6ypse10svKv1UQhMoca8QgFMLC+DYl4A7E
         ypqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711630827; x=1712235627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/AjMOT3HT8tt2clqaveH3JYtGktFT3MJvxhAn7/WUU=;
        b=Vu6zzpsplfE9Z+/Nwx3p80255uihqVKjSeWafN+tmjaYB+fxO9vYQxomwRwBcfR3ax
         u4FXujBUiWGAB0jbQ7P0fEYt5omKXGYj/pg6wOGsObsolNSiRqTNoUheUuXX2dvUjWMa
         1jxS1+Ldg5ZN7pSMHziKDGnn9RHD0R0FjCNgQdFYV3ies2eJpowqTOb2PIVLTU2B1yid
         IKCQK4ovOA2Xz4g2x1Y/djDSzHSq/MP++lmRWkjyGmnhFJJ+1jXlng9saAbmSp8HNSfW
         mZSPfbOGU1dX/HhJREIKK5gEpaRTprq13f7GD1b71cg5UZfBjnRqMnyVBe6kPO1TjMI3
         ek+A==
X-Forwarded-Encrypted: i=1; AJvYcCWi5EpqC5ssCPfvYjz8r7vOciOVWX6GXomtwxh2GzjPPXbEqa7xuYZ8SDWTUh39pXv7hfRAKe2d1hXPdhpC+aTVvY/uqDIICYb3+li/
X-Gm-Message-State: AOJu0Yx6Un4ue9oH5F+nYFtbA/zthe/u9XuLYTbdkYqZpml7s6a3u5Bp
	gKdY22PtvoXcnv2DQ8lDT/IJB1QGumAjjJV99ZPGByYrU3c8vJxFsxTY292vYWc5Sa+J2/1dF0D
	CnaqRZbBMBpYlRrzZAJukPzqbLGE=
X-Google-Smtp-Source: AGHT+IFIS1ir+HV9i+A50lcERS3uuHvos/1q6/p2/DPOxQHumrqAlPqWxS8NZtvVFTPkDZB6iPwVOPr3TTVui6ePPOE=
X-Received: by 2002:a81:47c1:0:b0:613:fb28:b694 with SMTP id
 u184-20020a8147c1000000b00613fb28b694mr1127105ywa.3.1711630827494; Thu, 28
 Mar 2024 06:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327032337.188938-1-wedsonaf@gmail.com> <20240327032337.188938-3-wedsonaf@gmail.com>
 <ffuYV4VQCfRoM7Fws9Z7TOVXS_dJp89q9--Sv9fipzWpOUqkjad5EfXsZPcBZ8ciGzrPo-U-2rEy5CUOitXNp4e4hAJHwZ0uH_u3zDxr0zE=@proton.me>
In-Reply-To: <ffuYV4VQCfRoM7Fws9Z7TOVXS_dJp89q9--Sv9fipzWpOUqkjad5EfXsZPcBZ8ciGzrPo-U-2rEy5CUOitXNp4e4hAJHwZ0uH_u3zDxr0zE=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Thu, 28 Mar 2024 10:00:16 -0300
Message-ID: <CANeycqp08CFeh4rO+b1ocGDp_nViN2uYhL6_RZ4PWn5TeVmNVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] samples: rust: add in-place initialisation sample
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 10:53, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 27.03.24 04:23, Wedson Almeida Filho wrote:
> > diff --git a/samples/rust/rust_inplace.rs b/samples/rust/rust_inplace.rs
> > new file mode 100644
> > index 000000000000..ba8d051cac56
> > --- /dev/null
> > +++ b/samples/rust/rust_inplace.rs
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Rust minimal in-place sample.
> > +
> > +use kernel::prelude::*;
> > +
> > +module! {
> > +    type: RustInPlace,
> > +    name: "rust_inplace",
> > +    author: "Rust for Linux Contributors",
> > +    description: "Rust minimal in-place sample",
> > +    license: "GPL",
> > +}
> > +
> > +#[pin_data(PinnedDrop)]
> > +struct RustInPlace {
> > +    numbers: Vec<i32>,
> > +}
> > +
> > +impl kernel::InPlaceModule for RustInPlace {
> > +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
> > +        pr_info!("Rust minimal sample (init)\n");
>
> This text needs updating.

Fixed in v2.

>
> > +        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
> > +        try_pin_init!(Self {
> > +            numbers: {
> > +                let mut numbers = Vec::new();
> > +                numbers.push(72, GFP_KERNEL)?;
> > +                numbers.push(108, GFP_KERNEL)?;
> > +                numbers.push(200, GFP_KERNEL)?;
> > +                numbers
> > +            },
> > +        })
>
> I think it might be useful to also have a field that needs pin-init, eg
> a `Mutex` or similar. What about placing the `Vec` inside of a mutex?

I'm not sure this belongs in a "minimal" example.

But I added it in v2 because we're already violating minimality with
vectors anyway. Perhaps we should later have minimal samples and
rename these to something else.

> --
> Cheers,
> Benno
>
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl PinnedDrop for RustInPlace {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        pr_info!("My numbers are {:?}\n", self.numbers);
> > +        pr_info!("Rust minimal inplace sample (exit)\n");
> > +    }
> > +}
> > --
> > 2.34.1
> >
>

