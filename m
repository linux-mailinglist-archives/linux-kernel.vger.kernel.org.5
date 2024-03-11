Return-Path: <linux-kernel+bounces-98466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB59877A84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394531F21C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA00E8827;
	Mon, 11 Mar 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1hNUhEk"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B079C2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710133927; cv=none; b=dqcO1lLmgu/z+79jIqedompJ2bsWMJhs3f57yjOb45Dbk9rdYDoQwTJB29KT2coaTG+YeqzTfil5bsZN4NW4wL+2WiupRdwe0vkFZJHzsYHxMd7rtTIve9CLnnt1iYTUpa4rYUMrC1KyPgtZcKrnpbaN1DMEs6MwdpNzYIBMTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710133927; c=relaxed/simple;
	bh=NytgupDwFvRzUjIAqpINUKzOWjpIAOh67PoPb8mOSyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jok9vg8cj34EzPlGwyDX6+a71U4M4D2GcEjuf3G90UZGufLRApp63JIU3+dlOEkKRVszMkYzKXe2cKSK9M03SdxQPG6KpFN08rPNzaUaKnRry+vb6kku83MairMQYXv4+rn3zhVnsEzIFBNoMdWMAGUUzSWWP7LKlz3QYLItI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1hNUhEk; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0c7d1d79-2372-4bae-ba9b-e7b6070af14c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710133921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/B6d+GFP5GHkSgOlSDC80Gd/aLW5H4DEqHwRQcwm970=;
	b=f1hNUhEkqDnkLr6ETTnU+nPsndIOcnXyMheyLd2g9RfrfNEGbFeDMvlk7boqNBodrG4EJi
	egLsIhMf3RMF8qIhUFOYIgtKKjj9hlOawFlk+AK7YHwwKWq6UXtLsE+IwIh60GOvCz9w//
	cM/ZiVlMJacJPcU89Kd8OC5Cq3X6gDk=
Date: Mon, 11 Mar 2024 06:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
To: linke li <lilinke99@qq.com>, leon@kernel.org
Cc: bmt@zurich.ibm.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20240310191910.GG12921@unreal>
 <tencent_03614198A34E56D038455012AA31022D9C06@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_03614198A34E56D038455012AA31022D9C06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/11 3:34, linke li 写道:
>> If value can change between subsequent reads, then you need to use locks
>> to make sure that it doesn't happen. Using READ_ONCE() doesn't solve the
>> concurrency issue, but makes sure that compiler doesn't reorder reads
>> and writes.
> 
> This code do not need to prevent other thread from writing on the flags.
> 
> This topic got quite a bit of discussion [1], quote from it:
> 
>      (READ_ONCE and WRITE_ONCE)
>      That's often useful - lots of code doesn't really care if you get the
>      old or the new value, but the code *does* care that it gets *one*
>      value, and not some random mix of "I tested one value for validity,
>      then it got reloaded due to register pressure, and I actually used
>      another value".
> 
>      And not some "I read one value, and it was a mix of two other values".
>   
>  From the original code, the first read seems to do the same things. So
> READ_ONCE is probably ok here.
> 
> I just want to make sure the flags stored to wqe->sqe.flags is consistent
> with the read used in the if condition.

Sure. Follow Leon's advice, to make this ("wqe->sqe.flags is consistent 
with the read used in the if condition") happen, you need a lock to 
ensure it. The lock can be spin lock or mutex lock depens on its 
sleeping or not.

 From the original source code, wqe->sqe.flags should be a volatile 
variable. It should be read from the original source, not from cache.

Zhu Yanjun

> 
> [1]https://lore.kernel.org/lkml/CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com/
> 


