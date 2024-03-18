Return-Path: <linux-kernel+bounces-106658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93787F1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BACEB21DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED1D58127;
	Mon, 18 Mar 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Is9n+Lir"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAE250EC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795634; cv=none; b=rvRkBPf8lprK2GdBjTHZgqOwzYYPct9RccvVGZVXatsHEgO1WgR0iwSPdbDZ3f8k/ln7QCBdHN3JdcNB7UN5RH8Nvn/AUMDVXBTb5TiNbJQ3NiUSwd56OEPiPsVNhMXswJACO/6Bhru7RbSN7NKhIRSAdXashvTTDxSExmU0Eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795634; c=relaxed/simple;
	bh=f3yibNWRdC5Y5/+ROWafQ7ECLxx5ABWOLebZuD6BerI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESO1ontChTlhHIXwgoVzdIvd7ufn7xfsZy0VC3YeCKKKBfHWRbOjo47BjY5hXPBCjPgvdeDIYPgeXwZMELloh/PHABMXidUj47rIENXbzzZaGKABIu41iu0r93IEd4CucUtwWNyxd0R5Ttc6EoSbLDg1QKGQhy5tva20ZmbRKes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Is9n+Lir; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46cc855600so176410166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710795630; x=1711400430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dvebqtRjtJMkLTFS/Lue+MhyvzNYqefXWF1X4IBuhio=;
        b=Is9n+LircmNpgB/wdLtUkgKnsT7nMyiRBAwZixpqkZzDknjLRnRlLkkHOH5mBKuYjU
         /fafGK4qIomMwCbQrkN0YCcM7FOGmDLYEMi22mr9YdQT4OnX1ym1rYxd/KLvcJOXFboJ
         Prr1WHZ9VIsPJra5Ww7HMf3ZE7X68IWENAD371L4hWneyoJJ+ZOmvDVbj+AXxGnqGPvl
         ACYBdwOHcl5soEgDZ9hCCDu8HnktmeJ75awGA8agP+l3WG7VTqoqZYywiJ3dHxovlIGm
         DONriMAqrMmyXjJw4cvTFKgHenaMClN76GrOJKjWYPCt9jIOa06ZZfd+wt8Dv7jhwjxM
         jiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795630; x=1711400430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvebqtRjtJMkLTFS/Lue+MhyvzNYqefXWF1X4IBuhio=;
        b=cNpKq19ejH47lDM78ducAw1/+L3sJa501fWcrAglJPnGnxZxhhlCa49GbXIbqIT65P
         d/SJtE5Joh4hOgfy+t7op5HMViv2pC0taFq+xuy5OYZ3nxjqp1AAgJ8+sJ2HQg1/jaO7
         poWF26lXu1sOEC7TfqtiR04DM/PNyVUkDfG/fRiz0+lN47gKrs67Nqg87faw84GH5vSv
         Zpbzarxmmb7BEXovjS0sSyAQR4rz1SJFwO9BY0U39uQV24RyAlqnGdqYgs5+V+60jzAF
         QiDraISSUwxCOd8gWACkLLjGxyO5i2sngrT7i0x0CrQQ3afOtrXxmQtVbiHyObgvfIig
         7i8w==
X-Forwarded-Encrypted: i=1; AJvYcCVBPoWByKr0+17QH4R26MlJraZnKge/vwr+dHN+TkB/P4/5BfYyqyGG6sqLRllt1uBVMdgNXe4NR/72bC3vOvTNdCmzzLm60jPLM4RU
X-Gm-Message-State: AOJu0Yz0GTbXsBL7xt5UgqiYGt7E4M03379LG28N/rdpvJy/ypwIiaat
	xIENPNnaOOrQysQu7+bysph6DE67gtLbcaPmLjfl5ydbXJPc78lRMf6PaSfuCsBeZO24Cl78pgW
	rIHILjvd28J6ouqFnpvTd8+RM5TN8cjSje4CTkJWiSxqUbE8s8A==
X-Google-Smtp-Source: AGHT+IFjW5lvSm4+MS1nz5VL6V3edwHB/B04mw0doQI21cmkTMWGRBuqwczQ73Q8bjHSU11v1m24IHqG6y75DMY0EH4=
X-Received: by 2002:a17:906:1702:b0:a46:b764:fc81 with SMTP id
 c2-20020a170906170200b00a46b764fc81mr312170eje.44.1710795629480; Mon, 18 Mar
 2024 14:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAGsJ_4y7aFg3FBh_isa_TCqY1B8n64Rro5mVu6=wvk7FP35mWw@mail.gmail.com>
 <CAJD7tkaPmgsUjPCi0wKCYAmPb+Vnif_zS+ouyd9NGQN=mdhJPw@mail.gmail.com> <CAGsJ_4xyDm0BLYvbW0z9J-Q=sQPYrttva33g2mRFVXcJJ+wimw@mail.gmail.com>
In-Reply-To: <CAGsJ_4xyDm0BLYvbW0z9J-Q=sQPYrttva33g2mRFVXcJJ+wimw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Mar 2024 13:59:51 -0700
Message-ID: <CAJD7tkaP_wfkJG_dfsp-jV7QP2JWyMFfNApTFPWbsqmTvfKyLw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Barry Song <21cnbao@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > I guess that is because on arm32 , we have highmem but
> > > sg_init_one supports lowmem only. the below should be
> > > able to fix?
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 9dec853647c8..47c0386caba2 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1086,7 +1086,8 @@ static void zswap_decompress(struct zswap_entry
> > > *entry, struct page *page)
> > >                 zpool_unmap_handle(zpool, entry->handle);
> > >         }
> > >
> > > -       sg_init_one(&input, src, entry->length);
> > > +       sg_init_table(&input, 1);
> > > +       sg_set_page(&input, kmap_to_page(src), entry->length,
> > > offset_in_page(src));
> >
> > Is this working around the debug check in sg_init_one()? IIUC, only
>
> I wouldn't characterize it as a workaround; it's more of a solution.

I assumed that the debug check in sg_set_buf() is because
sg_set_page() cannot handle highmem pages, sorry if that isn't the
case. Apparently we are hitting a warning with kmap_to_page() though
as syzbot just reported.

>
> > lowmem pages are supported. We may be passing in a highmem page to
> > sg_set_page() now, right?
>
> we can pass highmem to sg_set_page(). This is perfectly fine.

So the debug check is only because we are using virt_to_page() in sg_set_buf()?

>
> >
> > Also, it seems like if src is a lowmem address kmap_to_page() will be
> > doing unnecessary checks (assuming it's working correctly)?
>
> In practice, we consistently use kmap and kunmap even on systems with
> low memory.
> However, it's worth noting that for low memory scenarios, kmap
> essentially returns
> page_to_virt(page_address). Thus, the overhead of kmap_to_page shouldn't be
> significant on low memory systems, especially considering that it simplifies to
> virt_to_page().
>
> Another approach is to consistently employ page_to_virt() for low
> memory situations
> and reserve kmap for high memory scenarios. However, since we always
> utilize kmap
> regardless of whether the page is low or high memory, we don't need to concern
> ourselves with this distinction

I see. Thanks for elaborating.

>
> >
> > Would it be more robust to just use the temporary buffer if src is a
> > kmap address?
>
> I don't think so because we will need a memcpy then.

I thought that was necessary because sg_set_page() cannot take in
highmem pages, but you mentioned that this isn't the case.

