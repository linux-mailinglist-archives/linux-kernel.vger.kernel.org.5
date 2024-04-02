Return-Path: <linux-kernel+bounces-127654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D52894EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05ACC1C21080
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36658AC6;
	Tue,  2 Apr 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hooYKUIx"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CD58203
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051184; cv=none; b=HZYa3Zf4D3w/Unw8hGhn/TRs5fUcvJybIkxlCkll9FOvnznTLvqBDMlijtMFzt48v1UXWu51Y++WR7IA3xOeVLnlECYC6FPSavqgk6t5wWHfNCWuBA9JSI/UxVJ8weZr25c4VNqHJrO7qBIcHVVho4JmQQ4hUEO4N/m7pkuu3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051184; c=relaxed/simple;
	bh=XggWFGhtT/fWL1kIWx1OwviwIwPRpAp9kiwk6uVXE38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf39t3fHGM7E2huG1Wez4ItW5uxIPRxzMiKhkRAYQpnJND2AAXUe9D7ueBQhHFgqp+5CQu98ATTwp5C0HShn59M6k7/2dTXxYhpBIZ05v72psbyUj0KW+xZqnAKcDLpa/iOXS/7EagZvD172YYMyJZTBxf+8q+f9BPXI+9uJBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hooYKUIx; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4783964353dso1688676137.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712051182; x=1712655982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1dO/cGx1ctVP9vVa9nf8DWsXEGQBHZzRz0NgOZhVoY=;
        b=hooYKUIx8HvBO2a+hT4X9jMCnm2liwwG0r+yh4zNemt26nFD9GHjG2nfNymuAWnGUZ
         mfAJ0+PXLc7lL4M1t1LZUKC8/dlTlrJja4b9swyy6rnqHtl3N8aKlF7BbQNXnPVtM1oE
         CfGn8PeVJgHLOSJrE/K2SqgEsnUC1JuzMxqibWPxBP0ynkMwH9doplxrtXQ3mNTaXFJt
         RkvoPkK3c74tP2T+PO78/fNd1cXIAim49kh6F/zZgvDuOb/EtzE0bTjNNNHaNbvK3ibm
         PzU+TXOoUOe4eSbxXBIOFpJ7jzil0FYTljsLoedzXMnbGzhb3LEM2vXOjHb+TVLd/qUr
         CTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051182; x=1712655982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1dO/cGx1ctVP9vVa9nf8DWsXEGQBHZzRz0NgOZhVoY=;
        b=OUfUCOR3PN0OyJqcWCqWkf1tTaw5QVtI7TNEyIAI2N3t37eybFexc2gUoYGpMmtpwG
         oR4qD9iIRl6jvfxjE2JFJSiMWOVSeqpBszcgEcC5UZMnPXIatk5VBNpCXQsEOIqz+mH/
         ux7wwYaPXy4I6HEPSaEEXPKS7ik9QYeTlwwseZv2IZ/rgv14SNwT/b1JEcGewNVxEi68
         niqv1dw9XLtVcGGRO2QoSxa66L1OC/oNAt8WQytvAnPYyOMGrq/nKotAUl1mt5jC/b8D
         wAX9UcrQLElU5xrUXN7bY/h+eVaVucXeXanHgAaT3H3zkeXJxY2GLUivtgx0+yioZW9H
         9OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBOpK4Z9E05Wd7NlRG2HYTO4epW0FqLnJee73r9uorHZ3V83GohjbtQUnNnKf68C4XgWwAvKS2VE2QbsDwzxlL61JRxlDwrHk+czZM
X-Gm-Message-State: AOJu0YznD8JzOt6g9+YOvysc+ctK4/UUg95PC04yWRLP9KasEuFBOOhN
	cv6CCadV7ZhDFMx5eAP9zc3+Op01ub7VwCrq8S5NHbBSauQWuFfUseGpNXFjSygWaCPXFECp7sU
	UQBN0MTpRNj8qFP0SjZpZQdJ+2adzMbGmUbYz
X-Google-Smtp-Source: AGHT+IGW2GUJeyNma3DGOQ7j/A22qw/Kjx0LjOB0xzFOgSDElcWMye+6V8iEJOLXi5ctc1HqkuMdpOobkUY4Obtf/ns=
X-Received: by 2002:a67:f8c9:0:b0:476:d833:ef6d with SMTP id
 c9-20020a67f8c9000000b00476d833ef6dmr9524383vsp.19.1712051182365; Tue, 02 Apr
 2024 02:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401214543.1242286-1-boqun.feng@gmail.com>
In-Reply-To: <20240401214543.1242286-1-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Apr 2024 11:46:11 +0200
Message-ID: <CAH5fLggN2PQeZs2pwR1EEeA6_O=xUo3=UvUgcuo=9YNtaBNrJw@mail.gmail.com>
Subject: Re: [PATCH] rust: types: Make Opaque::get const
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Obei Sideg <linux@obei.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:46=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> To support a potential usage:
>
>     static foo: Opaque<Foo> =3D ..; // Or defined in an extern block.
>
>     ...
>
>     fn bar() {
>         let ptr =3D foo.get();
>     }
>
> `Opaque::get` need to be `const`, otherwise compiler will complain
> because calls on statics are limited to const functions.
>
> Also `Opaque::get` should be naturally `const` since it's a composition
> of two `const` functions: `UnsafeCell::get` and `ptr::cast`.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

