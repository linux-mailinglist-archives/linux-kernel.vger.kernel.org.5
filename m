Return-Path: <linux-kernel+bounces-109617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB807881B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD1D1C21574
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6CB645;
	Thu, 21 Mar 2024 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dN2NPO+j"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955559468
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710990750; cv=none; b=l0ffkMAS1dHOaV9MWNpkzPTWctvrC8QXZZkry+NonX7JSgCcSjzAxA2+sdCn0GUfeW6lLAi9S8kgIa9xJPB8YFOOTV8RzNb8/+CaVAZQ4F1xgym9CxW5q9eXM00oRgEexjeja7I959poF7Tp9OkhywQ3ttGRC10iyistabeOZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710990750; c=relaxed/simple;
	bh=u8eei/XaFU11jj/r3wr8/HgwJCHdhFvIb3bpo9INGr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiZDsyLasbDtjCtlrfnt9zeN+NQmCH6WPpq9hL5kdT2yfnPOiJEWDz/hed0iIYskXJ87KxBBNhyIXThWXqSj8v2uNwF9VCu9qlOpkQMvpCL60MKK7avAEePLImGsCHDs8VekU14/oLKXRiCmRevN40MicRzPUi7IT5aqt9Jturw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dN2NPO+j; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <62b4dd34-bf05-4da6-94ea-cb85ac48bbeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710990746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkNEqpC4qw9eN2pRZI4l4aAjsLspOt5MnQaAsK4vE2s=;
	b=dN2NPO+jnsoAfDnhNxR7Gfb8ObZXwpQU4qwsX4kVFYl/aTei8h6hfwAdvL1ptAM7a7/kqm
	UdppMg5so3r8sPH5/RaWjxQR7nMSqESQ93T/wy2JBPQ8eCpXArpUTED5yz+6TkGmvD69iG
	kguv3oPptq5ghx9zCI1OoyX0sErgPws=
Date: Thu, 21 Mar 2024 11:12:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: mark racy accesses on slab->slabs
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
 iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 vbabka@suse.cz
References: <8bc1aebf-8395-416f-8c23-53cbd25d0eef@linux.dev>
 <tencent_BF745A1543ABB0579DFC20480AA1A4456307@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <tencent_BF745A1543ABB0579DFC20480AA1A4456307@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/21 10:48, linke li wrote:
> Sorry for a late reply, I just found this because of my bad email client.
> 
>> There is another unmarked access of "slab->slabs" in the show_slab_objects(),
>> which you can change too.
> 
> Yes, I think show_slab_objects() has a similar situation. Should I
> consider to submit a V2 patch for this?

Yes, I think so.

> 
>> I'm not sure that it's really safe to access "slab->slabs" here without any protection?
>> Although it should be no problem in practice, alternative choice maybe putting partial
>> slabs count in the kmem_cache_cpu struct.
> 
> I think it is ok, because it seems that slab->slabs in slub_percpu_partial
> and show_slab_objects() are just used for showing some infomation.
> 
> I noticed Paul summarized some of these strategies in access-marking.txt[1]

Ok, thanks.

> 
> Quote from it:
> 
> "Use of the data_race() Macro
> ----------------------------
> 
> Here are some situations where data_race() should be used instead of
> READ_ONCE() and WRITE_ONCE():
> 
> 1.	Data-racy loads from shared variables whose values are used only
> 	for diagnostic purposes.
> 
> 2.	Data-racy reads whose values are checked against marked reload.
> 
> 3.	Reads whose values feed into error-tolerant heuristics.
> 
> 4.	Writes setting values that feed into error-tolerant heuristics.
> "
> 
> Thanks,
> Linke
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> 

