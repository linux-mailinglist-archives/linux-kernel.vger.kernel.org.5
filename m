Return-Path: <linux-kernel+bounces-131464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288C3898836
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D031F219BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B086AE3;
	Thu,  4 Apr 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcWxKhtE"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E66EDF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234879; cv=none; b=cTiprVKGNzK5zDtyEULMhdGl0aN3RJ5e8ZeeamFvUzBemEoTsGU9wrcI5oaPtaLIPfrubt4E9G139PFBYqaupIcxWNrfaZtLZjNMwyWX/UM/8rTIeH5Lni8eddAd6EJiuUtt1Rhw+UNxhzENOyoyJxDlp+bEAX+StS6NVDn1oqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234879; c=relaxed/simple;
	bh=UGd+rT+/Qyvhs3wC9gBPZksoGVYkwNvYdF2yRcLiB2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy6XEW+o/cPMsqarlL0bSUxsyghKv6OmAM5i4GlprU8LbwXZeQwvqQHPh11y1/VDyLxyo/K5FYksaDwEdS5Y1QEwc7au5A9Hgqu+ge7j8Mr2smGTvxO0eTzAJmMmh+GO6cy5e3Vn87FrK1ZKFrAxieIF/6aiTCBcfPmoAMlHf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcWxKhtE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e3b3e33ae3so344640241.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712234877; x=1712839677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGd+rT+/Qyvhs3wC9gBPZksoGVYkwNvYdF2yRcLiB2M=;
        b=kcWxKhtE5DI7RZxy3dAaaS1du72uD9JbCWplXDwRbgM520uXBs+Ub+zIdXOcHA7yOK
         ycUrSufsO4R3Gte2CqRjyXg2hd4EbiJ8b7ESKmGq6Hhu2j6u0Xuq9QRta1s35EWkwH/l
         y+AVdRRqWq9+ufckyDPDfo/38sqgmA1wNrBGi+G9LsIdy1IS0QSzxBz/OyhTrB0F+LLU
         fqpx+rMUVZ3F6018NbS3T8A5eoNRJGVsn/NbkcplKuQq5wH4qQOznIM3XgHr5Lx+Ad6j
         WEdCewOHv4KwwYyh1h131lQ25xLCyz48p7ML77rbdObir2TJ4C6LAY9qUrTjhHu8ix3e
         KEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234877; x=1712839677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGd+rT+/Qyvhs3wC9gBPZksoGVYkwNvYdF2yRcLiB2M=;
        b=lte9PgO1qJSzoZKCI2PuJVads3evryn2g7gaOJmQHEghbqjkCS15GAIjUcHvEV8YAS
         5UdKVtwRqN/9lzcFLMMy1OWjWclgpNhfoPrn0/PxZK+KkjiD3dvZXB+XL+X7xI79AkcZ
         R9F9reOxLQuC0IbZWlqvD0xM6HsvmY65/1sWQ1L1FSpkVpjiqxb+pkgS892hhMGc5DVF
         LY9dg49awPIAMOxNmm8P2zecTBocpTVPyFdde+aFXiahHQSIHy1j3WyJcA83zPGseTo+
         WCVxW7RXEhvaPRjd6g0tMzXKWVXmvVjYGSfvMPnQpj63gaCLqZRjWK+l1QV/VB6I7Ej0
         Zgfw==
X-Forwarded-Encrypted: i=1; AJvYcCX0OeQgdjRT4EbXr+XGvWZ83yzz9gKPiCA8D4dzeATyKibg2M9BYbb6uMfMPtQaFHE+GT6spad5pvd8kyzULn522K8WqY2tAZsBhkgF
X-Gm-Message-State: AOJu0Yzg+wD0OTr2USik2l1xO7OyaPYiZGkkD8bLb3DL6/MfkBaIHSYY
	E542j4s22l/Rs8HYhIQEUXeqckI51slNvy/4+FEW3nBZase+DFV6ZmO2UAwO4AHzPByEo5L8hJH
	TsJLydK7I0o52HZyW7A+M7jug2Gwdt+rSluA9
X-Google-Smtp-Source: AGHT+IGR2Fpntb7ts3IL/7cCYHawqAwSvclDfUI8bdTiMJgZACpncp2Tkcb9qrk9ypOZ2vKwAlQ8YTBpElm1+hWHi3g=
X-Received: by 2002:a05:6122:90c:b0:4ca:4a07:9006 with SMTP id
 j12-20020a056122090c00b004ca4a079006mr2369215vka.0.1712234876680; Thu, 04 Apr
 2024 05:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240328195457.225001-4-wedsonaf@gmail.com>
In-Reply-To: <20240328195457.225001-4-wedsonaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 14:47:46 +0200
Message-ID: <CAH5fLgh-e=ZTPkka-RtEFgix=br4by7qkYhYwCZ8ehpF6UQ3Kg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: module: prefix all module paths with `::`
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:55=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This prevents the macro-generated code from accidentally referring to
> the wrong symbol if the caller's code happens to have submodules called
> `core` or `kernel`.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

