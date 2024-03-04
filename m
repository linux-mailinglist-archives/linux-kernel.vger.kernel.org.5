Return-Path: <linux-kernel+bounces-90904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A1870695
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1809CB241EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902E48CD4;
	Mon,  4 Mar 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/CJu2+P"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFF482ED;
	Mon,  4 Mar 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568436; cv=none; b=aIxVNST48oz5gyXY6sPG6MjcoDZ/EdLftGDUiasqyWm1rkx/VGlEVfA70EO0d1urkhbfPr9C5rrnL84yCc03HOY0m+9Nnu3IHJl+I/3ITAWuzyS47zPyvFM16VmmgPsVG4kw8x3hxQ1LmrdVqN+VB5KsJlwiepXyoeZLuBa0zgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568436; c=relaxed/simple;
	bh=k4TR10OnNmINkmPorunrjDAzeD+rHb7FeAaVbqOaY1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crgQkzjNO49RtuL7ubKsaH/L7I8yOth4BTr99jMxsKOXIb4nrHTbMlBxsDXEc6VS47oIsFg/g4cfd+CBDlLa9m7C1sjpbKhNZwcvCZNOvk/8Y7ZBGTOC8xaoZlYD6kbxeWy46iL9f3XhaJIEyx/0cs22Rwos5yCxvLKbmrv3Dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/CJu2+P; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e59bbdd8c7so3783153b3a.3;
        Mon, 04 Mar 2024 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709568434; x=1710173234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4TR10OnNmINkmPorunrjDAzeD+rHb7FeAaVbqOaY1M=;
        b=m/CJu2+Pbjyhmw2VJUJkQnQCtkFpJxrHGLFusviOtE57QrQlYj0JV8GDYH7UPApmS+
         OfQajgoitkqbikc6cKTqY3gzXuMokc8vU1QMrDe9FIbOYnXH4Do0J9wWA0uIUot2N2EC
         lO3ni+F68czaxLF3PO4uzNe5dDZeRVipeQQUuYMBvAwFSW6fyfzoLJXlpBUaS8UhtChG
         FLQ7LQuCDvfpCJkHkt4BhZLM5bdInmCQfOhkGcdTV/eIQ/3M3ouk/nUMrIjv8LCmyKe0
         AnLGGmEkoyPNC/mWDi+i6xoxFBrRJlSCq9mrWF/kY6ry+A4afyFvKz8Qjv4sbmJKIhO4
         rBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568434; x=1710173234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4TR10OnNmINkmPorunrjDAzeD+rHb7FeAaVbqOaY1M=;
        b=Kw2c9WOhGbGXOZREypfVj5LN9hw6PfSH+tyGDnmbbyHU+KeUeHRqWMPKEY8wA99IHu
         s7m+xaY9GoFrJj44Q6zaaQMqbFybtkIwU8wGBTfASx+An+KXXYn5uEnhk1kW6juKSkrT
         19oaz3M0N5cF/vkEZUZtgZAgjViHlVnr2gRxAqfIpY+CRWbL4yKdrzTDqzD5uidKYzXy
         BHjcAObtpxb97KUTxsjWfjbk0pAPlvemGab346pKtLIPOZ8Ipz3zllK6C8NEzS1ysEvF
         tCQu4DJrsXG5o8bdKp+x7xX/XNBHyBS+YpTPkhfzcFPUVjnv5s1+rs6EfccuiE6J1S2D
         VSYA==
X-Forwarded-Encrypted: i=1; AJvYcCVqtX+maSLXZfDSI0s5pUN3W8YJCcBg297al5R7MuB/iCHo9ew737KqFTmIl2rMp+nnF/A1vDtEWs/ArU0oHmL+Z1F/GVi2D7ebOOwYvECMP0I1jidVhaggSHMQ0vMATi5Tv0pXrTV6v7j8zig=
X-Gm-Message-State: AOJu0YxTKxjLpjo5+52vwMH6a3i1q/GcSGbFxakb5e4NQPjjhQRufWwL
	nzt46tbtPrpVq/qLH89E+jq/UgW4pN/JAOsm9QJxRe7fN/lfo79sbCT7dONjwBiNY5o0X196j4i
	zXWMh3hRK5CANLR4KQyc8rDqFI7s=
X-Google-Smtp-Source: AGHT+IFlTw+graS1GYFpuHX/+si581ZuRx910SbrbDYCgQI+m5x+oiChingS48e76W97/gjoZixOgklCOzjzBhM/d4E=
X-Received: by 2002:a05:6a20:160d:b0:1a0:dbf2:fd8f with SMTP id
 l13-20020a056a20160d00b001a0dbf2fd8fmr11819869pzj.21.1709568434111; Mon, 04
 Mar 2024 08:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304141426.163517-1-wangrui@loongson.cn>
In-Reply-To: <20240304141426.163517-1-wangrui@loongson.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 4 Mar 2024 17:07:00 +0100
Message-ID: <CANiq72mvdVrzN19PC8pNrvuBLkOEEQ3yX0WG6JcWc+RVaSM2nA@mail.gmail.com>
Subject: Re: [PATCH] loongarch: rust: Switch to use built-in rustc target
To: WANG Rui <wangrui@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, WANG Xuerui <kernel@xen0n.name>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:14=E2=80=AFPM WANG Rui <wangrui@loongson.cn> wrote=
:
>
> This commit switches to using the built-in rustc
> loongarch64-unknown-none-softfloat target for LoongArch.
>
> The Rust samples have been tested with this commit.
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
> base-commit: ("rust: Refactor the build target to allow the use of builti=
n targets")

I couldn't apply it on top of commit f82811e22b48 in arm64's tree
(which is the base? -- the offset differs significantly in the arch
Makefile), but I nevertheless applied it manually on top of that one,
build-tested it for loongarch64 and boot-tested it for x86_64:

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

