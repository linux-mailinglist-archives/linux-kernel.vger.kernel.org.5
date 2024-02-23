Return-Path: <linux-kernel+bounces-77721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E2860973
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347822862DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5829FBFC;
	Fri, 23 Feb 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ce5CfSyh"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34002B67F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659427; cv=none; b=YVcTzD+WsBw49V8x1cVOoGN8i159UeTRjTOrk7pVcOqcg8HIiDhW/IRD/kNcYuF696/GYowYJWfhdjexj/HUxwEd2U7W/uVOYMdpbiJ057ymgpuU9dNk4URqtfsjYlSGA+JRqCJiwYrCqY3uQsK/hYLl9gpHDeG8vXUe1Q07yrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659427; c=relaxed/simple;
	bh=par//A5Ss9eyZPtfnfdWP27cp3Cu9oFaavFcdrt6Ffo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXPPSZMwu5qOZ4+LjooZPb+lYVPZEG6a/042c/9SwPDNkqLQ31m3/Q75mB5Ih7pleMwxKJ5p1BAnNTjVEU2It5EsEEY0HOayabx/6J5nIDsvhUIya9ukijmvLgQ2LyRHvBXXH6XWp3AusCT+JCwM+tjo5xU/V5yo10wUnT4t2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ce5CfSyh; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708659420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL5JDmsyHyQirdU0lRKG6MlAN0ZaRI5cpkmSUjlEF9M=;
	b=ce5CfSyh0SuptVAvN/p/KYapS0NjlEJIZQuvwyUi33/REvbxv9IvkFjf26cFvC9uMD4FtP
	X3kiweqSqGZmYzeOXNdDDCznzB8TTo36TpgCXQqgqaKDy3dys1b3ljzkWsEleBIH1PB1rX
	koWEP+tu1VBfCBrrYq4+lGoWWembyoY=
Date: Fri, 23 Feb 2024 11:36:25 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/23 11:02, Christoph Lameter (Ampere) wrote:
> On Thu, 22 Feb 2024, Chengming Zhou wrote:
> 
>> Anyway, I put the code below for discussion...
> 
> Can we guestimate the free objects based on the number of partial slabs. That number is available.
> 

Yeah, the number of partial slabs is easy to know, but I can't think of a way to
estimate the free objects, since __slab_free() is just double cmpxchg in most cases.

> How accurate need the accounting be? We also have fuzzy accounting in the VM counters.

Maybe not need to be very accurate, some delay/fuzzy should be acceptable.

Another direction I think is that we don't distinguish slabs on cpu partial list or
slabs on node partial list anymore (different with current behavior).

Now we have three scopes:
1. SL_ALL: include all slabs
2. SL_PARTIAL: only include partial slabs on node
3. SL_CPU: only include partail slabs on cpu and the using cpu slab

If we change SL_PARTIAL to mean all partial slabs, it maybe simpler.

Thanks.

