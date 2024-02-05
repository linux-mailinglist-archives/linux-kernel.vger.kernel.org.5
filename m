Return-Path: <linux-kernel+bounces-52186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4D849516
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00A21C233FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBAB11714;
	Mon,  5 Feb 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEccBrd9"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870B11702
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120533; cv=none; b=uVNSWP3L+pWtBJd0FlekQ75EU9yNf482mEysQNUorPMxwlc54zFPimFcm5cesbioujSjH+dN5iruGZ0WGJV6HqS6xdTizn7MdH3vXVz/hqzgWBV5rOemr+3hYUv7Yjrw/CHrfOtP2gNyO1Z/cRAWqY/Gd3EMOM13XjIhrAILBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120533; c=relaxed/simple;
	bh=EC44DeqNr8LAwIvt5e63AJ5hgZz9O3zu7ss0PAinqmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxqGwcVyPiVL6PiQArSB2+kVHm/bBxmwsMVdMBR3WGNuV7rc9dg6m12GrDq8PqdCHt1+l6bDLdi5v2Uv+uNfaLJF1qqx9AQ66G/5kYo5QCzst+i3eTStJtWpaNwc0tsTcwmMNC9+GNA44sWrnOQFi5xNo8sxI/CADEi/9u0EDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cEccBrd9; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ab3961d-04e5-484d-bc71-2f33ebbefc67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707120528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDHjczhceVjO1MtODZfTIEYCTueKSLyt0SDAh9/KabE=;
	b=cEccBrd9TGxJ7J54r5l06zjN1IQaCqrAVOQt0NsGOyJDsqA1JEWqA7g3oEbeErkWFy7av7
	SykP+U5ITW1n4nnnLZVTx2bkpcBMTWzq2BRF34eVDHQtgpJOt4VqsCO5UIOsXli1CaslTN
	DMgRdV6jaBRoVGJHbut7rvylwlw9eBM=
Date: Mon, 5 Feb 2024 16:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP
 system
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>
References: <20240204072525.1986626-1-gang.li@linux.dev>
 <f05f658a-78fa-45cd-ad07-11d87b824702@linux.dev>
 <a749cb06-9495-40fc-9192-b019b48eca92@linux.dev>
 <828f990c-11af-42ad-a030-a66dde97a7f2@linux.dev>
 <7472563F-5C2D-4DCB-ACD6-F86D7A18BDF2@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <7472563F-5C2D-4DCB-ACD6-F86D7A18BDF2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/5 15:37, Muchun Song wrote:
> Actually, I did not get it. Why the above code cannot work? The above
> code already make it serialized in one call, right? What do I miss here?
> 
> Thanks.
> 

PADATA consists of two distinct functionality:

One part is `padata_do_multithreaded`, which disregards
order and simply divides tasks into several groups for parallel
execution. My patch use `padata_do_multithreaded`.

The other part is composed of a set of APIs that, while handling data in
an out-of-order parallel manner, can eventually return the data with
ordered sequence. Only `crypto/pcrypt.c` use them. I guess these APIs
are designed specifically for `crypto/pcrypt.c`.
```
padata_alloc
padata_alloc_shell
padata_do_parallel
padata_do_serial
padata_free_shell
padata_free
```

