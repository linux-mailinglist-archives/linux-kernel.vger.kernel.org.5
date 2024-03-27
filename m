Return-Path: <linux-kernel+bounces-122103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C888F1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF872940A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227314C5BE;
	Wed, 27 Mar 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6SXhoUN"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FC2376A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578779; cv=none; b=b5RRYrSSK8ir5bzUNtDRJDSEQXG2jpocCHkUDVajfejOcK4zJ7dxa4UQayhtRbIJIKYKj8WzjuqdPvGCK2334omVzh5P5ueaQAhKs4pwGkRoBZFts9SZYfj9uO+Jr02Chb1f9P2NT7pizaHVSE5/ySl+y0GL9a1JQukaoP8Ea3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578779; c=relaxed/simple;
	bh=/lTCSwUchJ0J5uoW78moJ36BuUo2rz69VBWHSZG7Tzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Il3x8gOli/9tnd28wHHPyXtzuSUuDgxk9WnVFO9+wRqdnCC0b6OVlM0DRvt5syOwYEnmXu3ZwD2ohjiYeA13K+YQdUpykCXIJCepqLI/tfB+1qJN6eS3rxFKBtMfa6gbVibdwxCTZ6VbSbYx/IuZ4Mt1kjAv7hBaCBg6M28okoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6SXhoUN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so315380a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711578776; x=1712183576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbcd+PIe6N4CDw4yRlMY0za1InBY4i1/TiiyWvtl4Fg=;
        b=L6SXhoUNztu/7+uHxC1VbPJ78j6EZDOAzVqzjt+R7MNIUf7ScZJjVY/Zf7z1iMrf4X
         s38TzprevV7r/H0+lAbEzvClE4QvW+maIQCjQPUj4rUCE+jasJgaxikBWE7GO5E+YKll
         fyegiZ4iXrExkGFAMnDxpJXsiLBPHwrhrHfpEbcsGivt6LoOrsBLjU418xS8BCSMjTQx
         k8/Gf2FCmxV0dTlJeVEMrqSGHwnaQ/jzjlYWmAocLG6TiN0KUKNOJeWRX+igva6sSPZ6
         w2+rfamydjjvj7aSK44b8bWPgIpIhKvD6wNYMx42VjJ6HmvGPL/bRRoopVPmYWSDwhj7
         YwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578776; x=1712183576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbcd+PIe6N4CDw4yRlMY0za1InBY4i1/TiiyWvtl4Fg=;
        b=tDxwW6EiHX273PtqxzRmf27A5UaGGoOtxKVXCL6EytDHZd22Wk6zwnLggLGfcw0gMP
         8Fr9E7anncoh2eHWvB9N+T6WBKcc+8EBDG0j1wCcpIfM33iKkpAGhrvMdaoZXBLQzNaE
         zBEU2rfGI/85NKYKCafj2BpOBY0mEy0QLrkEhpW0Oa/KsT1ljiupOasGpYcF+cSuSJyD
         Nfz4DePSnm0FsosevYBH1/KCGOF+8SsKUuUr8R/3DmLYMvkHlEkQgNHS2RckZz/FNDvR
         CyfcOKnxT18JdnjLZAZgnB7ZQIdoWYIusNR4pXaEnI2VlvOAUM/ME9X4hQD0vD5DLYWp
         GItA==
X-Forwarded-Encrypted: i=1; AJvYcCUUSjJtFfeoqzSvePAygGF8CXlnX9Ex3GzM1CU4Wv0p306TYicqCGWoVeXM5YyhBTRRBIA0Bk7xC5sO1A5Ejy+nvcHdF+q6kb7oW6qM
X-Gm-Message-State: AOJu0Yx15OTn+gZV5/v9jeZ+Ulgd1wz9JDmtqXlzbARv+skzXkGsms5E
	+fKYYgHygVLAOQGWW/JLqhVvgJXp+DbWeh2TBB73nSlZl8cE/G716rlAyj73qtbi0/VKbkkTqOx
	zF2V/K89IYbrJQ8ijEYWuNSUnY76jnbX8Y1jx
X-Google-Smtp-Source: AGHT+IGA8qE9wQIsqVFqSUZImJGYLwiSCRayTaYDwN9BZH8LNDUx5Enn+51vzaGQm+Ek47WzMKwK4q3yATeuJ/ARmRw=
X-Received: by 2002:a17:906:3c4c:b0:a46:ecdd:d1f3 with SMTP id
 i12-20020a1709063c4c00b00a46ecddd1f3mr488077ejg.56.1711578775819; Wed, 27 Mar
 2024 15:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-5-yosryahmed@google.com> <fef4556f-5d22-4941-9990-a4a3cf003dc4@linux.dev>
In-Reply-To: <fef4556f-5d22-4941-9990-a4a3cf003dc4@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 27 Mar 2024 15:32:19 -0700
Message-ID: <CAJD7tkb-mo-ote4PGa06mksrVEfQ=qANXGneAwLn4OMSfVJySA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] mm: zswap: move more same-filled pages checks
 outside of zswap_store()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:39=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/26 07:50, Yosry Ahmed wrote:
> > Currently, zswap_store() check zswap_same_filled_pages_enabled, kmaps
> > the folio, then calls zswap_is_page_same_filled() to check the folio
> > contents. Move this logic into zswap_is_page_same_filled() as well (and
> > rename it to use 'folio' while we are at it).
> >
> > This makes zswap_store() cleaner, and makes following changes to that
> > logic contained within the helper.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> LGTM with one comment below:
>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>
> > ---
> >  mm/zswap.c | 45 ++++++++++++++++++++++++---------------------
> >  1 file changed, 24 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 6b890c8590ef7..498a6c5839bef 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1385,26 +1385,36 @@ static void shrink_worker(struct work_struct *w=
)
> >       } while (zswap_total_pages() > thr);
> >  }
> >
> > -static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
> > +static bool zswap_is_folio_same_filled(struct folio *folio, unsigned l=
ong *value)
> >  {
> >       unsigned long *page;
> >       unsigned long val;
> >       unsigned int pos, last_pos =3D PAGE_SIZE / sizeof(*page) - 1;
> > +     bool ret;
> >
> > -     page =3D (unsigned long *)ptr;
> > +     if (!zswap_same_filled_pages_enabled)
> > +             return false;
> > +
> > +     page =3D kmap_local_folio(folio, 0);
> >       val =3D page[0];
> >
> > -     if (val !=3D page[last_pos])
> > -             return 0;
> > +     if (val !=3D page[last_pos]) {
> > +             ret =3D false;
> > +             goto out;
> > +     }
> >
> >       for (pos =3D 1; pos < last_pos; pos++) {
> > -             if (val !=3D page[pos])
> > -                     return 0;
> > +             if (val !=3D page[pos]) {
> > +                     ret =3D false;
>
> nit: ret can be initialized to false, so
>
> > +                     goto out;
> > +             }
> >       }
> >
> >       *value =3D val;
> > -
> > -     return 1;
> > +     ret =3D true;
>
> only need to set to true here.

I didn't bother improving the code here because patch 6 will replace
it anyway, but I will do that in the next version anyway, might as
well.

Thanks!

