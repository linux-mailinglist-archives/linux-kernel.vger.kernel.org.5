Return-Path: <linux-kernel+bounces-84576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B432986A88D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60C71C243A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662FB22F13;
	Wed, 28 Feb 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMsio4B4"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FB22EF0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102961; cv=none; b=JKl8xAIaUrG5q+pg3HFlqANvoWP+uhOBLTKgfKbX3P/rqxViQyopl6ExxJZVho9CTLagH2tNSUaHYZ6ur8356nNDA4E2+XAfmqfTnxeKgzx1CjHx6uvsjT97D9eAfHVg/vgNmByl03Vabe7KCNYf8XWPck42pifE4sbxQ3h7xbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102961; c=relaxed/simple;
	bh=/7ifBW+dVDQN5fSOaW3OantJn+4kOQoQ7Eo9Q5Mj0po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUUxhkKoAxBFoXt3mDN5F849kg9IJFxnRCx1mPvaXKwpuqzvbK56jvbSTSAeqttlu68iJq3W3eBVb5TjizJ775W1HE/KkIsUeSxSCq2eZUWPNO6UZQZEpc+eJj2Kj+qeGD6kDLOyJGKWbMhXMntAHXJK4zLteOr0NVv1+FRCcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMsio4B4; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3ad60ec-6968-4ebb-a561-0ffc5774c30c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709102957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S3YME2pgLHPYQU3lBfvV94TvsKe/nmiEavd1qVEYLk=;
	b=CMsio4B4CD/lJBJgZVox0kRhNO08fsp634BgnlQYADsLOBK70SxK874YnDqebGx3mVqGxd
	tYTRXTfBnUaUmG2G3iCbM4okoyM3/d0uIxyFPTdpHVWpe+5fngTF0nIOp8l2UU5WfllGgi
	y8KESOTMZgiUD225b3xoD8vMA+ZAF8A=
Date: Wed, 28 Feb 2024 14:49:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: yosryahmed@google.com, hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
 <20240228061400.GL11972@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240228061400.GL11972@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 14:14, Sergey Senozhatsky wrote:
> On (24/02/27 03:02), Chengming Zhou wrote:
>> @@ -834,13 +841,12 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>>  		VM_BUG_ON_PAGE(!PageLocked(page), page);
>>  		next = get_next_page(page);
>>  		reset_page(page);
> 
> reset_page()->__ClearPageMovable()->PageMovable() expects page to be
> locked.

This seems to make the patch doesn't work anymore... will think about it.

Thanks!

> 
>> -		unlock_page(page);
>>  		dec_zone_page_state(page, NR_ZSPAGES);
>>  		put_page(page);
>>  		page = next;
>>  	} while (page != NULL);

