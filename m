Return-Path: <linux-kernel+bounces-106800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4E87F3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9AE1C2147F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C75DF0A;
	Mon, 18 Mar 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1BH0+Em"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE65DF03
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803848; cv=none; b=SmoTyhF2OkRPWsDsoR1Y32NXbJw4D97+7ZvZi4abpRCWAY09uOA+9DcPKb59q6eCESUpaQlzNo8aP8wpeQku3RUXZ8LjxCeooq3WT0MiBN/AUGm0JhhdippiGhKRwzenRmDIw+WfvluZnMLVlcgCxvPrfDEhnfZb492YF5aiZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803848; c=relaxed/simple;
	bh=2WaEYq9CzU+FAeWlZLffJUIMJBRhvk4H1BattzDDvS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+qjvLzKRzbwQPVRYGfz+p55yYDDNjhDGf5oNq8JrItgUm8PMnvtSD+4zweuVmy7STcN1ZhiVoyn/4xmr2rLfCrFMraEf6+gZ8dHrf5GZTpNb3e1lqb3AL1yl8thztX4rtHn4yTuK3A5OI6CHb5pftBK9CKZz44pKhCbdyMRkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1BH0+Em; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46db55e64fso14143266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710803845; x=1711408645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYlJ0m8B4UnARm2TPYjOnOf8jyZsU1XoJlsBaw3m4Ek=;
        b=O1BH0+EmU7y67oznT2nOyarBQBWs4ButPue1UVLUoc5I4077uL5u88BoR1LHMwVoBm
         2zxGmgtC268LSa6hcv10nhXziecTCApY07+EAV0YkurczmN7JIAFb4EdXXxS++MoP3pt
         5xGNHSvSX1qsyMoMUWSX1lopuUIjvhFz5ult30WagvIONimWKLCXiQf7KEufl1bzi9+4
         jwFId9/MZvOXyKJS10zyqrCFzuUKvmQiXVBUYdJuJ2bRsxQJVUGeu3xm2ne4EP3vN3RQ
         xmzrWKORPYWy6WOyrtOAADpXacDKKDmZf7IOPYPFXWA0uks8IYaV3qkaoisN+8uFuAZm
         oOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803845; x=1711408645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYlJ0m8B4UnARm2TPYjOnOf8jyZsU1XoJlsBaw3m4Ek=;
        b=nUx5DM7qMiiqTE4WqRn3GumUAmYC/mSBak8YzIU6cR4WOoevfxtoAYUgYPWnXVMv50
         phy9kBuCUfIgsiARER293YdXOWorfYRLSylwO8BmyWPlE2TUC/TBFEpXFnswg+/ZMwer
         mbDZ6JBkb8ep/cGX4L6LX8pXaRPOEUl9a3QC2SBaF7REcvrDz7UcJXr8qUo7xcVDD5Nv
         16+EegvGvpC/lhChtVVdrqMjB4JnFdU41pAd/sGJOLzLrziBPQ4PJixJyFmEWwdjPorE
         IciF98AxSo31eGP3kEnZiA+eTZ0j7QupulvmULqk9rmLOJ6tt4JETJMyqOL6QIk3J3mF
         ephA==
X-Forwarded-Encrypted: i=1; AJvYcCXIdby7YL28r05/WywR3H5dOSOX7z6Jk5RdELhyNzDaBHIx30ZS1K27m4Lv8gvTLfycByEGCESYPhjpbl7S2Yeq4u5qFyC/dESx9f/I
X-Gm-Message-State: AOJu0YzW9BA12GQA1bu8ZnurXYPkyVF8DJKY80XAcg7COVpFgrCqXPM0
	wQu8+v9HebgJjTgIg0DTKKmif++5X6RyQJdHBj7g/mCpiq7PH1SonldgoxKH4JDaEb74DjxXQTt
	q419xZuBSbe4IK0qFWKggs+YKQ9LZoiwTg/zl
X-Google-Smtp-Source: AGHT+IGxy+nudpmCt0OCP8vE+D/ayY+4MLDrueOCL5VIn37CqXgAP7JT5EqPjiBfS+AcsXqTVkMlldAxDCiV3W8RiSE=
X-Received: by 2002:a17:907:971c:b0:a46:9a9e:f3b0 with SMTP id
 jg28-20020a170907971c00b00a469a9ef3b0mr8215722ejc.67.1710803844571; Mon, 18
 Mar 2024 16:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318230013.87543-1-21cnbao@gmail.com> <CAJD7tkYVJHsWoaEkTiTigJRzSNBrRSg3YVAL3Q5Q96cLSNJZrQ@mail.gmail.com>
 <CAGsJ_4wqPuZc47h=QRPForrxinhG3cvoh4VupLyDRo_uhneC-g@mail.gmail.com>
In-Reply-To: <CAGsJ_4wqPuZc47h=QRPForrxinhG3cvoh4VupLyDRo_uhneC-g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Mar 2024 16:16:46 -0700
Message-ID: <CAJD7tkaZNNn2p-WXx9EGTS+kR3yzYYC4JZwq=5g0D1VsHP=kdQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix kernel BUG in sg_init_one
To: Barry Song <21cnbao@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, v-songbaohua@oppo.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ira.weiny@intel.com, 
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:12=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Mar 19, 2024 at 12:06=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Mon, Mar 18, 2024 at 4:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > sg_init_one() relies on linearly mapped low memory for the safe
> > > utilization of virt_to_page(). Consequently, we have two choices:
> > > either employ kmap_to_page() alongside sg_set_page(), or resort to
> > > copying high memory contents to a temporary buffer residing in low
> > > memory. However, considering the introduction of the WARN_ON_ONCE
> > > in commit ef6e06b2ef870 ("highmem: fix kmap_to_page() for
> > > kmap_local_page() addresses"), which specifically addresses high
> > > memory concerns, it appears that memcpy remains the sole viable
> > > option.
> > >
> > > Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspot=
mail.com
> > > Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@goog=
le.com/
> > > Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sle=
epable")
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  mm/zswap.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 9dec853647c8..17bf6d87b274 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1080,7 +1080,8 @@ static void zswap_decompress(struct zswap_entry=
 *entry, struct page *page)
> > >         mutex_lock(&acomp_ctx->mutex);
> > >
> > >         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > > -       if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)=
) {
> > > +       if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool=
)) ||
> > > +           !virt_addr_valid(src)) {
> >
> >
> > Would it be better to explicitly check is_kmap_addr() here? I am
> > particularly worried about hiding a bug where the returned address
> > from zpool_map_handle() is not a kmap address, but also not a valid
> > linear mapping address.
> >
> > If we use is_kmap_addr() here, then the virt_addr_valid() check in
> > sg_init_one() will catch any non-kmap non-linear mapping addresses.
> > WDYT? Am I being paranoid? :)
>
> we have a possibility that a userspace buffer or vmalloc address is given=
 to
> sg_init_one, then it is non-kmap non-linear. but is it possible someday s=
ome
> people return a vmalloc/vmap address from zpool_map_handle() in the futur=
e?
> then we still need !virt_addr_valid().

Hmm I guess if zpool_map_handle() ever returns a vmalloc/vmap address
we would need to copy the data to the buffer in zswap code, at least
until we enlighten the code to deal with them directly. So I guess we
can keep virt_addr_valid(). Ideally the comment will clarify this.

Thanks!

