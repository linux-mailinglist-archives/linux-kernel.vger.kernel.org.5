Return-Path: <linux-kernel+bounces-50667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0772847C51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7771F2849C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E1126F14;
	Fri,  2 Feb 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsUjw0ku"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D50126F0B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912948; cv=none; b=ml7TfH0xE1iw9IpC9SZFkAZSrySyJMMkbfc7SbNzbgAc07TkEr5xK4Pe5+RdODeV4dEVyJv9CbkiBqGAQ3OVKMhaJ1qI2XlanLVWuR+qz2VZ2oJmygdbGadZ1KPRmu5lY9wyaiAXXemr0DbWHdfM/bTnm5REU1PD5iuripdB1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912948; c=relaxed/simple;
	bh=QQmJYxnUlUSvt1/zDq1r4NkiHQ/BRoPpeizKUvdTjDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8lsql0PXcVMJ4+gyqwcaOc5tOaLr+upbXF4qDSaVJ7ON+m0OD4jCcKVlsufomt/pz6pGUCT6YiwMpeZb8zqjHDTn+GKGkJb7R1lyiI/QR1ct5yvCjYKWiiiX8ugpVFb1rNJNxYxe4F0SqBFMRkimlX0YE8qd9XLZE0fGvzNWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsUjw0ku; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c064c20ad4so18788839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706912946; x=1707517746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpWz3y9T5jk0N4AIQW/ncWnKm//RNwFNaUOWg6Hg2gY=;
        b=gsUjw0ku77tD/ANNEO9LvfH3VhISxPHcMBL04DT9CAxN2egW4iYAY8PiGjDRZyfMl+
         Zvyv6TYyFMwMt+fFVzc5JajZCN1/CAsV8lg0JJa7d2TDoU/z65u5QlASNCxYYKFtOpMp
         WdQZWDh2LT9jci3PofFwgrPK2t/UWZCDKdR8s9BGD8oHeMgpduhG3Inhgd+pAmtGO6KQ
         mcT38qdRZ5uMyWpjmESWsTQsQZj0ANSDde3EKpLwiFvNSi9Hujcnj+P1fQnwlJPdt5MA
         +edmPtFrLzmVUGz3gdNgi/UGiBc2lyZpVy/ufyLd1uOC8ESkFg28FBtTcnNMmmAp+VSD
         sO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912946; x=1707517746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpWz3y9T5jk0N4AIQW/ncWnKm//RNwFNaUOWg6Hg2gY=;
        b=Vs3h3LB+7/dqBKMh1CE2PUkj9g9DfPljmPWN289jU+ebmggRq5WhwBbqtHyS5GD38i
         SbxE4kDfjkYsArxTXdwlGBTe/oeF/+lIElhy5qPr5UojlsjQgNs+OXT05HNmGSyXc1HE
         N4TPM7030thZcPvhQSr765FyHOKZiXUp4hainfQB5R7C68vxaiRmCl4r+b6LyzQuK0Nx
         1cAW2MlnRR/oE6YHzoV+SMARTzDi388Ezqjx3PZeBu4v+UiQghydf9mTX1FRu65mCZR+
         r6WpPV79V4UzqFNwZ7B5uF2r0IOXw1Hh7TTlB1eRKYcDQJ7Rp4Lom1R2cXeN5HDqgS1F
         B0kw==
X-Gm-Message-State: AOJu0Yz6rYap8G+7ZXBSN2Ro58Qp6O2xeEHR1mx0X/cJa7c8atNfsDV0
	et3Qnt+dvwaHphOwKOYNb58g1ZB/+NZCmw4A9caBOfRVRq7UTrx8vyJEZWFDUSOQFwWF03fbvud
	IN2XesZenB2kWsSNY4ovKnhVixih/w19Xj7g=
X-Google-Smtp-Source: AGHT+IGd1s5f779+z/mlI9HNZsPpnP3PKjULBa46sWLQ2p/wBmfkcY/t1deG6xDJaQKsyZ39bJpUnOQ7NyGjE7cND5M=
X-Received: by 2002:a05:6e02:1a43:b0:363:8d25:a0a4 with SMTP id
 u3-20020a056e021a4300b003638d25a0a4mr380931ilv.12.1706912945776; Fri, 02 Feb
 2024 14:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Feb 2024 14:28:54 -0800
Message-ID: <CAKEwX=Pj9ms56zPaFznXrY0mF7E_q1hMXUkV-Fhnx5V17OY6og@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm/zswap: remove duplicate_entry debug value
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> cat /sys/kernel/debug/zswap/duplicate_entry
> 2086447
>
> When testing, the duplicate_entry value is very high, but no warning
> message in the kernel log. From the comment of duplicate_entry
> "Duplicate store was encountered (rare)", it seems something goes wrong.
>
> Actually it's incremented in the beginning of zswap_store(), which found
> its zswap entry has already on the tree. And this is a normal case,
> since the folio could leave zswap entry on the tree after swapin,
> later it's dirtied and swapout/zswap_store again, found its original
> zswap entry. (Maybe we can reuse it instead of invalidating it?)

Interesting. So if we make invalidate load the only mode, this oddity
is gone as well?

>
> So duplicate_entry should be only incremented in the real bug case,
> which already have "WARN_ON(1)", it looks redundant to count bug case,
> so this patch just remove it.

But yeah, I have literally never checked this value (maybe I should
ha). I'm fine with removing it, unless someone has a strong case for
this counter?

For now:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4381b7a2d4d6..3fbb7e2c8b8d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -71,8 +71,6 @@ static u64 zswap_reject_compress_poor;
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare)=
 */
>  static u64 zswap_reject_kmemcache_fail;
> -/* Duplicate store was encountered (rare) */
> -static u64 zswap_duplicate_entry;
>
>  /* Shrinker work queue */
>  static struct workqueue_struct *shrink_wq;
> @@ -1571,10 +1569,8 @@ bool zswap_store(struct folio *folio)
>          */
>         spin_lock(&tree->lock);
>         entry =3D zswap_rb_search(&tree->rbroot, offset);
> -       if (entry) {
> +       if (entry)
>                 zswap_invalidate_entry(tree, entry);
> -               zswap_duplicate_entry++;
> -       }
>         spin_unlock(&tree->lock);
>         objcg =3D get_obj_cgroup_from_folio(folio);
>         if (objcg && !obj_cgroup_may_zswap(objcg)) {
> @@ -1661,7 +1657,6 @@ bool zswap_store(struct folio *folio)
>          */
>         while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -E=
EXIST) {
>                 WARN_ON(1);
> -               zswap_duplicate_entry++;
>                 zswap_invalidate_entry(tree, dupentry);
>         }
>         if (entry->length) {
> @@ -1822,8 +1817,6 @@ static int zswap_debugfs_init(void)
>                            zswap_debugfs_root, &zswap_reject_compress_poo=
r);
>         debugfs_create_u64("written_back_pages", 0444,
>                            zswap_debugfs_root, &zswap_written_back_pages)=
;
> -       debugfs_create_u64("duplicate_entry", 0444,
> -                          zswap_debugfs_root, &zswap_duplicate_entry);
>         debugfs_create_u64("pool_total_size", 0444,
>                            zswap_debugfs_root, &zswap_pool_total_size);
>         debugfs_create_atomic_t("stored_pages", 0444,
>
> --
> b4 0.10.1

