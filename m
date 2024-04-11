Return-Path: <linux-kernel+bounces-141310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3D8A1C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D159C1F21839
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6293199E94;
	Thu, 11 Apr 2024 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMnH0ULc"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF7199E8C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852517; cv=none; b=sadwpQe9226sm+x7m16TJk5Ji5Xi+9EUxlLicUWlfzDJDj/fMvd+X2jX92j1wfrr5WaS8m8ApNCMZjroDKl5Hht4uuMLJSb0XD1wMODaPBotS7SBRKKI9NmL3HJlZQ9UiNxSRkx5R/Rd+HYpLaxrOeDh6W+C9KNp0jwYnm8HPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852517; c=relaxed/simple;
	bh=lf+0Ib0/SILN3w7/PCPazIMQblm1eMQjgq0Ng4XGKNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACYfgbw8tAcgiYL/GHcOTWnfZVE+QXoAz/h//ECtVksaddB2pNznAOsLNX063lksmIB+PDiWnHTRd4DUa7e+eiUK4ie4FOKvN1N3+uVmQGx2fQjKa3G4XjJMOJYcuSSeihzmg6MOsxGdhTUEb+2MgZaBnt3ZFtoNMDtp3/2eRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMnH0ULc; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3385334b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712852515; x=1713457315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcZ0pKuDsoHogwdYuz9mbRdwS2176lXlA0vTIaXKs1g=;
        b=zMnH0ULcpk/KnxXzuQGSuJEzDwYXSJyiOjphfmUxivDi57fC0HuCsgLiXgtuqeS/ot
         boEr7tASYZ9++10beVcD8wK4s+hKPqntMoqOG9WMCQ1/H8VFy0ctro8n02DKqS1t/vcp
         iGW066n5TuiIGrP4ICG5g9huwn6jTecXvyZcTIYry4g+0iVxxBdXPn44uwzbu/FA3928
         pPC5g63RzV1RqeMIdF0yTgecvsWtF9/2rV/QRnIFJf/2pe0xF6hP3ELgs/ChD/5HiqOW
         ghDdDy/5oiz9bX97l9aC+B9QFIKzYfKSdT/Aplg2WZrFB+yLk0wTYWtR1QbDDm05MK94
         2QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852515; x=1713457315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcZ0pKuDsoHogwdYuz9mbRdwS2176lXlA0vTIaXKs1g=;
        b=kZSt1vrYGP0gMKKpleDtlT9qXCEDmSv1kRbn1rc2jKPzd8NvnRR/565p56skKS9CiH
         RS3ZlCzfaTO588LcTX2AnVwihCePRLGozQ447Cx3yjpem/CKOlMFizxfb79XPwqUe4Wj
         eHFpCwrs91o6EKL207sAw/g15jd+e6+qScEjRTUdsjNRGXI+ohRwixfGK6OqpgYytgqa
         EJGE5qPM1SnaoiePicZy/L7Wx8T3AJGZpl8nDGdozt55Fg96fvdEeZh2uSX1rOgaIT8y
         8j97jQb3aZ8S0au/mpsIh9hUNhaiWHLMWfrqVE+ocxpO86J1uZ0j1m7rnTxlD44p8QZ0
         D0FA==
X-Forwarded-Encrypted: i=1; AJvYcCUt/uGnw/TLV562fGI3eezLP5E0zyljOy4P6ytYfwzmM+6Z6oNeZqjAgsCN/HzcBWtMa5WIih2mdnUrdPts2KIqR1h7Th+72WzHWdGw
X-Gm-Message-State: AOJu0YxTcsuPQ7jYp2RKJjSr4Cs7Qg04MHvyfaLrv6c+NrCsINewN0FE
	xYu9OmHtzLBp52qVbGKwVL2qrfzSPxqIoBX3/7NPTlRqPfAZWn8nrcUsGlpXgck+esNEiXUcBaP
	vENxmC1RSnVIbKePxkdgsV+WWVvdXAoRb+KXA
X-Google-Smtp-Source: AGHT+IFcZi96Ry1HT9pKgtfjtu0w8kWo1mew/Ye/KOYKY3s21BuVIydCjug0RSuMOVFkuaeS3O4HOABhJR3D+LUzbSQ=
X-Received: by 2002:aca:100f:0:b0:3c5:fc80:56a with SMTP id
 15-20020aca100f000000b003c5fc80056amr109433oiq.32.1712852514866; Thu, 11 Apr
 2024 09:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com> <ZhgISqMcEl21QZmW@boqun-archlinux>
In-Reply-To: <ZhgISqMcEl21QZmW@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 11 Apr 2024 18:21:43 +0200
Message-ID: <CAH5fLgh4-OunYFmKYJ4L-jWthiB2D_moESpsZ7vwz0gUxdC6kQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: time: add Ktime
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:57=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Mar 22, 2024 at 08:59:38AM +0000, Alice Ryhl wrote:
> > +    /// Returns the number of milliseconds.
> > +    #[inline]
> > +    pub fn to_ms(self) -> i64 {
> > +        self.divns_constant::<NSEC_PER_MSEC>()
> > +    }
> > +}
> > +
> > +/// Returns the number of milliseconds between two ktimes.
> > +#[inline]
> > +pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> > +    (later - earlier).to_ms()
> > +}
> > +
> > +impl core::ops::Sub for Ktime {
> > +    type Output =3D Ktime;
> > +
> > +    #[inline]
> > +    fn sub(self, other: Ktime) -> Ktime {
> > +        Self {
> > +            inner: self.inner - other.inner,
>
> Nit: although we use "Release mode" to compile Rust code in kernel, so
> i64 substraction behaves as 2's complement wrap, I think it's better we
> use wrapping_sub here:
>
>         self.inner.wrapping_sub(other.inner)
>
> however it's not a correctness issue for now, so with or without it,

We enable overflow checks even on release mode right now. But I don't
understand this nit because we only have an overflow condition if the
two ktimes differ by more than 2^31, and if that happens then that's a
*legitimate* overflow that we would want to catch. Or is there
something I am missing?

Alice

