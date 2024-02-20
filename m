Return-Path: <linux-kernel+bounces-73200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAD485BF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CC51F260D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FC973169;
	Tue, 20 Feb 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="df36qAYb"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B06D1D8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440889; cv=none; b=EToB0m81KJYQcO1ZLKCUE6MK8pDz6bnVhpgNMiAUUZoHelKM1r94avaJImycJqbwF1hcux3mVyhZXlsqDt2ULqvjp0Ze28Rimgai0dqTiEXdAGygiOOzqfRfZ5UrP/a9BkM0owXrkO8SM3iWhkwrogLKdbwIc7o6qCvFtnqbBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440889; c=relaxed/simple;
	bh=t7WKFuVoBIh4h/QQSUN5wp4k+pcVzp6X/vrHWjJLCHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJHFPdkbT1p1dtnqWUkq1Dnsv2tcNPVcj0RXVd6pcqAt38GswmdhHZRV5I621TPcZ6VyU6qZFEXpJlZ6l1Dh8WaHX0rRHn6ygQ9+UMxphERkwdy0KC59Ieahb/UA0co6iCuViYEg8eFYAusbImBk4V+NxJMJDJTsH84lAiDuAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=df36qAYb; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da3eefaf-a73a-4d7b-8bee-5a6c874cd071@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708440885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSnDrKTQ+lfaKVQJ2Gr6xzNYDhojGRC4cM6fjj3eBR4=;
	b=df36qAYb/KdV/gQLR8wDkHZ9EIiAfHKyK8etyz2Rvi7VY6Egf8shF00/YZMoHOGqoCA1ju
	AtFb+FlZIDcuEY+AcwQiyLSw6yYeGpD19fjOdcvNiKcwjK8uiPrVwwra++WWZlsbrVqQxw
	LUD9LHDGrXj0AMDxhEB/3ph508oJUdY=
Date: Tue, 20 Feb 2024 22:54:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] net/mlx5: pre-initialize sprintf buffers
To: Yevgeny Kliteynik <kliteyn@nvidia.com>, Arnd Bergmann <arnd@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alex Vesker <valex@nvidia.com>,
 Erez Shitrit <erezsh@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240219100506.648089-1-arnd@kernel.org>
 <bbef7014-5059-405d-a27a-a379431a3fcf@linux.dev>
 <2abe3279-ccba-4e1d-a04c-fd724e1660b6@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <2abe3279-ccba-4e1d-a04c-fd724e1660b6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/2/20 14:57, Yevgeny Kliteynik 写道:
> On 20-Feb-24 07:50, Zhu Yanjun wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 在 2024/2/19 18:04, Arnd Bergmann 写道:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The debugfs files always in this driver all use an extra round-trip
>>> through an snprintf() before getting put into a mlx5dr_dbg_dump_buff()
>>> rather than the normal seq_printf().
>>>
>>> Zhu Yanjun noticed that the buffers are not initialized before being
>>> filled or reused and requested them to always be zeroed as a
>>> preparation for having more reused between the buffers.
>>
>> I think that you are the first to find this.
> 
> The buffers are not initialized intentionally.
> The content is overwritten from the buffer's beginning.
> Initializing is not needed as it will only cause perf degradation.

If the mentioned functions are not in the critical path, this 
initialization will not make too much difference on the performance.

But if this function knows how many bytes are written and read, it is 
not necessary to initialize the buffer. Or else we should initialize the 
buffer before it is used again.

Zhu Yanjun

> 
> -- YK
> 
> 


