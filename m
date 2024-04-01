Return-Path: <linux-kernel+bounces-127001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EAB89459F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BA71C2157A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2D537F0;
	Mon,  1 Apr 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpca0jo0"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8463D9E;
	Mon,  1 Apr 2024 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000556; cv=none; b=apLgwGC618DDOO1PZIiEVZoAhYb0ZaoWVhb4l/DCEyjQ1blrqxcYUCjJA7miCTiOuZRXD2enrOavKzElMEhqzjOtg2fQ1hONvpxmd/tB1OIx4otVxRx9zXHak/NcAYFh/uHVnMK1MiFHX5UOnv19sSsieyFUfcp3Wf9ASlhXgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000556; c=relaxed/simple;
	bh=F4uOlu0iJswfQVUOUs/h1wLZx+BpMx1FQLUpSBttbAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0gMr4XXZD0DhuwCY7kHc76oRPj/yMWSRLBWX45Pcn6Ca41eUycD31qnrTGcflNZMIA47CmJ2pfDQkf4VPcKepRcuaHSOqg1LAXXZxEJHKEkkjXUTJIzCcT7LtoWjCJKjX28TJn6TE2aJzZt8XhH255YeC7OGye9mhrGx9AJh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpca0jo0; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6147942ae18so21501417b3.2;
        Mon, 01 Apr 2024 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000554; x=1712605354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4uOlu0iJswfQVUOUs/h1wLZx+BpMx1FQLUpSBttbAQ=;
        b=Mpca0jo04ZLwcaSxMd6qmWczgxTesYD0H4OOgBJk3A6PoECTqvo6m+qmKwHYbQcCW8
         xtiTnW8uCWC7b4Q/wbgwlIQa7ksS0lTtKey8EhqYhRsGh9NQLCuJrh4QvDwu6yVTyojU
         RC5KpJx/SD0y/roZPg2gTteYpjz0VMVRor5/UYiATAeOj7kCl5s+RSfUT0lRUgyBV++A
         gBKOX4RCs3C+Iv8fo2JMe11Biekz4PKEsJx8F6OrO3oNazBqU7DALkaW9nQkEA08Gu+y
         nUNaoUID2YI9Tl5ncdXpWwDY06mpqlhlg4TNQxUGxyr6Jab3FXvuQWz/EAjL45XZj1Sq
         4D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000554; x=1712605354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4uOlu0iJswfQVUOUs/h1wLZx+BpMx1FQLUpSBttbAQ=;
        b=U0gvg6SkhT9H9ASoc4caVP4o6IgSZ0VDDLqjQo/ehro2Y7k5IQzPyGB7r90efbwPMW
         oQ20J290wJJwq+WHwa+Oay4Jd7qEnUg1fUkzeyMaNqfWervUEHA1xXuG/5jUE94RZeWb
         Rrjn/MYM7LpDrzAboXRgcHkoAE4wBsC/dlFxPewmqyVLXEy4wWUFrcEt6k5dVIVEF2Kf
         5NJm9gGxNlrP/FPEwbtY8cFt75bwW6B1LpUpU8gT+iD3DwoqE8Ibdm8ykIsY/bL2p92l
         lHUnQ7N4mrF8cvCx3Xj3S8Bi2jJj9sUjwcH4H2iz1/SZqZlx+AbYRUEUAqyqdXMOmvxh
         xThA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8E+7rCGSu+xbxUAh+K4qy/TIB+bH5/3MSdZ9zs3ADiqu5/LOKml0cpxDqGtrhCwXFai31oVs884FD2XuHYK8JhGidsJ58cMiaEU5LJsoh1zUAXNTKn2RQuVADtHJ8/LTh72koEVcLaXF/Pj5i8aFN71egPQfFp/FMM0xWukmQxk5Znw=
X-Gm-Message-State: AOJu0YzXSj0L4Q4FPff0+X0UOxDUs4NKuw2ScX5uXQobT/tGN10d0aI7
	dn3wXpxcF5NmtfD3cLWI5c71Kje5+r8cbYvlvCUII78+4/D4Fcc+WyqdBMwChTlQce4DdwalZcF
	R28mUe4T8V/cznkqn3fW0H0ndR/I=
X-Google-Smtp-Source: AGHT+IFk1rGj6CgyKv0DM+vtq6ogRDZ4o/Z28k6W7y5K+/2ghPixrwH899nJaYUN2PN+/oo5Zf7VVcihOXlXXG+uTQg=
X-Received: by 2002:a05:690c:f10:b0:611:200c:9229 with SMTP id
 dc16-20020a05690c0f1000b00611200c9229mr7675489ywb.8.1712000554097; Mon, 01
 Apr 2024 12:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401185222.12015-1-benno.lossin@proton.me>
In-Reply-To: <20240401185222.12015-1-benno.lossin@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 1 Apr 2024 16:42:23 -0300
Message-ID: <CANeycqracHqSh0AS3sSWerMA=tGUWs7U=iPfnL+UzqBQs1oUZw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Sumera Priyadarsini <sylphrenadin@gmail.com>, Neal Gompa <neal@gompa.dev>, 
	Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, 
	Matthew Bakhtiari <dev@mtbk.me>, Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@google.com>, Finn Behrens <me@kloenk.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 15:52, Benno Lossin <benno.lossin@proton.me> wrote:
>
> The `module!` macro creates glue code that are called by C to initialize
> the Rust modules using the `Module::init` function. Part of this glue
> code are the local functions `__init` and `__exit` that are used to
> initialize/destroy the Rust module.
> These functions are safe and also visible to the Rust mod in which the
> `module!` macro is invoked. This means that they can be called by other
> safe Rust code. But since they contain `unsafe` blocks that rely on only
> being called at the right time, this is a soundness issue.
>
> Wrap these generated functions inside of two private modules, this
> guarantees that the public functions cannot be called from the outside.
> Make the safe functions `unsafe` and add SAFETY comments.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/Rust-for-Linux/linux/issues/629
> Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Wedson Almeida Filho <walmeida@microsoft.com>

