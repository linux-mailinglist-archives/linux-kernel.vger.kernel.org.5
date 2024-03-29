Return-Path: <linux-kernel+bounces-125273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25880892328
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E5B1F232DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D31137900;
	Fri, 29 Mar 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Wp77cbUF"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A943130E3B;
	Fri, 29 Mar 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735746; cv=none; b=GLe95pJa3tPk5a/lYB+9695TTAWl/tpl6AQuznxl+4FjldsrzlsLGrVGEl4MNTJdN1f116ZKJYH7RlI6qHhzfBL7YEwxH1tnau6X5DJnrD01CEIl2GY7ohTjr3jxrIs2d5Kfp7LTOZate+b4yqiwpwPWJi2oajwp0x8uf7ocs/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735746; c=relaxed/simple;
	bh=0KpYsLlOtxOalPJ88rmppN2txUpmTSaw7D+ZNPM0U+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQh/I31r0wVC/c5YBG4UMvUqLfG2kEn9auU/l3iBSRxYlBUxJ9qPUo+UKLRL3WgPaZgue0ds0cp1id5AOuNyVd88EkGCZqYXP701gTabo0LsXwtHo0ysZysXBsYCfu+Tf6DDAeSVyG4CQnIcD+BzIVtlKpY+BUWFyg+VSOPe2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Wp77cbUF; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5pLy5394z6Cnk8t;
	Fri, 29 Mar 2024 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711735735; x=1714327736; bh=ztIfknU9pw7hvz5EnpxuDR6L
	cD1rd+rn/sOLgvSIGvY=; b=Wp77cbUFN0/Rv6vygzvN2iAyp3np/H7tt6Spuup7
	YUjab9jECNyvZcbgT24g4Pwi1JMD0+bJG0NqV2DNt+RARUD/cwEFpM9kdwyhmPbO
	mr6a0zcDnYZDDdS7cjj2wbPu/YeGQP45VXKkxo8IadGFwsdZ0WOm5PP2HFuRg8oo
	GTHtGNtlwSGgONnvTYPf7dJyYhFJIP8qjlYYKFWsqPGk/ntAbaQUkqkDJVn627Vw
	5yr8ifBzHrRj+HEmcknbWf+Grne12jwsPMs+0WSCBX8h5azpQByMB/lQQ/zJnsXN
	vd9iGbt4TGXr+kLreva2T1lwdPK4dkYKDOFZLZp99dg0CQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qMEjARNbCWpr; Fri, 29 Mar 2024 18:08:55 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5pLs0tllz6Cnk8m;
	Fri, 29 Mar 2024 18:08:52 +0000 (UTC)
Message-ID: <890bd06d-2a94-4138-9854-4a7ed74e0e51@acm.org>
Date: Fri, 29 Mar 2024 11:08:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com,
 Damien Le Moal <dlemoal@kernel.org>
References: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 7:44 PM, Zhiguo Niu wrote:
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 02a916b..89c516e 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -646,10 +646,12 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
>   	struct request_queue *q = hctx->queue;
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	struct blk_mq_tags *tags = hctx->sched_tags;
> +	unsigned int shift = tags->bitmap_tags.sb.shift;
> +	unsigned int dd_min_depth = max(1U, 3 * (1U << shift)  / 4);
>   
>   	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
>   
> -	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
> +	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd_min_depth);
>   }

The above patch sets min_shallow_depth to the same value as commit
d47f9717e5cf ("block/mq-deadline: use correct way to throttling write
requests"). That commit got reverted because it was causing performance
problems. So the above patch reintroduces the performance problem that
has been fixed by commit 256aab46e316 ("Revert "block/mq-deadline: use
correct way to throttling write requests"").

Thank you for attempting to reintroduce a problem that just got fixed
without even mentioning that this is an attempt to reintroduce a
performance problem.

Bart.



