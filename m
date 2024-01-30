Return-Path: <linux-kernel+bounces-44912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE18842900
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947AD283C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764186AF7;
	Tue, 30 Jan 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNBV9PqV"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632386AE7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631705; cv=none; b=S3KK+/8wRHJHQiAm+lpf621rXSv2jW/ZGmvCK0VoFMT0yKKzlQtgaU4pEe/pT6mRgRLye+8UaZklQpVybNU+P94Pxfah6ibSIpXk4PwTZfWq2QJzxMR84paIU3hKtjdRmeJDPBaiWqa+I3gHThRlJh3R7q7lDR/IZSrRXNOSvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631705; c=relaxed/simple;
	bh=ZoTXqAawfFOPJaM9uWkJ6nckbuWDe705Xaebu8R1xfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKZZxJqvn88Xr2yx4BoEkP4RZ5Rdsfeb2w6ku5EbhqXYvqtlg3Qg/4hC/E+tFc4wSYlHhkv+/6KcNQqqxxsIHgCOlfuOMs405u6WqheCrEhr5erJOk2p+DHv8ptvNwOCk7T2MB1fnbYUuc5nptYX1KB/ZaKTRpfuBwAzPWJK5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNBV9PqV; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bffface817so60792139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706631702; x=1707236502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AflKDfWvlGw5qdywRHr9cPLeGhB9EGNqNEemcMp55J4=;
        b=PNBV9PqVWLbUj0CWL5kC9LOCYlne1dO5QEsagaDr4DWOLwKS8DOW/+PhqTs9WYph15
         VUgEP6eXgsXQVIEwHEpz1UekH2/WlTql8ZVLMToGWDWYJkZZ4x88Egpk9nTo6gNi75DI
         b3moQYekw+BnOFPglYXWdgmSinkwZaVLN9Y6zNIn5RNHzZLon+xfORP9Wu+7B/gstZqU
         jPRZ8zrZwmZ3y1WQnCjmkOLSgS4JXBakgdJbowAa8vysZjZtQ7TLNfXYAdVZTm/p9U0a
         57MH0uV8mW4pbi0mAyFekkR4qTgPOnA8Ohp863qRSzJzAmVTc3nleB4ByvY86e4sS9Ro
         2sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631702; x=1707236502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AflKDfWvlGw5qdywRHr9cPLeGhB9EGNqNEemcMp55J4=;
        b=rojRsYkOZ2hIsjjTX1TtlcVtDSXrvl+X0jXUC7Axr1cR+yYDG2nFkMHN/FtnKQ7Z7X
         10N2CGFDrzCwk50PneEa8Uz4uLQczku3GpL68EH/enDEHP99XGnzBL2jgChIa4dPeM9D
         W0MkRanlIb59YvgkHPl2IVHN/P/iRhX70z5b6lhQ1yRJHL9NNFBkQT9DaecSq5jhx54A
         OyypVC5wPuIEjDar+PEx/mPN6FVevMcj/6uZaCjIQcBfPVpks1dqjk5p2bySeadYPvA8
         TfsY0asIAhirMUo4dZQFyFgJAcAvbEsNRrrb7xhhL4tW9Bs52HzMC5evDJxkkPr7t+QY
         LtvQ==
X-Gm-Message-State: AOJu0Yw7wVw76ejyYoDfPrinbPvLcNpyD1rOOQwXurUb4V4EFTzPwPhW
	vmbyaS6D3tdfKeIpIBmF9KcwtzAwIPjTUUmkwky1xf84MWp8xIeC84Gz8qh5WKF+ZW8c4dJrFs9
	cOqgiFr80uiBkbmj5ejRJB2gu2zI=
X-Google-Smtp-Source: AGHT+IH9iD5NQgWDxIpLd1KkGLSeZbaNpPoZ44ePMCg1ia4YEyZLat4eJk7qzKnT4DjhkFsktc2Oa6c87tBulTT43NY=
X-Received: by 2002:a05:6e02:1a25:b0:363:6da9:2bc3 with SMTP id
 g5-20020a056e021a2500b003636da92bc3mr8965204ile.11.1706631702636; Tue, 30 Jan
 2024 08:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-8-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-8-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 08:21:31 -0800
Message-ID: <CAKEwX=MCqHwUA5mH4kPdG4O0joqeHvjUhT8rD42avQxJg7hnxA@mail.gmail.com>
Subject: Re: [PATCH 07/20] mm: zswap: break out zwap_compress()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> zswap_store() is long and mixes work at the zswap layer with work at
> the backend and compression layer. Move compression & backend work to
> zswap_compress(), mirroring zswap_decompress().
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 145 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 77 insertions(+), 68 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index bdc9f82fe4b9..f9b9494156ba 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1316,6 +1316,79 @@ static int zswap_enabled_param_set(const char *val=
,
>         return ret;
>  }
>
> +static bool zswap_compress(struct folio *folio, struct zswap_entry *entr=
y)
> +{
> +       struct crypto_acomp_ctx *acomp_ctx;
> +       struct scatterlist input, output;
> +       unsigned int dlen =3D PAGE_SIZE;
> +       unsigned long handle;
> +       struct zpool *zpool;
> +       char *buf;
> +       gfp_t gfp;
> +       int ret;
> +       u8 *dst;
> +
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +
> +       mutex_lock(&acomp_ctx->mutex);
> +
> +       dst =3D acomp_ctx->buffer;
> +       sg_init_table(&input, 1);
> +       sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
> +
> +       /*
> +        * We need PAGE_SIZE * 2 here since there maybe over-compression =
case,
> +        * and hardware-accelerators may won't check the dst buffer size,=
 so
> +        * giving the dst buffer with enough length to avoid buffer overf=
low.
> +        */
> +       sg_init_one(&output, dst, PAGE_SIZE * 2);
> +       acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
> +
> +       /*
> +        * it maybe looks a little bit silly that we send an asynchronous=
 request,
> +        * then wait for its completion synchronously. This makes the pro=
cess look
> +        * synchronous in fact.
> +        * Theoretically, acomp supports users send multiple acomp reques=
ts in one
> +        * acomp instance, then get those requests done simultaneously. b=
ut in this
> +        * case, zswap actually does store and load page by page, there i=
s no
> +        * existing method to send the second page before the first page =
is done
> +        * in one thread doing zwap.
> +        * but in different threads running on different cpu, we have dif=
ferent
> +        * acomp instance, so multiple threads can do (de)compression in =
parallel.
> +        */
> +       ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &a=
comp_ctx->wait);
> +       dlen =3D acomp_ctx->req->dlen;
> +       if (ret) {
> +               zswap_reject_compress_fail++;
> +               goto unlock;
> +       }
> +
> +       zpool =3D zswap_find_zpool(entry);
> +       gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> +       if (zpool_malloc_support_movable(zpool))
> +               gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> +       ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
> +       if (ret =3D=3D -ENOSPC) {
> +               zswap_reject_compress_poor++;
> +               goto unlock;
> +       }
> +       if (ret) {
> +               zswap_reject_alloc_fail++;
> +               goto unlock;
> +       }
> +
> +       buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> +       memcpy(buf, dst, dlen);
> +       zpool_unmap_handle(zpool, handle);
> +
> +       entry->handle =3D handle;
> +       entry->length =3D dlen;
> +
> +unlock:
> +       mutex_unlock(&acomp_ctx->mutex);
> +       return ret =3D=3D 0;
> +}
> +
>  static void zswap_decompress(struct zswap_entry *entry, struct page *pag=
e)
>  {
>         struct zpool *zpool =3D zswap_find_zpool(entry);
> @@ -1472,18 +1545,11 @@ bool zswap_store(struct folio *folio)
>         struct page *page =3D &folio->page;
>         struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry, *dupentry;
> -       struct scatterlist input, output;
> -       struct crypto_acomp_ctx *acomp_ctx;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>         struct zswap_pool *pool;
> -       struct zpool *zpool;
> -       unsigned int dlen =3D PAGE_SIZE;
> -       unsigned long handle, value;
> -       char *buf;
> -       u8 *src, *dst;
> -       gfp_t gfp;
> -       int ret;
> +       unsigned long value;
> +       u8 *src;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1568,65 +1634,10 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> -       /* compress */
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -
> -       mutex_lock(&acomp_ctx->mutex);
> -
> -       dst =3D acomp_ctx->buffer;
> -       sg_init_table(&input, 1);
> -       sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
> +       if (!zswap_compress(folio, entry))
> +               goto put_pool;
>
> -       /*
> -        * We need PAGE_SIZE * 2 here since there maybe over-compression =
case,
> -        * and hardware-accelerators may won't check the dst buffer size,=
 so
> -        * giving the dst buffer with enough length to avoid buffer overf=
low.
> -        */
> -       sg_init_one(&output, dst, PAGE_SIZE * 2);
> -       acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
> -       /*
> -        * it maybe looks a little bit silly that we send an asynchronous=
 request,
> -        * then wait for its completion synchronously. This makes the pro=
cess look
> -        * synchronous in fact.
> -        * Theoretically, acomp supports users send multiple acomp reques=
ts in one
> -        * acomp instance, then get those requests done simultaneously. b=
ut in this
> -        * case, zswap actually does store and load page by page, there i=
s no
> -        * existing method to send the second page before the first page =
is done
> -        * in one thread doing zwap.
> -        * but in different threads running on different cpu, we have dif=
ferent
> -        * acomp instance, so multiple threads can do (de)compression in =
parallel.
> -        */
> -       ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &a=
comp_ctx->wait);
> -       dlen =3D acomp_ctx->req->dlen;
> -
> -       if (ret) {
> -               zswap_reject_compress_fail++;
> -               goto put_dstmem;
> -       }
> -
> -       /* store */
> -       zpool =3D zswap_find_zpool(entry);
> -       gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> -       if (zpool_malloc_support_movable(zpool))
> -               gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> -       ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
> -       if (ret =3D=3D -ENOSPC) {
> -               zswap_reject_compress_poor++;
> -               goto put_dstmem;
> -       }
> -       if (ret) {
> -               zswap_reject_alloc_fail++;
> -               goto put_dstmem;
> -       }
> -       buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> -       memcpy(buf, dst, dlen);
> -       zpool_unmap_handle(zpool, handle);
> -       mutex_unlock(&acomp_ctx->mutex);
> -
> -       /* populate entry */
>         entry->swpentry =3D swp;
> -       entry->handle =3D handle;
> -       entry->length =3D dlen;
>
>  insert_entry:
>         entry->objcg =3D objcg;
> @@ -1663,8 +1674,6 @@ bool zswap_store(struct folio *folio)
>
>         return true;
>
> -put_dstmem:
> -       mutex_unlock(&acomp_ctx->mutex);
>  put_pool:
>         zswap_pool_put(entry->pool);
>  freepage:
> --
> 2.43.0
>

LGTM :)
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

