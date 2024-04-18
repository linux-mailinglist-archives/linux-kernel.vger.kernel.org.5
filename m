Return-Path: <linux-kernel+bounces-149603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2568A9356
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAC91F2168A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E992E3F7;
	Thu, 18 Apr 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUjVAFoi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA328C11
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422649; cv=none; b=BMSO5+gSWHqOwasszedrCHAg41cfj4e69evZ1v4w7VOLT6Gfa8g4Uj0WEAvX/CzbCeAhTC6wuw0H46wx1F/nDQMijPdp9oLXEVQ85oa+7rZIruWXMcvcHcT9KnIWsj/soBRNb82mrChYsIqXe4MXv5LHAnEr/zfI0Hq33lTbHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422649; c=relaxed/simple;
	bh=m3Ryu5pNPT9NKoAFnVN5C3vBRFE2G9wUJfovS31lKBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbiCdx+06FKkQHE+EfNquX5KkT4Bm5nLF9jFfQyyZWJn54PeDxxdU6ApzNzGAFm2ICzEonWIBNDAltuJgZhMoQifVc8MhjPw1aq8mjOC8BgjaVz92hAplt/L8kHFykX2RXxNTRY9XLY2GRH6rT9CX/l9KNSoXWeZFhuO8BCkbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUjVAFoi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713422647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+jyIdNmCmRDq2Tfb24hu6l/6jJfbfj68TnMmrtzF+w=;
	b=FUjVAFoiDPCB0PH4SZvhRb0o5ZlUwPUVePi7Xc+zEzQJoL5oLdu106tlRe8W+qv/jXX3vV
	e/wzLUCHYpZ9/hi996p1YbIIlDJUqkWD/SyE9eCvs8lVcpIVlPEV8pmaAwVFGHt9CqiHS5
	NdNJFvj5pOOklH4aPvrVE4YIhQWHj8w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-LybonVTfOSyBAUiOEHYUVQ-1; Thu, 18 Apr 2024 02:44:05 -0400
X-MC-Unique: LybonVTfOSyBAUiOEHYUVQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e851c0204aso7838025ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422644; x=1714027444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+jyIdNmCmRDq2Tfb24hu6l/6jJfbfj68TnMmrtzF+w=;
        b=AMgGIrsxAwBFrZLFLbOGQNwozctsodaAjbZCYwv0uAYA1LbKaVpEN08/n9qm0k0o2k
         CUhSVGm5BWd5wYE7EmcnzLMrfo1IHYc+9C9k7kV41lvauq+nlbGtzE/Wq/9xvLSA6u7j
         27mTzaDtRDnrs6JMQSk8MFJ0mW7zcZFGydiPiBn5f/tZXcMaFdPL6hX1No8r42HyNLsf
         o7wP8DCpcuEjUMQzBcFOWrVw53jZVN6+oKSLH3g+4/N7FGXVQkrHRapQXIO8qojMX/kw
         sjPK6SKTxdqLnWvqU+0V1JKmjTl2cimv01Axe/foKL+nxiNd4VWJuh5Bd2a1nbFBri77
         6Clg==
X-Forwarded-Encrypted: i=1; AJvYcCVfk/jiYEiZ6O99PZtaUGpQWEeQtJdemmIWiJoXryT8z8OEq6ChVmmW+969FCYJPphfvJmp9zOrci/tTZ6lSMYCmFWRogOx2l8H+QQz
X-Gm-Message-State: AOJu0YxrivdJy/T0fHzcOasTtckuBoboXfjYt0fSkVyHQLrmsE3LbscW
	vf2v1K70/wmS+bDMMTCpstPXNtCpIOrVKoUXFUvUzEvAt19Jn8rE1s4lfY8xsDqne0/4hkc1G7h
	TjZMPnLg1ilWsXY4lb2ZGm0bUmjaMilCMvw4ms2q/B8W+T8lbCvOnF2fXj/VUkA==
X-Received: by 2002:a17:902:b907:b0:1e4:9ad5:7522 with SMTP id bf7-20020a170902b90700b001e49ad57522mr1802474plb.21.1713422644467;
        Wed, 17 Apr 2024 23:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7i13VHRnkWqSR3qq0QcNNIr94YcswslzKaupW+/Lkc72QhLzt9HvulwLD2aNX2Rfh804ROA==
X-Received: by 2002:a17:902:b907:b0:1e4:9ad5:7522 with SMTP id bf7-20020a170902b90700b001e49ad57522mr1802459plb.21.1713422644061;
        Wed, 17 Apr 2024 23:44:04 -0700 (PDT)
Received: from [10.72.116.7] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001e2bb03893dsm737003plf.198.2024.04.17.23.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 23:44:03 -0700 (PDT)
Message-ID: <d206e1c7-34f8-434a-b690-dd43b9e92205@redhat.com>
Date: Thu, 18 Apr 2024 14:43:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfs : WARNING: possible circular locking dependency detected
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org,
 linux-kernel@vger.kernel.org
References: <a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com>
 <ZiCp2ArgSzjGQZql@dread.disaster.area>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <ZiCp2ArgSzjGQZql@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/18/24 13:04, Dave Chinner wrote:
> On Thu, Apr 18, 2024 at 11:39:25AM +0800, Xiubo Li wrote:
>> Hi all
>>
>> BTW, is this a known issue and has it been fixed already ? I can reproduce
>> this always with my VMs:
>>
>>
>> <4>[ 9009.171195]
>> <4>[ 9009.171205] ======================================================
>> <4>[ 9009.171208] WARNING: possible circular locking dependency detected
>> <4>[ 9009.171211] 6.9.0-rc3+ #49 Not tainted
>> <4>[ 9009.171214] ------------------------------------------------------
>> <4>[ 9009.171216] kswapd0/149 is trying to acquire lock:
>> <4>[ 9009.171219] ffff88811346a920 (&xfs_nondir_ilock_class){++++}-{4:4},
>> at: xfs_reclaim_inode+0x3ac/0x590 [xfs]
>> <4>[ 9009.171580]
>> <4>[ 9009.171580] but task is already holding lock:
>> <4>[ 9009.171583] ffffffff8bb33100 (fs_reclaim){+.+.}-{0:0}, at:
>> balance_pgdat+0x5d9/0xad0
>> <4>[ 9009.171593]
>> <4>[ 9009.171593] which lock already depends on the new lock.
>> <4>[ 9009.171593]
>> <4>[ 9009.171595]
>> <4>[ 9009.171595] the existing dependency chain (in reverse order) is:
>> <4>[ 9009.171597]
>> <4>[ 9009.171597] -> #1 (fs_reclaim){+.+.}-{0:0}:
>> <4>[ 9009.171603]        __lock_acquire+0x7da/0x1030
>> <4>[ 9009.171610]        lock_acquire+0x15d/0x400
>> <4>[ 9009.171614]        fs_reclaim_acquire+0xb5/0x100
>> <4>[ 9009.171618] prepare_alloc_pages.constprop.0+0xc5/0x230
>> <4>[ 9009.171622]        __alloc_pages+0x12a/0x3f0
>> <4>[ 9009.171625]        alloc_pages_mpol+0x175/0x340
>> <4>[ 9009.171630]        stack_depot_save_flags+0x4c5/0x510
>> <4>[ 9009.171635]        kasan_save_stack+0x30/0x40
>> <4>[ 9009.171640]        kasan_save_track+0x10/0x30
>> <4>[ 9009.171643]        __kasan_slab_alloc+0x83/0x90
>> <4>[ 9009.171646]        kmem_cache_alloc+0x15e/0x4a0
>> <4>[ 9009.171652]        __alloc_object+0x35/0x370
>> <4>[ 9009.171659]        __create_object+0x22/0x90
>> <4>[ 9009.171665] __kmalloc_node_track_caller+0x477/0x5b0
>> <4>[ 9009.171672]        krealloc+0x5f/0x110
>> <4>[ 9009.171679]        xfs_iext_insert_raw+0x4b2/0x6e0 [xfs]
>> <4>[ 9009.172172]        xfs_iext_insert+0x2e/0x130 [xfs]
> The only krealloc() in this path is:
>
> 	new = krealloc(ifp->if_data, new_size,
>                          GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
>
> And it explicitly uses __GFP_NOLOCKDEP to tell lockdep not to warn
> about this allocation because of this false positive situation.
>
> Oh. I've seen this before. This is a KASAN bug, and I'm pretty sure
> I've posted a patch to fix it a fair while back that nobody seemed
> to care about enough to review or merge it.
>
> That is: kasan_save_stack() is doing a fixed GFP_KERNEL allocation
> in an context where GFP_KERNEL allocations are known to generate
> lockdep false positives.  This occurs depsite the XFS and general
> memory allocation code doing exactly the right thing to avoid the
> lockdep false positives (i.e. using and obeying __GFP_NOLOCKDEP).
>
> The kasan code ends up in stack_depot_save_flags(), which does a
> GFP_KERNEL allocation but filters out __GFP_NOLOCKDEP and does not
> add it back. Hence kasan generates the false positive lockdep
> warnings, not the code doing the original allocation.
>
> kasan and/or stack_depot_save_flags() needs fixing here.

Hi Dave,

Thanks very much for your feedback.

BTW, do you have the link of your patch ? I can help test it.

Thanks

- Xiubo


> -Dave.


