Return-Path: <linux-kernel+bounces-127409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DC894AED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0B11F23710
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6818628;
	Tue,  2 Apr 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG0Xe/q0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C91803A;
	Tue,  2 Apr 2024 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036682; cv=none; b=hGKJWphmnt60eEMFd3R/faewPALQo9PqHbQ/II6bQZh8MioIGTh+NXDTUtuaXOJF2sChfi4vX265r20pol5O68z5VtriDHT3ytwOLj8aEj96q2jZiBWKklB6f9U8nwxAN+GIrF8AcVUhCKpmOBmLF30gh6p4vsCIam4A7fi4+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036682; c=relaxed/simple;
	bh=dESIgQbdtYd3N4yNgthDMABPtH2hgaswv7cOW4tUTRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtS84NqV1GSouq2wMa7PjK+sxAW1jhc6VbmS410nPlAB5RrRg1cjX3M2j7yJl+IKNyBgZOuigDJd7QyfqBcaHQSrGjbkikCX+J7uws4z5/GiQlNrHTBUAB1tdd+cXE3B2uTBksWdwpsbcD2fCyP4/YTb1IwBgQ2n6Rlw1Z0wcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG0Xe/q0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so31179335e9.1;
        Mon, 01 Apr 2024 22:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712036678; x=1712641478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HapPy0wGVgdmqgUe2fujV1jw2EA/8wMr8AnIhAWmrtg=;
        b=KG0Xe/q0uGc3TELK2kB8RvsyCKAI2tL+rpQ46g/tllVMKJYxdSNil1kUOEe0ouitqF
         qv2qYgZNYqNtvxr4e7e87b6Gtgf5tul7/1goU3KOZl1v6k3imBJcyv3IVn9RF+hrihYy
         CD0FSmkD0LWQMCvW27DgWoRLPXwd+o6ur745OD1QhG7QdATFwEd5nWxupwAoYne3lbaY
         pbIZNLhoZf1sLcNThlle3XcXyMmkfmqIXIT5gou2uF5IMQBnzCN8UQJYSo0hE5CB7jIZ
         g0pBjg4Q7OoU+1Dg5QRNGrUBDxG8XwjldgPW1ppBqL9VCB9yPJ9G0mi7b1bh1kgZNMah
         r3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712036678; x=1712641478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HapPy0wGVgdmqgUe2fujV1jw2EA/8wMr8AnIhAWmrtg=;
        b=GZYM3fWWp3Yg8q9PE3hsMevJMu7JpaBi/8so8IKv6QPBvZgHe/pXm2TcSjkgx9boFO
         RsEJ0bWaZMv7Mm9BL6fDd+Iy/pZZXkbhssUDZOgpqpzwz9gwlEDwoJ6D2lOoqL3x2Aqp
         FfP+LqTFDOo38ManphtSpR0pjrfUksB4fmEfzueMRSllPPDAE3vNVHcOnLsg90F+tKm5
         UncVm3fJKlwB7m9yL3ZDb9jTczmhiR/q8QC1xux9jHC5KST8gl37txR6mV+diUZLkO3T
         xc+IyAt+ehzSNCbjhTvbl6CZyIFQiYcwSDOpiIEgX+elfp/E3nH6dBHndQ5CiTsyENZI
         6F4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO5jnRc0lKDlKjX3FFv3mkUZfJGuvwPUwQm+L+/nb78xBXnEObQ2RN4pXpLazDrnlU2A7hnsgS1yxphH9svygtWZFbgKnpQTCQWGSFSedXgS8O09RuZyF5GzeMCbq1L3Oq1yuT8tJGt8o=
X-Gm-Message-State: AOJu0YyrgxhxumsZ6mt2bakuXfkaBmydKfwzXZ5DMZTPyEby3WJp9BuQ
	6qg8hsu40UOH7SCB0tTegM6BNPpg77AMp0eL+ZcJxufn5QDZmnX6BQp4AJNRXeZL19dwCxA9kRR
	KanIzfvMor8WokXV+qxAaL7tpbxqVvDuXl8I=
X-Google-Smtp-Source: AGHT+IGwCF7sVhH1lPYYZ9dSvYpS+nLV9sKrN34iTwyfSnF5llXkCQIDqSyEhA6V4Wisrp07yZKuVNZOHwq6ABpHeH0=
X-Received: by 2002:a05:600c:1911:b0:414:7fc6:e482 with SMTP id
 j17-20020a05600c191100b004147fc6e482mr9193558wmq.0.1712036678150; Mon, 01 Apr
 2024 22:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com>
 <890bd06d-2a94-4138-9854-4a7ed74e0e51@acm.org> <CAHJ8P3K9OL6MHNrSrqmf0esbr2h1HJ3mVRmxDNVpf95ZMHQcqg@mail.gmail.com>
 <92e45c93-e2ff-4d34-b70f-7772f0596e68@acm.org>
In-Reply-To: <92e45c93-e2ff-4d34-b70f-7772f0596e68@acm.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 2 Apr 2024 13:44:27 +0800
Message-ID: <CAHJ8P3KgU-tFDAgCNc5GcPbUBtDDyFmcfza2HsoD9TJ3h1DS=Q@mail.gmail.com>
Subject: Re: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, ke.wang@unisoc.com, hongyu.jin@unisoc.com, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:23=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 3/31/24 17:58, Zhiguo Niu wrote:
> > On Sat, Mar 30, 2024 at 2:08=E2=80=AFAM Bart Van Assche <bvanassche@acm=
org> wrote:
> >>
> >> On 3/28/24 7:44 PM, Zhiguo Niu wrote:
> >>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> >>> index 02a916b..89c516e 100644
> >>> --- a/block/mq-deadline.c
> >>> +++ b/block/mq-deadline.c
> >>> @@ -646,10 +646,12 @@ static void dd_depth_updated(struct blk_mq_hw_c=
tx *hctx)
> >>>        struct request_queue *q =3D hctx->queue;
> >>>        struct deadline_data *dd =3D q->elevator->elevator_data;
> >>>        struct blk_mq_tags *tags =3D hctx->sched_tags;
> >>> +     unsigned int shift =3D tags->bitmap_tags.sb.shift;
> >>> +     unsigned int dd_min_depth =3D max(1U, 3 * (1U << shift)  / 4);
> >>>
> >>>        dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
> >>>
> >>> -     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_d=
epth);
> >>> +     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd_min_dept=
h);
> >>>    }
> >>
> >> The above patch sets min_shallow_depth to the same value as commit
> >> d47f9717e5cf ("block/mq-deadline: use correct way to throttling write
> >> requests"). That commit got reverted because it was causing performanc=
e
> >> problems. So the above patch reintroduces the performance problem that
> >> has been fixed by commit 256aab46e316 ("Revert "block/mq-deadline: use
> >> correct way to throttling write requests"").
> > Hi Bart Van Assche,
> >
> > This  patch only modifies the initial minimum value of
> > min_shallow_depth and does not change "dd->async_depth",
> > so it will not cause performance problems like the previous patch
> > (d47f9717e5cf ("block/mq-deadline: use correct way to throttling write
> > requests")).
>
Hi Bart Van Assche,
thanks for your reply.

> Oops, I misread your patch. After having taken another look, my
> conclusions are as follows:
> * sbitmap_queue_min_shallow_depth() is called. This causes
>    sbq->wake_batch to be modified but I don't think that it is a proper
>    fix for dd_limit_depth().
yes, it will affect sbq->wake_batch,  But judging from the following code:
wake_batch =3D clamp_t(unsigned int, depth / SBQ_WAIT_QUEUES, 1, SBQ_WAKE_B=
ATCH);
wake_batch will be between 1~8. and my experiment result is:
1. hw conditions:  8 cpus,emmc flash, one hw queue, and
queue_depth=3D64, sched_tag/nr_request=3D128, init dd->async_depth=3D96
--before this patch, get sched_tag infor from
sys/kernel/debug/block/mmcblk0/hctx0
---depth=3D128
---bits_per_word=3D32
---map_nr=3D4
---wake_batch=3D8
---min_shallow_depth=3D96
--after this patch, get sched_tag infor from
sys/kernel/debug/block/mmcblk0/hctx0
---bits_per_word=3D32
---map_nr=3D4
---wake_batch=3D8
---min_shallow_depth=3D24
wake_batch not changed.

2. hw conditions:  8 cpus,ufs flash, one hw queue, and queue_depth=3D31,
sched_tag/nr_request=3D62, init dd->async_depth=3D46
--before this patch, get sched_tag infor from sys/kernel/debug/block/sda/hc=
tx0
---depth=3D62
---bits_per_word=3D8
---map_nr=3D8
---wake_batch=3D7
---min_shallow_depth=3D46
--after this patch, get sched_tag infor from sys/kernel/debug/block/sda/hct=
x0
---bits_per_word=3D8
---map_nr=3D8
---wake_batch=3D6
---min_shallow_depth=3D6
wake_batch changed from 7 to 6, so it seems the patch  have little
impact on wake_batch?

> * dd_limit_depth() still assigns a number in the range 1..nr_requests to
>    data->shallow_depth while a number in the range 1..(1<<bt->sb.shift)
>    should be assigned.
yes, In order to avoid the performance regression problem that Harshit
Mogalapalli reported, this patch will not directly modify
dd->async_depth,
but user can modify dd->async_depth from sysfs according to user's
request. which will modify data->shallow_depth after user modify it by
sysfs.
>
> > So what are your suggestions for fixing the warning shown in commit
> > msg if dd->async_depth is set by the user from sysfs?
> > thanks
>
> How about the two untested patches below?
>
> Thanks,
>
> Bart.
>
>
> Subject: [PATCH 1/2] block: Call .limit_depth() after .hctx has been set
>
> Prepare for using .hctx in dd_limit_depth().
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 34060d885c5a..d0db9252bb71 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -435,6 +435,7 @@ __blk_mq_alloc_requests_batch(struct
> blk_mq_alloc_data *data)
>   static struct request *__blk_mq_alloc_requests(struct
> blk_mq_alloc_data *data)
>   {
>         struct request_queue *q =3D data->q;
> +       struct elevator_mq_ops *ops =3D NULL;
>         u64 alloc_time_ns =3D 0;
>         struct request *rq;
>         unsigned int tag;
> @@ -459,13 +460,11 @@ static struct request
> *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>                  */
>                 if ((data->cmd_flags & REQ_OP_MASK) !=3D REQ_OP_FLUSH &&
>                     !blk_op_is_passthrough(data->cmd_flags)) {
> -                       struct elevator_mq_ops *ops =3D &q->elevator->typ=
e->ops;
> +                       ops =3D &q->elevator->type->ops;
>
>                         WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
>
>                         data->rq_flags |=3D RQF_USE_SCHED;
> -                       if (ops->limit_depth)
> -                               ops->limit_depth(data->cmd_flags, data);
>                 }
>         }
>
> @@ -478,6 +477,9 @@ static struct request
> *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>         if (data->flags & BLK_MQ_REQ_RESERVED)
>                 data->rq_flags |=3D RQF_RESV;
>
> +       if (ops && ops->limit_depth)
> +               ops->limit_depth(data->cmd_flags, data);
> +
>         /*
>          * Try batched alloc if we want more than 1 tag.
>          */
>
>
>
I think this part is OK .
> Subject: [PATCH 2/2] block/mq-deadline: Fix the tag reservation code
>
> Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags
> for synchronous requests")
> ---
>   block/mq-deadline.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 02a916ba62ee..8e780069d91b 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -621,6 +621,20 @@ static struct request *dd_dispatch_request(struct
> blk_mq_hw_ctx *hctx)
>         return rq;
>   }
>
> +/*
> + * 'depth' is a number in the range 0..q->nr_requests. Convert it to a
> number
> + * in the range 0..(1 << bt->sb.shift) since that is the range expected =
by
> + * sbitmap_get_shallow().
> + */
> +static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int
> qdepth)
> +{
> +       struct sbitmap_queue *bt =3D &hctx->sched_tags->bitmap_tags;
> +       const unsigned int nrr =3D hctx->queue->nr_requests;
> +
> +       return max(((qdepth << bt->sb.shift) + nrr - 1) / nrr,
> +                  bt->min_shallow_depth);
will this still  cause the performance regression mentioned by Harshit
Mogalapalli?
this will change data->shallow_depth value that is less than
dd->async_depth " dd->async_depth =3D max(1UL, 3 * q->nr_requests /
4);".
> +}
> +
>   /*
>    * Called by __blk_mq_alloc_request(). The shallow_depth value set by t=
his
>    * function is used by __blk_mq_get_tag().
> @@ -637,7 +651,7 @@ static void dd_limit_depth(blk_opf_t opf, struct
> blk_mq_alloc_data *data)
>          * Throttle asynchronous requests and writes such that these requ=
ests
>          * do not block the allocation of synchronous requests.
>          */
> -       data->shallow_depth =3D dd->async_depth;
> +       data->shallow_depth =3D dd_to_word_depth(data->hctx, dd->async_de=
pth);
>   }
>
>   /* Called by blk_mq_update_nr_requests(). */
> @@ -649,7 +663,7 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hc=
tx)
>
>         dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
>
> -       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_dep=
th);
> +       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
this will also change  min_shallow_depth and affect wake_batch?

My personal opinion is to keep the current dd->aync_depth unchanged to
avoid causing performance regression,
but it should  allow users to set it by sysfs, and the WARN mentioned
best to be solved.
and just only change this part?
 -       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_dept=
h);
 +       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
thanks!
>   }
>
>   /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
>

