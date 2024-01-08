Return-Path: <linux-kernel+bounces-19150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028058268D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FFE1C20929
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0898C09;
	Mon,  8 Jan 2024 07:45:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DA8BED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-9bfT6_1704699918;
Received: from 30.221.132.24(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-9bfT6_1704699918)
          by smtp.aliyun-inc.com;
          Mon, 08 Jan 2024 15:45:19 +0800
Message-ID: <328501ae-828f-4aa8-baab-833573c010e7@linux.alibaba.com>
Date: Mon, 8 Jan 2024 15:45:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] mm: vmalloc: Remove global vmap_area_root
 rb-tree
To: Hillf Danton <hdanton@sina.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-5-urezki@gmail.com>
 <238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com>
 <ZZfe4O850fFaxOgQ@pc638.lan>
 <52766da2-41de-41ce-b60b-1118da343b8a@linux.alibaba.com>
 <20240107065942.3141-1-hdanton@sina.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240107065942.3141-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/7 14:59, Hillf Danton wrote:
> On Sat, 6 Jan 2024 17:36:23 +0100 Uladzislau Rezki <urezki@gmail.com>
>>>
>>> Thank you! I tried the patch, and it seems that the wait for rwlock_t
>>> also exists, as much as using spinlock_t. (The flamegraph is attached.
>>> Not sure why the read_lock waits so long, given that there is no frequent
>>> write_lock competition)
>>>
>>>                 vzalloced shmem(spinlock_t)   vzalloced shmem(rwlock_t)
>>> Requests/sec         583729.93                     460007.44
>>>
>>> So I guess the overhead in finding vmap area is inevitable here and the
>>> original spin_lock is fine in this series.
>>>
>> I have also noticed a erformance difference between rwlock and spinlock.
>> So, yes. This is what we need to do extra if CONFIG_HARDENED_USERCOPY is
>> set, i.e. find a VA.
> 
> See if read bias helps to understand the gap between spinlock and rwlock.
> 
> --- x/kernel/locking/qrwlock.c
> +++ y/kernel/locking/qrwlock.c
> @@ -23,7 +23,7 @@ void __lockfunc queued_read_lock_slowpat
>   	/*
>   	 * Readers come here when they cannot get the lock without waiting
>   	 */
> -	if (unlikely(in_interrupt())) {
> +	if (1) {
>   		/*
>   		 * Readers in interrupt context will get the lock immediately
>   		 * if the writer is just waiting (not holding the lock yet),

Thank you for the idea! Hillf.

IIUC, the change makes read operations more likely to acquire lock and
modified fairness to favor reading.

The test in my scenario shows:

vzalloced shmem with     spinlock_t      rwlock_t      rwlock_t(with above change)
Requests/sec              564961.29     442534.33     439733.31

In addition to read bias, there seems to be other factors that cause the
gap, but I haven't figured it out yet..

Thanks,
Wen Gu

