Return-Path: <linux-kernel+bounces-135020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EAB89BA09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998AF283354
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F102DF73;
	Mon,  8 Apr 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUS6KZZf"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052522C69C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564381; cv=none; b=jjgoXSsbcNP2BBv5YkvNJaqQNXfunUi4PvURNg9xRyOWOY9sSGs7QnqIzjCmDgqvzKqV5LVRp9L3dPsVVDZ4qxXcvHLtypWPGsWGAmn4gl+pIFDqlUfM9BFwOSy1anREzXziPXjExP20eRHRG9aCUnd60SHLagxJZQxQL6B2apM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564381; c=relaxed/simple;
	bh=3xyKNVnpyx7eTuoCOHoqqHyJSp+D6SnTDkUbYoFulbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaqyLTzaLakeNNrBQnDbNpGW/6FpT/n1sKylebbrIDmsZVNKf2sopzDRwgc6nyRrQqoQP71IFZ91Zve2xHX4xyZ0lss9GsM/Oa1xsQW/EF301HV5OSLdLJUQHo8zvt2krHWM33p2S2v9Om0SlTx7cP9txCcNP93pObC/2f+GVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUS6KZZf; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e057fb0b69so889275241.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712564379; x=1713169179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX5+jXHMJTfU3cppVGB1oM10Q5k8KJr3dApT/VnvvYU=;
        b=WUS6KZZffhntHjBHPFuISwpGxTINGTH+KvrV9GZEzh3Mi5xcz8uMtQsrcAL2fXqOXb
         h/WlEqeU0Ul6YKVRwhD3kyysYfDl5CR80WtiadBPmhecL3pY5l475mK6X8WHaIMidqrp
         8+foXHWDccz1J0zY8NkHgE5aglaefiCHz7fqkdvyoCMaCWf7Hz3LKH/czOxFpA9UxIg5
         KrL5rlBE+7iiJt6rIFZOFiL+kPLONknKnyHaI6iF2mvfWTj+HIYcKDOGQp33awEiSndE
         g8cgj6MXdzjpGCRnWHSx9HL1LpNfaNmbR3NQsD5JcNeIw+kHTgmD88imK25J7TgoctbS
         MJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564379; x=1713169179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX5+jXHMJTfU3cppVGB1oM10Q5k8KJr3dApT/VnvvYU=;
        b=VePq3NX0KgdX/A6lcy6G5ZytwvN6R5549t9dMkVNkyB9ppBBUidV/Qz6nOou+ilWVh
         Qv4815WUnRUw8YJ60uyEInwCqHVGEAIfQ5rD5mtuwlj3rlbhQjnk3DcAlDVGahYbkkYN
         InObjeg473Dje10raWBhmN+LfRVemkzp21U1QzmnHKvoFjuh4Bo9Zhej5M1HrDNn1nyb
         zno/gSIfvOsYvn6zZuyb/mdwjTX0j6cpzV87Uc1SKAGI9KE/iFDEuV5XTkvAIAf1h0/a
         s9W1dpOq6lrrw3cI/G2BlwbltqzHzvCWEQllpBaTyu+ap+UaAWwejPtBpspf5hkQ3r3R
         oE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhiKRcIhZdujYlc/ALI4596T50jF97Cp2gzoSkGi2eqivzHiES9eKruDTg9e8WXwhh7iYVtatu7hpevg7R01OrRefyDpAl2QEyuCt3
X-Gm-Message-State: AOJu0YwzG2EBYs0yHzb5eHGo1wasr6nuWe9z5qEMjybAjRHk1TOs5AAM
	h5x2agRZZzWJToI7MNUEvV4oDCdI2Z3Nx9qNZ0t8FncNeYShgjuHuUHbMIGmcHpmI5b6vHRVqFR
	8BrMTyzYaTFUzDpfOKA9v2saf16k=
X-Google-Smtp-Source: AGHT+IHwKABiDH+sg4ocAOFV1rysPCy6M6jUel2pd3ftK4+6+b2hwxv91016VKyxPctK/xPT3DR2sG4D7Wn8cgcCrtA=
X-Received: by 2002:a05:6102:32c8:b0:47a:110:143e with SMTP id
 o8-20020a05610232c800b0047a0110143emr1628878vss.6.1712564378854; Mon, 08 Apr
 2024 01:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408080539.14282-1-liuhailong@oppo.com>
In-Reply-To: <20240408080539.14282-1-liuhailong@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 8 Apr 2024 20:19:26 +1200
Message-ID: <CAGsJ_4y7oGpxrgaWp=0WmG-zdkr2JmqMxnqQdjTsc1Q=5kKdoQ@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: do not skip CMA while LRU is full of CMA folios
To: liuhailong@oppo.com
Cc: akpm@linux-foundation.org, nathan@kernel.org, ndesaulniers@google.com, 
	trix@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, surenb@google.com, zhaoyang.huang@unisoc.com, 
	quic_charante@quicinc.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:06=E2=80=AFPM <liuhailong@oppo.com> wrote:
>
> From: liuhailong <liuhailong@oppo.com>
>
> If the allocation flag isn't movable, commit 5da226dbfce3 ("mm:
> skip CMA pages when they are not available") skips CMA during direct
> reclamation. This generally speeds up the reclamation of non-movable
> folios. However, in scenarios with limited system memory and a majority
> of reclaimable folios in LRU being from CMA, this can result in prolonged
> idle loops where the system reclaims nothing but consumes CPU.
>
> I traced the process of a thread entering direct reclamation,
> and printed the relevant information of the sc(scan_control).
> __alloc_pages_direct_reclaim start
> sc->priority:9 sc->nr_skipped_cma:32208  sc->nr_scanned:36  sc->nr_reclai=
med:3
> sc->priority:8 sc->nr_skipped_cma:32199  sc->nr_scanned:69  sc->nr_reclai=
med:3
> sc->priority:7 sc->nr_skipped_cma:198405 sc->nr_scanned:121 sc->nr_reclai=
med:3
> sc->priority:6 sc->nr_skipped_cma:236713 sc->nr_scanned:147 sc->nr_reclai=
med:3
> sc->priority:5 sc->nr_skipped_cma:708209 sc->nr_scanned:379 sc->nr_reclai=
med:3
> sc->priority:4 sc->nr_skipped_cma:785537 sc->nr_scanned:646 sc->nr_reclai=
med:3
> __alloc_pages_direct_reclaim end duration 3356ms
>
> Continuously skipping CMA even when the LRU is filled with CMA
> folios can also result in lmkd failing to terminate processes. The
> duration of psi_memstall (measured from the exit to the entry of
> __alloc_pages_direct_reclaim) becomes excessively long, lasting for
> example a couple of seconds. Consequently, lmkd fails to awaken and
> terminate processes promptly.

If you're planning to send a newer version, it's best to include
the reproducer here.

>
> This patch introduces no_skip_cma and sets it to true when the number of
> skipped CMA folios is excessively high. It offers two benefits: Rather
> than wasting time in idle loops, it's better to assist other threads in
> reclaiming some folios; This shortens the duration of psi_memstall and
> ensures timely activation of lmkd within a few milliseconds.
>
> Signed-off-by: liuhailong <liuhailong@oppo.com>

I believe this patch tackles a niche scenario where CMA is configured
to be large.

Acked-by: Barry Song <baohua@kernel.org>

> ---

This is evidently version 3 of your previous patch titled "[PATCH v2] Rever=
t "
mm: skip CMA pages when they are not available".[1]

It's advisable to provide a brief explanation of the changes made from v2
and include a link to v2 here.

[1] https://lore.kernel.org/linux-mm/CAGsJ_4wD-NiquhnhK_6TGEF4reTGO9pVNGyYB=
nYZ1inVFc40WQ@mail.gmail.com/

>  mm/vmscan.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fa321c125099..2c74c1c94d88 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -114,6 +114,9 @@ struct scan_control {
>         /* Proactive reclaim invoked by userspace through memory.reclaim =
*/
>         unsigned int proactive:1;
>
> +       /* Can reclaim skip cma pages */
> +       unsigned int no_skip_cma:1;
> +
>         /*
>          * Cgroup memory below memory.low is protected as long as we
>          * don't threaten to OOM. If any cgroup is reclaimed at
> @@ -157,6 +160,9 @@ struct scan_control {
>         /* Number of pages freed so far during a call to shrink_zones() *=
/
>         unsigned long nr_reclaimed;
>
> +       /* Number of cma-pages skipped so far during a call to shrink_zon=
es() */
> +       unsigned long nr_skipped_cma;
> +
>         struct {
>                 unsigned int dirty;
>                 unsigned int unqueued_dirty;
> @@ -1572,9 +1578,13 @@ static __always_inline void update_lru_sizes(struc=
t lruvec *lruvec,
>   */
>  static bool skip_cma(struct folio *folio, struct scan_control *sc)
>  {
> -       return !current_is_kswapd() &&
> +       bool ret =3D !current_is_kswapd() && !sc->no_skip_cma &&
>                         gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABL=
E &&
>                         folio_migratetype(folio) =3D=3D MIGRATE_CMA;
> +
> +       if (ret)
> +               sc->nr_skipped_cma +=3D folio_nr_pages(folio);
> +       return ret;
>  }
>  #else
>  static bool skip_cma(struct folio *folio, struct scan_control *sc)
> @@ -6188,6 +6198,7 @@ static unsigned long do_try_to_free_pages(struct zo=
nelist *zonelist,
>                         vmpressure_prio(sc->gfp_mask, sc->target_mem_cgro=
up,
>                                         sc->priority);
>                 sc->nr_scanned =3D 0;
> +               sc->nr_skipped_cma =3D 0;
>                 shrink_zones(zonelist, sc);
>
>                 if (sc->nr_reclaimed >=3D sc->nr_to_reclaim)
> @@ -6202,6 +6213,16 @@ static unsigned long do_try_to_free_pages(struct z=
onelist *zonelist,
>                  */
>                 if (sc->priority < DEF_PRIORITY - 2)
>                         sc->may_writepage =3D 1;
> +
> +               /*
> +                * If we're getting trouble reclaiming non-cma pages and
> +                * currently a substantial number of CMA pages on LRU,
> +                * start reclaiming cma pages to alleviate other threads
> +                * and decrease lru size.
> +                */
> +               if (sc->priority < DEF_PRIORITY - 2 &&
> +                   sc->nr_scanned < (sc->nr_skipped_cma >> 3))
> +                       sc->no_skip_cma =3D 1;
>         } while (--sc->priority >=3D 0);
>
>         last_pgdat =3D NULL;
> --
> 2.36.1
>

Thanks
Barry

