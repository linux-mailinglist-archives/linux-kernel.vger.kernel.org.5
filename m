Return-Path: <linux-kernel+bounces-58904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B520D84EE60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384B81F25FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C807FF;
	Fri,  9 Feb 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik+BM2gX"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55301360;
	Fri,  9 Feb 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438551; cv=none; b=l+SJHsSZwcoFLcDWW/PRpAwF9Iid4zJZKg8RVgOkrXKRjgf1vhNwJ5o/w8vrbNdv127enLbQaB7P9IMydpL2m8KwMQBkx/ccb7muogc29q1kzHJZynaHSaXJRH01roLxJV7tFbxXs9Z3un422R1OIVCD9cZuE0aDL8sPhupAJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438551; c=relaxed/simple;
	bh=mxIXfavPDX1gqzM3y8fLX5I+QOs8CzXzRcxl+812TWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNreBpaOcfErBZwU1Z6xb9FJyTGg0PTrE+GtB7HpghhE9YQqNfJgVuUm9CKeNxec5VTbIOTxM8xhZ1IgnwQ/KHflaU55uUdqZ4F3UoMOvdsPheEaQMXIWxJHKC2pNXT+K/WzbjAQAINFo3yROKG7ekQcCET2hp0nIqXPFJD7Zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik+BM2gX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09faadba5so6367731fa.1;
        Thu, 08 Feb 2024 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707438547; x=1708043347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m85Rc7O+xtvz/kv98+mO9yNpBrc4x6v0UIlGlomnOFQ=;
        b=ik+BM2gXhfF9TUoMmIOIIJdBeBjOdrVLMcEZuYtfeXLmRs1jnhYjMGw/g2OHTIS7ia
         /AbsV9SJ5eDWC1DSMh9gtkcWiokEzAR6Yn+B3rGLg3m+kR/On6nB3hyIRjnQD/tkY+/f
         tAX4HUXOeLJa7ZC3uPQwWb6OqtF1V2INhREp08xL4HjgqBp6vjRmUuR524fgT48BNDFz
         euwR1CRj4e0MaJFxsFxjPWxh8RkE+ESoNO8McOpZcop4Oqv2YGsliZ6axmEHUzNfD1ty
         hwOGTy0MS+6re1c081OXK49CsNm0L77B51Ui1UQUhOYUEbHODIQoDK5dcRPAmMGUCbq0
         EkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707438547; x=1708043347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m85Rc7O+xtvz/kv98+mO9yNpBrc4x6v0UIlGlomnOFQ=;
        b=b8SOOlODQAwEcnEOKnPSf7mX6z9cCYoucfHzPMkD9uHKKWeljg6bw0yny2S20VgmK6
         2FIE5n/c7S9RBxQzbUWVnrPt0m0ieEr606BnRnFYu1b7xawKQYbqXmlQZCq6vvK49l9X
         B6AUepxixFQHWFydOGqrRLZctlmXSi7Yh1zej0CcpckrqMoskUZy3JYmHjpiTAWyW+cb
         5AnrvhEE49oNp6dl+LHbQh2uAZWmo9GKQ4aA18KQ8SMrZRPFB1OLQdcC4PygQmoA+4JT
         KnTHmfAJB2avR4cqbcTcKA5AzyotcKGSrG6fTE3JGJ2J1vkTzTWiq3GyniFKH0jQZoqn
         +Zbg==
X-Gm-Message-State: AOJu0YzMO06ZCNfNhQxlZBk9MYUOg49fKia54xQeL3djvXF/cjPNX0YU
	gO9/I8BfIW2z9HC1MToFeGW+GuRZzYilazsXCJAqzU08vu0eicEr/We/LuxGnYn2iik7p9jlxhk
	Mr/t9ykVUuiFzFQ+L0WXP7VNUKII=
X-Google-Smtp-Source: AGHT+IFCVX4IVfOyeEpva/DPmxBJEmy15N2pfq7usKYdm30lldPboQ7A7iqrtCXsa05A0cmAimGP4ZAKW+5USCZa+h4=
X-Received: by 2002:a2e:83d0:0:b0:2d0:af09:e3df with SMTP id
 s16-20020a2e83d0000000b002d0af09e3dfmr98586ljh.16.1707438547136; Thu, 08 Feb
 2024 16:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com> <ca00ff75-e98d-4652-9c52-94b2e876901e@kernel.dk>
 <CAGWkznH6Y8u7PsoHWid0uQ+ceRK_qzSn6=eWn4dvDhK+DzSXzg@mail.gmail.com> <da41bac4-015f-4df0-b8cc-6c8b2f468e12@kernel.dk>
In-Reply-To: <da41bac4-015f-4df0-b8cc-6c8b2f468e12@kernel.dk>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 9 Feb 2024 08:28:55 +0800
Message-ID: <CAGWkznGnyPXM_DyyUxxZFoW=3K0B3Nh8sRZ8Lnsvm7WfES_fmA@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
To: Jens Axboe <axboe@kernel.dk>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Yu Zhao <yuzhao@google.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 8:11=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/8/24 5:02 PM, Zhaoyang Huang wrote:
> > On Fri, Feb 9, 2024 at 1:49?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 2/8/24 2:31 AM, zhaoyang.huang wrote:
> >>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> >>> index f958e79277b8..43c08c3d6f18 100644
> >>> --- a/block/mq-deadline.c
> >>> +++ b/block/mq-deadline.c
> >>> @@ -15,6 +15,7 @@
> >>>  #include <linux/compiler.h>
> >>>  #include <linux/rbtree.h>
> >>>  #include <linux/sbitmap.h>
> >>> +#include "../kernel/sched/sched.h"
> >>>
> >>>  #include <trace/events/block.h>
> >>>
> >>> @@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ct=
x *hctx, struct request *rq,
> >>>       u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
> >>>       struct dd_per_prio *per_prio;
> >>>       enum dd_prio prio;
> >>> +     int fifo_expire;
> >>>
> >>>       lockdep_assert_held(&dd->lock);
> >>>
> >>> @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ct=
x *hctx, struct request *rq,
> >>>               /*
> >>>                * set expire time and add to fifo list
> >>>                */
> >>> -             rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];
> >>> +             fifo_expire =3D task_is_realtime(current) ? dd->fifo_ex=
pire[data_dir] :
> >>> +                     CFS_PROPORTION(current, dd->fifo_expire[data_di=
r]);
> >>> +             rq->fifo_time =3D jiffies + fifo_expire;
> >>>               insert_before =3D &per_prio->fifo_list[data_dir];
> >>>  #ifdef CONFIG_BLK_DEV_ZONED
> >>>               /*
> >>
> >> Hard pass on this blatant layering violation. Just like the priority
> >> changes, this utterly fails to understand how things are properly
> >> designed.
> > IMHO, I don't think this is a layering violation. bio_set_ioprio is
> > the one which introduces the scheduler thing into the block layer,
> > this commit just wants to do a little improvement based on that. This
> > commit helps CFS task save some IO time when preempted by RT heavily.
>
> Listen, both this and the previous content ioprio thing show a glaring
> misunderstanding of how to design these kinds of things. You have no
> grasp of what the different layers do, or how they interact. I'm not
> sure how to put this kindly, but it's really an awful idea to hardcore
> some CFS helper into the IO scheduler. The fact that you had to fiddle
> around with headers to make it work was the first warning sign, and the
> fact that you didn't stop at that point to consider how it could be
> properly done makes it even worse.
>
> You need to stop sending kernel patches until you understand basic
> software design. Neither of these patches are going anywhere until this
> happens. There's been plenty of feedback to telling you that, but you
> seem to just ignore it and plow on ahead. Stop.
Ok, thanks for pointing this out, I will follow your advice. But I
have to say that '[PATCHv9 1/1] block: introduce content activity
based ioprio' really solved layering violation things. I would like to
humbly ask for your kindly patient to have a look, as it is really
helpful.
>
> --
> Jens Axboe
>

