Return-Path: <linux-kernel+bounces-54245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5884ACC6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10711C22EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA673163;
	Tue,  6 Feb 2024 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLjFp1gP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02B745E9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189408; cv=none; b=UPDcJXwW0CqDxNU/51nLlf2+TbbM1uv4DRsHw7yjDShB/KLBOOgfL5xfWVF170s/kYME/doQ81fZI3kebw3MaiRhqIWIXI2ZDvODEgFSuV+yjnHLULSzsDmsAco8+3iTb52RL99Dzouet4jzdfsN2U57EDbKXbar3wzI3OcTdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189408; c=relaxed/simple;
	bh=XlT/oFXhFBECcFABqd/c6XAVL8ZjWF+z5VrLDcUku2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ir93Lbme5VnU6xLkCBXhooOacpELj+02MjDC2wb2/pQMgQPrAnDQLT5U5OOdzpdOUV/EPN7FWCh6VpT3EXwdA2OjXUA1O7417OHTLWS+nZvEEmqBXzZphOd8zEPJoY98E6vDeP/ChnwVHaVdqI9oMMQ+rhxgetvedH9NCOLN6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLjFp1gP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707189406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNKnKIcGVgRey+WDdSS1pYfQz/TNzPFoLWEek88f+c0=;
	b=fLjFp1gPXyFzxzchdA2BA5EN/FqJfsjtUcPnyym4RR6zbhiEKBu9+7nRiVCHJFwnKfGFHV
	V6fOrlBZUdGBgJZXrZwop81Wlo1mUtzWeGgWO49wvGz+HUHyNd3kVIXD8PCt88reY6pyCZ
	McMDn2S4l1382QRj0EGXYqwMHoBP9l0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-K45c_6kFP7iWy58RcRhdfQ-1; Mon, 05 Feb 2024 22:16:42 -0500
X-MC-Unique: K45c_6kFP7iWy58RcRhdfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97904800074;
	Tue,  6 Feb 2024 03:16:41 +0000 (UTC)
Received: from [10.22.17.212] (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8716B492BF0;
	Tue,  6 Feb 2024 03:16:40 +0000 (UTC)
Message-ID: <da2417c0-49f1-4674-95f9-297d6cd9e0fa@redhat.com>
Date: Mon, 5 Feb 2024 22:16:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Content-Language: en-US
To: "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>,
 Zefan Li <lizefan.x@bytedance.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
References: <20240131172027.10f64405@gandalf.local.home>
 <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
 <61af19ca-5f9a-40da-a04d-b04ed27b8754@suse.cz>
 <698633db-b066-4f75-b201-7b785819277b@linux.dev>
 <PH0PR11MB519280092AA66FAE6BB3FACEEC402@PH0PR11MB5192.namprd11.prod.outlook.com>
 <fb8161d9-16c0-da8c-09ee-905e39ae199b@linux.com>
 <PH0PR11MB5192FC6A7AA3CB84BA3BC7E6EC462@PH0PR11MB5192.namprd11.prod.outlook.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <PH0PR11MB5192FC6A7AA3CB84BA3BC7E6EC462@PH0PR11MB5192.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 2/5/24 20:46, Song, Xiongwei wrote:
> Adding the maintainers of cpuset of cgroup.
>
>> On Sun, 4 Feb 2024, Song, Xiongwei wrote:
>>
>>> Once SLAB_MEM_SPREAD is removed, IMO, cpuset.memory_spread_slab is useless.
>> SLAB_MEM_SPREAD does not do anything anymore. SLUB relies on the
>> "spreading" via the page allocator memory policies instead of doing its
>> own like SLAB used to do.
>>
>> What does FILE_SPREAD_SLAB do? Dont see anything there either.
> The FILE_SPREAD_SLAB flag is used by cpuset.memory_spread_slab with read/write operations:
>
> In kernel/cgroup/cpuset.c,
> static struct cftype legacy_files[] = {
> ... snip ...
>          {
>                  .name = "memory_spread_slab",
>                  .read_u64 = cpuset_read_u64,
>                  .write_u64 = cpuset_write_u64,
>                  .private = FILE_SPREAD_SLAB,
>          },
> ... snip ...
> };

It looks like that memory_spread_slab may have effect only on the slab 
allocator. With the removal of the slab allocator, memory_spread_slab is 
now a no-op. However, the memory_spread_slab cgroupfs file is an 
externally visible API. So we can't just remove it as it may break 
existing applications. We can certainly deprecate it and advise users 
not to use it.

Cheers,
Longman



