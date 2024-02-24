Return-Path: <linux-kernel+bounces-79545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D18623F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BC81F21AA0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34571AAD7;
	Sat, 24 Feb 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U/5SIqsF"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039817995
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767182; cv=none; b=EN99949+HggsxAJEYubyaKl3TZbAVz4N4vOka1du/PnPcUqqKLSIGSajyej4QXVINOZPhzHlUbBw1W0rHQ4pcwA3ZB1mjot2Oe4AsuS73kZJF8HhjZe8y+zj7BF4xg0k35+KKXzZjDHyqkkUDoFCQDheCsDszMUYpfVRh68eHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767182; c=relaxed/simple;
	bh=yobnoCxe2oqRMlBuWssGh9lK2tMG7dzpuL0hIybyM5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSp8WD0WHmsiYcPLFSI8rKRIq/IL2v+9HmMOW3iGdO/dqT/sU30e21gCjdXyr+g9bHE2pp+ptl9owD8H7wBid4EflzhyP+v21lbQ8mmHa4ENPmIq5AWx80mUSvzy3M1ifNV2owhB8PQWYtRiEa6Qal9I/5ZGfTVPCHCXTRa68Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U/5SIqsF; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e63166ef-4aff-485d-8c32-4e4ad3384563@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708767178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5CbQ+eZHnRkInbsJ83G0MenQ1/0DqwIekM9Cx5ZW3Q=;
	b=U/5SIqsFSOxdX9GeE99DeSkUhKxMm/M0NSpx9+5xsxSOO1n5b15ZC8EFMT+rEzKVxB4Lt+
	VrjYjDqNIBkmBxH6SyVOb3vrsFc+QTsASp9Ec7GM5Edjh5YRJoWkpBSv6csOOnIZYHvMTC
	ZWvRiGBP7jrM7SjZDQUBn/z6wegbKOw=
Date: Sat, 24 Feb 2024 17:32:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
 <ZdZBN_K8yJTVIbtC@P9FQF9L96D.corp.robot.car>
 <CO1PR11MB51854DA6F03753F12A540293EC562@CO1PR11MB5185.namprd11.prod.outlook.com>
 <7e27b853-e10f-4034-bc81-2d5e5a03361a@linux.dev>
 <beb2b051-af97-4a6a-864c-e2c03cd8f624@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <beb2b051-af97-4a6a-864c-e2c03cd8f624@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 00:41, Vlastimil Babka wrote:
> On 2/22/24 03:32, Chengming Zhou wrote:
>> On 2024/2/22 09:10, Song, Xiongwei wrote:
>>> Hi Vlastimil,
>>>
>>>> On Tue, Feb 20, 2024 at 05:58:25PM +0100, Vlastimil Babka wrote:
>>>> 0;95;0c> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>>>>> removed.  SLUB instead relies on the page allocator's NUMA policies.
>>>>> Change the flag's value to 0 to free up the value it had, and mark it
>>>>> for full removal once all users are gone.
>>>>>
>>>>> Reported-by: Steven Rostedt <rostedt@goodmis.org>
>>>>> Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
>>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>>
>>>> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>>>>
>>>> Do you plan to follow up with a patch series removing all usages?
>>>
>>> If you are not available with it, I can do.
>>
>> Actually, I have done it yesterday. Sorry, I just forgot this task. :)
>>
>> I plan to send out it after this series merged in the slab branch. And
>> I'm wondering is it better to put all diffs in one huge patch or split
>> every diff to each patch?
> 
> I'd suggest you do a patch per subsystem (mostly different filesystems) and
> send them out to respective maintainers to pick in their trees. I've talked
> to David from btrfs and he suggested this way.

Ok, will send out individually.

> 
> You don't need to wait for this series to be merged. The flag is already a
> no-op as of 6.8-rc1. Also I'd suggest sending the patches individually. In a
> series they wouldn't depend on each other anyway, and you would either have
> to Cc maintainers separately per patch of the series, or everyone on
> everything, and there would always be somebody who would prefer the other
> way that you pick.

Right, thanks for your instructions!

> 
>> Thanks!
> 

