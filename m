Return-Path: <linux-kernel+bounces-36723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598D83A591
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DB71C21824
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBE17C70;
	Wed, 24 Jan 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP0MVfJr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009617C61;
	Wed, 24 Jan 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088962; cv=none; b=GVsiGoLTVeIXOAbvoaMCTrYqUXefBhEN4mlBNPvIXSl676onTashBWRGudFB1Fr6mb3gGUcj+Afc3n2Bj4ZupdkiuWFzMC2IbjITdxzvK0ktJRCOJyvtrCF35AxYvivrJ58E+3O0N1A1mVWH2rAMtJcjn0pJz+CFx2tzRo5q6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088962; c=relaxed/simple;
	bh=IkOzD3WQiOa41IYz5QTMBQFirnR9+U4zXgNFYBu5X7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTl+UVBZywsMwJLyGnsthHDEpZRqrIdToc7SoMSIzsnVe8VpdRxRUhpmardMQrh+B8DYRQb4MQLVtFFrCKDBt+C1ED44G/tCwdylF3Jqnp4GrEViT716uYyhEa6t4mEURinwFCWDaX3PXyk7XFnOAXKXxq5lIQKJ08VN5MC9jiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP0MVfJr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5100cb64e7dso1278554e87.0;
        Wed, 24 Jan 2024 01:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706088958; x=1706693758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx7XeGiLu0dPd7LHjpTzO0dQgZ5zb0c2EqLFG0xX8E0=;
        b=fP0MVfJrNRQk/+8HHLjw7jTqQpm32E/qlzsHqm0ULUt4MLxqiFjafe08L1iMPkYCfx
         fU3kSYyKGntiXW+OPkufskwu2nEQl/K0rGRd5nO2ek7Dp57TOs+WKU9Zz+tE3RVw+o9C
         HizR/ywNIp6R12eKHVtyudpXJTdktTA7/1Rs9A9aAbI4qSyvEvIMTg0KwVFuIonh7aj8
         AnFwdGscuhGcfQh7WZzdB3PYah8MMb3BocVla3074GiRfHor1TB2v73tokVL0W9wSqYL
         rxIT3AsOUSpGIbnKYFV56pNyOMfIRuZvJu+FuxMWPAR+XI0kNelybH7DrTsWvyQTJHLd
         YPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088958; x=1706693758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx7XeGiLu0dPd7LHjpTzO0dQgZ5zb0c2EqLFG0xX8E0=;
        b=NhCNmhOL3tAdNxI7iseh+sMNp/Kxib5XN/77eyNJQPEoPgv9O5tPPZL1gsadhJ6634
         ++EHtACH06G94ToTDNedHQrk2MaZ4Ocu82UrNzfXfDgAkRxQ8aHViDJ+l4vOknXY5wjo
         rDD9LrbA0QteRIxDvtqHb1oBqF+3gQZh4FwRb+PArK6AiQoHXxD1UWO9dCsElEO2UVZM
         NC9cNJ0urnbJDdDT0+z3zG7I2/IniULo0atQlDeat89fLplBaEa9hZ0NHesXoeXb18R8
         u6tip7nAt5ugrofsT5b0zmRkB+rcoGgMEw7+uhN3nUvcferyQlnZ555ljlJkWQnezzzO
         9jGQ==
X-Gm-Message-State: AOJu0YzwLuF7/3O+lLLMPKXXLZ9mZYCVwLaFAc/Vbf4seuWnc0WJoYxd
	deto5fmaSe6Lqci09sgycYGbTg+1oflSTg3pNpZWUjNW3VzUZ7wRPuxUpP6YZ+m9WraA/ZPB4P8
	YzpwtlF6ckPjZeb38PEtHnyz/aJA=
X-Google-Smtp-Source: AGHT+IE4TU4dbR1fiZgEMFn92/jrB53uGuhwBUPRGQSV5l+FDUZbGu2KLwgWzu+WWvVFwxcOdh/2tfAZ0FzqZ2CxtHA=
X-Received: by 2002:a05:6512:4002:b0:510:1025:6a4 with SMTP id
 br2-20020a056512400200b00510102506a4mr234021lfb.96.1706088958347; Wed, 24 Jan
 2024 01:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com> <ZbDWSUkT/OjHTe0t@infradead.org>
In-Reply-To: <ZbDWSUkT/OjHTe0t@infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 24 Jan 2024 17:35:47 +0800
Message-ID: <CAGWkznHAi_U5erM0s8vFWwwucRKPoSzimNr9tdsPvs_sApGxgQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] block: introduce content activity based ioprio
To: Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:20=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Jan 24, 2024 at 04:53:34PM +0800, zhaoyang.huang wrote:
> >  void __bio_add_page(struct bio *bio, struct page *page,
> >               unsigned int len, unsigned int off)
> >  {
> > +     int class, level, hint, activity;
> > +
> > +     class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > +     level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> > +     hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> > +     activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> > +
> >       WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
> >       WARN_ON_ONCE(bio_full(bio, len));
> >
> >       bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
> >       bio->bi_iter.bi_size +=3D len;
> >       bio->bi_vcnt++;
> > +     activity +=3D bio_page_if_active(bio, page, IOPRIO_NR_ACTIVITY);
> > +     bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint,=
 activity);
>
> If you need to touch anything in the block layer I/O path
> you're doign this wrong.  The file system that is submitting the
> I/O needs to be in control of the priorities.
> must not hack the assignment behind the
Please correct me if I am wrong. According to my understanding,
bio(request)'s ioprio is set via either task's scheduler priority or
blkcg's priority during submit_bio, that is, there is no explicit
operation over ioprio from the file system so far. Furthermore, this
commit is actually an add-on feature which is not against the current
way of setting ioprio.

