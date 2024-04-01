Return-Path: <linux-kernel+bounces-127080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59AF894680
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B0EB22764
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4854BD6;
	Mon,  1 Apr 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fWgc6Hib"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89D4683;
	Mon,  1 Apr 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006609; cv=none; b=ZfCSM3BTp0pCp+MhbxfNlD+aw5k1gVfUG21UnXhXZvMtQkOPepktsW8yFAXa/PHUGpvqDUO8q+z8uUPaq+AA5N9uRXrw3m9sL414wHM3bknb9QFppg/lqcmJ7sERsdQtzjkSEVawRQdKLAAhfXQIMJ2lRyq+sTyKdpWhhYYcRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006609; c=relaxed/simple;
	bh=CFKYD9nVhCS3d3jWxKqwf7HPx0PmDPX0G8/hDBXf/TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFU73TokmuH6tG0CfLcHvth1/h0RyDB/eb9Uqck55t9uhfdK6PfQDw9hQ5QIvVzC+Ca9rlnhNPKWJmBJT1TtBWOXMEteAoqvDbQpqmebi65zqPDtlKg2lGl6YyVwyZKRZDnQOPkx6D0J+nUnN1RSzh6juBoV5SDyuEitkRUCoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fWgc6Hib; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V7kWs2kdzz6Cnk8t;
	Mon,  1 Apr 2024 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712006594; x=1714598595; bh=O7oKmKUsBp2UuDlgNH+Fc49v
	eA1RbMZi5k1upyKoAng=; b=fWgc6Hib+t0Pg/8cg55FNrqGHd74DX17FAgsa/vj
	AS2i44wlI4OLpu7D/OJEZL7Jr6+A4rZ8QwA1l9D8IjPZn7G5POE4MzrcsHjlRLvL
	u7laJHFI8AzgDAmqqB9ukKzxstt3BXHEk5mPpUZ5Bs2Dy8InWoNt8Oar/xm0VMOV
	YrOFFvWfXWcyP+MFptn3a2Rw7KVakN2bqup95uqW/oGqgrCtS5Wpqhzj5msACk1m
	CD9G4XtHV/j95g7Sl9d+pDJ9G2T7rnWyEsgpbqNeY8UMnpKWvdLKYRGeZkg1jsKr
	Z2AFV8hM2qJxdlADI0Jt+qkoIEVjbUPUiicCDUQYeJHaCw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h-yZf0CWai33; Mon,  1 Apr 2024 21:23:14 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V7kWh3FJ5z6Cnk8m;
	Mon,  1 Apr 2024 21:23:12 +0000 (UTC)
Message-ID: <92e45c93-e2ff-4d34-b70f-7772f0596e68@acm.org>
Date: Mon, 1 Apr 2024 14:23:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com,
 Damien Le Moal <dlemoal@kernel.org>
References: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com>
 <890bd06d-2a94-4138-9854-4a7ed74e0e51@acm.org>
 <CAHJ8P3K9OL6MHNrSrqmf0esbr2h1HJ3mVRmxDNVpf95ZMHQcqg@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHJ8P3K9OL6MHNrSrqmf0esbr2h1HJ3mVRmxDNVpf95ZMHQcqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/31/24 17:58, Zhiguo Niu wrote:
> On Sat, Mar 30, 2024 at 2:08=E2=80=AFAM Bart Van Assche <bvanassche@acm=
org> wrote:
>>
>> On 3/28/24 7:44 PM, Zhiguo Niu wrote:
>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>>> index 02a916b..89c516e 100644
>>> --- a/block/mq-deadline.c
>>> +++ b/block/mq-deadline.c
>>> @@ -646,10 +646,12 @@ static void dd_depth_updated(struct blk_mq_hw_c=
tx *hctx)
>>>        struct request_queue *q =3D hctx->queue;
>>>        struct deadline_data *dd =3D q->elevator->elevator_data;
>>>        struct blk_mq_tags *tags =3D hctx->sched_tags;
>>> +     unsigned int shift =3D tags->bitmap_tags.sb.shift;
>>> +     unsigned int dd_min_depth =3D max(1U, 3 * (1U << shift)  / 4);
>>>
>>>        dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
>>>
>>> -     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_d=
epth);
>>> +     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd_min_dept=
h);
>>>    }
>>
>> The above patch sets min_shallow_depth to the same value as commit
>> d47f9717e5cf ("block/mq-deadline: use correct way to throttling write
>> requests"). That commit got reverted because it was causing performanc=
e
>> problems. So the above patch reintroduces the performance problem that
>> has been fixed by commit 256aab46e316 ("Revert "block/mq-deadline: use
>> correct way to throttling write requests"").
> Hi Bart Van Assche,
>=20
> This  patch only modifies the initial minimum value of
> min_shallow_depth and does not change "dd->async_depth",
> so it will not cause performance problems like the previous patch
> (d47f9717e5cf ("block/mq-deadline: use correct way to throttling write
> requests")).

Oops, I misread your patch. After having taken another look, my
conclusions are as follows:
* sbitmap_queue_min_shallow_depth() is called. This causes
   sbq->wake_batch to be modified but I don't think that it is a proper
   fix for dd_limit_depth().
* dd_limit_depth() still assigns a number in the range 1..nr_requests to
   data->shallow_depth while a number in the range 1..(1<<bt->sb.shift)
   should be assigned.

> So what are your suggestions for fixing the warning shown in commit
> msg if dd->async_depth is set by the user from sysfs?
> thanks

How about the two untested patches below?

Thanks,

Bart.


Subject: [PATCH 1/2] block: Call .limit_depth() after .hctx has been set

Prepare for using .hctx in dd_limit_depth().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/blk-mq.c | 8 +++++---
  1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 34060d885c5a..d0db9252bb71 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -435,6 +435,7 @@ __blk_mq_alloc_requests_batch(struct=20
blk_mq_alloc_data *data)
  static struct request *__blk_mq_alloc_requests(struct=20
blk_mq_alloc_data *data)
  {
  	struct request_queue *q =3D data->q;
+	struct elevator_mq_ops *ops =3D NULL;
  	u64 alloc_time_ns =3D 0;
  	struct request *rq;
  	unsigned int tag;
@@ -459,13 +460,11 @@ static struct request=20
*__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
  		 */
  		if ((data->cmd_flags & REQ_OP_MASK) !=3D REQ_OP_FLUSH &&
  		    !blk_op_is_passthrough(data->cmd_flags)) {
-			struct elevator_mq_ops *ops =3D &q->elevator->type->ops;
+			ops =3D &q->elevator->type->ops;

  			WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);

  			data->rq_flags |=3D RQF_USE_SCHED;
-			if (ops->limit_depth)
-				ops->limit_depth(data->cmd_flags, data);
  		}
  	}

@@ -478,6 +477,9 @@ static struct request=20
*__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
  	if (data->flags & BLK_MQ_REQ_RESERVED)
  		data->rq_flags |=3D RQF_RESV;

+	if (ops && ops->limit_depth)
+		ops->limit_depth(data->cmd_flags, data);
+
  	/*
  	 * Try batched alloc if we want more than 1 tag.
  	 */



Subject: [PATCH 2/2] block/mq-deadline: Fix the tag reservation code

Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags=20
for synchronous requests")
---
  block/mq-deadline.c | 18 ++++++++++++++++--
  1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916ba62ee..8e780069d91b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -621,6 +621,20 @@ static struct request *dd_dispatch_request(struct=20
blk_mq_hw_ctx *hctx)
  	return rq;
  }

+/*
+ * 'depth' is a number in the range 0..q->nr_requests. Convert it to a=20
number
+ * in the range 0..(1 << bt->sb.shift) since that is the range expected =
by
+ * sbitmap_get_shallow().
+ */
+static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int=20
qdepth)
+{
+	struct sbitmap_queue *bt =3D &hctx->sched_tags->bitmap_tags;
+	const unsigned int nrr =3D hctx->queue->nr_requests;
+
+	return max(((qdepth << bt->sb.shift) + nrr - 1) / nrr,
+		   bt->min_shallow_depth);
+}
+
  /*
   * Called by __blk_mq_alloc_request(). The shallow_depth value set by t=
his
   * function is used by __blk_mq_get_tag().
@@ -637,7 +651,7 @@ static void dd_limit_depth(blk_opf_t opf, struct=20
blk_mq_alloc_data *data)
  	 * Throttle asynchronous requests and writes such that these requests
  	 * do not block the allocation of synchronous requests.
  	 */
-	data->shallow_depth =3D dd->async_depth;
+	data->shallow_depth =3D dd_to_word_depth(data->hctx, dd->async_depth);
  }

  /* Called by blk_mq_update_nr_requests(). */
@@ -649,7 +663,7 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hc=
tx)

  	dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);

-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
  }

  /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */


