Return-Path: <linux-kernel+bounces-59236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDB884F39D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E08C1C240C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8720300;
	Fri,  9 Feb 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28TKxQUE"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E312E4C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475237; cv=none; b=s8v6BW76lr4dl7jWhZLxIp8VCG/c+0q0LqIfyAJk0SHbshjh6iCUl+1McqZYuQ6q+hiON+IRQ2k3p5OPbs91GcLaIjH73V616TErLcthIxufftTDRuXr224Usvvh5C+OWNya1XVnku9itl1FHvRaIyb2rUS4xo+1Z+0atwXavXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475237; c=relaxed/simple;
	bh=JChLw94N2LlI4c15ZWLrWrA258+plXDoIYh1ywZgYrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1alzma1F+GwqEUYbjHZDrlZCRVdKQJYS+Zpkwwx1pKI/3Qj/nBiwmpOoioQcKGeUo6aVTdLjSyqBvAOUVSjsNdYy9eMs2xDBf6uce7Itn3RehOweGQuSrmahnUJONxqZhYEtctK3Vmuiwu0W/noGq0uYjzOK08TnWhbhUlQvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28TKxQUE; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5c514944fso866806241.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707475235; x=1708080035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsvt0WN0Q+3QLUT9l3zysLscG0T2/IlzfGAIXHSNZh0=;
        b=28TKxQUEnoUSeX7Ww33jAHw9odiX64rKR43c4F+xgBZfcIlrq9LlCjmK4oZ7xTTWpB
         GSX+MU/OuwQDjRqj8W8SEa5OX149kVKONu9G1WyibS3s4xXlxEnfR8+NaEzY5LE5uXqz
         /yOFslBandEMXL6Fhf3WCKlqoJX9shIrW9dLBp2YAmk1FifHSJtpBMA/786Owz7hyEKe
         gA0QogTtSF+S/gOceU0Km3L++FAHKA5WIzMMcE+KliJPuAKLfB0JkKHvkxlc71glN2/D
         e6vjAa6bJhK9cdB9/h0Lljy8MmVmg+BdhUMYWCj2avhhPZolOqZWJY58x88TrtTKaX3r
         ENsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475235; x=1708080035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsvt0WN0Q+3QLUT9l3zysLscG0T2/IlzfGAIXHSNZh0=;
        b=SDqhes4beL26+asxPSeuBVdM7pTd8uhl65EBllIfiBl4P1OigNy5xs9S7BgfwTpyUx
         vB2wnVqEcJDVS7EGQ4IOersVS3RSg7tZ4LZlHLBpRz3Vl5ZHZrU9szW3Xy04wlLCIOy9
         sfS1OORxnL2o39YmtW7VKjATaRD0m0P8Ovho7d8uRAUEHRsFoFYKvw76p5GrkOa47LM+
         Pta+aeyXvCd00E5kXnHpD0Ciwh5RqsiiklgYMtHj0vO+GyujznTDsk9t45e/VSUy5I2V
         otL+4O/PZHOS85lLXlE0pWAhjFmqNQrWOVfHmRpOhUcFgwLmf1ukZVoBuRJFPr4MOlKk
         UKdQ==
X-Gm-Message-State: AOJu0Yyb91As5i3bgkgPLYcmC+QGeNOIZcPbLfxT+gpfW3yG9XmmVS1F
	xUZ4DILz8sQQaqSmNhtzLrpqP+nXBbWr2O/zTQJSX6coy/uBMQrU2Bf7CkcK9wlZOKIG3uiIh4Z
	nxOpz8T1E/MsFu4ZgXPaBl30rreb3mHlRSXq/
X-Google-Smtp-Source: AGHT+IGyJbE/oLWsC/siVXihK5czgIws1GI9FUcGNwzlxH+9vubxFLpJLPXCPZ83/8Qz0TPgrUwZqpCMEUYcw4ZCYrc=
X-Received: by 2002:a05:6102:21c2:b0:46c:f91f:b03b with SMTP id
 r2-20020a05610221c200b0046cf91fb03bmr214596vsg.13.1707475234844; Fri, 09 Feb
 2024 02:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-alice-mm-v2-3-d821250204a6@google.com> <20240208225748.12031-1-kernel@valentinobst.de>
In-Reply-To: <20240208225748.12031-1-kernel@valentinobst.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 11:40:24 +0100
Message-ID: <CAH5fLgg3C79DHz0FJ1LOhvetv4THHNAnu6XPx0vycFCb_txkfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rust: uaccess: add typed accessors for userspace pointers
To: Valentin Obst <kernel@valentinobst.de>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	arnd@arndb.de, arve@android.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:57=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> > +/// If a struct implements this trait, then it is okay to copy it byte=
-for-byte
> > +/// to userspace. This means that it should not have any padding, as p=
adding
> > +/// bytes are uninitialized. Reading uninitialized memory is not just =
undefined
> > +/// behavior, it may even lead to leaking sensitive information on the=
 stack to
> > +/// userspace.
>
> This feels a bit too restrictive to me. Isn't it okay to copy types with
> padding if it is ensured that the padding is always initialized?
>
> I recall that in C one occasionally does a `memset` for structs that are
> copied to user space. I imagine that one could have a Rust
> abstraction/macro that makes it easy to define custom types that can
> always guarantee that all padding bytes are initialized. Such types
> would then qualify for being copied to user space if all field do so as
> well.
>
> This could be a significant quality-of-life improvement for drivers
> as it can be tedious to define struct without padding.

I don't think we should go that route. For example:

let struct_1 =3D ..;
memset(&mut struct_1, 0);
let struct_2 =3D struct_1;

Even though struct_1 has its padding zeroed here, that is not the case
for struct_2. When Rust performs a typed copy/move, the padding is not
copied.

Anyway, there is a work-around. Define your struct with MaybeUninit:

// INVARIANT: All bytes always initialized.
struct MyWrapper(MaybeUninit<bindings::c_struct>);

impl Default for MyWrapper {
    fn default() -> Self {
        MyWrapper(MaybeUninit::zeroed())
    }
}

Unlike the bare struct, things wrapped in MaybeUninit always have
their padding preserved. Then, you can implement the trait for this
wrapper, since its padding is always initialized even if that is not
true for the wrapped struct.

Alice

