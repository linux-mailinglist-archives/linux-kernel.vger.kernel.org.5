Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F87D1B82
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJUHZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:25:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B56D65
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 00:25:13 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SCCYJ6GSYzNmNP;
        Sat, 21 Oct 2023 15:21:08 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 21 Oct 2023 15:25:09 +0800
Subject: Re: [PATCH 1/3] coresight: ultrasoc-smb: fix sleep while close
 preempt in enable_smb
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <linuxarm@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
 <20231012094706.21565-2-hejunhao3@huawei.com>
 <20231019142956.00005a3b@huawei.com>
CC:     <suzuki.poulose@arm.com>, <james.clark@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <2f6c2af0-b867-5be5-ed37-c5d71b1ed1ce@huawei.com>
Date:   Sat, 21 Oct 2023 15:25:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20231019142956.00005a3b@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.218]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,


On 2023/10/19 21:30, Jonathan Cameron wrote:
> On Thu, 12 Oct 2023 17:47:04 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
>
>> When we to enable the SMB by perf, the perf sched will call perf_ctx_lock()
>> to close system preempt in event_function_call(). But SMB::enable_smb() use
>> mutex to lock the critical section, which may sleep.
>>
>>   BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
>>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 153023, name: perf
>>   preempt_count: 2, expected: 0
>>   RCU nest depth: 0, expected: 0
>>   INFO: lockdep is turned off.
>>   irq event stamp: 0
>>   hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>>   hardirqs last disabled at (0): [<ffffa2983f5c5f40>] copy_process+0xae8/0x2b48
>>   softirqs last  enabled at (0): [<ffffa2983f5c5f40>] copy_process+0xae8/0x2b48
>>   softirqs last disabled at (0): [<0000000000000000>] 0x0
>>   CPU: 2 PID: 153023 Comm: perf Kdump: loaded Tainted: G   W  O   6.5.0-rc4+ #1
>>
>>   Call trace:
>>   ...
>>    __mutex_lock+0xbc/0xa70
>>    mutex_lock_nested+0x34/0x48
>>    smb_update_buffer+0x58/0x360 [ultrasoc_smb]
>>    etm_event_stop+0x204/0x2d8 [coresight]
>>    etm_event_del+0x1c/0x30 [coresight]
>>    event_sched_out+0x17c/0x3b8
>>    group_sched_out.part.0+0x5c/0x208
>>    __perf_event_disable+0x15c/0x210
>>    event_function+0xe0/0x230
>>    remote_function+0xb4/0xe8
>>    generic_exec_single+0x160/0x268
>>    smp_call_function_single+0x20c/0x2a0
>>    event_function_call+0x20c/0x220
>>    _perf_event_disable+0x5c/0x90
>>    perf_event_for_each_child+0x58/0xc0
>>    _perf_ioctl+0x34c/0x1250
>>    perf_ioctl+0x64/0x98
>> ...
>>
>> Use spinlock replace mutex to control driver data access to one at a
>> time. But the function copy_to_user() may sleep so spinlock do not to
>> lock it.
> I'd like to see a comment on why we no longer need to lock over the copy_to_user
> rather than simply that we can't.

Yes, I will do that.

>> Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> A follow up patch could change a lot of this to use the new cleanup.h (don't want that
> in the fix though as will make back porting trickier.).
> That should let you do
> guard(spin_lock)(&drvdata->spinlock);
> and then use direct returns instead of goto complexity.
>
>
>
> Jonathan

Thanks for sharing.
I will append up a new patch to use guards to reduce gotos.

>
>> @@ -132,10 +132,8 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>>   	if (!len)
>>   		return 0;
>>   
>> -	mutex_lock(&drvdata->mutex);
>> -
>>   	if (!sdb->data_size)
>> -		goto out;
>> +		return 0;
>>   
>>   	to_copy = min(sdb->data_size, len);
>>   
>> @@ -145,20 +143,18 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>>   
>>   	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
>>   		dev_dbg(dev, "Failed to copy data to user\n");
>> -		to_copy = -EFAULT;
>> -		goto out;
>> +		return -EFAULT;
>>   	}
>>   
>> +	spin_lock(&drvdata->spinlock);
>>   	*ppos += to_copy;
>> -
> Unrelated white space change that shouldn't be here.

Ok, i will drop this white space



Thanks for the comments!

Best regards,
Junhao.

>
>>   	smb_update_read_ptr(drvdata, to_copy);
>>   
>> -	dev_dbg(dev, "%zu bytes copied\n", to_copy);
>> -out:
>>   	if (!sdb->data_size)
>>   		smb_reset_buffer(drvdata);
>> -	mutex_unlock(&drvdata->mutex);
>> +	spin_unlock(&drvdata->spinlock);
>>   
>> +	dev_dbg(dev, "%zu bytes copied\n", to_copy);
>>   	return to_copy;
>>   }
>
> .
>

