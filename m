Return-Path: <linux-kernel+bounces-58888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D3184EE29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C391C2128F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4F72F56;
	Fri,  9 Feb 2024 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmP820gE"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF823CB;
	Fri,  9 Feb 2024 00:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436962; cv=none; b=hufA5aatS+mSb+NjZ4rAy4xHaOp9gVtGcWbzY3jh6xtdCYdJBQzWJIe+qQXFCslQ9Ou3e3stfe33EjU+4zZ48y6U+K+0ZXLU1m7u4wekipnf7r1NxWCq59TPX2UnP3ivCF+n4fWKLGNMZc/0sbW0+KdVyKj0OWBXjspn/sf9p74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436962; c=relaxed/simple;
	bh=FisFr5Y6c/oPOlBwdDGJu3BWMqSFmvw6cnye1shtkPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTiW/jFIh3uoONw0Ql2T3ZyNpTXnkZFuSnZ8ww3KTVYiUFawBLFiWxEAhD45T96+g5k7mJmmIMi7eKU1RMKxqQEExuDOztAqeCH1YzY1BNkLyRivJHAgaPongx6AtppLqYmbdPvCP/6EWxX45hWWlkAepAucp8m1ib8eFN1c5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmP820gE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so6073501fa.1;
        Thu, 08 Feb 2024 16:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707436959; x=1708041759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MN7qUrCvpfzMejtNGOLudK1J8Ct+G2fviTUgl85LWU=;
        b=BmP820gEpU/UpFZEldqoVEDQz4ucctclnqLO+xSpnTCadc9mXVxPK48iDnJSgliXkW
         nQ1sllvki8xlKK6VEZ5HDX6lLduIQJ8arJ5DLMBljg91bxGTeYi8dB7ZOq9adHHLV9zx
         asHs6+/aXpBU9Lg5+0XvxFJmO/yAiuNB7g/hD1uYQrDq6esiB/0ZkvbPKtV7OFyXSqp4
         eWl0YcyHCPpl95VBLU0WugeUpbrQDg9NwUFZvuulhcmjxJTFL3MckgUHtP8psc9CEQPh
         zjSG4Fb/dXsN2/TOoyA3dbhfldbBamh4rZP8/87zJYDwkziiIywm9TPJDU5mcRQJnQ4c
         G8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707436959; x=1708041759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MN7qUrCvpfzMejtNGOLudK1J8Ct+G2fviTUgl85LWU=;
        b=sub9+41fNT42slD6NZpkWI2A1qnQkff+R9ZuauaCPGzLiV01+Une9aZfjFmhKB37yD
         OHQuwdEeNOmv8YvNXh/ViWPfIjPPxZWyxy2OBtxaTOLB+IgNmzn908NBar7XXeROWMWB
         xwhVcYV6jpFcEK6mDXGs+YcGuE6BTymUjnsyygT+aEVVkZ+GNefT1eTeF/ksR/DavQVa
         vbtEfCV0dT/gGqK1eOtsn6C/lTJXK1+1rr9hGPHGfHjJIdL9vpQT2zzPjuHM1q1yXP8O
         0vwNnmxdWke2RgKBnvkwz0fmffV4zaaNscjtoc/2Ufd6vmYrFYsz62aRaH0fvQ3kadsY
         iSrg==
X-Gm-Message-State: AOJu0YxTWBr8e5Wyo+ERfSLYgZq4eh3GiwDmC/o9obLFErM6f5AoILyr
	cSnbs40G+ZiYimt34TJO9aYMKb5apM0fp96kVm8/jYVAVcGlBAhESdo/YoXvWpkZL+BvjRX/zgK
	e0WZtGdVwK3tj9iWNVz28OyZa8sE=
X-Google-Smtp-Source: AGHT+IFPQsKzLG22PNSWQLxElsi73Fq3Nqu3C6JLq9s0cOD5Oi/toZlY2O4Z1f2M/MHycvukxOBeUTkFU4nJLadMsUY=
X-Received: by 2002:a05:651c:4c9:b0:2d0:b644:57ba with SMTP id
 e9-20020a05651c04c900b002d0b64457bamr103794lji.35.1707436958585; Thu, 08 Feb
 2024 16:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com> <ca00ff75-e98d-4652-9c52-94b2e876901e@kernel.dk>
In-Reply-To: <ca00ff75-e98d-4652-9c52-94b2e876901e@kernel.dk>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 9 Feb 2024 08:02:27 +0800
Message-ID: <CAGWkznH6Y8u7PsoHWid0uQ+ceRK_qzSn6=eWn4dvDhK+DzSXzg@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
To: Jens Axboe <axboe@kernel.dk>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Yu Zhao <yuzhao@google.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 1:49=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/8/24 2:31 AM, zhaoyang.huang wrote:
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index f958e79277b8..43c08c3d6f18 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/sbitmap.h>
> > +#include "../kernel/sched/sched.h"
> >
> >  #include <trace/events/block.h>
> >
> > @@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> >       u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
> >       struct dd_per_prio *per_prio;
> >       enum dd_prio prio;
> > +     int fifo_expire;
> >
> >       lockdep_assert_held(&dd->lock);
> >
> > @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> >               /*
> >                * set expire time and add to fifo list
> >                */
> > -             rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];
> > +             fifo_expire =3D task_is_realtime(current) ? dd->fifo_expi=
re[data_dir] :
> > +                     CFS_PROPORTION(current, dd->fifo_expire[data_dir]=
);
> > +             rq->fifo_time =3D jiffies + fifo_expire;
> >               insert_before =3D &per_prio->fifo_list[data_dir];
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >               /*
>
> Hard pass on this blatant layering violation. Just like the priority
> changes, this utterly fails to understand how things are properly
> designed.
IMHO, I don't think this is a layering violation. bio_set_ioprio is
the one which introduces the scheduler thing into the block layer,
this commit just wants to do a little improvement based on that. This
commit helps CFS task save some IO time when preempted by RT heavily.

PS: [PATCHv9 1/1] block: introduce content activity based ioprio has
solved layering violation issue. Could you please have a look.
>
> --
> Jens Axboe
>

