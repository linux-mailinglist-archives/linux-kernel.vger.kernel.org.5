Return-Path: <linux-kernel+bounces-85274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC786B34D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE9E1F2486C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391EC15CD5C;
	Wed, 28 Feb 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dRf76Gze"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2D1487DC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134697; cv=none; b=WYPZrX0LMiQaPavehQX5RCF7NUAb3r6w/NYDJmdqKFPQb5qA8UId523Xikqy/bU074XO7HlZ3T+0c2XTNDKgMwJNPlgrOTdReDmExUgD60HdKIwOm8JeGqoeaJijkv3/1vbyhwkj/+8LlT4mPHmSFZnYAocWL/90LC09q3uBY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134697; c=relaxed/simple;
	bh=NbS4ybyMq5F+EbD4iOULthp4VmxMo+5F4uVrDuOU59s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5YB4COuTMsRg5RGdZpXWQRt/x3kgOmyeyWn9LBHPqLe+zNL1RTynIhij88PvBiKIDbt5Dqs+iin5295rE/QlshrciTGvWmBh58a7TOuaXpTHGAsCqd3HFBjUYV1XwZbEbcF5qCb/SFtj/DwjcqLy9YPL3xdJnospKrmMvX9jI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dRf76Gze; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1d920f2c-2f86-46b9-b5d9-b5615284e5c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709134692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAMr9s0PDAu7F214uDGmplVN6l5UXk4Dj4yqN4bYWl8=;
	b=dRf76GzeokEhPZ1ik9l9Sy4CMEvb8socWoqzXfb4JNB/MOwXUk9MD6NNgtm0DybRYSCukn
	J0+8Uacsdj14kAdx2yBFH/2ipO36LZt1i4rvlDGaUCRfs1t7xzLPp6WwtFKMF/O0huYkl4
	VLvYG4kmbkAbUCoImGTL7500ghvShZk=
Date: Wed, 28 Feb 2024 23:37:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable hotfix] mm/zswap: fix zswap_pools_lock usages
 after changing to percpu_ref
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
 nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v3-2-200495333595@bytedance.com>
 <20240228151832.2431993-1-chengming.zhou@linux.dev>
 <Zd9QFkE2nr5FyYDq@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <Zd9QFkE2nr5FyYDq@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 23:24, Matthew Wilcox wrote:
> On Wed, Feb 28, 2024 at 03:18:32PM +0000, Chengming Zhou wrote:
>> Now the release of zswap pool is controlled by percpu_ref, its release
>> callback (__zswap_pool_empty()) will be called when percpu_ref hit 0.
>> But this release callback may potentially be called from RCU callback
>> context by percpu_ref_kill(), which maybe in the interrupt context.
>>
>> So we need to use spin_lock_irqsave() and spin_unlock_irqrestore()
>> in the release callback: __zswap_pool_empty(). In other task context
>> places, spin_lock_irq() and spin_unlock_irq() are enough to avoid
>> potential deadlock.
> 
> RCU callback context is BH, not IRQ, so it's enough to use
> spin_lock_bh(), no?

You're right, it's the softirq context, so spin_lock_bh() is enough.

Thanks!

