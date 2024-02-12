Return-Path: <linux-kernel+bounces-61834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59075851738
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87851F2260B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EDC3BB28;
	Mon, 12 Feb 2024 14:42:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489A39FD7;
	Mon, 12 Feb 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748964; cv=none; b=lEfcbOXg9/4Um6ghff96z77ZipEjpwuGtckfKXlT4nXBeiDdqDmtIaNRi4gR/yE05x8r/CtoE6lzxAwk1zCToo0gUeYcpY7KruZxe33zD0tiake1LhmisOi6WbpOJdREu3ARPQosBWgQr7K4gcLz2OlvWlBAdnzPheoOUEudZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748964; c=relaxed/simple;
	bh=/Hf+DbrJyyiXo/DYirJXw3aIfv42g2EBeTeWIWBCGCE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EaJcDgKc0s7rcubhfyHGtWQ4YRvsFxdzDKkMiJ2SfWX5ZN6INJb1a5WG1PhPoJPDRnvOYe30VyIkFn4lnh0yvnDx3an4BXx6qGPU3Q3n5rq5B0O3LOtHKb7CYKZ4QeW5jFLbxK+me0gyG0bQv/LkcwD9wyVJIbXUG6IBVoV5Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF32C433F1;
	Mon, 12 Feb 2024 14:42:41 +0000 (UTC)
Message-ID: <2e5f1e92-7fad-4a74-b375-1e194ff08ce6@xs4all.nl>
Date: Mon, 12 Feb 2024 15:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: "Yang, Chenyuan" <cy54@illinois.edu>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "jani.nikula@intel.com" <jani.nikula@intel.com>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "Zhao, Zijie"
 <zijie4@illinois.edu>, "Zhang, Lingming" <lingming@illinois.edu>
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
 <f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
 <526380BE-57AC-493D-A7B0-B8F0ECC0FE0A@illinois.edu>
 <f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
In-Reply-To: <f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chenyuan,

On 30/01/2024 15:35, Hans Verkuil wrote:
> On 29/01/2024 04:03, Yang, Chenyuan wrote:
>> Hi Hans,
>>
>> Thanks a lot for this new patch!
>>
>> After applying this new patch in the latest kernel (hash: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7) and fuzzing with Syzkaller, it seems that the hang still exists.
>> To help you better debug it, I attached the covered lines for the fuzz testing and the output of `git diff`. Hope this could help you.
>>
>> By the way, the syscall descriptions for CEC have been merged into the Syzkaller mainstream: https://github.com/google/syzkaller/blob/master/sys/linux/dev_cec.txt.
>>
>> Let me know if you need further information.
>>
>> Best,
>> Chenyuan
> 
> Here is another patch. This now time outs on all wait_for_completion calls
> and reports a WARN_ON and shows additional info. Hopefully this will give me
> better insight into what is going on.
> 
> Unfortunately I was unable to reproduce this issue on my VM, so I have to
> rely on you to run the test.

Did you have time to run the test with this patch? It would be very useful to
see the results.

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 
> [PATCH] Test
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
> index 5741adf09a2e..b1951eb7f5bd 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -935,9 +935,12 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
>  	 * Release the lock and wait, retake the lock afterwards.
>  	 */
>  	mutex_unlock(&adap->lock);
> -	wait_for_completion_killable(&data->c);
> -	if (!data->completed)
> -		cancel_delayed_work_sync(&data->work);
> +	if (WARN_ON(wait_for_completion_killable_timeout(&data->c, msecs_to_jiffies(adap->xfer_timeout_ms + 1000)) <= 0)) {
> +		dprintk(0, "wfc1: %px %d%d%d%d %x\n", adap->kthread_config,
> +			adap->is_configuring, adap->is_configured,
> +			adap->is_enabled, adap->must_reconfigure, adap->phys_addr);
> +	}
> +	cancel_delayed_work_sync(&data->work);
>  	mutex_lock(&adap->lock);
> 
>  	/* Cancel the transmit if it was interrupted */
> @@ -1563,10 +1566,12 @@ static int cec_config_thread_func(void *arg)
>  			cec_transmit_msg_fh(adap, &msg, NULL, false);
>  		}
>  	}
> +	mutex_unlock(&adap->lock);
> +    call_void_op(adap, configured);
> +    mutex_lock(&adap->lock);
>  	adap->kthread_config = NULL;
>  	complete(&adap->config_completion);
>  	mutex_unlock(&adap->lock);
> -	call_void_op(adap, configured);
>  	return 0;
> 
>  unconfigure:
> @@ -1592,6 +1597,17 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>  	if (WARN_ON(adap->is_configuring || adap->is_configured))
>  		return;
> 
> +	if (adap->kthread_config) {
> +		mutex_unlock(&adap->lock);
> +//		wait_for_completion(&adap->config_completion);
> +		if (WARN_ON(wait_for_completion_killable_timeout(&adap->config_completion, msecs_to_jiffies(10000)) <= 0)) {
> +			dprintk(0, "wfc2: %px %d%d%d%d %x\n", adap->kthread_config,
> +				adap->is_configuring, adap->is_configured,
> +				adap->is_enabled, adap->must_reconfigure, adap->phys_addr);
> +		}
> +		mutex_lock(&adap->lock);
> +	}
> +
>  	init_completion(&adap->config_completion);
> 
>  	/* Ready to kick off the thread */
> @@ -1599,11 +1615,17 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>  	adap->kthread_config = kthread_run(cec_config_thread_func, adap,
>  					   "ceccfg-%s", adap->name);
>  	if (IS_ERR(adap->kthread_config)) {
> -		adap->kthread_config = NULL;
>  		adap->is_configuring = false;
> +		adap->kthread_config = NULL;
>  	} else if (block) {
>  		mutex_unlock(&adap->lock);
> -		wait_for_completion(&adap->config_completion);
> +		//wait_for_completion(&adap->config_completion);
> +		if (WARN_ON(wait_for_completion_killable_timeout(&adap->config_completion, msecs_to_jiffies(10000)) <= 0)) {
> +			dprintk(0, "wfc3: %px %d%d%d%d %x\n", adap->kthread_config,
> +				adap->is_configuring, adap->is_configured,
> +				adap->is_enabled, adap->must_reconfigure, adap->phys_addr);
> +
> +		}
>  		mutex_lock(&adap->lock);
>  	}
>  }
> diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
> index 67dc79ef1705..d64bb716f9c6 100644
> --- a/drivers/media/cec/core/cec-api.c
> +++ b/drivers/media/cec/core/cec-api.c
> @@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
>  		list_del_init(&data->xfer_list);
>  	}
>  	mutex_unlock(&adap->lock);
> +
> +	mutex_lock(&fh->lock);
>  	while (!list_empty(&fh->msgs)) {
>  		struct cec_msg_entry *entry =
>  			list_first_entry(&fh->msgs, struct cec_msg_entry, list);
> @@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
>  			kfree(entry);
>  		}
>  	}
> +	mutex_unlock(&fh->lock);
>  	kfree(fh);
> 
>  	cec_put_device(devnode);
> 


