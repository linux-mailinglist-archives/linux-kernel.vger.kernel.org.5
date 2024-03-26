Return-Path: <linux-kernel+bounces-118202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2089488B67C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25F8B2B192
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED16F7F6;
	Tue, 26 Mar 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqOXG6N2"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B55179;
	Tue, 26 Mar 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411510; cv=none; b=f8JBONhyrkyyZbJeBdlhEKzEI1ax9eIciwAGxqbVehnGCuYLlFArNlFpLU53guzTCwqh5qfMuYPJH2rnd95ASWdzuIOyfvpy7vra8oMyGyIj+0ocdVLBg3bc/T5ebRpb8B3MSqFXGtpv9R3qa97P6nvJTRc1EIeZQuAY/9983Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411510; c=relaxed/simple;
	bh=Bh9rhEHh+i+R9OCvZo236WB4vh/unExdet3tkRvNCkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slSj5hPH6KohOwEPK4YOukR1QhKMM4MIQP1zB+q8D2i3uA7naOSbBzi1TPVVpTJWLnqvTn/RfFkIXw05WKKCfQtVybtH9RN8foQQi0umXqRITVKWExleA9+gDn5OkRGBtddT7mfH5KHoKMSamsXzg+9QyF3Qm36fhO+gsPYurKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqOXG6N2; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a3c48e70fso51213517b3.1;
        Mon, 25 Mar 2024 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711411507; x=1712016307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N14+Wldzr0J09GVr7zg7jWLb5e4Mzxk52YZUPWcSUiI=;
        b=MqOXG6N2eFsdFv7O56/fOG0wx+HjCaH2hUoJ5trYyT+00iVjIoeKT3imV5aR7OaZwA
         BC6YMZflLixqDlO4O/s8HzuUt0wNwn2RX4S9v7NLtv+lWS1J2JUEa8ru+vjjr9sjqwRn
         eQVa28INMsPka7hHKAmPhm7g3TJgFrkleEHjzVEcAf6sojc6UEhDutOTwlRQ42XzhFHV
         1Ljh2Hhqq3AuiLPngoqfl0o/cAayaNaUO2oMiGKPr948Tfe+AEptOJO2CiUQ8Zph20Py
         wZ+dld3JiVix/kqcU4eMXu0rk/dp42hwZ0PSEkI7CWFzOD0/rWKEZA7st/JF/ticGraQ
         ySLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711411507; x=1712016307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N14+Wldzr0J09GVr7zg7jWLb5e4Mzxk52YZUPWcSUiI=;
        b=tl2A0vbpUt+FC0eKx0Rm1WJ68B111FGaE/5jaNyhFjb/phu1/Al+QOCpWZoBk8ZYfL
         fG/sScZ8bGYycUOOy1yGk3TJNoxEYoYJqSOTtr3MBn+CmjQdI4DaFF8nbJjhdSh824gL
         JtAQvg2ofe70p1q7WfLVR/VpvxJ+8zd44NBDraVX6CRTKBp4NLh8+QfGb6+UoaRWh5Gd
         ODVPgunxpXOOxSt3COZAm8Rw3vao5ZJC/ChTA0FRx/wLYA0X6jc+jMBFsVwaaAAClyus
         ZQEGNMtij2emuXXlP5rUa9s5lEf3qVI/cV1f66GnAGnuGx3IrnpyLRazOL0idIF/aiQq
         Pc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7BbaiHljjNdAMZfyBYxnqCMZxX2X/elLa2j7X5vCLgLV8w9Tjlff8MXkwTdmkRAwTllpV9maC1RrsP/6qozsIVMdPFfo/NyEvQ+VX
X-Gm-Message-State: AOJu0YznaZQ3LDcBlgdk4QpPyldzpjvWOYI0yNbFhnwby8eYbPd0OjXw
	YNMV3qdDSWHn0tNKzXaC7neHMgwn99jFCeVh6ftJGp5cDpqFEq/fpwrXCy9P4MhVaDErbyws+00
	rT9VZEp4PoQZrlgkeAvluruWGtMM=
X-Google-Smtp-Source: AGHT+IHTuQiiI2AbYGJJ5fjELVtFfzWxoxqy+odEkOPQdv5dmS5K7Uu83poll4g1wHvNrD2kF162NDFcdz7cnZYYMcA=
X-Received: by 2002:a81:c242:0:b0:610:e242:2f6e with SMTP id
 t2-20020a81c242000000b00610e2422f6emr6955811ywg.20.1711411507520; Mon, 25 Mar
 2024 17:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-2-wedsonaf@gmail.com>
 <-uzW9xCfocYgSqqwoHB8D6k5CKhc5Rxnrmjq9N8XmTTNVZI3CYHIK9uigpGprs7EDYHWkALopDuv7e9w_FVfZW-9iGh3VlV9WpuSAKAWhFc=@proton.me>
In-Reply-To: <-uzW9xCfocYgSqqwoHB8D6k5CKhc5Rxnrmjq9N8XmTTNVZI3CYHIK9uigpGprs7EDYHWkALopDuv7e9w_FVfZW-9iGh3VlV9WpuSAKAWhFc=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 25 Mar 2024 21:04:56 -0300
Message-ID: <CANeycqpdV5d21g_GZHOjJs09Wm9c+WPHrkEngBgmR2_sCY2k6w@mail.gmail.com>
Subject: Re: [PATCH 01/10] rust: kernel: move `allocator` module under `alloc`
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 18:56, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 25.03.24 20:54, Wedson Almeida Filho wrote:> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > We will add more to the `alloc` module in subsequent patches (e.g.,
> > allocation flags and extension traits).
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>
> One nit below, but feel free to add:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > ---
> >   rust/kernel/alloc.rs                 | 7 +++++++
> >   rust/kernel/{ => alloc}/allocator.rs | 0
> >   rust/kernel/lib.rs                   | 4 +---
> >   3 files changed, 8 insertions(+), 3 deletions(-)
> >   create mode 100644 rust/kernel/alloc.rs
> >   rename rust/kernel/{ => alloc}/allocator.rs (100%)
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > new file mode 100644
> > index 000000000000..ccd4149932c3
> > --- /dev/null
> > +++ b/rust/kernel/alloc.rs
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Allocation support.
>
> I think 'Extensions to the `alloc` crate.' fits better.

SGTM. I will update for v2.

>
> --
> Cheers,
> Benno
>
> > +
> > +#[cfg(not(test))]
> > +#[cfg(not(testlib))]
> > +mod allocator;
> > diff --git a/rust/kernel/allocator.rs b/rust/kernel/alloc/allocator.rs
> > similarity index 100%
> > rename from rust/kernel/allocator.rs
> > rename to rust/kernel/alloc/allocator.rs
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index be68d5e567b1..51f30e55bd00 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -28,9 +28,7 @@
> >   // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
> >   extern crate self as kernel;
> >
> > -#[cfg(not(test))]
> > -#[cfg(not(testlib))]
> > -mod allocator;
> > +pub mod alloc;
> >   mod build_assert;
> >   pub mod error;
> >   pub mod init;
> > --
> > 2.34.1
> >

