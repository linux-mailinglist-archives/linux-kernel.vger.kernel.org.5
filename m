Return-Path: <linux-kernel+bounces-47810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFB784532B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F21F25CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C979915AAAF;
	Thu,  1 Feb 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwnOo3Pl"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868663B793
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777621; cv=none; b=bq8I76iiznbR3g7l/E/OForVuqfbePOnxmx7i/j1cWn5Qr9+Z0KV2Vs3+zgxZ9AmDr2JGMNi6tPlUjURvEUryrYlzvqTXj14mrUs001fK1av5Q0JkfR7wXNQYoIjfMWG6z0aCchx5M4PoN3buHimJ8jopKsCGqCff+xvedlzV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777621; c=relaxed/simple;
	bh=j/NPgAXVMjTv3N42vxQLM3gBTE1eKKQEJAVuN/0VWkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag2fhBcm+2tVhUhDMDm2asW6eiyfjNT43u3me7tga+ql7OH962bhFLirNlGD2gr+ayO1pNEMvLL66Hj79yl01afx+M+tVp7+ntMES/SaQieBoz1NWyEDa4REVxUHBxzqqh8D0j9MU4XbmFuk6QRZAplGzd8y0bsPDEJhOlURV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwnOo3Pl; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46b165745deso315664137.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706777618; x=1707382418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9X/QBAjvJKlfeOxD/oXT29ra0R70AXdnTz+IJPfF+Ec=;
        b=WwnOo3Pl3Nj+rb6v+qrtw3ZVehsoMIAXIaA7jPXRz7AoNJ8IByCH4ScgwSaoTDK1aU
         l97MD5wBUqBwNfzPrMMeF4wgPHiINB5hAJ+AQ/NqroKG5K5CSfKDmSEVIjiGc0up3gHN
         fS0RLd/9kR/YORb4MMdQjh9JeDI5SjtswOi4QiC5Eq/Xrz4tsx1lBr2Xxi+4NkjEFEOH
         Nyq4lwspD7vDO03yeTuqqGCN2yGkNiOJOU738V0YU8cTTkPTllcS3BN5z7rkmsh+x4d1
         rT26mn/iX+/xzEIxthOlbXOR6v/u7+2fzYbUwLV8KNxfg769/I97Hb9mgIYio2Qh/YMw
         7Ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777618; x=1707382418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X/QBAjvJKlfeOxD/oXT29ra0R70AXdnTz+IJPfF+Ec=;
        b=Lyl0B+xlm9LM72N5QZgBDhBp+pD7FFgeL4TXPLCAHyXm8XHD5r2uQXau8iHZiR3RgU
         SzeRssoVX49ZRfqQB6B6zUpMBylWD2KZtxETiOf7q6qhL634HyS/zJlZwrKvUStz3cBk
         W2TORW1sLE+mwYruHHBn1bf//r/B81sxE+AYx2Abi5FRB6eqVwcvb8lRmfHCcCBLeG7G
         pzKI4Uab5uK30Lz/BN+botPX3QjH7mxr/7AIVmVw3IFgbMiydXMnq/JS6ZJ6aub4UoCE
         L4EXzkIJNd5v8I60obpE8tvmN9SiIYSOfOZ1dJFI8PX8WpXfibdQMlpn4ZYdjvJg+40g
         TuSw==
X-Gm-Message-State: AOJu0Yx0zuV9gSPKUCdzr2F6BUPx0q+9zAQiX0+VJxQnjhDoF00AlXjn
	k+CIX+q7AGjhF87R9ghk9norZT+lpgyRhexmiUQx0pcf/i09nqKKuJjtYFk5Z6GaDSezZS/re1U
	kz2tOPFOgXAPjwlaMu22xWM/X1wInXZyOqj59
X-Google-Smtp-Source: AGHT+IGnQ/PU+QeHPHQoIQRSPkvcrHjczMglXbm4uDY0nigyNzDdWVpMlxI8b0RDHD2EKFpFp7aSpvF1C94AADCtkSE=
X-Received: by 2002:a05:6102:364:b0:46b:29df:6977 with SMTP id
 f4-20020a056102036400b0046b29df6977mr4054423vsa.10.1706777618171; Thu, 01 Feb
 2024 00:53:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201083259.1734865-1-elver@google.com>
In-Reply-To: <20240201083259.1734865-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 1 Feb 2024 09:52:59 +0100
Message-ID: <CANpmjNNtLMX8cB-YS_u3TWq-v=2XFDwhQKi+SCoXKKSZf39qaw@mail.gmail.com>
Subject: Re: [PATCH -mm] stackdepot: do not use flex_array_size() in memcpy()
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Stephen Rothwell <sfr@canb.auug.org.au>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 09:35, Marco Elver <elver@google.com> wrote:
>
> Since 113a61863ecb ("Makefile: Enable -Wstringop-overflow globally")
> string overflow checking is enabled by default. Unfortunately the
> compiler still isn't smart enough to always see that the size will never
> overflow.
>
> Specifically, in stackdepot, we have this before memcpy()'ing a
> stacktrace:
>
>   if (nr_entries > CONFIG_STACKDEPOT_MAX_FRAMES)
>         nr_entries = CONFIG_STACKDEPOT_MAX_FRAMES;
>   ...
>   memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
>
> Where 'entries' is an array of unsigned long, and STACKDEPOT_MAX_FRAMES
> is 64 by default (configurable up to 256), thus the maximum size in
> bytes (on 32-bit) would be 1024. For some reason the compiler (GCC
> 13.2.0) assumes that an overflow may be possible and flex_array_size()
> can return SIZE_MAX (4294967295 on 32-bit), resulting in this warning:
>
>  In function 'depot_alloc_stack',
>      inlined from 'stack_depot_save_flags' at lib/stackdepot.c:688:4:
>  arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' specified bound 4294967295 exceeds maximum object size 2147483647 [-Werror=stringop-overflow=]
>    150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>  lib/stackdepot.c:459:9: note: in expansion of macro 'memcpy'
>    459 |         memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
>        |         ^~~~~~
>  cc1: all warnings being treated as errors
>
> Silence the false positive warning by inlining the multiplication
> ourselves.
>
> Link: https://lore.kernel.org/all/20240201135747.18eca98e@canb.auug.org.au/
> Fixes: d869d3fb362c ("stackdepot: use variable size records for non-evictable entries")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  lib/stackdepot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 8f3b2c84ec2d..e6047f58ad62 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -456,7 +456,7 @@ depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depot_flags_

Sigh, switching this 'int nr_entries' to 'unsigned int' also fixes it
- please disregard this patch.

