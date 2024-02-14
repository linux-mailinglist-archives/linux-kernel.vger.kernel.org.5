Return-Path: <linux-kernel+bounces-66017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B05855577
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E599F28E607
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902EE1419A9;
	Wed, 14 Feb 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvcYhFnA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED813EFE3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948096; cv=none; b=AgbiAHVcatQ4YLqKGQ5SpQ4gEO4M6w/PYq11ByqQRyc3nxqcpzAyq6i0H/WyN76kVvivlSFloybt8wQPb3Q6boVfkCAJz5o2eVPbd4nLPvRqNx20x3J4MIQvCgNNpArRrtFeUf/++/857DUdpZ4GNEawnKJqnFGJ1ZekzXdemao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948096; c=relaxed/simple;
	bh=pizdAD3OJdRSZaEjPLGRyqSE6Y2Tq1Sdi/I+Em97CK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSfpw9oq+Z/sajnq5vWjqhyVxm+fKF9rqhve4pwxtm34hMbHDP9k3vDv7S2ek3gruXYViKbH4SVdayHfFCAZSVto1Sye1M3RTz2pXbwwCd1vTHAPhO5CIVJyY8UEsK8nFeQI5cIoBVUALu8Bmdyhjq2VbdjCtss6jPyk1CfAtik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvcYhFnA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411ef179d2eso1617035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707948093; x=1708552893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0ESyyBcqjsDVYShCT0eHRNmp20GSZgnSy4/io1Ynu0=;
        b=lvcYhFnAshbTvMk2u7Fre8jBYFYaEB1ISoJmMC7cZDp2wa+oYsC6nysIb5husFn7KT
         HhWyzSA3AXUdaqVigkPctFl+be9pAd8XuKa8t8/mGsg7RSuxWsTqF1jKLl99o+fXpBBp
         hj0TeL4yB3sUGF9g3YufV51w4W6IizoZAL/pRmHokBIVrPzP2l9JNeIwmYkXk3c9xFVp
         qjNqTIeaNA5iKIsW+MJXZOyfNMmAAi1JgBvRmplqhhMAZ7KJkcrG+E8SDonoAhWatcW5
         Wi70rDcvNsb2PHpMXhImazkGEPDnG1SEwmIVcN92tWhi8Dxa+mjkqVAhDu0vleDA5Gsi
         64JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707948093; x=1708552893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0ESyyBcqjsDVYShCT0eHRNmp20GSZgnSy4/io1Ynu0=;
        b=eUDQJkHaPlGLfV1d8lSulKf8a9IeIidwO8VbKPtdMwvGFfTx3K4kLo/FOmUrBSkzt5
         Id0t+1x6V4mhZV18SSoMOYJw11ZH7C4WdUI1xyyQfnAweIGwHxrhq20QC+F921jFHVqk
         KtjOMe1lxUu+UFEKSfpPvHjfQshWvtba6q6M4qfN+fLO+CI3F95fC9c8MSMji3YNl1Vn
         7yETNycYx+jREpf5ZKDUzqdpb4800uzQ9x7N0sOw+GK9MQgkRMr2UQB8+KbvCGXfJA0P
         bxim8BXJ5PnDRcqyVFz16pKI0KFdoqfzKczXJKJqOwDwsd0UM5D7SoNgTL1lfHABir4w
         b+5w==
X-Forwarded-Encrypted: i=1; AJvYcCUvd7OwOESnxFeduVudoRpWIOaAN4RLbUKZ50Vl2it7bHUCRHtOIVKaryrN/eYlh/yhIknKjEasFtQZHtLXykpabN/GeyqFyTK8XzYv
X-Gm-Message-State: AOJu0YyioacSDyZgKmms/bOoD+Oc8JUGl9k6EGoOIyIyrNfzKs7w75lY
	9K1HQKyi1J8sNy9cX/1MCUuMRbVVo9bBmVdWN2KqvTKFQvAw8RNX07i/qyI2//aCD0N1h36WkyM
	kXLclTSI2R8gAq/NkI33aA1k952g=
X-Google-Smtp-Source: AGHT+IFVzfw569hUDx3aEGZmf2QM21gRW/L8FFiZEN9rpMdOg4TZxk0pq9lMUeHQk6a6R5C03bkl27cUK358GE3TAAQ=
X-Received: by 2002:a5d:4a8b:0:b0:33b:1577:a2d1 with SMTP id
 o11-20020a5d4a8b000000b0033b1577a2d1mr2765986wrq.1.1707948093094; Wed, 14 Feb
 2024 14:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212111609.869266-1-arnd@kernel.org>
In-Reply-To: <20240212111609.869266-1-arnd@kernel.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Feb 2024 23:01:22 +0100
Message-ID: <CA+fCnZe4Tr4FXruNgOzaXHR-u+M8h2MkZCOQMH0B8mwUy=wVig@mail.gmail.com>
Subject: Re: [PATCH] kasan/test: avoid gcc warning for intentional overflow
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <adech.fo@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The out-of-bounds test allocates an object that is three bytes too
> short in order to validate the bounds checking. Starting with gcc-14,
> this causes a compile-time warning as gcc has grown smart enough to
> understand the sizeof() logic:
>
> mm/kasan/kasan_test.c: In function 'kmalloc_oob_16':
> mm/kasan/kasan_test.c:443:14: error: allocation of insufficient size '13'=
 for type 'struct <anonymous>' with size '16' [-Werror=3Dalloc-size]
>   443 |         ptr1 =3D kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
>       |              ^
>
> Hide the actual computation behind a RELOC_HIDE() that ensures
> the compiler misses the intentional bug.
>
> Fixes: 3f15801cdc23 ("lib: add kasan test module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/kasan/kasan_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 318d9cec111a..2d8ae4fbe63b 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -440,7 +440,8 @@ static void kmalloc_oob_16(struct kunit *test)
>         /* This test is specifically crafted for the generic mode. */
>         KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
>
> -       ptr1 =3D kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
> +       /* RELOC_HIDE to prevent gcc from warning about short alloc */
> +       ptr1 =3D RELOC_HIDE(kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL), 0);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>
>         ptr2 =3D kmalloc(sizeof(*ptr2), GFP_KERNEL);
> --
> 2.39.2
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

