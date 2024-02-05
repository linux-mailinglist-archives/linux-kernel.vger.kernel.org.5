Return-Path: <linux-kernel+bounces-53942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977E384A851
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5186328A9C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E04140783;
	Mon,  5 Feb 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJK74dzZ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06D18EB2;
	Mon,  5 Feb 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167174; cv=none; b=V4J7VB0e6xe/yVwK1A4XQ6S54zm0R0M/kbpsVB96T747YxVvkExEjKvIfTE11yEQ0kZwn5hLq8x5ZMzj7GZGq0E7whu4qgeXp0GeYz4OmZoeEuLS7r+ZP+MFzZXUKrCJ02gK0wXkfoAEi0XhAUw/dPaNY8vS5osH0vFpi/141k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167174; c=relaxed/simple;
	bh=AqJ2v80mx+3OzAqt8PUSCnloJ7PT6QExzuLDDSzhFXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSDtdbOmiiTlikxh4zLMPZXt1FNKleIBQkw0HmEKm4FQuDkVzhUU9d2X2rHZU2tfOTwBLMlEZ8P3WM4MvATXJXc9C2J7tTeayRx4ReEFV61J8TI4eImJRDCse00RzqeO9W2g8jnhqbr977GWZEMXK4ghVimQm/L1S+H7uf/5ZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJK74dzZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so43629365e9.2;
        Mon, 05 Feb 2024 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707167171; x=1707771971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYuB7rX3JOcdu5mrg7aKnBeo6EiHj+iA643HXTXEZt0=;
        b=VJK74dzZH1ykR6tAY97X+tk7oGE0UL3di43boSi8udSeOABedcwc2NXOOFZ3UVI5Tx
         /aOAGnrBpZDtJei/V+Kdr45oDyWEnvQUM3ouCe6KKZOS2AuC1GOrxTHlrDJbLh0hyrL+
         TXvGgvU4YgHIcdxkT0uJbr9cVjAq5LTqBJLkjUJhRL3zsOiyzYbk5FeqD7YxMsJRN2sk
         k6pVBlb2RAJoEMayTus1tnPLgyJayXq0E3EwLKFenkVJ0HqqGN8ykl0FqziKs/0LCPm1
         Nk3O8IVYMghCWVCzQnyTPFslh7vZ1DVdI9Ppj7y2pJGfzlOswKCR18XzHiun3qNTq30M
         UDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167171; x=1707771971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYuB7rX3JOcdu5mrg7aKnBeo6EiHj+iA643HXTXEZt0=;
        b=mdc/JJcU2nyX/PkX5d6IlGIqGcGxwX5n4GRKvuzcGaP51NyGCOmHFzEDZ2JoyerBoS
         MnvvSN6SBUu+7y6o7BTtVZx6qwT6Frkq1oCGopQO5gMGPeLCJv+i6GA6X3RsQuKUsKuZ
         HGy1NBbRIAt51khAT8gQ9ckJxQXJIivEFVDODfuF/itCl/aEoYXoFxTc6ZTqEVwthjCY
         Vc3OuoybCHRJFfN9cK4AZpFXUm6rF4qRfGrtPc2KrnLHMplqdgHYKb8nUBGVQhZBqJs4
         KQtZFi1g+iGulR5jYROpPjJg2QmmFSCnkYtwtw5c5kMf1m8UX/2ABMVuTqcp6oIXrvVh
         e70w==
X-Gm-Message-State: AOJu0Yzt09RiGNZ5AGp93LwIO6Lv4WLWyC77lu1Ywni2ZtfmX29AzR4M
	GLjt0l+GPH3jdcdUnmN/FMXX74cwtzPXVhAXGjYMCvXg4XMMgg4y7tVX3pF77p2//Ywjsok8DOE
	Dk1iYgDbkhHoV123KAriHRJwEgSc=
X-Google-Smtp-Source: AGHT+IGomtbLPkRkNcFViqEMdOXtyWcy9rH0JnxpE4rKLdWEzFJKOYBWOXVdu/KAVk26VGVQgPzK/nOTLX7j03TlxMk=
X-Received: by 2002:a05:600c:3ba8:b0:40f:b630:a9e2 with SMTP id
 n40-20020a05600c3ba800b0040fb630a9e2mr181152wms.14.1707167171018; Mon, 05 Feb
 2024 13:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205060925.15594-1-yangtiezhu@loongson.cn> <20240205060925.15594-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240205060925.15594-3-yangtiezhu@loongson.cn>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 5 Feb 2024 22:06:00 +0100
Message-ID: <CA+fCnZdvQmA7S6cnFS5niSm3zERyaLpb_wp5Y6=na-yeNNX9=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: Rename test_kasan_module_init to kasan_test_module_init
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:09=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> After commit f7e01ab828fd ("kasan: move tests to mm/kasan/"),
> the test module file is renamed from lib/test_kasan_module.c
> to mm/kasan/kasan_test_module.c, in order to keep consistent,
> rename test_kasan_module_init to kasan_test_module_init.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  mm/kasan/kasan_test_module.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
> index 8b7b3ea2c74e..27ec22767e42 100644
> --- a/mm/kasan/kasan_test_module.c
> +++ b/mm/kasan/kasan_test_module.c
> @@ -62,7 +62,7 @@ static noinline void __init copy_user_test(void)
>         kfree(kmem);
>  }
>
> -static int __init test_kasan_module_init(void)
> +static int __init kasan_test_module_init(void)
>  {
>         /*
>          * Temporarily enable multi-shot mode. Otherwise, KASAN would onl=
y
> @@ -77,5 +77,5 @@ static int __init test_kasan_module_init(void)
>         return -EAGAIN;
>  }
>
> -module_init(test_kasan_module_init);
> +module_init(kasan_test_module_init);
>  MODULE_LICENSE("GPL");
> --
> 2.42.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

