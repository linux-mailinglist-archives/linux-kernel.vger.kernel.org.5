Return-Path: <linux-kernel+bounces-109220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D68881655
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB2B1C23189
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFA6A32B;
	Wed, 20 Mar 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvswr+8H"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169276A327
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955016; cv=none; b=NTNdTZYlgJvEubdAvFa7jBRraCybsIVJYuRjSsJ0j65z48njvjAnXBPiJK92ofAeREmX0zC38917j4f3ZfPfVr38DekIJ7cpFKZ3/ZBgL44FjNal3xZOXfdp/kRQPtpzw4skN8HXN2wRejH+6Pt1GdFQRbkMPIOiVKixQoZyOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955016; c=relaxed/simple;
	bh=PTgza+W1/v68t8gIEmwRzft+VKxQNQUrzbgfRmoXdEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG2mlh/fE4QHkVepF3RtQXivBIZ+onGor9yBBkEKS9j/Udfm8hMvYgVBbUOKlK3rxK11vSDKU32tqJDp7JeOqOfL+9CGLRrXXlilTCg55EBzOpEVKr1rqZpMLjQ4JpYuVpQ/HectCFcFzyNCcYJU18YrMR0wnnN5mUrFTnzaERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvswr+8H; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dee917abd5so7775ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710955012; x=1711559812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrHJYPRQxE5Zvv5TnRibVQ4dHuC7YD8BtX+J00w7sAs=;
        b=cvswr+8HYd+GRt8xMmegLEgL6HiAjOdRLzqN0LiHFRkgA8kmPELmLfTXbuK/Rcy5EX
         mp4/xmo/1xw+2eN2af3oEYYMqXUaxSw1qvs4FUstxpoZ0QLQm1p2dcJeo68Lad3Im0qj
         V+wzQxKe7mC5VRMo5x51EtX0/xNZHHWmG0MMWxtfek3dzioSRlOu2GDBLyUiPJ3ky/Lx
         Zg6uvHtt0KQm8uFqMtrO4k5ujNdomz9JZZelqhZ97zh5pkpIqxyhZZFSuTng5RqTiXaS
         vsos5lGzQpZC0uJ6+KC726lf81+w9FhXaKTjD1tMyPVI3XiyAbKdNMX6vau+SbjkagEs
         iPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710955012; x=1711559812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrHJYPRQxE5Zvv5TnRibVQ4dHuC7YD8BtX+J00w7sAs=;
        b=WhRoqj9rgT3nWprwwZk08OppJYvYOITbNMuNMTyB888jy479tSdtI/a83BU3oG7Hoz
         c+kYeg04QBx3andvfWWqe2LofZF1Nm49kyAAJh4W8J2szufVtpzbXBB95gVIM68+q/zf
         VS6kxbKJVy9MiEmP/UIkO3xqM0SxbOKO8p71FFa5zse6RFA+eKr4CNGxywhme1RKLOK8
         u1O/HWICtAM0ywpj8za6ydLfAktaGdCN2AyHzGZhmqBdPOb15rPxmtWy8sLUHbYmikxo
         FCXntYNqSP3ittn0V+mWWacNuS4giuq2nNMtu7aZbB5moyYerxWpxQ4C/+GMyhP7DQNV
         +rNw==
X-Forwarded-Encrypted: i=1; AJvYcCV+9gCEj56G+ZGUlSfATmHEbSPSV8CY64eB9u/3/trTta4TFS4n2ZDOxLZh4X2QLFp/81Skty22Ifi9dx6hJ16rldOlzud2h5GH18g5
X-Gm-Message-State: AOJu0YweuKVpt8my39Ub/yQlWZstoo/OyiKcVbG+/5QRaSYLvkVW1YtY
	FjYK/lj0yi5zfhBBx9ChxGXL4uUDWuWfMChNqNddAWYvAspmIvJWs80LxrEyqdf19UB2d5ZQWw9
	b5K1jRmYEfMqBfZWlaV1HxXNE+qyLTLYFJRMx
X-Google-Smtp-Source: AGHT+IGhYuvoUpEMguGI9pVuujlqsVK7YxGeJA4BXDEYnr+q81vjH/5j0TsYhHOQkkJGzGl3Gg9kg0vfb28GWP26+Yk=
X-Received: by 2002:a17:903:41c4:b0:1dd:65bd:69ec with SMTP id
 u4-20020a17090341c400b001dd65bd69ecmr305677ple.20.1710955012019; Wed, 20 Mar
 2024 10:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320145417.336208-1-visitorckw@gmail.com> <20240320145417.336208-14-visitorckw@gmail.com>
In-Reply-To: <20240320145417.336208-14-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 10:16:40 -0700
Message-ID: <CAP-5=fX-R=UGvb7a9hcFaRvWk-NiMvy9h2g+bKkTx5pQvjC9-A@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] lib/test_min_heap: Use min_heap_init() for initializing
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, dm-devel@lists.linux.dev, 
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 7:55=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Replace direct assignment of values to heap data members with
> min_heap_init() for better code readability and maintainability.
>
> Link: https://lkml.kernel.org/CAP-5=3DfW+FvUu8JL+KrtVv5uC++4AW=3DVhyEOgmd=
WzpH1mswQNzw@mail.gmail.com
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Ah, got it :-)

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  lib/test_min_heap.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
> index 062e908e9fa3..8d25fc8256db 100644
> --- a/lib/test_min_heap.c
> +++ b/lib/test_min_heap.c
> @@ -67,9 +67,8 @@ static __init int test_heapify_all(bool min_heap)
>                          -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
>         struct min_heap_test heap;
>
> -       heap.heap.data =3D values;
> +       min_heap_init(&heap, values, ARRAY_SIZE(values));
>         heap.heap.nr =3D ARRAY_SIZE(values);
> -       heap.heap.size =3D  ARRAY_SIZE(values);
>         struct min_heap_callbacks funcs =3D {
>                 .less =3D min_heap ? less_than : greater_than,
>                 .swp =3D swap_ints,
> @@ -99,9 +98,7 @@ static __init int test_heap_push(bool min_heap)
>         int values[ARRAY_SIZE(data)];
>         struct min_heap_test heap;
>
> -       heap.heap.data =3D values;
> -       heap.heap.nr =3D 0;
> -       heap.heap.size =3D  ARRAY_SIZE(values);
> +       min_heap_init(&heap, values, ARRAY_SIZE(values));
>         struct min_heap_callbacks funcs =3D {
>                 .less =3D min_heap ? less_than : greater_than,
>                 .swp =3D swap_ints,
> @@ -131,9 +128,7 @@ static __init int test_heap_pop_push(bool min_heap)
>         int values[ARRAY_SIZE(data)];
>         struct min_heap_test heap;
>
> -       heap.heap.data =3D values;
> -       heap.heap.nr =3D 0;
> -       heap.heap.size =3D  ARRAY_SIZE(values);
> +       min_heap_init(&heap, values, ARRAY_SIZE(values));
>         struct min_heap_callbacks funcs =3D {
>                 .less =3D min_heap ? less_than : greater_than,
>                 .swp =3D swap_ints,
> --
> 2.34.1
>

