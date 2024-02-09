Return-Path: <linux-kernel+bounces-58959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA89F84EF32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A3C284AB8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9797F4C8E;
	Fri,  9 Feb 2024 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUXaXEhO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106494A33;
	Fri,  9 Feb 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448135; cv=none; b=NlmJBktIuZV3pYml0eNwvo98GV5mh/X1yolj8z8dd3Z9mpgeqMDwKTRtwlnlncmbq2hbQzdTqBlP5nuAaaKgItyxT/ID3X/0xZOLpqzdI4NgTIQqoFI56pvGW2fNKXe42gaGFIBCN7Lbk8KMkA96NK1VzpkU8+6vD1iDfPfYV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448135; c=relaxed/simple;
	bh=HSwIs+6yXgaeXaxtBZqR5tlrFYIiuRbB70oiT9yzVos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua1LCYy/I2s399rOxP7gRiU3yOPvtVQDoyyDMXGH62en5JfWLknvOdTVo4EYnGmye4E/XSaNKt4RDGIgeCUsK2Ju+osyiqGSTXZVJPb4baC+eekvhFFJmH8zmy08HixMIoagX6f9XrL0ffhj2H+9hx/ZNLkoy4+SW3i/ryiuzns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUXaXEhO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5116ec49081so515843e87.2;
        Thu, 08 Feb 2024 19:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707448132; x=1708052932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA7zysnnen/eiyjA85Qy8vXwnmTQ4CUuQzIP9UDpn9c=;
        b=nUXaXEhOmcm4Yd1yWg2ct/lg/MzdlC7V7b6vvTXJjjrM69XgIfX3QXI+laez5Eugt1
         Ib0sofnB7EZN/wOGq+by9ej8i0S6icTARNc2+XnILDknldXa/w+3WxR5bQdJdbdk7MQ9
         LgjmHKdb5RZRv90CXVAZMl66artMxqAKqU2EtLDoHEQvP0jM4iO4MEuMkGCEu6iCX96O
         1FllXrnBE6W6rDs7iTEFqHbpynTKxdiJ7sFw+bQu/uytM9RZG0JUi19BTjou5RLKE2DK
         9fpeYQ/cdg7kXVg3DI8mNnRCH6lwx+3WmZJMvBF/nbIl2miuDADDWI1SkKXPUsbUUJQQ
         Kc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707448132; x=1708052932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA7zysnnen/eiyjA85Qy8vXwnmTQ4CUuQzIP9UDpn9c=;
        b=VoKJC4QGBoOYOpx5NrKItyPTgW+SFzWJzHJLluSGM60MfxTlbvkUMi3VQKk6HRsvJe
         OgsikByLnugr/RbAN6J84N5XGxO4pNrLJad89ykjOebVyYqyy0gASUaBfIw4sNrYRBhv
         9pcqS57p4mGBnM9faKLPrzRWObDPQ7JY1yGVg+QTP10PdnWLplOwKAJ0zgIle6YalCJI
         QrENn79yWpZATOcH8so+jr4MRuk6YqiB5jFGwrUW5hEUzGpE9dJEe5SsKBJQMfzl7ecB
         uN+mNaYGpsepAqaOTIH9roh9ciBwvGR6pHBMROnq4waZfiIflPoSvvKjzUjb1PxXzhag
         pWPg==
X-Gm-Message-State: AOJu0Yy9R1wSxKOY1G363nTaeVX+MOXDC0brQupxpDO2m6GxMuuDGrcX
	2nIyQ5Zt29Hhafsm8gtHYRu6x5j1onnW7Lu17ny39z7oi0zTR7j9JrScfP8FMLIECjZHHk6X2Gk
	pOjt5tWgOA8v3mxzE8LOLweZBoXanhb/PffM=
X-Google-Smtp-Source: AGHT+IGNq80u/yGxy3EnckYt2BORTY+QclBMj8OBVDQu8SjsCU3ideqfu4PQGKkxm+Z1JrhMtSmFKlfGGrb3t1ac2lU=
X-Received: by 2002:a05:6512:4ce:b0:511:429e:43d4 with SMTP id
 w14-20020a05651204ce00b00511429e43d4mr127741lfq.11.1707448131775; Thu, 08 Feb
 2024 19:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com> <ca00ff75-e98d-4652-9c52-94b2e876901e@kernel.dk>
 <CAGWkznH6Y8u7PsoHWid0uQ+ceRK_qzSn6=eWn4dvDhK+DzSXzg@mail.gmail.com>
 <da41bac4-015f-4df0-b8cc-6c8b2f468e12@kernel.dk> <CAGWkznGnyPXM_DyyUxxZFoW=3K0B3Nh8sRZ8Lnsvm7WfES_fmA@mail.gmail.com>
 <e4078b85-5675-4fdb-a01f-7112342ec501@kernel.org>
In-Reply-To: <e4078b85-5675-4fdb-a01f-7112342ec501@kernel.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 9 Feb 2024 11:08:40 +0800
Message-ID: <CAGWkznFRTKmqH1Y6sQ=9dbK2q0LfJ5VEzba2Y7rsy01HWVqJZg@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Yu Zhao <yuzhao@google.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 9:58=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 2/9/24 09:28, Zhaoyang Huang wrote:
> > On Fri, Feb 9, 2024 at 8:11=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wro=
te:
> >>
> >> On 2/8/24 5:02 PM, Zhaoyang Huang wrote:
> >>> On Fri, Feb 9, 2024 at 1:49?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 2/8/24 2:31 AM, zhaoyang.huang wrote:
> >>>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> >>>>> index f958e79277b8..43c08c3d6f18 100644
> >>>>> --- a/block/mq-deadline.c
> >>>>> +++ b/block/mq-deadline.c
> >>>>> @@ -15,6 +15,7 @@
> >>>>>  #include <linux/compiler.h>
> >>>>>  #include <linux/rbtree.h>
> >>>>>  #include <linux/sbitmap.h>
> >>>>> +#include "../kernel/sched/sched.h"
> >>>>>
> >>>>>  #include <trace/events/block.h>
> >>>>>
> >>>>> @@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_=
ctx *hctx, struct request *rq,
> >>>>>       u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
> >>>>>       struct dd_per_prio *per_prio;
> >>>>>       enum dd_prio prio;
> >>>>> +     int fifo_expire;
> >>>>>
> >>>>>       lockdep_assert_held(&dd->lock);
> >>>>>
> >>>>> @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_=
ctx *hctx, struct request *rq,
> >>>>>               /*
> >>>>>                * set expire time and add to fifo list
> >>>>>                */
> >>>>> -             rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir]=
;
> >>>>> +             fifo_expire =3D task_is_realtime(current) ? dd->fifo_=
expire[data_dir] :
> >>>>> +                     CFS_PROPORTION(current, dd->fifo_expire[data_=
dir]);
> >>>>> +             rq->fifo_time =3D jiffies + fifo_expire;
> >>>>>               insert_before =3D &per_prio->fifo_list[data_dir];
> >>>>>  #ifdef CONFIG_BLK_DEV_ZONED
> >>>>>               /*
> >>>>
> >>>> Hard pass on this blatant layering violation. Just like the priority
> >>>> changes, this utterly fails to understand how things are properly
> >>>> designed.
> >>> IMHO, I don't think this is a layering violation. bio_set_ioprio is
> >>> the one which introduces the scheduler thing into the block layer,
> >>> this commit just wants to do a little improvement based on that. This
> >>> commit helps CFS task save some IO time when preempted by RT heavily.
> >>
> >> Listen, both this and the previous content ioprio thing show a glaring
> >> misunderstanding of how to design these kinds of things. You have no
> >> grasp of what the different layers do, or how they interact. I'm not
> >> sure how to put this kindly, but it's really an awful idea to hardcore
> >> some CFS helper into the IO scheduler. The fact that you had to fiddle
> >> around with headers to make it work was the first warning sign, and th=
e
> >> fact that you didn't stop at that point to consider how it could be
> >> properly done makes it even worse.
> >>
> >> You need to stop sending kernel patches until you understand basic
> >> software design. Neither of these patches are going anywhere until thi=
s
> >> happens. There's been plenty of feedback to telling you that, but you
> >> seem to just ignore it and plow on ahead. Stop.
> > Ok, thanks for pointing this out, I will follow your advice. But I
> > have to say that '[PATCHv9 1/1] block: introduce content activity
> > based ioprio' really solved layering violation things. I would like to
> > humbly ask for your kindly patient to have a look, as it is really
> > helpful.
>
> If properly designed, that patch would *not* be a block layer API/functio=
n and
> so does not need review by block layer folks/Jens as it would simply set =
an IO
> prio for a BIO issued by an FS. So that patch needs to be accepted by FS
> people, for the FS you are interested in.
Thanks for the heads-up, sorry for my none-sense on the needs of
maintaining the whole framework. IMHO, the newly introduced API is a
little bit like bio_set_pages_dirty which is mainly related to bio and
the pages inside. Patchv9 has changed a lot to meet your kind advice.
I would be grateful to you if you could review it.
>
>
> --
> Damien Le Moal
> Western Digital Research
>

