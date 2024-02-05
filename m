Return-Path: <linux-kernel+bounces-53157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C384A16C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3763B22628
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D547F55;
	Mon,  5 Feb 2024 17:54:38 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0B47F53
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155678; cv=none; b=pGZelq1tjMhR3ko8yQzfUQHHA1Qd2T2Qj917ixbc0MiB7scsouWiPtTeD//j5rFIUBe4n8Yn4/pLlAynrSb8oC0dk2OkZuzhADH4tlTB4lsP467yL/y3tn5vfTMNtYV3uQlEdswbwvMa9GivGMf2LR/9UW1f+eJ9y3jdOfnXPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155678; c=relaxed/simple;
	bh=DK9YgOqGlVPKk/+dHP9WbLLFdMltfJIuTdP0ECcr/A8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OeiQ3M0iS0BNcP6FYFSBTYBRncVS3ZF0gaoMGCDJwpl9U3UGaqx35V8uCmArs7GfdtQii5AVbEYOhkcdMtjHtutGVu4UrX2Nk4W6Np4iKxGaMCYBdPXUKVyYp1uRx2Xv5vY7//FMilCqj7hdNiWIf2iTWerBIIi9k1yMGxYwYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 6BF1941CB0; Mon,  5 Feb 2024 09:54:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 6B6E940789;
	Mon,  5 Feb 2024 09:54:34 -0800 (PST)
Date: Mon, 5 Feb 2024 09:54:34 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Greg KH <gregkh@linuxfoundation.org>, 
    Fangzheng Zhang <fangzheng.zhang@unisoc.com>, 
    Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, 
    Fangzheng Zhang <fangzheng.zhang1003@gmail.com>, 
    Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] mm/slab: Add slabreclaim flag to slabinfo
In-Reply-To: <2f43774a-16cf-412e-b4b7-840889bb796b@suse.cz>
Message-ID: <58191e1b-7ebc-16ff-1df0-16ddcaa2e7b9@linux.com>
References: <20240131094442.28834-1-fangzheng.zhang@unisoc.com> <2024020441-version-chihuahua-1067@gregkh> <2f43774a-16cf-412e-b4b7-840889bb796b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Feb 2024, Vlastimil Babka wrote:

> On 2/4/24 14:09, Greg KH wrote:
>> On Wed, Jan 31, 2024 at 05:44:42PM +0800, Fangzheng Zhang wrote:
>>> In order to enhance slab debugging, we add slabreclaim flag to
>>> slabinfo. Slab type is also an important analysis point in slabinfo
>>> for per slab, when various problems such as memory leaks or memory
>>> statistics occur.
>>>
>>> Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
>>> ---
>>>  mm/slab_common.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>>> index 238293b1dbe1..aeeb2bfe6dda 100644
>>> --- a/mm/slab_common.c
>>> +++ b/mm/slab_common.c
>>> @@ -1038,7 +1038,7 @@ static void print_slabinfo_header(struct seq_file *m)
>>>  	seq_puts(m, "slabinfo - version: 2.1\n");
>>>  	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
>>>  	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
>>> -	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
>>> +	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail> <slabreclaim>");
>>
>> Doesn't this change the slabinfo version number above?  Where is this
>> change documented so that userspace knows about it?

I have never seen such a document. I would suggest incrementing the 
version to 2.2 since there is a minor extension of the format.

I tried to remove /proc/slabinfo in the past and have people use the more 
versatile /sys/kernel/slab interface. But /proc/slabinfo has a long 
legacy.

Could we mark /proc/slabinfo as deprecated and recommend the use of
either sysfs directly or use of the "slabinfo" tool that we have 
been providing in linux/tools/mm for a long time?


