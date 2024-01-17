Return-Path: <linux-kernel+bounces-29148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14183099C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EDD1F21739
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3FF219FC;
	Wed, 17 Jan 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gVZpMmny"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CB2136A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504835; cv=none; b=ZttazxqHIRKhXBPnT6iKCim8VoIUVuYYVl+1J1qJqVDlYEcPlaNisHwL48e5avbj30MbTgmk+ZxXvjkRAaYMtjuxDHBk7hNB7dSPjGegT3QTWDpvJm2zgPK9OJQSC386w3qk3tKEJEidXeiT2Vhyl3OtGrOZK+CuykyfwdrkwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504835; c=relaxed/simple;
	bh=8h//Y4D40TIJ3bm66JZJVXSbBnrYa+8chML8MPwAOmA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=igDRL9lRu7rjubwPcUitde9OZvRR0sK4bzIrjOtUL+3UqYJC5aEOSoT689xWtQ37yfVmyeYMK8ZpujnLDjwT3UW2V/Mrt3KHB+OnUyvVaUMA9tBW9o9SaPVvgsWaBqy8lySZF9anHy9pvj3yT6tBARKdU3vRphFOguyyQxYIPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gVZpMmny; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36095e0601bso4368995ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705504830; x=1706109630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6t76MRgEP0lNMIx3NTwHCmr1aDY56vh5yaF0XHXtoYw=;
        b=gVZpMmnyfWffE0R4LCDkMy23YNSdpMeWXGaWQVIn7JxPFfcOYffHUR4DSpCnjaD0o3
         YD1VMUrY7Ficb2NZooiizLambUqEvUXon7ln0ymzDSfnt+B8vrd61CzxSlXj8NJ/PgA3
         wb8dkQn+ha3XtF3IXrs4asNvaxN+yWr86jVtjVdonQdY2Ng4fUGS/g2Eg0/fj62WT3Uv
         KLTPx6d4Rtm4/zsYLiDg4M+8o5XAB7o/W9ciH5dcv5aotLDGVIPRWLyNL+GpgijUukS/
         EzPhBavd6A+noFC94vLG2hFv2k2xS/dKv7rWA/L5/RuOAEhYdU4uZDQ7f9DWOgGt3kjJ
         jkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705504830; x=1706109630;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6t76MRgEP0lNMIx3NTwHCmr1aDY56vh5yaF0XHXtoYw=;
        b=VKrm9zoZ6lOpBj/fnTmqJ6ip4F9Vvq34cd6+S/6Nc80iSCGTrKsJ+u0Td9yNL2Jgns
         bgIsfBsW9Econ+UAFh2IFCM3pud4LwJw8V3L48VH1a4UysGRJu7uDkwxSlZ9QvKOb1oE
         NtQIT9OKXQDea1X5bmDKsDpDdwXkSbj3J5uRJyio8dmn7/rXt2Knrhp1BAakNzU0QkDL
         aVRm56QVAWN3DXRnQ2SkpIOhPMweXDD29+iZKemt91FK87T8LYXlH97p/2SnDOkTPUMO
         bk/MIdbxotev3Y+jHg70wxuXYy/zab9uh80O/DdORmbDypbwkB1+n36zYQUPSaGB5wyQ
         kwZw==
X-Gm-Message-State: AOJu0Yx2xOsJobm5Zmf8pHfIsUEHOOkixoIWNdymgI8FNaJBcpOFMUcd
	oWClsFvWBcImTE6G5sWuCmlA0ZDa3iuqxQ==
X-Google-Smtp-Source: AGHT+IHTZVxZlpRMD6m3xrWxmZ4DDvayZPLBzeE0M+bz0WrzsfdwWXRN51BD8aqJtpX783JSZN6Rlg==
X-Received: by 2002:a05:6602:14c7:b0:7be:edbc:629f with SMTP id b7-20020a05660214c700b007beedbc629fmr16799807iow.0.1705504829992;
        Wed, 17 Jan 2024 07:20:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b18-20020a026f52000000b0046e5fe2d364sm460581jae.9.2024.01.17.07.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 07:20:29 -0800 (PST)
Message-ID: <00afbc29-9f25-403e-af18-08953fa79e24@kernel.dk>
Date: Wed, 17 Jan 2024 08:20:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] block: introduce activity based ioprio
Content-Language: en-US
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
References: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/24 2:23 AM, zhaoyang.huang wrote:
> [1]
> ./fault_latency.bin 1 5 > /data/dd_costmem &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> dd if=/dev/block/sda of=/data/ddtest bs=1024 count=2048000 &
> dd if=/dev/block/sda of=/data/ddtest1 bs=1024 count=2048000 &
> dd if=/dev/block/sda of=/data/ddtest2 bs=1024 count=2048000 &
> dd if=/dev/block/sda of=/data/ddtest3 bs=1024 count=2048000
> 
> [2]
> mainline:
> Summary for 5932.00(ms)
>     All Faults:       1398   235.67 counts/sec
>         Iowait:        553    93.22 counts/sec
>    All latency:    7432948  1253.03 us/ms
>         Iowait:    1321971   222.85 us/ms
> Summary for 6706.00(ms)
>     All Faults:       1921   286.46 counts/sec
>         Iowait:       1273   189.83 counts/sec
>    All latency:   25890252  3860.76 us/ms
>         Iowait:    4468861   666.40 us/ms
> Summary for 5838.00(ms)
>     All Faults:       1580   270.64 counts/sec
>         Iowait:        619   106.03 counts/sec
>    All latency:    6862215  1175.44 us/ms
>         Iowait:    1077616   184.59 us/ms
> Summary for 5916.00(ms)
>     All Faults:       1195   201.99 counts/sec
>         Iowait:        494    83.50 counts/sec
>    All latency:    4555134   769.97 us/ms
>         Iowait:     902513   152.55 us/ms
> Summary for 6229.00(ms)
>     All Faults:       1395   223.95 counts/sec
>         Iowait:        359    57.63 counts/sec
>    All latency:    6091882   977.99 us/ms
>         Iowait:    1251183   200.86 us/ms
> Summary for 6059.00(ms)
>     All Faults:       1201   198.22 counts/sec
>         Iowait:        299    49.35 counts/sec
>    All latency:    5612143   926.25 us/ms
>         Iowait:    1155555   190.72 us/ms
> Summary for 6005.00(ms)
>     All Faults:        847   141.05 counts/sec
>         Iowait:        320    53.29 counts/sec
>    All latency:    5852541   974.61 us/ms
>         Iowait:     433719    72.23 us/ms
> Summary for 5895.00(ms)
>     All Faults:       1039   176.25 counts/sec
>         Iowait:        288    48.85 counts/sec
>    All latency:    4184680   709.87 us/ms
>         Iowait:     686266   116.41 us/ms
> Summary for 6371.00(ms)
>     All Faults:       1176   184.59 counts/sec
>         Iowait:        269    42.22 counts/sec
>    All latency:    6282918   986.17 us/ms
>         Iowait:    1160952   182.22 us/ms
> Summary for 6113.00(ms)
>     All Faults:       1322   216.26 counts/sec
>         Iowait:        281    45.97 counts/sec
>    All latency:    7208880  1179.27 us/ms
>         Iowait:    1336650   218.66 us/ms
> 
> commit:
> Summary for 7225.00(ms)
>     All Faults:       1384   191.56 counts/sec
>         Iowait:        285    39.45 counts/sec
>    All latency:    6593081   912.54 us/ms
>         Iowait:     934041   129.28 us/ms
> Summary for 6567.00(ms)
>     All Faults:       1378   209.84 counts/sec
>         Iowait:        167    25.43 counts/sec
>    All latency:    3761554   572.80 us/ms
>         Iowait:     220621    33.60 us/ms
> Summary for 6118.00(ms)
>     All Faults:       1304   213.14 counts/sec
>         Iowait:        268    43.81 counts/sec
>    All latency:    3835332   626.89 us/ms
>         Iowait:     413900    67.65 us/ms
> Summary for 6155.00(ms)
>     All Faults:       1177   191.23 counts/sec
>         Iowait:        185    30.06 counts/sec
>    All latency:    4839084   786.20 us/ms
>         Iowait:     660002   107.23 us/ms
> Summary for 6448.00(ms)
>     All Faults:       1283   198.98 counts/sec
>         Iowait:        353    54.75 counts/sec
>    All latency:    4798334   744.16 us/ms
>         Iowait:    1258045   195.11 us/ms
> Summary for 6179.00(ms)
>     All Faults:       1285   207.96 counts/sec
>         Iowait:        137    22.17 counts/sec
>    All latency:    3668456   593.70 us/ms
>         Iowait:     419731    67.93 us/ms
> Summary for 6165.00(ms)
>     All Faults:       1500   243.31 counts/sec
>         Iowait:        182    29.52 counts/sec
>    All latency:    3357435   544.60 us/ms
>         Iowait:     279828    45.39 us/ms
> Summary for 6270.00(ms)
>     All Faults:       1507   240.35 counts/sec
>         Iowait:        361    57.58 counts/sec
>    All latency:    4428320   706.27 us/ms
>         Iowait:     741304   118.23 us/ms
> Summary for 6597.00(ms)
>     All Faults:       1263   191.45 counts/sec
>         Iowait:        238    36.08 counts/sec
>    All latency:    5115168   775.38 us/ms
>         Iowait:     950482   144.08 us/ms
> Summary for 6503.00(ms)
>     All Faults:       1456   223.90 counts/sec
>         Iowait:        402    61.82 counts/sec
>    All latency:    6782757  1043.02 us/ms
>         Iowait:    1483803   228.17 us/ms

That's a lot of data, and I'm sure you did some analysis of this to
conclude that the change makes a positive difference. It would be
prudent to include such analysis, rather than just a raw dump of data.
On top of that, you don't mention what you are testing on - what is sda?

A few comments - regardless of whether or not this change makes
functional sense.

> diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
> index 27f11320b8d1..cd6fcfca7782 100644
> --- a/block/Kconfig.iosched
> +++ b/block/Kconfig.iosched
> @@ -44,4 +44,11 @@ config BFQ_CGROUP_DEBUG
>  	Enable some debugging help. Currently it exports additional stat
>  	files in a cgroup which can be useful for debugging.
>  
> +config ACTIVITY_BASED_IOPRIO
> +	bool "Enable folio activity based ioprio on deadline"
> +	depends on LRU_GEN && MQ_IOSCHED_DEADLINE
> +	default n
> +	help
> +	This item enable the feature of adjust request's priority by
> +	calculating its folio's activity.

Doesn't seem like this should be a config thing. In any case, 'default
n' is the default, so you should kill that line.

> @@ -224,14 +225,42 @@ static void deadline_remove_request(struct request_queue *q,
>  		q->last_merge = NULL;
>  }
>  
> +static enum dd_prio dd_req_ioprio(struct request *rq)
> +{
> +	enum dd_prio prio;
> +	const u8 ioprio_class = dd_rq_ioclass(rq);
> +#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
> +	struct bio *bio;
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
> +	struct page *page;
> +	int gen = 0;
> +	int cnt = 0;
> +
> +	if (req_op(rq) == REQ_OP_READ) {
> +		__rq_for_each_bio(bio, rq) {
> +			bio_for_each_bvec(bv, bio, iter) {
> +				page = bv.bv_page;
> +				gen += PageWorkingset(page) ? 1 : 0;
> +				cnt++;
> +			}
> +		}
> +		prio = (gen >= cnt / 2) ? ioprio_class_to_prio[IOPRIO_CLASS_RT] :
> +			ioprio_class_to_prio[ioprio_class];
> +	} else
> +		prio = ioprio_class_to_prio[ioprio_class];
> +#else
> +	prio = ioprio_class_to_prio[ioprio_class];
> +#endif
> +	return prio;
> +}

This is pretty awful imho, you're iterating the pages which isn't
exactly cheap. There's also a ternary operator (get rid of it), and
magic cnt / 2 which isn't even explained.

This would make much more sense to do when the page is added to the bio,
rather than try and fix up the prio after the fact.

>  static void dd_request_merged(struct request_queue *q, struct request *req,
>  			      enum elv_merge type)
>  {
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(req);
> -	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> +	const enum dd_prio prio = dd_req_ioprio(req);
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];
> -
>  	/*
>  	 * if the merge was a front merge, we need to reposition request
>  	 */
> @@ -248,8 +277,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
>  			       struct request *next)
>  {
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(next);
> -	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> +	const enum dd_prio prio = dd_req_ioprio(next);
>  
>  	lockdep_assert_held(&dd->lock);

What are these changes?

> @@ -745,10 +773,30 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
>  {
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  	const u8 ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> -	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> -	struct dd_per_prio *per_prio = &dd->per_prio[prio];
> +	struct dd_per_prio *per_prio;
>  	sector_t sector = bio_end_sector(bio);
>  	struct request *__rq;
> +#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
> +	enum dd_prio prio;
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
> +	struct page *page;
> +	int gen = 0;
> +	int cnt = 0;
> +
> +	if (bio_op(bio) == REQ_OP_READ) {
> +		bio_for_each_bvec(bv, bio, iter) {
> +			page = bv.bv_page;
> +			gen += PageWorkingset(page) ? 1 : 0;
> +			cnt++;
> +		}
> +	}
> +	prio = (gen >= cnt / 2) ? ioprio_class_to_prio[IOPRIO_CLASS_RT] :
> +			ioprio_class_to_prio[ioprio_class];
> +#else
> +	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> +#endif
> +	per_prio = &dd->per_prio[prio];

And here you duplicate the entire thing from above again?

> @@ -798,10 +846,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	struct request_queue *q = hctx->queue;
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  	const enum dd_data_dir data_dir = rq_data_dir(rq);
> -	u16 ioprio = req_get_ioprio(rq);
> -	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
>  	struct dd_per_prio *per_prio;
> -	enum dd_prio prio;
> +	enum dd_prio prio = dd_req_ioprio(rq);
>  
>  	lockdep_assert_held(&dd->lock);
>  
> @@ -811,7 +857,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	 */
>  	blk_req_zone_write_unlock(rq);
>  
> -	prio = ioprio_class_to_prio[ioprio_class];
>  	per_prio = &dd->per_prio[prio];
>  	if (!rq->elv.priv[0]) {
>  		per_prio->stats.inserted++;
> @@ -920,8 +965,7 @@ static void dd_finish_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(rq);
> -	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> +	const enum dd_prio prio = dd_req_ioprio(rq);
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];

And again these changes?

-- 
Jens Axboe


