Return-Path: <linux-kernel+bounces-163913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968E8B75AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC36B22B58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E004140360;
	Tue, 30 Apr 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MAQ9GBoy"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663113FD8D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479876; cv=none; b=l/W45uLTtQS9CfSpxqpqhokjTh/LD6Gg19HodlrULXGJbKAKf8XUzu1sULHzTXNp10+KDcm0bug+i+1uMJ/EY1VpFbU56o4o2aCPhac/Simmrprm/IFSnjY9noDvEJYKuKGPenGM2iT0hMXfpg3cp1Nv9TPBqXx5cnB16BgsaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479876; c=relaxed/simple;
	bh=2bm1i0MQ3FR9Xk4H1b2IgOwC/li7E1JWYo7MM7WgaOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwqTv8vMAnOeUDmGHzVT/+rhWPJrUFZelH0/NKP7CU2t3e+YKZ09R/FwkOKyTEGYRs4PyQoZQe0ssFLXUH1BKftJio8QwQH5OqDJc6B/lE4SJQR52UsRDKm1mF3Pk4bKQkq4USD12MVv9hKLC4AjbA0xGk/zjAPg8s09k4A8xA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MAQ9GBoy; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e85ba009-9150-4e50-918b-a86500dbc820@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714479871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1ytzCh4DK871MzJc5SzNhcnB9s/CPyVS2qgE0inj/o=;
	b=MAQ9GBoy69q68FHEh+wSZq+JT7JQs/4lSj7VNLfvQuaZmJIp1s5NaWHotn4kf7cHLhqfW5
	8twUjpDPSa9J5WCERMB77nomDcVelzyE5lVNR+YPy1FCLmXpqlQCs9F4tjqhGexiw9gtS/
	DCBgtaHbK/jesohHwiHXPaTpkA1bZaY=
Date: Tue, 30 Apr 2024 20:24:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] slub: Fixes freepointer encoding for single free
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <ZjDXY74yS6UyQPxv@archlinux>
 <1a2e8da7-6969-43ac-9e65-2361c93d107f@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <1a2e8da7-6969-43ac-9e65-2361c93d107f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/4/30 19:58, Vlastimil Babka wrote:
> On 4/30/24 1:34 PM, Nicolas Bouchinet wrote:
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>
>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
>> separately") splits single and bulk object freeing in two functions
>> slab_free() and slab_free_bulk() which leads slab_free() to call
>> slab_free_hook() directly instead of slab_free_freelist_hook().
>>
>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
>> set, the do_slab_free() slowpath executes freelist consistency
>> checks and try to decode a zeroed freepointer which leads to a
>> "Freepointer corrupt" detection in check_object().
>>
>> During bulk free, slab_free_freelist_hook() isn't affected as it always
>> sets it objects freepointer using set_freepointer() to maintain its
>> reconstructed freelist after `init_on_free`.
>>
>> For single free, object's freepointer thus needs to be avoided when
>> stored outside the object if `init_on_free` is set. The freepointer left
>> as is, check_object() may later detect an invalid pointer value due to
>> objects overflow.
>>
>> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
>> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.
>>
>> dmesg sample log:
>> [   10.708715] =============================================================================
>> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
>> [   10.712695] -----------------------------------------------------------------------------
>> [   10.712695]
>> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
>> [   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
>> [   10.716698]
>> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                                      ....
>> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not freed
>>
>> Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
> 
> Chengming Zhou, could you provide your s-o-b please?

Of course.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

> 
>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Added to slab/for-6.9-rc7/fixes, thanks!

Thanks!

