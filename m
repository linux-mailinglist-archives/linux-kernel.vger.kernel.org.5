Return-Path: <linux-kernel+bounces-156553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54D8B0474
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C11B238A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15C158877;
	Wed, 24 Apr 2024 08:37:14 +0000 (UTC)
Received: from mail-m17233.xmail.ntesmail.com (mail-m17233.xmail.ntesmail.com [45.195.17.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42998156873;
	Wed, 24 Apr 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947833; cv=none; b=PzSRYdj3wP2e7G3TvzDuPH2zfFxUilLf6w+9MZHESr7wIbBepuUjh7xiQuMoNfor9x3zWE+d/p3/lw8m6oeskYu6ygD+lbGs+kwmXVNT5d9I13Wmt5ilBWtudoqi5yM652zu/SNP10U7wH0CNvaNvxYUz06Wqq5RTnfiQs1Q4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947833; c=relaxed/simple;
	bh=EeqnpYJ0MMalAJhDr+e/tjgslFlLPwIFQcqgq2tThYQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ne1x43JYK8U/qor37GORfh03ltQAFTgTdLJvf1bs1sHGmlwjTiUIyNp75TYNeq7j9Tq/QAubpa14JwTxMm7yV9ENQ0Py2V1HDSgp7mULDKb7iUjRdHKXyQQ7QlpD7HaONKJ5BnmCdmpqdfWNAMjXaGa1ULbPtkwI5b2WclGKAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id D2242860237;
	Wed, 24 Apr 2024 16:36:37 +0800 (CST)
Subject: Re: [PATCH 1/7] block: Init for CBD(CXL Block Device)
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-2-dongsheng.yang@easystack.cn>
 <c345a609-8114-4dc7-a223-186728cac41f@nvidia.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <691cfcb7-eced-b675-8353-7a53dc3c3698@easystack.cn>
Date: Wed, 24 Apr 2024 16:36:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c345a609-8114-4dc7-a223-186728cac41f@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBpDVk5JT0NCQktISBpNGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f0f3fea98023ckunmd2242860237
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6Eio4ETczDRAKLlEUKEMq
	DU9PCQFVSlVKTEpIQk9MTEJDTUtKVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBQktMQjcG



在 2024/4/24 星期三 上午 11:58, Chaitanya Kulkarni 写道:
>> +/*
>> + * As shared memory is supported in CXL3.0 spec, we can transfer data via CXL shared memory.
>> + * CBD means CXL block device, it use CXL shared memory to transport command and data to
>> + * access block device in different host, as shown below:
>> + *
>> + *    ┌───────────────────────────────┐                               ┌────────────────────────────────────┐
>> + *    │          node-1               │                               │              node-2                │
>> + *    ├───────────────────────────────┤                               ├────────────────────────────────────┤
>> + *    │                               │                               │                                    │
>> + *    │                       ┌───────┤                               ├─────────┐                          │
>> + *    │                       │ cbd0  │                               │ backend0├──────────────────┐       │
>> + *    │                       ├───────┤                               ├─────────┤                  │       │
>> + *    │                       │ pmem0 │                               │ pmem0   │                  ▼       │
>> + *    │               ┌───────┴───────┤                               ├─────────┴────┐     ┌───────────────┤
>> + *    │               │    cxl driver │                               │ cxl driver   │     │  /dev/sda     │
>> + *    └───────────────┴────────┬──────┘                               └─────┬────────┴─────┴───────────────┘
>> + *                             │                                            │
>> + *                             │                                            │
>> + *                             │        CXL                         CXL     │
>> + *                             └────────────────┐               ┌───────────┘
>> + *                                              │               │
>> + *                                              │               │
>> + *                                              │               │
>> + *                                          ┌───┴───────────────┴─────┐
>> + *                                          │   shared memory device  │
>> + *                                          └─────────────────────────┘
>> + *
>> + * any read/write to cbd0 on node-1 will be transferred to node-2 /dev/sda. It works similar with
>> + * nbd (network block device), but it transfer data via CXL shared memory rather than network.
>> + */
>> +
>> +/* printk */
> 
> I don't think you need above comment ..

Agreed
> 
>> +#define cbd_err(fmt, ...)							\
>> +	pr_err("cbd: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__)
> 
> you can use #define pr_fmt and remove cmd: prefixes in each pr_xxx above ?

pr_fmt was one of my choice, however, it cannot fulfill all my 
requirements, such as adding other prefixes like "transport%u," etc. So, 
in the end, I didn't use pr_fmt, also to maintain consistency with other 
macros.
> 
>> +#define cbd_info(fmt, ...)							\
>> +	pr_info("cbd: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__)
>> +#define cbd_debug(fmt, ...)							\
>> +	pr_debug("cbd: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__)
>> +
>> +#define cbdt_err(transport, fmt, ...)						\
>> +	cbd_err("cbd_transport%u: " fmt,					\
>> +		 transport->id, ##__VA_ARGS__)
>> +#define cbdt_info(transport, fmt, ...)						\
>> +	cbd_info("cbd_transport%u: " fmt,					\
>> +		 transport->id, ##__VA_ARGS__)
>> +#define cbdt_debug(transport, fmt, ...)						\
>> +	cbd_debug("cbd_transport%u: " fmt,					\
>> +		 transport->id, ##__VA_ARGS__)
>> +
>> +#define cbd_backend_err(backend, fmt, ...)					\
>> +	cbdt_err(backend->cbdt, "backend%d: " fmt,				\
>> +		 backend->backend_id, ##__VA_ARGS__)
>> +#define cbd_backend_info(backend, fmt, ...)					\
>> +	cbdt_info(backend->cbdt, "backend%d: " fmt,				\
>> +		 backend->backend_id, ##__VA_ARGS__)
>> +#define cbd_backend_debug(backend, fmt, ...)					\
>> +	cbdt_debug(backend->cbdt, "backend%d: " fmt,				\
>> +		 backend->backend_id, ##__VA_ARGS__)
>> +
>> +#define cbd_handler_err(handler, fmt, ...)					\
>> +	cbd_backend_err(handler->cbdb, "handler%d: " fmt,			\
>> +		 handler->channel.channel_id, ##__VA_ARGS__)
>> +#define cbd_handler_info(handler, fmt, ...)					\
>> +	cbd_backend_info(handler->cbdb, "handler%d: " fmt,			\
>> +		 handler->channel.channel_id, ##__VA_ARGS__)
>> +#define cbd_handler_debug(handler, fmt, ...)					\
>> +	cbd_backend_debug(handler->cbdb, "handler%d: " fmt,			\
>> +		 handler->channel.channel_id, ##__VA_ARGS__)
>> +
>> +#define cbd_blk_err(dev, fmt, ...)						\
>> +	cbdt_err(dev->cbdt, "cbd%d: " fmt,					\
>> +		 dev->mapped_id, ##__VA_ARGS__)
>> +#define cbd_blk_info(dev, fmt, ...)						\
>> +	cbdt_info(dev->cbdt, "cbd%d: " fmt,					\
>> +		 dev->mapped_id, ##__VA_ARGS__)
>> +#define cbd_blk_debug(dev, fmt, ...)						\
>> +	cbdt_debug(dev->cbdt, "cbd%d: " fmt,					\
>> +		 dev->mapped_id, ##__VA_ARGS__)
>> +
>> +#define cbd_queue_err(queue, fmt, ...)						\
>> +	cbd_blk_err(queue->cbd_blkdev, "queue-%d: " fmt,			\
>> +		     queue->index, ##__VA_ARGS__)
>> +#define cbd_queue_info(queue, fmt, ...)						\
>> +	cbd_blk_info(queue->cbd_blkdev, "queue-%d: " fmt,			\
>> +		     queue->index, ##__VA_ARGS__)
>> +#define cbd_queue_debug(queue, fmt, ...)					\
>> +	cbd_blk_debug(queue->cbd_blkdev, "queue-%d: " fmt,			\
>> +		     queue->index, ##__VA_ARGS__)
>> +
>> +#define cbd_channel_err(channel, fmt, ...)					\
>> +	cbdt_err(channel->cbdt, "channel%d: " fmt,				\
>> +		 channel->channel_id, ##__VA_ARGS__)
>> +#define cbd_channel_info(channel, fmt, ...)					\
>> +	cbdt_info(channel->cbdt, "channel%d: " fmt,				\
>> +		 channel->channel_id, ##__VA_ARGS__)
>> +#define cbd_channel_debug(channel, fmt, ...)					\
>> +	cbdt_debug(channel->cbdt, "channel%d: " fmt,				\
>> +		 channel->channel_id, ##__VA_ARGS__)
>> +
> 
> [...]
> 
>> +
>> +struct cbd_se {
>> +	struct cbd_se_hdr	header;
>> +	u64			priv_data;	// pointer to cbd_request
> 
> use /**/ instead //

agreed

Thanx
> 
> 
> -ck
> 
> 

