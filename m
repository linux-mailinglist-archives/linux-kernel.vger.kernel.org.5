Return-Path: <linux-kernel+bounces-52618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C45849A75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E861F21249
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569E2374E;
	Mon,  5 Feb 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muXv4IwE"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B809210F4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136541; cv=none; b=Gt68SNX9v+jjXZP3SdeDjDwNLCbcHohZmXL6Kkp+ArfDkK1kEwqjiU0dXAWjMEuuRBrCuB4ZnvDCZYStRNtNdsuFR7a49BbgK/10yS9p47rMcbsord3B+JStDvI0FeQ066xXBGav2ZVXn1ShDior6LInLkSOqFBFp4em5nHPaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136541; c=relaxed/simple;
	bh=DDCSdXRdjjJGeHjCGYAAVDZnOLHtjFFFD84mk0/1UmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOXOz0wTillaeoTO10ZwLSPQ+AlJsIJul1KVkQU0DlVTLTfOjos00KwKJRTvNbmLqnhC/rKHZDJT4oC03HL9waRXbo5IlozjRPlWuxO32Kf05P5cKomvcyulhmdEilMfgIJwetHHg2mHiwIhOF1tDcl6aY80yZaUPCugPPHcgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muXv4IwE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso2175978241.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707136539; x=1707741339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pqINmvXfIdTyRxv3LEyPIo0XoyRMgoEvWKIchHbThYU=;
        b=muXv4IwEXdMd13Q/9675NEwnYZItdV1w53RvWKHOsurSqEDjeUGm2d2AhsuUynGTf5
         IpFIWclrSvtjqIz1Vif4hwab/UcWWpKoai9Ktel3XxPk2CxeazqOtEXJ12QbQW95DpdS
         c6QMICCUOKUoU/EtitnKnznyGJ8mYuEFZ1vl9np76ACyVjOFFOYplOGNtg+PdxgX4OGg
         VdNq+V5mTzz+EJswhNN5AOmc+8gfOcQj5GTuu3lJctM4QJEb8tA8qZBFHD0tFYtsCg80
         2lj6gjmmk6ojMk875ammiOACptF4oNH40vW4f2FRl61ZpTNS9ymer/yfk/4+RJvlvSlS
         +v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136539; x=1707741339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqINmvXfIdTyRxv3LEyPIo0XoyRMgoEvWKIchHbThYU=;
        b=sT9E2iOnfqFN+D3iMa6RQna05xEQW1dieIR5QUI6nbsjFGTgBZp59pP7j0jO4n/78T
         Jrx1ZgYAWTbXZXoPtL77BIBsAzE5pk3VtQQX+b/ioWG+P09UOtPu+zUdK9a0a96YKBor
         JU91UzDaVgs7q6FoC54MQKB3wvgOyhkmtDHGje32jVkA/TPZAdDBu41JHAone7Js1HVY
         9zMfGKYKFi+l/9FpM5wCY2lvsIpzZDITvAfHQu4iWuk2P3tPI/h5YGQFdrT8APIIXfVX
         Azqgk1eDQ8fF9/oXT0dI94zlIN1QcMpdDzWNmIQOBHBCwFzCU0UEm3Wm4UaDD67D/zXS
         Qnew==
X-Gm-Message-State: AOJu0YzWEdzfvJr8ks0A3Yub0190//Yla4qFmSBbp5AbWEEvemkixvlC
	TOVPdAD7nnicF7FKb1xsciX6Ar0Oy9f6sju8D4erOHycAYW6whWtAhnMsdC48HdbtEd5TJRizTa
	6ZxUeenNMEmL8Gx8wGzjq6xpUvggUOhbWORTJ
X-Google-Smtp-Source: AGHT+IFpCZQz3iUtLkGRy1heGYq2Y3VsvgfUbeBvfC1uSZoOSni1XaRbWkWCAB/qndpA7PwNfCPVOscJUljWOYkp8Ac=
X-Received: by 2002:a67:cd87:0:b0:46d:2fb2:337c with SMTP id
 r7-20020a67cd87000000b0046d2fb2337cmr1824167vsl.8.1707136538764; Mon, 05 Feb
 2024 04:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205060925.15594-1-yangtiezhu@loongson.cn> <20240205060925.15594-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240205060925.15594-3-yangtiezhu@loongson.cn>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 13:35:02 +0100
Message-ID: <CANpmjNP4gp0k-VpqJferxUAV7Z9M4ROYdq7+mQS57qiYDccw7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: Rename test_kasan_module_init to kasan_test_module_init
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 07:09, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> After commit f7e01ab828fd ("kasan: move tests to mm/kasan/"),
> the test module file is renamed from lib/test_kasan_module.c
> to mm/kasan/kasan_test_module.c, in order to keep consistent,
> rename test_kasan_module_init to kasan_test_module_init.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Seems reasonable:

Acked-by: Marco Elver <elver@google.com>

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
>          * Temporarily enable multi-shot mode. Otherwise, KASAN would only
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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240205060925.15594-3-yangtiezhu%40loongson.cn.

