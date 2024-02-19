Return-Path: <linux-kernel+bounces-70668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06E2859AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30181C20F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA023C2;
	Mon, 19 Feb 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FGOysB4P"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4F20F1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311825; cv=none; b=Rdpxwq+YJkWbdbhiNqW63G0n52Sju1wzo6v61GppsFJTEyagd1VOybJr12pYAzgXK1G/1KOgsyDBEAB3zdcF1V+uiAf5k2uOrNZ/yt2xlE/YQPjDzSjTiWHViZpLWsKVJZY1CfxheZCsGr36zjeBIC0eLFtnmwjp1dnv/aEZgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311825; c=relaxed/simple;
	bh=VpIrBj6BuWpvsTnMW109kNdGd7OdPqlGVsB7EKru9bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8X8waY//Wz3deVIgVJHC2fiLL/61jtV2KrVOsz+XzXe5lZ0tgP/OmPD053cEeD/h/msn1SEA5wAImviQeM7+46eclDHWgEhbQG2UCe6pyYOc862n6MYAbq5eGojabxft7NkiM/YNr4UPF2bHPUiP2WOgIStPrtp59bZCRI8bYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FGOysB4P; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66232486-12a9-4097-baad-fa20655194b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708311820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t20blBerpKsJdkYRiYA6u1qgZaBDK6ikdtFcirK4gro=;
	b=FGOysB4P60wrEANwTQ0+4FFxSGNMB9pYGE43QhvFc+W7I5b6+Oxv2AJeJebL5JHFFruPTF
	/xpw0t5R3FIddXV1V9WFvzIS6H/rz6pHXuofL1zt9lu2yXv00Zd8fMVdMRBNdrxFTOI0mQ
	NesSEWVRjv+5mJhTTPNPH0Pvq4pud9c=
Date: Mon, 19 Feb 2024 11:03:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/2] hugetlb: two small improvements of hugetlb init
 parallelization
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240213111347.3189206-1-gang.li@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <20240213111347.3189206-1-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/13 19:13, Gang Li wrote:
> This series includes two improvements: fixing the PADATA Kconfig warning
> and a potential bug in gather_bootmem_prealloc_parallel. Please refer to
> the specific commit message for details.
> 
> For Andrew:
> If you want me to include these two fixes into the previous series[1], I
> would be happy to send v6. Otherwise, you can directly apply these two
> patches.
> 
> [1]. https://lore.kernel.org/lkml/20240126152411.1238072-1-gang.li@linux.dev/

Hi Andrew,
A gentle ping here :).

Do you want to apply these two patches, or would you like me to
include them into the original patch and send out v6?

> 
> Gang Li (2):
>    padata: downgrade padata_do_multithreaded to serial execution for
>      non-SMP
>    hugetlb: process multiple lists in gather_bootmem_prealloc_parallel
> 
>   fs/Kconfig             |  2 +-
>   include/linux/padata.h | 13 +++++++++----
>   mm/hugetlb.c           | 15 +++++++++++----
>   3 files changed, 21 insertions(+), 9 deletions(-)
> 

