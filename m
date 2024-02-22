Return-Path: <linux-kernel+bounces-75799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D99C85EF26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26440283C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1C14284;
	Thu, 22 Feb 2024 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WKipzrUZ"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD114ECC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569190; cv=none; b=ZDsS+iWJOWc4s55qcBGsS9QAHR/mVSj4DjpzxPEVEYsfYG28Vzgpo5TbwKuKyNC0e7bWIpvUSYDGsb4x3x5Resxkd+RD+771ceHeUYfB+UUw08fYbq6yIPKn61FssXOOtsVc+6A8IsB0gPJajsYkBzQw+9em08h/CcephZnX0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569190; c=relaxed/simple;
	bh=kM1AW3Bz2ajD4Ey9z6LfXeQKZXOXra99OPtNo5PE1LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVbep/I+BjkmtWooptGbEXZnF97yZdgTa/ybZ54UvzjiODxMRazoIS+YXV2vp+HriXhgd4SYhyZnVy9c6klCX0/ULccCxhARkzD8pVNk6ofo9uRgzReRBdSPsuOv7HW49lbGcSUURzwVj4vRU7M0xVCwTYTYuFxl9QyskQ47Zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WKipzrUZ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e27b853-e10f-4034-bc81-2d5e5a03361a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708569185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Lcomib2YoDBqz/0vjugx8QRFaaeaSrpG+g/RGvt17I=;
	b=WKipzrUZFjdAB46ynW/WwWX0SrwqTqCA61R8AL/wBrpDV52bHSiLu8gCOot00zd1JF5VQw
	fFhNYAKrgUQ+8slT4Xu3HI4Hu76eQZGdiV4MsqdNR8ptQc+1sX91j+1wYUnp6YgQF5NY/w
	HdwDvRiG2/iFH/36+oJaToz4iyU9054=
Date: Thu, 22 Feb 2024 10:32:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Content-Language: en-US
To: "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Vlastimil Babka <vbabka@suse.cz>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CO1PR11MB51854DA6F03753F12A540293EC562@CO1PR11MB5185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/22 09:10, Song, Xiongwei wrote:
> Hi Vlastimil,
> 
>> On Tue, Feb 20, 2024 at 05:58:25PM +0100, Vlastimil Babka wrote:
>> 0;95;0c> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>>> removed.  SLUB instead relies on the page allocator's NUMA policies.
>>> Change the flag's value to 0 to free up the value it had, and mark it
>>> for full removal once all users are gone.
>>>
>>> Reported-by: Steven Rostedt <rostedt@goodmis.org>
>>> Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>>
>> Do you plan to follow up with a patch series removing all usages?
> 
> If you are not available with it, I can do.

Actually, I have done it yesterday. Sorry, I just forgot this task. :)

I plan to send out it after this series merged in the slab branch. And
I'm wondering is it better to put all diffs in one huge patch or split
every diff to each patch?

Thanks!

