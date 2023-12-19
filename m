Return-Path: <linux-kernel+bounces-5118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3D8186B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8841F23859
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78D179AD;
	Tue, 19 Dec 2023 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4xYrQ+t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B617988
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136F2C433C9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702986983;
	bh=W4Km5BUCImieH3TlsrHeoYW32Py36cu158I8pZSmnfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M4xYrQ+tIPHsJdvVFMVpYxh0B/UzD/hWUc7XCGanXCyP6mB0yoAQWYrCiwgoG7q8b
	 /Rz7pvNVmpG74CUSPhv16sjidihMUodqbd/eEkSHUC1vFALVda6tKx31jN1B52DWN9
	 0acwVTJUGcwIchRDiXe87zcd87N466C7ROsAMBDTsxxJ708xMBQunNcshdiiq09szc
	 1VtFt6L6npAt5Zkiz1bznGbamFcRxKb8jSXaBev0Iq/UsPwdGISOyM44dwA8DUEt7T
	 0+NUvyL44YI5WUdEaxglPt30eaFad0TTUx6QfrP4fj3xzLS97E9uFSOvf+K1eEarQY
	 hgpRzLRAs+Vyg==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso3707920a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:56:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxdwAXHoJ4Vh5D6aLbeGDXcIQBnPkZLVxLRyvb2+Zrcay4rHirZ
	60INM+VDAYucDfJNaCKQnUW3SuX7pWFA7p7E9RiPgQ==
X-Google-Smtp-Source: AGHT+IHvvxHbPHkj8Vwa4wMSIQTUgNRZuXA3BmwwDBi2HgelcGrTVhk+BEG6Gg7UKtpwRvBCXv63qfAGii9NBTEQIhg=
X-Received: by 2002:a17:90a:4f0e:b0:28b:7c39:2d98 with SMTP id
 p14-20020a17090a4f0e00b0028b7c392d98mr2329863pjh.25.1702986982592; Tue, 19
 Dec 2023 03:56:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com> <20231213-zswap-dstmem-v2-1-daa5d9ae41a7@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v2-1-daa5d9ae41a7@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Dec 2023 03:56:10 -0800
X-Gmail-Original-Message-ID: <CAF8kJuP5SHT+1n1xqtFZyrxUBOY7AqJFy6QSeLcYbdZZ8Wiv3A@mail.gmail.com>
Message-ID: <CAF8kJuP5SHT+1n1xqtFZyrxUBOY7AqJFy6QSeLcYbdZZ8Wiv3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm/zswap: change dstmem size to one page
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Nhat Pham <nphamcs@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org> (Google)

Chris

On Mon, Dec 18, 2023 at 12:22=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Change the dstmem size from 2 * PAGE_SIZE to only one page since
> we only need at most one page when compress, and the "dlen" is also
> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
> we don't wanna store the output in zswap anyway.
>
> So change it to one page, and delete the stale comment.
>
> There is no any history about the reason why we needed 2 pages, it has
> been 2 * PAGE_SIZE since the time zswap was first merged.
>
> According to Yosry and Nhat, one potential reason is that we used to
> store a zswap header containing the swap entry in the compressed page
> for writeback purposes, but we don't do that anymore.
>
> This patch works good in kernel build testing even when the input data
> doesn't compress at all (i.e. dlen =3D=3D PAGE_SIZE), which we can see
> from the bpftrace tool:
>
> bpftrace -e 'k:zpool_malloc {@[(uint32)arg1=3D=3D4096]=3Dcount()}'
> @[1]: 2
> @[0]: 12011430
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7ee54a3d8281..976f278aa507 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -707,7 +707,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
>         struct mutex *mutex;
>         u8 *dst;
>
> -       dst =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu))=
;
> +       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
>         if (!dst)
>                 return -ENOMEM;
>
> @@ -1662,8 +1662,7 @@ bool zswap_store(struct folio *folio)
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
>
> -       /* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_li=
st */
> -       sg_init_one(&output, dst, PAGE_SIZE * 2);
> +       sg_init_one(&output, dst, PAGE_SIZE);
>         acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
>         /*
>          * it maybe looks a little bit silly that we send an asynchronous=
 request,
>
> --
> b4 0.10.1

