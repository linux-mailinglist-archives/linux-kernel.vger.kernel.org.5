Return-Path: <linux-kernel+bounces-10351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719E81D338
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADE61F22C51
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADB8F70;
	Sat, 23 Dec 2023 08:54:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB48F4E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Sxych5L5tz1fyhx;
	Sat, 23 Dec 2023 16:53:24 +0800 (CST)
Received: from kwepemi500024.china.huawei.com (unknown [7.221.188.100])
	by mail.maildlp.com (Postfix) with ESMTPS id ADCC6140259;
	Sat, 23 Dec 2023 16:54:40 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Dec 2023 16:54:39 +0800
Message-ID: <5ac8c272-6887-5406-50e3-7b87b302498d@huawei.com>
Date: Sat, 23 Dec 2023 16:54:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] locking/osq_lock: Avoid false sharing in
 optimistic_spin_node
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, "mingo@redhat.com"
	<mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com"
	<longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>
CC: "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>, "liwei391@huawei.com"
	<liwei391@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20231222121040.2635879-1-zengheng4@huawei.com>
 <9c48658677a6475eb4fe13baed798e97@AcuMS.aculab.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <9c48658677a6475eb4fe13baed798e97@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)


在 2023/12/22 20:40, David Laight 写道:
> From: Zeng Heng
>> Sent: 22 December 2023 12:11
>>
>> Using the UnixBench test suite, we clearly find that osq_lock() cause
>> extremely high overheads with perf tool in the File Copy items:
>>
>> Overhead  Shared Object            Symbol
>>    94.25%  [kernel]                 [k] osq_lock
>>     0.74%  [kernel]                 [k] rwsem_spin_on_owner
>>     0.32%  [kernel]                 [k] filemap_get_read_batch
>>
>> In response to this, we conducted an analysis and made some gains:
>>
>> In the prologue of osq_lock(), it set `cpu` member of percpu struct
>> optimistic_spin_node with the local cpu id, after that the value of the
>> percpu struct would never change in fact. Based on that, we can regard
>> the `cpu` member as a constant variable.
>>
> ...
>> @@ -9,7 +11,13 @@
>>   struct optimistic_spin_node {
>>   	struct optimistic_spin_node *next, *prev;
>>   	int locked; /* 1 if lock acquired */
>> -	int cpu; /* encoded CPU # + 1 value */
>> +
>> +	CACHELINE_PADDING(_pad1_);
>> +	/*
>> +	 * Stores an encoded CPU # + 1 value.
>> +	 * Only read by other cpus, so split into different cache lines.
>> +	 */
>> +	int cpu;
>>   };
> Isn't this structure embedded in every mutex and rwsem (etc)?
> So that is a significant bloat especially on systems with
> large cache lines.
>
> Did you try just moving the initialisation of the per-cpu 'node'
> below the first fast-path (uncontended) test in osq_lock()?
>
> OTOH if you really have multiple cpu spinning on the same rwsem
> perhaps the test and/or filemap code are really at fault!
>
> 	David

Hi，

The File Copy items of UnixBench testsuite are using 1 read file and 1 
write file

for file read/write/copy test. In multi-parallel scenario, that would 
lead to high

file lock contention.

That is just a performance test suite and has nothing to do with whether 
the user

program design is correct or not.


B.R.,

Zeng Heng


