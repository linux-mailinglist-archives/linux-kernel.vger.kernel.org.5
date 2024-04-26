Return-Path: <linux-kernel+bounces-160578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976C8B3F80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4921C23687
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9746FA8;
	Fri, 26 Apr 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUbtxMPa"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3763AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156917; cv=none; b=ehgjp/EGEg/PEnXdbP0DrGvDKmsEWhoFVKUvUzzefEypRcd+hqc/8X5LFftQZ5+20RjUDXCfy8D3emTomAe/Vqr679Drv4EcNoU4ClJfYryqxY6fpmt8ng2mOLbR3HvZvOG2g5+Dbtcs5wjNssudloGpB/vxMztbOYF3S3/z4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156917; c=relaxed/simple;
	bh=rFfiul7lN3W4ving5spK8bKXhKZAySO3bcWAGeEJCSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYo0iQtDbqzyP2ft/rkRmHguprYvZDdy0I8+9klF8B3knlWLqVWw+kB0DrlI4fDcaShvzwE/LIh1+JY79tUVIvN+mGnVk9kLOHSFx0LNuMzj9vVs5iBihyjeaCmAHGcdpP3cIb/iVShTVKcXJr4CqEkyeelC2DSWH4Oo89cR53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUbtxMPa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so445782a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714156914; x=1714761714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUJqNR/S6ihu0yVmhT6SDnrwYDU6/B9sR5X5jfrhksU=;
        b=RUbtxMPaj3xcPgKqcTvpRM8xhg+i9oC488iF9RQrmOjpTN8s3stpcF2psju7ja4mez
         InFjcg4LXoq+DF3g+ndImVfkldn5nx6rSmc3+jLRBmISlB5nLNUvMJsPxVTEimTs7rl7
         2vZ9xB5eyqUeD7f7Cdd58acDZLO61JL5U9L2QMvCipJO4viN0hImhCAYMouSm64utD63
         I+axVgsUvbQTWUoB7bUmoj+WT2By4vVaobtqzccyhYl1oc3XK0aOE+j7n8wbRe+jMDUR
         OyZDHjHudXFBZNPBOWwe1eAWcLk6vmSnjPRf9FPBPHSHN/VicjmhqWFFFqCZIeBPYiSg
         sHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156914; x=1714761714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUJqNR/S6ihu0yVmhT6SDnrwYDU6/B9sR5X5jfrhksU=;
        b=eetNGa6kxZJ/BEDnCpwAFQP0Eq7g8xcSOdnW7qTTjgod4n/wTgTqg+yR9YpfrQG2cF
         jMk+9CFb2zCHbT0wCutJn4l/tSLhKIdY5iqB/n8Gq5BWL1iYZwU6v3/+x8TgQtDkBvZh
         fuHhEpN6SQWceZE1DtoqKHD4Fc2AiZtE7am6ctMkr5Eb83Xy+VbX6GtUW8fwx1a3FGWN
         G8/Gyg50tmmS6RBg7MK0ZXm4vnUBVcZDn3xNA8Bv5WI/JnTF7vk+j1lhJBeu3CwbWWnd
         XQGPqrQ5YayBFHUl6BOUavfFfkFN14ewlSXwc/0ODgMyjERQruUGXA6ArTgMs4O4gGCC
         olBw==
X-Forwarded-Encrypted: i=1; AJvYcCUTn5JrRDAaUTEDFUMBxrl/WvsGMYx2W8ots7QiBfj7UyDCnDu8rnO70i9bbDHM5sUERixcmK2w0mdzNdTq2aSwC1tKtMb7tBt0MtNK
X-Gm-Message-State: AOJu0Yy4+APRUX+AhlO/LhfQsWBkwms57vSdkSlOIc2patbXrA1CZ5/2
	0I9UXfXa+5zEAI/bIfKWwKMJp0OVvOx4GCTh1UlRy6i0EUvFrPrADWNFZ4gxOhL4ibxFTvTjOOL
	ZinhakHYR7t7eEd4xq44L2c8Y6LA=
X-Google-Smtp-Source: AGHT+IHL50vkU5e2FRTV9N/UG5c5QHN1n3fJd/D3N0Z5Di6Ohr+hn6EsKibgn039BfBIv8fUWmKCYqA8nAZGi80X6O4=
X-Received: by 2002:a50:998a:0:b0:56e:2b0b:58 with SMTP id m10-20020a50998a000000b0056e2b0b0058mr2525093edb.10.1714156913663;
 Fri, 26 Apr 2024 11:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
 <7c233278-1006-4449-81b2-d473b18a66ca@redhat.com>
In-Reply-To: <7c233278-1006-4449-81b2-d473b18a66ca@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 26 Apr 2024 11:41:42 -0700
Message-ID: <CAHbLzkqZmd=HGQ8_adjEipp49GEzN45bz=NwJPi9X+qOHnNFZQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 1:26=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
>
> > @@ -1553,9 +1557,9 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
> >                    * page of the folio is unmapped and at least one pag=
e
> >                    * is still mapped.
> >                    */
> > -               if (folio_test_large(folio) && folio_test_anon(folio))
> > -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdm=
apped)
> > -                               deferred_split_folio(folio);
> > +               if (folio_test_large(folio) && folio_test_anon(folio) &=
&
> > +                   list_empty(&folio->_deferred_list) && partially_map=
ped)
> > +                       deferred_split_folio(folio);
>
> And now I realize that we can then even drop the folio_test_large(folio)
> check here!

Good idea. This is more understandable.

>
> --
> Cheers,
>
> David / dhildenb
>

