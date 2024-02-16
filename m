Return-Path: <linux-kernel+bounces-68317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818C8578A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BB5B21AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF101B959;
	Fri, 16 Feb 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKIwqPMn"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583D1B946
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075026; cv=none; b=TyT/izmgW0LDmIV575J+EmwJnYrURe22Ps1768Z2JlKMEpfUHc/3J1m/gJjWxCn5LUH0dSY69A/aTUc1l9x92X9MGFw47PfLLzh6bFigMn8RBV/dbFOwtnp6oWrpxW5LuPIfxbe37bp3+0YxHDQecITVhZ690Ri8FzTxtpzuLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075026; c=relaxed/simple;
	bh=thIM3TQWMDS3Ai92AKDt4E6wvZDdMSOLPzob8/YDqf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaKd8X7eKvM6Gk3em+0QwOG7GpH4tMkAwAZ8GfIq51HOvJbyxGdXRMlMOklCMSpNMsKRJnqW1c6Ka/m3KOmZf9478mx0rGolaYjBRM3O+YaUugGwe393AQxDzKYG7NiIu7GC53A3MFHXFl3Pa3jqXKQde9+ijE6Cgc8XnICR48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKIwqPMn; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso919571241.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708075023; x=1708679823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he9AVpIpD5nWkjT+QCgW4hitvbgqoZnHfV5brGo3wms=;
        b=VKIwqPMncsZTRkC3a4yHwU15qoOv95knaNXqqx1MGtkkjb06UgsTa2y8iDHqrQUOb/
         zPRvshRuYDmXTINGVV+hYrOAhDtJMFuEiY7ZJ+AwkPtvl/pBU4EefIsjWngJWv2vlCos
         66rIRmyZRKygmA/VmxiLVDmXWes7bae/A1cN/mlUgfDl3aCKjI13Lx/WjuIceaX3HDR1
         5UGuijYHyCROhkoKPwAUck3OZ7facsyVpIvrUl34sNb7kfTQgnLIB+iw1J5uEwLK9bFI
         hU+SXPy5suD0A0oWY2+iPgo7U7bd7cg0o73m1wWBMKbKKwcdDqEm3bHKy6sJYNEMYPa4
         kdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708075023; x=1708679823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he9AVpIpD5nWkjT+QCgW4hitvbgqoZnHfV5brGo3wms=;
        b=Nfb46vXt9JR7o4a5w0k5mUQjEMM0XUjNL8xMSEopELxaDM+X0jt/tpo2uWqq9X8Elw
         1X/3KNoOu5wdej/IOT6Cl3I6ctSJiFeRqKMOPtbxNSg0bx5WL+0e8AZLC/2DGDH4wwF1
         FmQNE+1qddXBoVEAvm+rvUXc5LA1cSM2HaOW0Xr6GNNKCU0UciufkMYZXfjWPngDtvGg
         aMY4zmQxUvyQdzRQ5+acTevH1kRKwgvIkeeij60RfFUjhluAQgt/moU1Aw2r7FYeDrQF
         EEBNr+PR4etVswjv7EPnnUY5tlE61CNh54hZQ3CvrheETX6GHSVtMsHXZ2LJbP81Nwko
         eBrA==
X-Forwarded-Encrypted: i=1; AJvYcCUO9rRJ6xi4SytkzsAGcW737QFTVgHnzEB/eIx+Oqoy+SJQGqv0K1xfOhDTX2XQHBQl+XN8uFkJGiE47aN7f+IH/EbjJCm/Of6TSmVu
X-Gm-Message-State: AOJu0Yzi0BwyofDh52csGUG5tldzfUeuaOZ18f/68JB0rBQfgBQleo9d
	RThLEdvzmHHZNzExaFKCV8a8b1RWGJPxqjOnc9icjB5acGQvw4WJX8yvGfUWKj/9CnBFKBsvMhf
	i/FlAWFIXmb80+ehkTCa39DclosM=
X-Google-Smtp-Source: AGHT+IEVWWkiFbK6tM0f7DPRYCf9afrd6JuGYb/jX66jHv0B8tuARiXYSeP3boL9HWnwHTfIbnocBeutxWdsMHzoyFY=
X-Received: by 2002:a1f:ccc7:0:b0:4c0:21c4:3a9b with SMTP id
 c190-20020a1fccc7000000b004c021c43a9bmr3699796vkg.15.1708075023647; Fri, 16
 Feb 2024 01:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216030539.110404-1-21cnbao@gmail.com> <Zc8bjZFZAZneObQG@google.com>
 <b717ae0c-ed4f-4ebc-90cf-51a8da0a6583@bytedance.com>
In-Reply-To: <b717ae0c-ed4f-4ebc-90cf-51a8da0a6583@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Feb 2024 17:16:50 +0800
Message-ID: <CAGsJ_4zSDP_A32jUPrYPwZ=uwU4o0a6x-GW2HO3vu8yUh0qYjA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
To: Chengming Zhou <zhouchengming@bytedance.com>, Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Nhat Pham <nphamcs@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 5:07=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/2/16 16:23, Yosry Ahmed wrote:
> > On Fri, Feb 16, 2024 at 04:05:39PM +1300, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> My commit fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EIN=
VAL
> >> in zs_malloc while size is too large") wanted to depend on zs_malloc's
> >> returned ENOSPC to distinguish the case that compressed data is larger
> >> than the original data from normal compression cases. The commit, for
> >> sure, was correct and worked as expected but the code wouldn't run to
> >> there after commit 744e1885922a ("crypto: scomp - fix req->dst buffer
> >> overflow") as Chengming's this patch makes zswap_store() goto out
> >> immediately after the special compression case happens. So there is
> >> no chance to execute zs_malloc() now. We need to fix the count right
> >> after compressions return ENOSPC.
> >>
> >> Fixes: fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL=
 in zs_malloc while size is too large")
> >
> > I don't see how this is a fix for that commit. Commit fc8580edbaa6 made
> > sure zsmalloc returns a correct errno when the compressed size is too
> > large. The fact that zswap stores were failing before calling into
> > zsmalloc and not reporting the error correctly in debug counters is not
> > that commits fault.
> >

Hi Yosry, Chengming,

Thanks for your quick responses.

> > I think the proper fixes should be 744e1885922a if it introduced the
> > first scenario where -ENOSPC can be returned from scomp without handlin=
g
> > it properly in zswap. If -ENOSPC was a possible return value before
> > that, then it should be cb61dad80fdc ("zswap: export compression failur=
e
> > stats"), where the counter was introduced.
>
> Right, 744e1885922a maybe a better fixes target.

I agree 744e1885922a is a better fixes target.

>
> >
> >> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> >> Cc: Nhat Pham <nphamcs@gmail.com>
> >> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> ---
> >>  mm/zswap.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 6319d2281020..9a21dbe8c056 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -1627,7 +1627,10 @@ bool zswap_store(struct folio *folio)
> >>      dlen =3D acomp_ctx->req->dlen;
> >>
> >>      if (ret) {
> >> -            zswap_reject_compress_fail++;
> >> +            if (ret =3D=3D -ENOSPC)
> >> +                    zswap_reject_compress_poor++;
> >> +            else
> >> +                    zswap_reject_compress_fail++;
> >
> > With this diff, we have four locations in zswap_store() where we
> > increment zswap_reject_compress_{poor/fail}.
> >
> > How about the following instead?A
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 62fe307521c93..3a7e8ba7f6116 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1059,24 +1059,16 @@ static bool zswap_compress(struct folio *folio,=
 struct zswap_entry *entry)
> >        */
> >       ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &a=
comp_ctx->wait);
> >       dlen =3D acomp_ctx->req->dlen;
> > -     if (ret) {
> > -             zswap_reject_compress_fail++;
> > +     if (ret)
> >               goto unlock;
> > -     }
> >
> >       zpool =3D zswap_find_zpool(entry);
> >       gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> >       if (zpool_malloc_support_movable(zpool))
> >               gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> >       ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
> > -     if (ret =3D=3D -ENOSPC) {
> > -             zswap_reject_compress_poor++;
> > -             goto unlock;
> > -     }
> > -     if (ret) {
> > -             zswap_reject_alloc_fail++;
> > +     if (ret)
> >               goto unlock;
> > -     }
> >
> >       buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> >       memcpy(buf, dst, dlen);
> > @@ -1086,6 +1078,10 @@ static bool zswap_compress(struct folio *folio, =
struct zswap_entry *entry)
> >       entry->length =3D dlen;
> >
> >  unlock:
> > +     if (ret =3D=3D -ENOSPC)
> > +             zswap_reject_compress_poor++;
> > +     else if (ret)
> > +             zswap_reject_alloc_fail++;
>
> Here have two cases: zswap_reject_compress_fail, zswap_reject_alloc_fail.

Is it safe to differentiate these two cases by checking ret =3D=3D -ENOMEM =
?
otherwise, it seems the original patch still makes more sense?

>
> >       mutex_unlock(&acomp_ctx->mutex);
> >       return ret =3D=3D 0;
> >  }
> >
> >>              goto put_dstmem;
> >>      }
> >>
> >> --
> >> 2.34.1
> >>

Thanks
Barry

