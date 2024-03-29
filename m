Return-Path: <linux-kernel+bounces-125349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A1892470
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D861C21606
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E513A3E7;
	Fri, 29 Mar 2024 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+oYY6P8"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EE320B;
	Fri, 29 Mar 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741574; cv=none; b=sUs/WpITxzfp1VrMFm47wELRC6bKX84bGOxVSCAg0Y832+waO3R8yN29xVHuSJIwxSk7YHfYALmOV+q2BPPRxeeR27tRyEceDJtEtREjb57TQLeeMLf/CGV05hI6DGb3slfowbOOTZxhYYHnPAW4w9kwtARXvJIIX3m034FyYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741574; c=relaxed/simple;
	bh=8d0sab0BqgsFQw++CvUb36xP5swzUsNaNhoSwe5Jo/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRxvp3qq4scvsvyl2EfXlw5DhrNt5pUrd19x3Lajk83tj1WyxR+EwAeNoGD5REzch9BkXCfcCasuNx5u1QLtF2Wgq8pnVS3iir4UBIoUSDIKFhP345bKOI09uPhlL9vlxVzL7WC+J62RNhWboCU3EjmCc59SCd3xvebSDBMdpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+oYY6P8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29ddfd859eeso1880122a91.1;
        Fri, 29 Mar 2024 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741572; x=1712346372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d0sab0BqgsFQw++CvUb36xP5swzUsNaNhoSwe5Jo/w=;
        b=U+oYY6P8grXhI/ShZLQQD8le6o03xy4L+b1iJ8osk8nXzUQMQkx/gxCihSzv6L6zV4
         +5LiXc1yzzIAugs33GAxDs5dh543ldGH1nQsV28Y4V1aWms8BAA9iTxVeWx3wg3yI2tc
         mvo1B0adsCooz86LrEjjIP+oWyKiTOnakU9Xx+xqTbBNnvYaj31b4t/P2editBLJ+f3N
         wOYiwCR+J8aELiFMA5/A5tKAYoGNE+VbTJORtsg2xp8ZsyuoMj+Em2fsjWmbbuGTXgbl
         YmlFyimdc2x130rexU9ieamuRUjvenFvfKpk4NUs1cTnETAsHHNToFDk19FRK7xk5VMQ
         uBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741572; x=1712346372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8d0sab0BqgsFQw++CvUb36xP5swzUsNaNhoSwe5Jo/w=;
        b=ojWEcc/gRAcFJam0DfsrjGwlreHgIOdXKHWuSV9GTJDokYSAElWnmUUTsYW6duIYUl
         c3ORMMwLMtu8gfcC058WUQQ0XE99MFOC8ctjIt732k0DHAQ0wmdvdNoLgTA+wj+CvAUm
         zGWkM9qVVtj3txC8//31Cb0HKQw2iLU0aKSS3QK/5s89ktwYac8DhQKLGUl/XRdipCnj
         dfPOgPgWzWSmlDq2jXWuaLlgKFt5LrKiQLEvs9d5UOLlFqUkVP1SiFo945eROAymV/pa
         iTpI0JkqRYw0JBzIncXrgib5PP0aDw6kMmZy6CmYeP434F56XS77BR86z7THtWk8tOwI
         u9lg==
X-Forwarded-Encrypted: i=1; AJvYcCXLiqVH3NtcSAN0V5g5riSCa6jIibwr3+GootHnBGwRzfh+Me8i3jC8a9TYhZRsBSFt1bU27R9dDelOUsuoImukfkzcoMsm02mpnWxvSJW++iRlcISkn6pCa2CI5QvgVh8/5MuQ5HcQ1sRfil4=
X-Gm-Message-State: AOJu0Ywns8Vc5yR3H8rQ3Fv4X6z5gE1PjEw5lqmaOWnIprpQqy9PL/bU
	Nv+qkVYVCEUAaZmVqz1hspS5DRUBY+7RqD9qRPRRxQQkXNA9PikC6EraUTa4o0+jUpI84Aa02da
	DOt6AG9gMKjbYSFV6X1jeRUCoebI=
X-Google-Smtp-Source: AGHT+IGZC+i6f8lxTrzjWMWDRWWtkMpdofdcuUMGrShdwfuZlvo+4lYDbyD3Ya//GwAHR09AjajC7y0QqUjktcP2qMs=
X-Received: by 2002:a17:90a:3fcf:b0:2a0:390e:f032 with SMTP id
 u15-20020a17090a3fcf00b002a0390ef032mr2910188pjm.32.1711741572386; Fri, 29
 Mar 2024 12:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-module-as-ptr-v1-1-83bc89213113@google.com>
In-Reply-To: <20240226-module-as-ptr-v1-1-83bc89213113@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Mar 2024 20:45:37 +0100
Message-ID: <CANiq72nYx=ZKB1_Qj9O2+oKBHWL5MVifKHSvgt9MbfLZQ4WWHA@mail.gmail.com>
Subject: Re: [PATCH] rust: add `Module::as_ptr`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:44=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This allows you to get a raw pointer to THIS_MODULE for use in unsafe
> code. The Rust Binder RFC uses it when defining fops for the binderfs
> component [1].
>
> This doesn't really need to go in now - it could go in together with
> Rust Binder like how it is sent in the Rust Binder RFC. However, the
> upcoming 1.77.0 release of the Rust compiler introduces a new warning,
> and applying this patch now will silence that warning. That allows us to
> avoid adding the #[allow(dead_code)] annotation seen in [2].
>
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08=
ba9197f637@google.com/ [1]
> Link: https://lore.kernel.org/all/20240217002717.57507-1-ojeda@kernel.org=
/ [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` (before the Rust version upgrade) -- thanks everyone=
!

Cheers,
Miguel

