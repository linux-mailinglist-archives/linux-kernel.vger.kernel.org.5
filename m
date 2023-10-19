Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9C7CFB03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345850AbjJSNa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjJSNaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:30:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7836131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:30:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB7mF0lVhz6HJdH;
        Thu, 19 Oct 2023 21:26:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 14:30:18 +0100
Date:   Thu, 19 Oct 2023 14:30:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>, <linuxarm@huawei.com>
CC:     <suzuki.poulose@arm.com>, <james.clark@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/3] coresight: ultrasoc-smb: fix sleep while close
 preempt in enable_smb
Message-ID: <20231019142956.00005a3b@huawei.com>
In-Reply-To: <20231012094706.21565-2-hejunhao3@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
        <20231012094706.21565-2-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 17:47:04 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> When we to enable the SMB by perf, the perf sched will call perf_ctx_lock()
> to close system preempt in event_function_call(). But SMB::enable_smb() use
> mutex to lock the critical section, which may sleep.
> 
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 153023, name: perf
>  preempt_count: 2, expected: 0
>  RCU nest depth: 0, expected: 0
>  INFO: lockdep is turned off.
>  irq event stamp: 0
>  hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>  hardirqs last disabled at (0): [<ffffa2983f5c5f40>] copy_process+0xae8/0x2b48
>  softirqs last  enabled at (0): [<ffffa2983f5c5f40>] copy_process+0xae8/0x2b48
>  softirqs last disabled at (0): [<0000000000000000>] 0x0
>  CPU: 2 PID: 153023 Comm: perf Kdump: loaded Tainted: G   W  O   6.5.0-rc4+ #1
> 
>  Call trace:
>  ...
>   __mutex_lock+0xbc/0xa70
>   mutex_lock_nested+0x34/0x48
>   smb_update_buffer+0x58/0x360 [ultrasoc_smb]
>   etm_event_stop+0x204/0x2d8 [coresight]
>   etm_event_del+0x1c/0x30 [coresight]
>   event_sched_out+0x17c/0x3b8
>   group_sched_out.part.0+0x5c/0x208
>   __perf_event_disable+0x15c/0x210
>   event_function+0xe0/0x230
>   remote_function+0xb4/0xe8
>   generic_exec_single+0x160/0x268
>   smp_call_function_single+0x20c/0x2a0
>   event_function_call+0x20c/0x220
>   _perf_event_disable+0x5c/0x90
>   perf_event_for_each_child+0x58/0xc0
>   _perf_ioctl+0x34c/0x1250
>   perf_ioctl+0x64/0x98
> ...
> 
> Use spinlock replace mutex to control driver data access to one at a
> time. But the function copy_to_user() may sleep so spinlock do not to
> lock it.

I'd like to see a comment on why we no longer need to lock over the copy_to_user
rather than simply that we can't.

> 
> Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

A follow up patch could change a lot of this to use the new cleanup.h (don't want that
in the fix though as will make back porting trickier.).
That should let you do
guard(spin_lock)(&drvdata->spinlock);
and then use direct returns instead of goto complexity.



Jonathan

> @@ -132,10 +132,8 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>  	if (!len)
>  		return 0;
>  
> -	mutex_lock(&drvdata->mutex);
> -
>  	if (!sdb->data_size)
> -		goto out;
> +		return 0;
>  
>  	to_copy = min(sdb->data_size, len);
>  
> @@ -145,20 +143,18 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>  
>  	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
>  		dev_dbg(dev, "Failed to copy data to user\n");
> -		to_copy = -EFAULT;
> -		goto out;
> +		return -EFAULT;
>  	}
>  
> +	spin_lock(&drvdata->spinlock);
>  	*ppos += to_copy;
> -

Unrelated white space change that shouldn't be here.

>  	smb_update_read_ptr(drvdata, to_copy);
>  
> -	dev_dbg(dev, "%zu bytes copied\n", to_copy);
> -out:
>  	if (!sdb->data_size)
>  		smb_reset_buffer(drvdata);
> -	mutex_unlock(&drvdata->mutex);
> +	spin_unlock(&drvdata->spinlock);
>  
> +	dev_dbg(dev, "%zu bytes copied\n", to_copy);
>  	return to_copy;
>  }


