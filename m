Return-Path: <linux-kernel+bounces-72397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A749E85B2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9ACF1C221E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA859B4A;
	Tue, 20 Feb 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q5ZCbZUq"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E55917D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409830; cv=none; b=ElbLmat298ZqX+Whfp5wn+YYtXH8iXpGZUlf1sBEpP2G7/DJ3gu3XnYPvSetOApksC8zGnTTMh7zZ3rAPpV6CnbzXQKs9HEmTiPhaWNk8H2J0lwtDZpyG04qfxtTvB1i2JdwqY+iSAN2438l4ZlfrFGzenI9K7j2+or52XWEdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409830; c=relaxed/simple;
	bh=+KqDInz6N2xa6+YZcODnAKD7O944LMB3cVT0ap7koMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PC6uABD5S68F5GKjFq7yg5CoieeXT0sA0HuXV89VcxGl+JZ9OZ8w/2xDg4tDaXFHrE/ed6kdavS29/LCJbNPyc+7Ldpk5cYGLHkXz7BSsNI2Ftj5bz2Run+xnBtvCyBqjUWIO4lGLonl3CpT4pju/t+16uCyJCSTyPu7ofP+NDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q5ZCbZUq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00ae16dd-1558-4e45-b2c6-31f3f421d178@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708409826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2NOfwy5+3jnI+yyple/uQY8Xx4+Zcc8NYDIAHbSvxg=;
	b=Q5ZCbZUqAhr6C7JZGNFM4FcQXIDhBb4CjIgPbmr3ouRUEnixdUj/i/EgTZelolC6fkclvP
	owSSKT57Y46NpUWhxDbFLfKRgqiIQoKZppNaKTX88kKGplk38DabHVsR6g0nhCiI48IwhV
	Hj4nrZ9hhF1UrnnoUIDEYQV/QT/Yes8=
Date: Tue, 20 Feb 2024 14:17:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/2] hugetlb: two small improvements of hugetlb init
 parallelization
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240213111347.3189206-1-gang.li@linux.dev>
 <66232486-12a9-4097-baad-fa20655194b1@linux.dev>
 <20240219175248.bc70d8bddd28fced647eceb7@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <20240219175248.bc70d8bddd28fced647eceb7@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/20 09:52, Andrew Morton wrote:
> On Mon, 19 Feb 2024 11:03:29 +0800 Gang Li <gang.li@linux.dev> wrote:
> 
>> On 2024/2/13 19:13, Gang Li wrote:
>>> This series includes two improvements: fixing the PADATA Kconfig warning
>>> and a potential bug in gather_bootmem_prealloc_parallel. Please refer to
>>> the specific commit message for details.
>>>
>>> For Andrew:
>>> If you want me to include these two fixes into the previous series[1], I
>>> would be happy to send v6. Otherwise, you can directly apply these two
>>> patches.
>>>
>>> [1]. https://lore.kernel.org/lkml/20240126152411.1238072-1-gang.li@linux.dev/
>>
>> Hi Andrew,
>> A gentle ping here :).
>>
>> Do you want to apply these two patches, or would you like me to
>> include them into the original patch and send out v6?
> 
> The patchset is now rather a mess and I'm not confidently identifying
> which issues remain open and which are addressed.
> 
> So yes, a full redo and resend would be preferred, please.
> 
> Links which I collected are:
> 
> https://lkml.kernel.org/r/202402020454.6EPkP1hi-lkp@intel.com
> https://lkml.kernel.org/r/20240204072525.1986626-1-gang.li@linux.dev
> https://lkml.kernel.org/r/6A148F29-68B2-4365-872C-E6AB599C55F6@linux.dev
> https://lkml.kernel.org/r/j7xb7m5cy374ngbdm23rvryq6vy6jxtewtu3abjeidhho4bly7@t3aawaeybxlk

In summary, there is two issues based on v5[1] and all are fixed by my
patch.

Scattered discussions led to some confusion, I'll make it clear in the
next version.

Thanks.

[1]. 
https://lore.kernel.org/lkml/20240126152411.1238072-1-gang.li@linux.dev/

