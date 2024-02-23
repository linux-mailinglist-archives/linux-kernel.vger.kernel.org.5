Return-Path: <linux-kernel+bounces-77777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3D6860A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0DA1F23787
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B7211738;
	Fri, 23 Feb 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mHqP772C"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4BD11706
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708664451; cv=none; b=s2q3sQwDJqwvgLf6ESI74w4VzuCayhzr5c0kMW/ura/oRZZo6A/pFwdFyF4WDNmB6H9aksYalhQrg+aqUVOaMa8eehQ3kdki7fNPZzLd+7+NE1X3NAtaL1bN3KPkTehsLrKPWB27Dr870G2ItVkUl8uO83IT0H2ANPFmWSUSp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708664451; c=relaxed/simple;
	bh=Que1evLbnFfHRKzVpQkiqW6XLuqZSBE2U004J7wfB1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlIgm2VOqzD8OInluDdP0GraWbot6Mu8I82o8OHg4/QkkuvS2/EAIZ9ECFnY68JI7kNwhICbZYUXnBkRy7X+U874PNMq42Nm+Xbyw499sWXclmx3ryPKzBUx3Ekf66fWxZYDSQTw/BLu4e5Ac5h6Bpc3IdwhvDpdeWrUBmUX0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mHqP772C; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708664446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44xWYjkvEitvr2LpqKYpVHLl/pWnfYZs1Xfy0OuFJbw=;
	b=mHqP772ChKDinSnQ925Tx/lQvvV6L4V4Qy8/FIogSIb1hkSpr01P6b5cfW5cz+tA26Hr/q
	sy5sDLAP7wNNgiZi/Fe386kHg36Tw22uAd006IjT6voIAtvlecUhl7xYLDtviEgqlJmA+7
	QhEucaJDD+nkDy3EExHa4388hqCHfNs=
Date: Fri, 23 Feb 2024 13:00:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
 <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
 <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/23 11:50, Christoph Lameter (Ampere) wrote:
> On Fri, 23 Feb 2024, Chengming Zhou wrote:
> 
>>> Can we guestimate the free objects based on the number of partial slabs. That number is available.
>>
>> Yeah, the number of partial slabs is easy to know, but I can't think of a way to
>> estimate the free objects, since __slab_free() is just double cmpxchg in most cases.
> 
> Well a starting point may be half the objects possible in a slab page?

Yeah, also a choice.

> 
> 
>>> How accurate need the accounting be? We also have fuzzy accounting in the VM counters.
>>
>> Maybe not need to be very accurate, some delay/fuzzy should be acceptable.
>>
>> Another direction I think is that we don't distinguish slabs on cpu partial list or
>> slabs on node partial list anymore (different with current behavior).
>>
>> Now we have three scopes:
>> 1. SL_ALL: include all slabs
>> 2. SL_PARTIAL: only include partial slabs on node
>> 3. SL_CPU: only include partail slabs on cpu and the using cpu slab
>>
>> If we change SL_PARTIAL to mean all partial slabs, it maybe simpler.
> 
> Thats not going to work since you would have to scan multiple lists instead of a single list.

We have to use percpu counters if we go this way.

> 
> Another approach may be to come up with some way to scan the partial lists without taking locks. That actually would improve the performance of the allocator. It may work with a single linked lists and RCU.
> 

I think this is a better direction! We can use RCU list if slab can be freed by RCU.


