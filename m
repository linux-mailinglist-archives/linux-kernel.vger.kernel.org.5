Return-Path: <linux-kernel+bounces-55976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F246F84C46F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4103288E22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F614F98;
	Wed,  7 Feb 2024 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLzDuAyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF41CD22
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284526; cv=none; b=TxNNIQ3Lq41DNnUUwm6uavqzSzT2sCWOwXQvZkLDbKRCLjWAJ0hJL1kfm2r3TnNKvU/qsmfCe80Xct7csEVyJ6dzlzE2+F35w24ZttkqaA0KTOKnK1hXDupsV26aO6lX1GhQ8NUkAv9M5kVxziBfTAg+fJ3eZPK9oXl2eRRqKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284526; c=relaxed/simple;
	bh=FgH8tnv5yRc3gbEHjgfT7POB2ce4RuHzox/ix/Fdxw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udyNWJYuxLXpBggR9GqBBD2PX3tdC0LZ8QJhsnsRmMCZhb6l334c3+xXU0w7S5nPl8ciTxp/UOfokOLeskq730yEiPU22AIK0GNQTNRI+7u5NCbZcoNPBt7zEdQScIGDMEmHm/XSe10v4iTfyFyRW9G8BpYtUvGS2lz1PM5lQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLzDuAyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C57BC433A6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707284526;
	bh=FgH8tnv5yRc3gbEHjgfT7POB2ce4RuHzox/ix/Fdxw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OLzDuAyDkJtvxaKy19srq2BFEWqRtctRUIw3lwOurfqnpSXTekjY8dCPrPAsi4uqe
	 eMkQGMm9ymCeupZTu9jdQWRgnYHxHeRe2V/Z/QR0oms0OPD1fhagjdbc7ZiR0UbvNK
	 GWLLyqeRwWJD1IPEREejUm9PxH+2CNskoaTuJAbc5xjQi3EcqhtdiZV37/M3iwuWei
	 Q6Ux4KD/+GTrT8IiSv5lGkuw0Y93e8NvwItRux6I4DE7FkujU33v5jLfoz6SBtgXo/
	 7UgSV1Pgyr+NFbdwPd4egKZxNIgkPvNrmbCGvXOb+0PGSHpt9zSr5b4WvTIajX7K/w
	 bodZCfVJN3XGQ==
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so17760839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 21:42:06 -0800 (PST)
X-Gm-Message-State: AOJu0YzbKGBwiCrzlD2vA/7lFE1azqdWEWU76FCI1SdqSIfL+rK7uFoW
	1VB6Ybrk+4wezrNgBpO2sWgDBuLPUm3KFgwgYw0nA1tfTGQfMDemHWhSNod4we5XmwRNN/huxJN
	nZiyqozuiSAhRlbD/4EaWncdpKouPt+fTpiLs
X-Google-Smtp-Source: AGHT+IGDXoXz7jBkmllm+YN/sz23Nu5IvF4AVg3js2wUAhQmGGQojd44IpYSEBJF+vwMJHRgA+5ET+KyIosZ+mdbTG0=
X-Received: by 2002:a92:d407:0:b0:363:d9eb:c2de with SMTP id
 q7-20020a92d407000000b00363d9ebc2demr1383300ilm.6.1707284525573; Tue, 06 Feb
 2024 21:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207033857.3820921-1-chengming.zhou@linux.dev>
In-Reply-To: <20240207033857.3820921-1-chengming.zhou@linux.dev>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 6 Feb 2024 21:41:53 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOCbuFemoFNUYeNGYzYJ7eGLka6Y6OvSg8h61vXUfYdLw@mail.gmail.com>
Message-ID: <CAF8kJuOCbuFemoFNUYeNGYzYJ7eGLka6Y6OvSg8h61vXUfYdLw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/zswap: invalidate old entry when store fail or !zswap_enabled
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 7:39=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> We may encounter duplicate entry in the zswap_store():
>
> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>    the zswap entry, then got reused. This has been fixed.
>
> 2. !exclusive load mode, swapin folio will leave its zswap entry
>    on the tree, then swapout again. This has been removed.
>
> 3. one folio can be dirtied again after zswap_store(), so need to
>    zswap_store() again. This should be handled correctly.

Thanks, I have been wondering about the cause of that for a while.

>
> So we must invalidate the old duplicate entry before insert the
> new one, which actually doesn't have to be done at the beginning
> of zswap_store(). And this is a normal situation, we shouldn't
> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
> to detect swap entry UAF problem? But not very necessary here.)
>
> The good point is that we don't need to lock tree twice in the
> store success path.
>
> Note we still need to invalidate the old duplicate entry in the
> store failure path, otherwise the new data in swapfile could be
> overwrite by the old data in zswap pool when lru writeback.
>
> We have to do this even when !zswap_enabled since zswap can be
> disabled anytime. If the folio store success before, then got
> dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback
> may overwrite the new data in swapfile.
>
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Cc: <stable@vger.kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v3:
>  - Fix a few grammatical problems in comments, per Yosry.
>
> v2:
>  - Change the duplicate entry invalidation loop to if, since we hold
>    the lock, we won't find it once we invalidate it, per Yosry.
>  - Add Fixes tag.
> ---
>  mm/zswap.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cd67f7f6b302..d9d8947d6761 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1518,18 +1518,8 @@ bool zswap_store(struct folio *folio)
>                 return false;
>
>         if (!zswap_enabled)
> -               return false;
> +               goto check_old;
>
> -       /*
> -        * If this is a duplicate, it must be removed before attempting t=
o store
> -        * it, otherwise, if the store fails the old page won't be remove=
d from
> -        * the tree, and it might be written back overriding the new data=
.
> -        */
> -       spin_lock(&tree->lock);
> -       entry =3D zswap_rb_search(&tree->rbroot, offset);
> -       if (entry)
> -               zswap_invalidate_entry(tree, entry);
> -       spin_unlock(&tree->lock);
>         objcg =3D get_obj_cgroup_from_folio(folio);
>         if (objcg && !obj_cgroup_may_zswap(objcg)) {
>                 memcg =3D get_mem_cgroup_from_objcg(objcg);
> @@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
>         /* map */
>         spin_lock(&tree->lock);
>         /*
> -        * A duplicate entry should have been removed at the beginning of=
 this
> -        * function. Since the swap entry should be pinned, if a duplicat=
e is
> -        * found again here it means that something went wrong in the swa=
p
> -        * cache.
> +        * The folio may have been dirtied again, invalidate the
> +        * possibly stale entry before inserting the new entry.
>          */
> -       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -E=
EXIST) {
> -               WARN_ON(1);
> +       if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXI=
ST) {
>                 zswap_invalidate_entry(tree, dupentry);
> +               VM_WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentr=
y));

It seems there is only one path called zswap_rb_insert() and there is
no loop to repeat the insert any more. Can we have the
zswap_rb_insert() install the entry and return the dupentry? We can
still just call zswap_invalidate_entry() on the duplicate. The mapping
of the dupentry has been removed when  zswap_rb_insert() returns. That
will save a repeat lookup on the duplicate case.
After this change, the zswap_rb_insert() will map to the xarray
xa_store() pretty nicely.

Chris

>         }
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
> @@ -1638,6 +1626,17 @@ bool zswap_store(struct folio *folio)
>  reject:
>         if (objcg)
>                 obj_cgroup_put(objcg);
> +check_old:
> +       /*
> +        * If the zswap store fails or zswap is disabled, we must invalid=
ate the
> +        * possibly stale entry which was previously stored at this offse=
t.
> +        * Otherwise, writeback could overwrite the new data in the swapf=
ile.
> +        */
> +       spin_lock(&tree->lock);
> +       entry =3D zswap_rb_search(&tree->rbroot, offset);
> +       if (entry)
> +               zswap_invalidate_entry(tree, entry);
> +       spin_unlock(&tree->lock);
>         return false;
>
>  shrink:
> --
> 2.40.1
>
>

