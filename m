Return-Path: <linux-kernel+bounces-55850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F884C27C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCD91F21E28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649ECF9DB;
	Wed,  7 Feb 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PvQ5YOH0"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE9EEAC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272739; cv=none; b=N92mqhEKOFOegKHSCtkKZIbYZd3vFosJlLBPV4ls2Ky2dA7AjcXjJnkNeXtNvx6gtUsB1pOQ3J6MogeiJ3teY83nRnP3u46UkFTvmIg3/hhca/1K8Qy+bZbAyOAjgNNFcMrrLaQKB5pQ37+hQkLxhuQgWtFge9UZXe64FrlFHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272739; c=relaxed/simple;
	bh=OuRoN1AaajxzC9NcM1BSle+BErg7eCWnR8Pv33SqleQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cfpnOinnZXAE1YOYNJl5SyFk4Qh2nwJI74N8y158dImxSDXyFGyyARc67cqQ+yN4xP9QwJuSOuwSGZrPmbeHtSu4Mqt40fouSLdS5zl2HNf0Gz/X6jRuIJ7YJsXoNpmGM6pV8/m+nNPRT7kHa9uBwWVDVw1m0MQ1tj/QxqrKRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PvQ5YOH0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707272735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxDGt9b3bgYXiw9ZtkUhOb/RH81efkpcL0KqwcN75VA=;
	b=PvQ5YOH00zOroTBNYKsZS52hOf+6xeqTmhSZoJIDwWQuhwYD2kGq/THf2t9yMELPeqFqwa
	hSMc7XmhwbuGoUTbDCkjBE0rEfqcv24cUEsg0/x2Upsy9PoBTc4Wd7KAV8gn8VO3hkvqfH
	o+26BJbbfBmzRv2GjgeVeFuLfvrHUoc=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3] mm: hugetlb: improve the handling of hugetlb allocation failure for freed or in-use hugetlb
Date: Wed, 7 Feb 2024 10:24:52 +0800
Message-Id: <CB00D336-84AE-412C-ACA4-254EDD3C2279@linux.dev>
References: <62890fd60b1ecd5bf1cdc476c973f60fe37aa0cb.1707181934.git.baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
 mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <62890fd60b1ecd5bf1cdc476c973f60fe37aa0cb.1707181934.git.baolin.wang@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 6, 2024, at 11:08, Baolin Wang <baolin.wang@linux.alibaba.com> wrot=
e:
>=20
> =EF=BB=BFalloc_and_dissolve_hugetlb_folio() preallocates a new hugetlb pag=
e before
> it takes hugetlb_lock. In 3 out of 4 cases the page is not really used and=

> therefore the newly allocated page is just freed right away. This is
> wasteful and it might cause pre-mature failures in those cases.
>=20
> Address that by moving the allocation down to the only case (hugetlb
> page is really in the free pages pool). We need to drop hugetlb_lock
> to do so and therefore need to recheck the page state after regaining
> it.
>=20
> The patch is more of a cleanup than an actual fix to an existing
> problem. There are no known reports about pre-mature failures.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks

> ---
> Changes from v2=EF=BC=9B
> - Update the commit message suggested by Michal.
> - Remove unnecessary comments.
> Changes from v1:
> - Update the suject line per Muchun.
> - Move the allocation into the free hugetlb handling branch per Michal.
> ---
> mm/hugetlb.c | 32 ++++++++++++++++----------------
> 1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9d996fe4ecd9..a05507a2143f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3031,21 +3031,9 @@ static int alloc_and_dissolve_hugetlb_folio(struct h=
state *h,
> {
>    gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THISNODE;
>    int nid =3D folio_nid(old_folio);
> -    struct folio *new_folio;
> +    struct folio *new_folio =3D NULL;
>    int ret =3D 0;
>=20
> -    /*
> -     * Before dissolving the folio, we need to allocate a new one for the=

> -     * pool to remain stable.  Here, we allocate the folio and 'prep' it
> -     * by doing everything but actually updating counters and adding to
> -     * the pool.  This simplifies and let us do most of the processing
> -     * under the lock.
> -     */
> -    new_folio =3D alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL)=
;
> -    if (!new_folio)
> -        return -ENOMEM;
> -    __prep_new_hugetlb_folio(h, new_folio);
> -
> retry:
>    spin_lock_irq(&hugetlb_lock);
>    if (!folio_test_hugetlb(old_folio)) {
> @@ -3075,6 +3063,16 @@ static int alloc_and_dissolve_hugetlb_folio(struct h=
state *h,
>        cond_resched();
>        goto retry;
>    } else {
> +        if (!new_folio) {
> +            spin_unlock_irq(&hugetlb_lock);
> +            new_folio =3D alloc_buddy_hugetlb_folio(h, gfp_mask, nid,
> +                                  NULL, NULL);
> +            if (!new_folio)
> +                return -ENOMEM;
> +            __prep_new_hugetlb_folio(h, new_folio);
> +            goto retry;
> +        }
> +
>        /*
>         * Ok, old_folio is still a genuine free hugepage. Remove it from
>         * the freelist and decrease the counters. These will be
> @@ -3102,9 +3100,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct h=
state *h,
>=20
> free_new:
>    spin_unlock_irq(&hugetlb_lock);
> -    /* Folio has a zero ref count, but needs a ref to be freed */
> -    folio_ref_unfreeze(new_folio, 1);
> -    update_and_free_hugetlb_folio(h, new_folio, false);
> +    if (new_folio) {
> +        /* Folio has a zero ref count, but needs a ref to be freed */
> +        folio_ref_unfreeze(new_folio, 1);
> +        update_and_free_hugetlb_folio(h, new_folio, false);
> +    }
>=20
>    return ret;
> }
> --=20
> 2.39.3
>=20

