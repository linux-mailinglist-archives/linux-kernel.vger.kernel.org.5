Return-Path: <linux-kernel+bounces-50105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D984744E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2326C1C25484
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4FB1474A5;
	Fri,  2 Feb 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4aG5jaD"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB281474A0;
	Fri,  2 Feb 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890142; cv=none; b=smyy5SyUPmls1IIplr5ikKksAZ0scmx7pc1CJ4sr2VjoODOc1UCOs4oRsdE997MPu921b6gcXBRoPfCtdD28v2fSLaKBg1lZSbPOG0jtsKAD4k/8T11MpxvQTbFvrJz5moTQr8YBdAojHQMMjOEtpniGxo5jftMXIGDzU/HXDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890142; c=relaxed/simple;
	bh=ObobwIusGY63NE/2MOWR+NbMWvgKu/d9ZjBL9g2lKRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOpYeOqPh6GQVZ3zgCPgFQwWaqB5Rtj39VqE78tyv4nsq9z8fJ6KfGPuezpDdCB/Pmy8LKKhcBoeK6kYFiFn0NgobP9njxaa+xcfaQIMnYx0d+SXbJCYR/11ACLJ2NY/dwkeuJjzExu3FQXK9y7u/HSU0Jycx7HFl9nJHV80lRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4aG5jaD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6041779e75eso24009227b3.3;
        Fri, 02 Feb 2024 08:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706890139; x=1707494939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObobwIusGY63NE/2MOWR+NbMWvgKu/d9ZjBL9g2lKRM=;
        b=P4aG5jaDyDYRpT+eVdAhqKTboEYgxtCcSFqFddMsR/tA4OfDmGLY5vqhusq0s5DLC9
         Cg+jgJKUN25AAgBN9xRQp7uvSQiPR4dj1RGfaxL5Qybhh9g9+VEHl8E/9ZijgqZ60wF5
         I+kWnwOqW9S3X62MeKqXQgJkY25bnnDCTfPUAYT0W/JFkZ1RDLUuq2UZWGtLckdZIT9a
         gwB+ps0VwjoclkuWq6lGjjH0ghpUsNG9EGQ8YPFVIfk89OzuX1QnFWcUJkHYCVE6+RGU
         FmdUggw8Ygjmdij6T/amKgnTpH+uoBGKKw2Usx05xbOhEgXHgG1kJZuojuNKtI86i7mU
         1W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890139; x=1707494939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObobwIusGY63NE/2MOWR+NbMWvgKu/d9ZjBL9g2lKRM=;
        b=qbD9G/Gt6DkkCUln5hyv8yKoKL++fXlOOf/djTNWE6YBWO+myS2Go1VoSLWhmC0Xm4
         ZQbHxHm7mKk0E58FGrfPpkPJaaCj1z2FzxClNFc2G0uFhI6fy011GE1nXmCrQO0i0ONr
         3TSCKjtQmX69r9GxQ/kvFkhUSvVPGXxhWlrK9Otyg/JMefzdy/yssnvYEAeb5R3QpOQz
         L2oCBsmylfFtzA5hkv7iOMcEFqUpodvUCuHwMUzCWWTL9jVlRLXGF62R5aUlzK3BEoEY
         JMucZ2SD73t43dhC0sgmC5j1dPZ2i9cfq6mevdCG6VIfs6ujIJWSyo/IXq61bLTbmY9W
         T5OA==
X-Gm-Message-State: AOJu0Yw7nq4Lbg++wqBtxDKPgsQDyU6QGLU+7LmL7WEiiyKK2ehtIMjj
	Ibd4NOKJCXWOcNbkyVaKw4y5bAhEmlToN/2eeSkO3K/zAKKZvgSEsXWmvDFfBbOT6Lk6EFFmU1A
	1ggu1a3P23H/fYtclu/VkU+8YtRc=
X-Google-Smtp-Source: AGHT+IGMWWJJIsEQaIGhd3HotQ+QkJuC6kkshmtHK3UG+EVQsNgMHpDuOqo3DccHZuJCzl1gJq/ilLs/vZ/Z4MzkmfU=
X-Received: by 2002:a81:441c:0:b0:5e8:92f9:46e8 with SMTP id
 r28-20020a81441c000000b005e892f946e8mr2730296ywa.30.1706890139331; Fri, 02
 Feb 2024 08:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202101311.it.893-kees@kernel.org> <20240202101642.156588-2-keescook@chromium.org>
 <CANpmjNPPbTNPJfM5MNE6tW-jCse+u_RB8bqGLT3cTxgCsL+x-A@mail.gmail.com> <202402020405.7E0B5B3784@keescook>
In-Reply-To: <202402020405.7E0B5B3784@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Feb 2024 17:08:48 +0100
Message-ID: <CANiq72ku9wsHtnPAh5G71Y_pbsftrPPyV5wmDCcZRM+WB6KVjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ubsan: Reintroduce signed and unsigned overflow sanitizers
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Fangrui Song <maskray@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Bill Wendling <morbo@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:17=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Perhaps I should hold off on bringing the unsigned sanitizer back? I was
> hoping to work in parallel with the signed sanitizer, but maybe this
> isn't the right approach?

If you can do anything to keep it in-tree, I think it would be nice so
that others can easily use it to test the tooling and to start to
clean up cases. A per-subsystem opt-in like Marco says could be a way,
and you could perhaps do one very small subsystem or similar to see
how it would look like.

Something that could also help would be to split the cases even
further (say, only overflows and not underflows), but is that a
possibility with the current tooling?

Thanks for working on this, Kees!

Cheers,
Miguel

