Return-Path: <linux-kernel+bounces-119973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEC88CF95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AFF3223A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE613D272;
	Tue, 26 Mar 2024 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7GjQ4Yo"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0512AAF3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487054; cv=none; b=D/+EwAotbwQ18XrKhoiLZJr5ru/Rwdirfeysw+ICahMCqeJ8SFzD0q8ll2yRrhXJc/hRSm6FBSNWxVn6I4zAfnAI4hBA/CCyik996dpVydta4gRyImZQcrYaup+gq1530Tcy+OdavqpMFKqoL3UKQVgEbQFZmHdnkUqeC+qK3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487054; c=relaxed/simple;
	bh=BkIKyc3Bm4/8mabE0kK8ooq2LU7d9NAnlx/tUWB9rNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuM1So9ZzmyjVV9HwVYSLwsJDPcojN1BThjSZHp9McNlvfYro73Dv5TLx1cSlnAdjy9ynZV1TOJlyFnrwGgxaYHURn0IveVciOX2gMG3pxlbkFr4Rsa7hadPizTJ44wQEieHXIRVsF1niGKugZkuAqiLdNgyCnmj0V4ZNv9OAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7GjQ4Yo; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69629b4ae2bso50649856d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711487052; x=1712091852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3KowE3wVTemf40htHz2gToH1Uj6cubwM/P4kmQ5UvQ=;
        b=Y7GjQ4YooS28l7k4edCJrjCnVcUF8EC6OGjnbsu89JNRE526m9jcrJJKSTVk2IEn07
         cEEN4GFigMN0wsapHj31y8dK/cbz8gXRRC+h7KlRhBk0k3fnD5Lcxb7RoXZYsKrZYN8f
         7eQx2by+V2/mNF+LvaH5Eotp4y2KWLEgPP4iAuVy488bg6ZaG2j5ftnLjahOkHh6YW7g
         EBWKF5JM3fJiDm4jYyfEkMkvRFXA5MMH1T2xaU0qczhFRcUZwYLBQ3jx5Q5fo6g1KkzT
         nRGFRFvpGF5gWgfJLDEhY43cPqkKhfPjCWdbF+PufP9PA84IFA3p9DTV4yHMj5GJulqP
         VlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487052; x=1712091852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3KowE3wVTemf40htHz2gToH1Uj6cubwM/P4kmQ5UvQ=;
        b=dG55d5DkypMG+bSp1+DfT5oafsRVF8iYVvD5+7HfPNECVfAe9DYguTEaYYV7G+Gf5W
         Uv/w6EGOtkEsM6KrJzNL/tWntXt5sVufVcvMV7xuxYam7WMPR3zWkb5fOIVjga6n6FRT
         UIEsq6EYnBRYihJnPd+Md3gLXVL8SLK3o+EEqa2wlTI5J0amlYn2E2Wu5NbbFUf/eu5a
         yJOS2bNk8bHDhQ4etIvbElGAddmojYX2yBXBRr84SW9vV1PQij2ISstnjz2eCvOjLx8G
         YTe8CTAVXoH2jV9kFf2CMPSsBTqy+KBaw/G30+KidIO8U1W+vRQS+mcRv1100F9C5WvM
         45kA==
X-Forwarded-Encrypted: i=1; AJvYcCUbU0nEm37PppEdwnKWVlGUKpHuXtuly1narsLgy4T7IZwCe/fuJzH7LQLzeHrt0PM+qW+crJKuA7vofGW6RTG7YebljkqdtHi0akqv
X-Gm-Message-State: AOJu0YyMZhAye12ZaIyfXxPjzFYu0vj59xcRfIulDegiBkIPuMKBoCUv
	A9lFogAaF4JxkXS+gggnajTrWU9UhXC+0sCDh1OOta5lfIfcN8n2JIE3KbSz/+YoNYlOJvz1cwP
	qUUb1wO2DPZQeXuWBj+u0BhMedNo=
X-Google-Smtp-Source: AGHT+IGnsgsPtHwjQqvvqw0AQo9J2//VlexEtHqsny9L/8THBmfrv+lOtIF8PwVh2VM6oSafEo2/1kpFy1OoHX9Ur9c=
X-Received: by 2002:a05:6214:2123:b0:696:3a75:2964 with SMTP id
 r3-20020a056214212300b006963a752964mr16506992qvc.18.1711487052237; Tue, 26
 Mar 2024 14:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org> <CANeU7Q=8p4whMu+H9GXqQc4Ehjt0_kCtNdg34TiW4bWFw03dbw@mail.gmail.com>
In-Reply-To: <CANeU7Q=8p4whMu+H9GXqQc4Ehjt0_kCtNdg34TiW4bWFw03dbw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 26 Mar 2024 14:04:01 -0700
Message-ID: <CAKEwX=MLFaA-1kYbKT0bMuTsJDqK9ZfoJ+WUyxM4tBu_owyPYA@mail.gmail.com>
Subject: Re: [PATCH v9] zswap: replace RB tree with xarray
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:42=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> > -        * When reading into the swapcache, invalidate our entry. The
> > +        * When reading into the swapcache, erase our entry. The
> >          * swapcache can be the authoritative owner of the page and
> >          * its mappings, and the pressure that results from having two
> >          * in-memory copies outweighs any benefits of caching the
> > @@ -1649,8 +1581,12 @@ bool zswap_load(struct folio *folio)
> >          * the fault fails. We remain the primary owner of the entry.)
> >          */
> >         if (swapcache)
> > -               zswap_rb_erase(&tree->rbroot, entry);
> > -       spin_unlock(&tree->lock);
> > +               entry =3D xa_erase(tree, offset);
> > +       else
> > +               entry =3D xa_load(tree, offset);
>
> This is the place I make the modification for the conflict resolution.
> It depends on the swapcache to execute xa_erase() or xa_load().
> Obviously, the xa_load() will not delete the entry from the tree.
>

The conflict resolution itself LGTM. I'll let you and Johannes decide
on the comment (but FWIW, the original meaning still holds, so I don't
see why we need to fix it).

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

