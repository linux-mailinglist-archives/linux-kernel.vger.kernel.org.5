Return-Path: <linux-kernel+bounces-79745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3D862627
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20861C213B0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B73E493;
	Sat, 24 Feb 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkROrc93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D74C6B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793638; cv=none; b=fCGiFj4G7ypMJSAPOfjHc2IGLlTUNIbNI55f6ghJv30aYeoTWXuc6nIzhrFCJK1VgWIk1BwcVkIEYzmM6tT3hnNcaW2V6uokLl0pL36yILqs7hzeDKq57dCHDk5SGTyVaeTsiQOy8vmu4B2sn/cfZJ5k9QBGjQtFBMydE7f3T2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793638; c=relaxed/simple;
	bh=z9zQiP3XZXSgVaP4ozx7WT6lEl1K4J/Q7eJNF6Jv8m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPwuCrc8U3iDAJ4K4pvCnDj4JlG73AyHtIHta6bnpkEH3ArwGEcAD3K8YFCDH+ZFcLU5pJnr0hhg6t2WRdaZIK5joHGSaOhUhk94amLZ6+vNF1LZ3w1K+HcasqiZ+Ib94mcXRNlJ41KuCeFaoceoGhHXQT0xuwtb6nJ9O3jk+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkROrc93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33361C4166A
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708793638;
	bh=z9zQiP3XZXSgVaP4ozx7WT6lEl1K4J/Q7eJNF6Jv8m4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZkROrc934Ipl6NHNHnwyToE+bfGW2rDvuPc10PLblBYpyiIUfBtjCM/UKTmYgLi92
	 IpFtO4qVJ74Xj80R2YdjzwNQFVgyRzzdu33qzbm3DVDhqLFlWcAtbgaNm8lfg4KFji
	 8ZlZ9C/SesV25q2gtHiyZ77V+j43Sk+I0HGA1tFsV0Ltj7a0+9GYRKIsqcmd3iflvz
	 bwXLa1b1sTsOureqC71dSHIr2MKD6Srk1nml67bDQnBDCtOZgW1mF/v+FYgtGrOn0a
	 cXAPnRHzXJ8FoyzC1bW5nZYR4vyYbZNZOxy7ccUo3CcU+JMGxjwZNEw4MpX1XcjgUI
	 GBplIvhVzToFA==
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3650b558a8cso5552355ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 08:53:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAT89s11qvEBYFQe/3YVugFQyS/jIp71WYqcBXkQGK9NiPcH2Lk/xIqb1gKYOeT+ZMB9cJNgH/mJ/pVdBnDHxbE+kYzptRrfTgOcWS
X-Gm-Message-State: AOJu0Yw7pfpsJv8w+sT02s1xpJJ08l9ZX9yHO566gTCKHbuOAEqsj45E
	4+sq8KpI2uVftFbTNm3U34+0SHN7ejfcHr9YV6O2jBE3F94Q9ZlBdmKF3/2qHsYNXa2RTbCGwLn
	2xJNORKpQpZr6eROeX0y7UuCBFvR+Jw7+n/lM
X-Google-Smtp-Source: AGHT+IFyT5hm/6XLvoYvExLY1LoEhxSoh4Cw8lHR+VE6pVCsWW9ltPb45mVeXnwzbDPYLbix+0vPxhd9zRAUxAGnWUg=
X-Received: by 2002:a05:6e02:13e5:b0:363:e99e:42e0 with SMTP id
 w5-20020a056e0213e500b00363e99e42e0mr3109696ilj.15.1708793637472; Sat, 24 Feb
 2024 08:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081135.173040-1-21cnbao@gmail.com> <20240222081135.173040-3-21cnbao@gmail.com>
In-Reply-To: <20240222081135.173040-3-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 24 Feb 2024 08:53:46 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO5+EzXhSan=Fxs4exaKNTjUg2kXfbvqMs2WBUUBYsC_A@mail.gmail.com>
Message-ID: <CAF8kJuO5+EzXhSan=Fxs4exaKNTjUg2kXfbvqMs2WBUUBYsC_A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm/zswap: remove the memcpy if acomp is not sleepable
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, yosryahmed@google.com, zhouchengming@bytedance.com, 
	ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Thu, Feb 22, 2024 at 12:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Most compressors are actually CPU-based and won't sleep during
> compression and decompression. We should remove the redundant
> memcpy for them.
> This patch checks if the algorithm is sleepable by testing the
> CRYPTO_ALG_ASYNC algorithm flag.
> Generally speaking, async and sleepable are semantically similar
> but not equal. But for compress drivers, they are basically equal
> at least due to the below facts.
> Firstly, scompress drivers - crypto/deflate.c, lz4.c, zstd.c,
> lzo.c etc have no sleep. Secondly, zRAM has been using these
> scompress drivers for years in atomic contexts, and never
> worried those drivers going to sleep.
> One exception is that an async driver can sometimes still return
> synchronously per Herbert's clarification. In this case, we are
> still having a redundant memcpy. But we can't know if one
> particular acomp request will sleep or not unless crypto can
> expose more details for each specific request from offload
> drivers.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 011e068eb355..de3c9e30bed7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -162,6 +162,7 @@ struct crypto_acomp_ctx {
>         struct crypto_wait wait;
>         u8 *buffer;
>         struct mutex mutex;
> +       bool is_sleepable;
>  };
>
>  /*
> @@ -950,6 +951,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
>                 goto acomp_fail;
>         }
>         acomp_ctx->acomp =3D acomp;
> +       acomp_ctx->is_sleepable =3D acomp_is_async(acomp);
>
>         req =3D acomp_request_alloc(acomp_ctx->acomp);
>         if (!req) {
> @@ -1077,7 +1079,7 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct page *page)
>         mutex_lock(&acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> -       if (!zpool_can_sleep_mapped(zpool)) {
> +       if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
>                 memcpy(acomp_ctx->buffer, src, entry->length);
>                 src =3D acomp_ctx->buffer;
>                 zpool_unmap_handle(zpool, entry->handle);
> @@ -1091,7 +1093,7 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct page *page)
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
>         mutex_unlock(&acomp_ctx->mutex);
>
> -       if (zpool_can_sleep_mapped(zpool))
> +       if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
>  }
>
> --
> 2.34.1
>

