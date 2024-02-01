Return-Path: <linux-kernel+bounces-47691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6097E84515A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04885B25480
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667E83CD5;
	Thu,  1 Feb 2024 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="axgxy3x6"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFEE69D2B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706768863; cv=none; b=APeygWfkFZ/P5EzJ4sw4P178PC0zSlWLH4nl1FIiqimL4PvvU/xSj4TICKuAMYjxTdduYne2AaZW4fiStyHtDjf4010+elmFBEpjD+mxWUYVE0ASg/4/BkOYnYYdB9SIgeWoU6dm/Ehx6QmSp3L9oB6vHoBlwy0rXc5u1aiHsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706768863; c=relaxed/simple;
	bh=qZ+RsLb2dmGFbUCMD4Q9h+jIkmnMbZKhyHgyxrJ3lH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=na+Zov1NpGWN6YoPlJCO6hTHLT8f4Q4UlVSpqP5d2URqkeqgmNK5P11SDJZLNAORdNAbca++TtyxUUDxQG8Wj56LMnhMyRNmqDjx9cbbNTbGbPjjmydhv5gW2lAEFl5dhNnnOSWq2KHZl6oJgdWY/lUpoC2b6i1Eo7tajxZnsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=axgxy3x6; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <698633db-b066-4f75-b201-7b785819277b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706768857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Qvm1uhfLMC1fJLgXMV0RsQ6nifi9sUu1XYYWSZg8Cw=;
	b=axgxy3x6LGdKdzkvApMtvByga7105wOUF1dtMY7024mq4NgCwACDwjDhUz5JSXqBpcikI8
	QxyL0TbWBStcU3svB/8WHZMBkM5zFMc3zx4wmhqf3tCS29VKmyNxvhzCmlbx+EEwP/XnU3
	g6gIkJKZ09uYjL4q+0W8oyiKXAz+Kw0=
Date: Thu, 1 Feb 2024 14:27:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Xiongwei Song <xiongwei.song@windriver.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Zheng Yejian <zhengyejian1@huawei.com>
References: <20240131172027.10f64405@gandalf.local.home>
 <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
 <61af19ca-5f9a-40da-a04d-b04ed27b8754@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <61af19ca-5f9a-40da-a04d-b04ed27b8754@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/1 06:40, Vlastimil Babka wrote:
> On 1/31/24 23:25, Yosry Ahmed wrote:
>> On Wed, Jan 31, 2024 at 2:20 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> I was looking into moving eventfs_inode into a slab, and after cutting and
>>> pasting the tracefs allocator:
>>>
>>>         tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
>>>                                                  sizeof(struct tracefs_inode),
>>>                                                  0, (SLAB_RECLAIM_ACCOUNT|
>>>                                                      SLAB_MEM_SPREAD|
>>>                                                      SLAB_ACCOUNT),
>>>                                                  init_once);
>>>
>>> I figured I should know what those slab flags mean. I also looked at what
>>> others in fs use for their slabs. The above is rather common (which I
>>> probably just copied from another file system), but I wanted to know what
>>> they are for.
>>>
>>> When I got to SLAB_MEM_SPREAD, I found that it's a common flag and there's
>>> a lot of caches that just set that and nothing else.
>>>
>>> But I couldn't find how it was used.
>>>
>>> Then I found this commit:
>>>
>>>  16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h")
>>>
>>> Which I think removed the only use case of SLAB_MEM_SPREAD.
>>>
>>>  $ git grep SLAB_MEM_SPREAD mm
>>> mm/slab.h:                            SLAB_MEM_SPREAD | \
>>>
>>> That's all I find in the mm directory.
>>>
>>> Is it obsolete now? Can we delete it? Maybe there's other SLAB_* flags that
>>> are no longer used. I don't know, I haven't audited them.
>>
>> Perhaps cpuset_do_slab_mem_spread() as well.
> 
> Yep, good find. Show how obscure mm/slab.c was in the end :)
> 
> CCing a few more new people who did slab changes recently, who'd like some
> low hanging fruit of negative diffcount? :)

Thanks for CCing, I can prepare the patch to do it. IIUC, what I need to do is:

1. delete SLAB_MEM_SPREAD and all its uses.

2. cpuset_do_slab_mem_spread() is not used anymore, should we keep the interface?
   Since it's the interface exported by cgroup-v1 "cpuset.memory_spread_slab".


