Return-Path: <linux-kernel+bounces-110562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187CF88609D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32E02869AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D765112BE80;
	Thu, 21 Mar 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwz6LVy5"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903356B98
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046173; cv=none; b=mFsIQ45yBNRVZZzdGkvrgnTws+iD349j+HIyPff6icTMSQ56Ycc6DDDHC2ap9rTAO+OhidcYmfo6r9yDQAKa7BYAoDu/Y0qYb9VI1Zh45bdYkKaACSarSkX1igh7dG2Sib1Oanj4rsX8EbNz/DHugGjwI7tbr4m3EjRAEJg6oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046173; c=relaxed/simple;
	bh=/in2eceAS8fZ6+yLyTWURuQbDPrMwEB5PcqFBq70qRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atsXxpw3ChgdFB1WtiyOLXIdu0swBHfcVM3yXSGwNkCYL1ratd+BKRwHjfldvijYLjZyQktWS0yRE1FfXOMhBzt5VlhdDoz+X0srybuDKN6J2PVBMj4Ypp4ECVO6Hv9NR4tlA76O0NYVoXsdTC4jmNCXelshvbMw4ceFhxt7zUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwz6LVy5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso22617501fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046170; x=1711650970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYHW2im/7U2eInaWrdKWsru+Lb393o8hz20jHiFRKek=;
        b=Fwz6LVy5wCjLNJrNyvnWmT9KwXeoqFQa25++XBLESDZUKhjEb2wsYql+i80Gxjkf5z
         ox8SPT/7B6f8SxBxtSMUHIzR7XflnFbUfottaeE4Jyx+f2J5pAewALYE4GuZ6kJyQ2Ve
         N3GBsAIIGCcWEBiKeucLwPeRDAzpbPnWsSEVwnrMX4BH1kPf9wfwOpxSiHTIPqRpWdnY
         Ygby3M99/nqWG3mGkUqrvdQvf/F39/rNE1JrhAoHlQ6Ckuc9qLHQHClR4UUNzduZlRu9
         kzCE1kUs3PmSkvSik33t2aEYYUq+BHbo+CTnBxbmpHHVAwqcGjl56m9fTN+M/vwkoM6O
         nGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046170; x=1711650970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYHW2im/7U2eInaWrdKWsru+Lb393o8hz20jHiFRKek=;
        b=UUby+75GFlOFyO/Y3A1dMHn95Hv+4ACb2ubfbPWGUeuWj6kcynpL+5DQxOMflwWWRU
         UjCjGLGIuRDqiW4XdrPmpUQ8KYjS2fsDuobhZOMKO6Cb88/N3fatxGdQzUg0ItfO8qX9
         t92iHjnmxMT0IZAX4P2e0jdyqp9UAaB3nE5JXAftOhmNBCNqY2mGANYacozfY0RE0LWK
         MeWDc+Ee9GxzygczOlHEX25zVuewRf7DIQhZg/0QnSPBR5jOYcucbbgbLjF98DEcI+eE
         74lskDY0l5qlpZDH/Qn2XIiOZJYimbOkHf3oclRq5Emv+Onc86Td/BOmqLnGMKd41QoM
         leng==
X-Forwarded-Encrypted: i=1; AJvYcCWmJZjBSXDjGrV71yRoO1uZluvdGz/GeBqQ+G1jrLJsuhI76DcjgEG/vGGcdPLj3TWOLkg2w6VIMYlVH3yx9F6TyLrtlGOQ7APL16Vs
X-Gm-Message-State: AOJu0YxwrWFUo4RC6OZvEDG+ojvvcfLhyyiL7sDCJITlTp8Rljo8TyRr
	7vn6QPoRjVrWMLmYd+82KoyNZOtDbQsOjpoIsQkRkpZxpUKfuxGne4AlH8TN2iixFmbOgPo6azy
	f6JZuXpq07drMkM1iBAwMVbI7Tm0=
X-Google-Smtp-Source: AGHT+IH5zSN7HMRx94vNa7NxxF1rY4ak+DSJW/1cvfXlwrhalqT1PKrc39Y7uWo4N6iLqV05t9okNOcU7hhYB2pG3CY=
X-Received: by 2002:a2e:9784:0:b0:2d4:ad34:85a7 with SMTP id
 y4-20020a2e9784000000b002d4ad3485a7mr245084lji.29.1711046169621; Thu, 21 Mar
 2024 11:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319092733.4501-1-ryncsn@gmail.com> <20240319092733.4501-5-ryncsn@gmail.com>
 <ZfoPjUyPiXpFSxA4@casper.infradead.org> <CAMgjq7BGN9SknnXF+doO-3p18OOYRzB0D5PMdwwstpCXtxj47g@mail.gmail.com>
In-Reply-To: <CAMgjq7BGN9SknnXF+doO-3p18OOYRzB0D5PMdwwstpCXtxj47g@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 22 Mar 2024 02:35:52 +0800
Message-ID: <CAMgjq7DGUmE3VEKNrX0oxZsHN-3vkFtDPjQ41yc1_po=GdDaEw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/filemap: optimize filemap folio adding
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:06=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Mar 20, 2024 at 6:20=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Tue, Mar 19, 2024 at 05:27:33PM +0800, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Instead of doing multiple tree walks, do one optimism range check
> > > with lock hold, and exit if raced with another insertion. If a shadow
> > > exists, check it with a new xas_get_order helper before releasing the
> > > lock to avoid redundant tree walks for getting its order.
> > >
> > > Drop the lock and do the allocation only if a split is needed.
> > >
> > > In the best case, it only need to walk the tree once. If it needs
> > > to alloc and split, 3 walks are issued (One for first ranced
> > > conflict check and order retrieving, one for the second check after
> > > allocation, one for the insert after split).
> > >
> > > Testing with 4k pages, in an 8G cgroup, with 20G brd as block device:
> > >
> > > fio -name=3Dcached --numjobs=3D16 --filename=3D/mnt/test.img \
> > >   --buffered=3D1 --ioengine=3Dmmap --rw=3Drandread --time_based \
> > >   --ramp_time=3D30s --runtime=3D5m --group_reporting
> > >
> > > Before:
> > > bw (  MiB/s): min=3D  790, max=3D 3665, per=3D100.00%, avg=3D2499.17,=
 stdev=3D20.64, samples=3D8698
> > > iops        : min=3D202295, max=3D938417, avg=3D639785.81, stdev=3D52=
84.08, samples=3D8698
> > >
> > > After (+4%):
> > > bw (  MiB/s): min=3D  451, max=3D 3868, per=3D100.00%, avg=3D2599.83,=
 stdev=3D23.39, samples=3D8653
> > > iops        : min=3D115596, max=3D990364, avg=3D665556.34, stdev=3D59=
88.20, samples=3D8653
> > >
> > > Test result with THP (do a THP randread then switch to 4K page in hop=
e it
> > > issues a lot of splitting):
> > >
> > > fio -name=3Dcached --numjobs=3D16 --filename=3D/mnt/test.img \
> > >   --buffered=3D1 --ioengine mmap -thp=3D1 --readonly \
> > >   --rw=3Drandread --random_distribution=3Drandom \
> > >   --time_based --runtime=3D5m --group_reporting
> > >
> > > fio -name=3Dcached --numjobs=3D16 --filename=3D/mnt/test.img \
> > >   --buffered=3D1 --ioengine mmap --readonly \
> > >   --rw=3Drandread --random_distribution=3Drandom \
> > >   --time_based --runtime=3D5s --group_reporting
> > >
> > > Before:
> > > bw (  KiB/s): min=3D28071, max=3D62359, per=3D100.00%, avg=3D53542.44=
, stdev=3D179.77, samples=3D9520
> > > iops        : min=3D 7012, max=3D15586, avg=3D13379.39, stdev=3D44.94=
, samples=3D9520
> > > bw (  MiB/s): min=3D 2457, max=3D 6193, per=3D100.00%, avg=3D3923.21,=
 stdev=3D82.48, samples=3D144
> > > iops        : min=3D629220, max=3D1585642, avg=3D1004340.78, stdev=3D=
21116.07, samples=3D144
> > >
> > > After (+-0.0%):
> > > bw (  KiB/s): min=3D30561, max=3D63064, per=3D100.00%, avg=3D53635.82=
, stdev=3D177.21, samples=3D9520
> > > iops        : min=3D 7636, max=3D15762, avg=3D13402.82, stdev=3D44.29=
, samples=3D9520
> > > bw (  MiB/s): min=3D 2449, max=3D 6145, per=3D100.00%, avg=3D3914.68,=
 stdev=3D81.15, samples=3D144
> > > iops        : min=3D627106, max=3D1573156, avg=3D1002158.11, stdev=3D=
20774.77, samples=3D144
> > >
> > > The performance is better (+4%) for 4K cached read and unchanged for =
THP.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/filemap.c | 127 ++++++++++++++++++++++++++++++-------------------=
--
> > >  1 file changed, 76 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 6bbec8783793..c1484bcdbddb 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -848,12 +848,77 @@ void replace_page_cache_folio(struct folio *old=
, struct folio *new)
> > >  }
> > >  EXPORT_SYMBOL_GPL(replace_page_cache_folio);
> > >
> > > +static int __split_add_folio_locked(struct xa_state *xas, struct fol=
io *folio,
> > > +                                 pgoff_t index, gfp_t gfp, void **sh=
adowp)
> >
>
> Thanks for the very helpful review!
>
> > I don't love the name of this function.  Splitting is a rare thing that
> > it does.  I'd suggest it's more filemap_store().
>
> Yes, the function name is a bit misleading indeed, I can rename it as
> you suggested, eg. __filemap_store_locked ?
>
> >
> > > +{
> > > +     void *entry, *shadow, *alloced_shadow =3D NULL;
> > > +     int order, alloced_order =3D 0;
> > > +
> > > +     gfp &=3D GFP_RECLAIM_MASK;
> > > +     for (;;) {
> > > +             shadow =3D NULL;
> > > +             order =3D 0;
> > > +
> > > +             xas_for_each_conflict(xas, entry) {
> > > +                     if (!xa_is_value(entry))
> > > +                             return -EEXIST;
> > > +                     shadow =3D entry;
> > > +             }
> > > +
> > > +             if (shadow) {
> > > +                     if (shadow =3D=3D xas_reload(xas)) {
> >
> > Why do you need the xas_reload here?
>
> This part of code works based on the guarantee that If there is a
> larger entry, it will be the first and only entry iterated by
> xas_for_each_conflict/xas_find_conflict. I added an xas_reload is here
> to ensure that. But on second thought, this seems not needed indeed.
>
> Will it be better if I write this part this way?
>
> + shadow =3D NULL;
> + order =3D -1;
> + xas_for_each_conflict(xas, entry) {
> +           if (!xa_is_value(entry))
> +                    return -EEXIST;

I noticed this should release potential alloced xas data, will fix this in =
v2.

> +          /*
> +          * If there is a larger entry, it will be the first
> +          * and only entry iterated.
> +          */
> +         if (order =3D=3D -1)
> +                  order =3D xas_get_order(xas);
> +         shadow =3D entry;
> + }
> +
> + if (shadow) {
> +          /* check if alloc & split need, or if previous alloc is
> still valid */
> +         if (order > 0 && order > folio_order(folio)) {
> +                   if (shadow !=3D alloced_shadow || order !=3D alloced_=
order)
> +                            goto unlock;
> +                   xas_split(xas, shadow, order);
> +                   xas_reset(xas);
> +          }
> +          order =3D -1;
> +          if (shadowp)
> +                   *shadowp =3D shadow;
> + }
>

Besides this, this should be OK? I think I can add more tests for
xas_for_each_conflict and xas_get_order to ensure this works, need to
export xas_get_order as GPL symbol for that.

>
> If there is a larger slot, xas_for_each_conflict and check above
> should catch that?
>
> >
> > > +                     if (shadowp)
> > > +                             *shadowp =3D shadow;
> > > +             }
> > > +
> > > +             xas_store(xas, folio);
> > > +             /* Success, return with mapping locked */
> > > +             if (!xas_error(xas))
> > > +                     return 0;
> > > +unlock:
> > > +             /*
> > > +              * Unlock path, if errored, return unlocked.
> > > +              * If allocation needed, alloc and retry.
> > > +              */
> > > +             xas_unlock_irq(xas);
> > > +             if (order) {
> > > +                     if (unlikely(alloced_order))
> > > +                             xas_destroy(xas);
> > > +                     xas_split_alloc(xas, shadow, order, gfp);
> > > +                     if (!xas_error(xas)) {
> > > +                             alloced_shadow =3D shadow;
> > > +                             alloced_order =3D order;
> > > +                     }
> > > +                     goto next;
> > > +             }
> > > +             /* xas_nomem result checked by xas_error below */
> > > +             xas_nomem(xas, gfp);
> > > +next:
> > > +             xas_lock_irq(xas);
> > > +             if (xas_error(xas))
> > > +                     return xas_error(xas);
> > > +
> > > +             xas_reset(xas);
> > > +     }
> > > +}
> >
> > Splitting this out into a different function while changing the logic
> > really makes this hard to review ;-(
>
> Sorry about this :(
>
> This patch basically rewrites the logic of __filemap_add_folio and the
> function is getting long, so I thought it would be easier to
> understand if we split it out.
> I initially updated the code in place but that change diff seems more
> messy to me.
>
> >
> > I don't object to splitting the function, but maybe two patches; one
> > to move the logic and a second to change it?
> >
>
> I can keep it in place in V2.

