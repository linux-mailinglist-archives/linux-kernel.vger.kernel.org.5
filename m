Return-Path: <linux-kernel+bounces-81088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65B867001
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14A3285A95
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A421364;
	Mon, 26 Feb 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rj9a1w9T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC5612EB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940752; cv=none; b=n/OQdxCKuEpzC+yU0cLP/1sLbUZ1/OqeHAf/cysIqBHGQJMv0EC1EuRTInQ99L24pKiuaXeY4e7Tx35KX8WkzUxY4W2R4gFRQgZNN4bKkABekiKKvVWK4Y1zStlsrvWBkxIukHBuN+6ohN55OqM2X/LP1Fn2jsyMDPKQeE6RWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940752; c=relaxed/simple;
	bh=dCKaVRI70X9nX5C5tTSd4BzqGMV1ZDrOuKEcOyxOIRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/uLsfQyz8LdXtNSlEojS4+GTAq9JShv9nZuD/4gCCXYmnNJpu75+5C6h3VZ3gnTj1f19mijhx5XYtiMADUbJ59VSw2BolDDK7BvCPONrkZTkURzCoNXC9N9PCcdPUKdOEjDdpu+ybrzXkRPrBCxGlHXA7ssZ7VNMlryQjZE33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rj9a1w9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708940748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCKaVRI70X9nX5C5tTSd4BzqGMV1ZDrOuKEcOyxOIRQ=;
	b=Rj9a1w9T7eLbmQdZyjqGrlCMkH/Cpisxc/j3aoArT5efc6b6Gl2cgtunOg/OMHduXrs22w
	aS9TWN5V/f+WJEMtSHlUJOuW7bdrvIYw4f79rC0fg/A0tOpdXMeTuWSx/O74JqEkMKjWWK
	VOIgU4f6MeFtlruV4H7fhsjctGqgtIE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-x3WjEc7RNoS5x0IBjXRmHA-1; Mon, 26 Feb 2024 04:45:47 -0500
X-MC-Unique: x3WjEc7RNoS5x0IBjXRmHA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-299ba5ae65eso2011109a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940746; x=1709545546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCKaVRI70X9nX5C5tTSd4BzqGMV1ZDrOuKEcOyxOIRQ=;
        b=HsJF9z9wTFgYevjMmCaD4ZqqCJG2qjB83Yb+kAymf8ozvN4D7sLPY3l0Bp/5arPNyK
         6FL874rGdqv9u4Vt/T1zlTurg06JJ0MiWinHBvQ6F41+UOmvQNQqcbt/gKHcfoiJz7sp
         Ez0ypx0C4oC2yRIS/ytrEisnoLld3oru20zR4z0RCklqlNVIIVDBkz552dPI9saNrTUT
         kv2fxruFPuVAA7kAWgVFO7bsRsCYirv47OH76+1zLtHlBfTgiQPFtp5KiOj4cDJGcLkk
         hYVgh0GJB1JiWk1cxUvBe7yY0+JaSeVBFDa9pShdA3wbdIJdjEzx7T0FjgrBYM1/4o8v
         nptg==
X-Forwarded-Encrypted: i=1; AJvYcCXtKNdUQbRrQV2fyodz3WxfsrYI7SW54L4cTJT3y/yF9qvlyiqtPIgKTxNeZaSoZSVg7Cx5IpvAMy3SKcsxyr875dzywAaAPvdxOqEz
X-Gm-Message-State: AOJu0Yx74qDwocP4qsHBkB/tx1uv6KdQlLSUVdiAU6Dg6aoHID6cR3xp
	tA1DpXdkuGgDAGPJTB8Q/jiEjqeII4Fb+JJPrXnhRBLcJdJ+wk61xMT5euyvTW4uA+RFCOcKUeX
	uab6xFxZINelpDowsq1gNpD7UjuNixcUweIQZTsl27oRPL5Ic/PZjZJecUPJf7w==
X-Received: by 2002:a17:90a:5804:b0:299:389e:b611 with SMTP id h4-20020a17090a580400b00299389eb611mr3031175pji.47.1708940746444;
        Mon, 26 Feb 2024 01:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwrMH4Pc4Gm/d62OCtdzo1pEAT6r1dMRKaxZDdA09uvO5xPSvH5TATmWN7Fro0w/9qlcZbEQ==
X-Received: by 2002:a17:90a:5804:b0:299:389e:b611 with SMTP id h4-20020a17090a580400b00299389eb611mr3031168pji.47.1708940746068;
        Mon, 26 Feb 2024 01:45:46 -0800 (PST)
Received: from [10.72.112.214] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id su6-20020a17090b534600b0029a7951c4a3sm5945862pjb.41.2024.02.26.01.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 01:45:45 -0800 (PST)
Message-ID: <0b9211b7-9d21-4525-b910-ba66af98a82f@redhat.com>
Date: Mon, 26 Feb 2024 17:45:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 Chengming Zhou <chengming.zhou@linux.dev>, idryomov@gmail.com,
 jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, roman.gushchin@linux.dev, Xiongwei.Song@windriver.com,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224134715.829225-1-chengming.zhou@linux.dev>
 <b6083c49-5240-40e3-a028-bb1ba63ccdd7@redhat.com>
 <d91e3235-395a-4e63-8ace-c14dfaf0a4fd@linux.dev>
 <35df81f5-feac-4373-87a3-d3a27ba9c9d4@redhat.com>
 <82c2553f-822e-40c2-9bf8-433689b3669d@linux.dev>
 <69589d2f-978d-4d14-9e5f-6bd6b3a43062@redhat.com>
 <cb1e2218-9a50-4c42-8a46-a35193208442@suse.cz>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <cb1e2218-9a50-4c42-8a46-a35193208442@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/26/24 16:32, Vlastimil Babka wrote:
> On 2/26/24 05:54, Xiubo Li wrote:
>> On 2/26/24 12:30, Chengming Zhou wrote:
>>> On 2024/2/26 12:23, Xiubo Li wrote:
>>>> On 2/26/24 10:42, Chengming Zhou wrote:
>>>>> On 2024/2/26 09:43, Xiubo Li wrote:
>>>>>> Hi Chengming,
>>>>>>
>>>>>> Thanks for your patch.
>>>>>>
>>>>>> BTW, could you share the link of the relevant patches to mark this a no-op ?
>>>>> Update changelog to make it clearer:
>>>>>
>>>>> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>>>>> removed as of v6.8-rc1, so it became a dead flag. And the series[1]
>>>>> went on to mark it obsolete to avoid confusion for users. Here we
>>>>> can just remove all its users, which has no functional change.
>>>>>
>>>>> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
>>>> Thanks for your quick feedback.
>>>>
>>>> BTW, I couldn't find this change in Linus' tree in the master and even the v6.8-rc1 tag, please see https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/slab.h?h=master.
>>>>
>>>> Did I miss something ? Or has this patch been merged ?
>>> You're right, this patch hasn't been merged. But it's already a dead flag as of v6.8-rc1.
>>>
>>> Update changelog to make it clearer:
>>>
>>> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>>> removed as of v6.8-rc1, so it became a dead flag since the commit
>>> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
>>> series[1] went on to mark it obsolete to avoid confusion for users.
>>> Here we can just remove all its users, which has no functional change.
>>>
>>> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
>>>
>>> Does this look clearer to you? I can improve it if there is still confusion.
>> Yeah, much clearer, thanks!
>>
>> Maybe we should just wait for the [1] to get merged first ?
> It's really not necessary to wait, [1] just makes it explicit but the flag
> is really effectively dead since v6.8-rc1 because nothing acts on it.

Okay, will apply this to ceph-client tree and run the tests.

Thanks

- Xiubo



