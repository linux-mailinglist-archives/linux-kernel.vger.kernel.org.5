Return-Path: <linux-kernel+bounces-111079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEE8867A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A89E1C23C00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5713FFB;
	Fri, 22 Mar 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcWmNbaV"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8412E4E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093890; cv=none; b=kjq0mIPN/fqBbGG+2iuAd4NrRAzpJoRqM8bacVriK4N6n6eWSUTIlxFafA20xOZ8CxoxEvESq/DkVPwPstH/JQXmsnKmRfFh372p+PdzLJD4hP1DToSTBNrrpmGhGOhfjt49FkHpLmiCxdW1dkbQBXkBRZCngbS6EK+TbvolS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093890; c=relaxed/simple;
	bh=3hw5Rawy4Kch8rLIOp9e/R80qsdn1Iud8TwBWgH4EuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODXwszxIjtO5ebkB4O/zXBynzrqBy6SZGcilC/sXM6FrjpremCnXP0w78sZ/xBt+JQepQsjIvUIulc8utRvd+RhJGAyUWXFM4I3TRz/iujPlUuz9cqdzk9ROuF0WPTOcOwt3oFvlcLYk86x5hTbWf0e2JG+AKVWZUanTzEC/R9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcWmNbaV; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e03e591693so680731241.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711093888; x=1711698688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UjpmRmSm7wnRaPwBJcqO6UsAFfeuNj9KOWlt7M4Keg=;
        b=HcWmNbaVm7dUJjFYJoE4XsIC372jdwSwbIAC7eWvMYq2zFLHPsZ8oCW+QovWud5wQN
         7wGo2EIATkEXMNmgq3mOWJA+RfTNq5sz55Cjpwa2u9SmhSrZ8n9KQmXawaugQYz6BweF
         Q6XZfgysyAtWTRwgmUn9B5Q+Dgy3P7XrQ1eul4gZnVJTpvBaYr4QhatKQWMllPGR7EFN
         fv7amZwR1sCQgC1NLsZpKZlCcfExJAwXSxLrryOMYBApm54VLGolBLJIgkSWE8IDQ+2G
         RulGi16XhekfVSUNoHQAzKCAMja40jgxF0I+4dH+3k7i+9bAfAZ28s9qTJ8e4DGtKNWi
         eOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711093888; x=1711698688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UjpmRmSm7wnRaPwBJcqO6UsAFfeuNj9KOWlt7M4Keg=;
        b=K0LBB8HbV27a+ryInhrcycjmFhFXaHifNpbhcJxUqmXk34YjvdAVu7wPQiEw2YfuNu
         EsqjFdTooZpjxdY36Efb3wAlyXtFYw8Z9puc5kLXnbhaictOC7c1n5sLcyFTRWn16e/a
         erhjR8hustQQ9Gz83WetIv6EEvDvmtnk50zk9tKlkoIQVNcdNAeaxQOi6aHP6/mhXgUP
         TTmVxY8V59nJW6f6PwKp1Cf03Vfjo3zEKBYlcYre6XrExccB/JUg9op01QYyAltJ+Q+/
         g2r3tUOjWEQfSFO4dIPJpDlygg83tB9XaEvSDe6Ev1T20wyxyX3uRiEb+CD/6fc0mKPA
         XX/g==
X-Forwarded-Encrypted: i=1; AJvYcCUjZC/E0zYx4rixzV/d9Z9j8TGKJE+qNma2ve20Of4b+/Ko3JK3cUIsHwQghIe/T856fZp7Cuz9D0aH9kNsHG9DJ3juPMTeK800tWYO
X-Gm-Message-State: AOJu0YzshOM0SwrMk6oQe5jQJoJTWINnYk7UCadtOfxE4eMoe0vO28Sw
	Ly4sc4dmFLvKyQK7/6PXAL3xff/Lf55LuIzPIKxqTUBn9fEZNvtyCT7+6eq/yvhEiQvdtscrhmw
	c4M/gOIyGYVFeO2Wh6ekv1wFZqJpQl5MgyCLf
X-Google-Smtp-Source: AGHT+IGkCHjyLzrgLqx6n7pTmi0lSVRd7YABhXvFnWPq13wNH0YkWBQ6GV/YYvb9OYRGvEojYsBwYUyLx8JF6ZC/dyk=
X-Received: by 2002:a67:f80f:0:b0:475:fe91:a9c4 with SMTP id
 l15-20020a67f80f000000b00475fe91a9c4mr1888206vso.6.1711093888402; Fri, 22 Mar
 2024 00:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com> <87wmpxghxg.ffs@tglx>
In-Reply-To: <87wmpxghxg.ffs@tglx>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Mar 2024 08:51:17 +0100
Message-ID: <CAH5fLgjFaduZ1AmfGGGo-kCNK-NO6qN9XK__Dz=VYHJ7dU4NvQ@mail.gmail.com>
Subject: Re: [PATCH] rust: time: add Ktime
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:18=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Mar 20 2024 at 10:08, Alice Ryhl wrote:
> > +impl Ktime {
> > +    /// Create a `Ktime` from a raw `ktime_t`.
> > +    #[inline]
> > +    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> > +        Self { inner }
> > +    }
> > +
> > +    /// Get the current time using `CLOCK_MONOTONIC`.
> > +    #[inline]
> > +    pub fn ktime_get() -> Self {
> > +        // SAFETY: It is always safe to call `ktime_get`.
>
> That's not entirely correct. ktime_get() cannot be safely invoked from
> NMI context. That won't matter for driver writers obviously.
>
> Looks sensible otherwise.

Thanks for pointing that out. I will send a v2 with a reworded comment soon=
.

Alice

