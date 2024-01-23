Return-Path: <linux-kernel+bounces-34860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19AD83886F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E3A285E97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2C55E6E;
	Tue, 23 Jan 2024 08:02:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AC56452;
	Tue, 23 Jan 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996928; cv=none; b=KElrEww/SM/g0n982n3NO1PbLMlwDzyq2Kx4HHjQgy3/MZ/jOGZW4/sB/nHUync1f53ph2Lj+m87E2Z4Ru/6cTGldZEFz/nUZMNtVUt4xWBnzHjPSirdQP2Kb5sR3llVisX98MvDvaU3hLRvmlKlkEDMiQI+pc8jXF3PaHTDdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996928; c=relaxed/simple;
	bh=Xi2X6fEyKmPQ+qFx1ws84yReMbGJGwWzGRLzGdmoUzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQltJoNTwGYm1BA2mJiBkAQeYeMrytLibAFpntozb4MYJqWd4epxF7d7U8xisp1mnnulGguJJx/+dx5wOcCPgsAeacfQskbafyae2QhZpCj7gbv7QT6/9GCTFqMg0CqUHt3NTfZBP7jIF8Fm2qh8KPsQwcx4miooBaqnUkm4waw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2A8C433C7;
	Tue, 23 Jan 2024 08:02:05 +0000 (UTC)
Message-ID: <382c37c0-15c1-48ad-a8d0-a6bc4bd7160a@xs4all.nl>
Date: Tue, 23 Jan 2024 09:02:03 +0100
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
To: "Yang, Chenyuan" <cy54@illinois.edu>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "jani.nikula@intel.com" <jani.nikula@intel.com>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "Zhao, Zijie"
 <zijie4@illinois.edu>, "Zhang, Lingming" <lingming@illinois.edu>
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
 <f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
 <89FAADA9-D4EC-4C27-9F8F-1D86B7416DE1@illinois.edu>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <89FAADA9-D4EC-4C27-9F8F-1D86B7416DE1@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/01/2024 20:11, Yang, Chenyuan wrote:
> Hi Hans,
> 
> Thank you very much for providing the patch!
> 
> After running the reproducible programs and 24-hour fuzzing, it seems that this patch could fix the issues 1, 2, 3 and 5.

Ah, that's good news.

> 
> The 4th issue, "INFO: task hung in cec_claim_log_addrs", is still triggered after applying the patch.

I'll dig a bit deeper into this one, see if I can figure out the cause.

Thank you for your help in testing this!

Regards,

	Hans

> 
> If you need more information, feel free to let met know.
> 
> Best,
> Chenyuan
> 
> ﻿On 1/19/24, 2:17 AM, "Hans Verkuil" <hverkuil-cisco@xs4all.nl> wrote:
> 
>     Hi Chenyuan,
> 
>     On 28/12/2023 03:33, Yang, Chenyuan wrote:
>     > Hello,
>     > 
>     >  
>     > 
>     > We encountered 5 different crashes in the cec device by using our generated syscall specification for it, here are the descriptions of these 5 crashes and the related files are attached:
>     > 
>     > 1. KASAN: slab-use-after-free Read in cec_queue_msg_fh (Reproducible)
>     > 
>     > 2. WARNING: ODEBUG bug in cec_transmit_msg_fh
>     > 
>     > 3. WARNING in cec_data_cancel
>     > 
>     > 4. INFO: task hung in cec_claim_log_addrs (Reproducible)
>     > 
>     > 5. general protection fault in cec_transmit_done_ts
>     > 
>     >  
>     > 
>     > For “KASAN: slab-use-after-free Read in cec_queue_msg_fh”, we attached a syzkaller program to reproduce it. This crash is caused by ` list_add_tail(&entry->list, &fh->msgs);`
>     > (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L224__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxZMf3fVQ$  <https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L224__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxZMf3fVQ$ >), which reads a
>     > variable freed by `kfree(fh);` (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-api.c*L684__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxT0xaxsY$ 
>     > <https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-api.c*L684__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxT0xaxsY$ >). The reproducible program is a Syzkaller program, which can be executed following this document:
>     > https://urldefense.com/v3/__https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md__;!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZx32PwCDs$  <https://urldefense.com/v3/__https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md__;!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZx32PwCDs$ >.
>     > 
>     >  
>     > 
>     > For “WARNING: ODEBUG bug in cec_transmit_msg_fh”, unfortunately we failed to reproduce it but we indeed trigger this crash almost every time when we fuzz the cec device only. We attached the report
>     > and log for this bug. It tries freeing an active object by using `kfree(data);` (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L930__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxhwnuzFw$ 
>     > <https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L930__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxhwnuzFw$ >).
>     > 
>     >  
>     > 
>     > For “WARNING in cec_data_cancel”, it is an internal warning used in cec_data_cancel (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L365__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxJ9Jw4fU$ 
>     > <https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L365__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxJ9Jw4fU$ >), which checks whether the transmit is the current or pending. Unfortunately, we also don't have the
>     > reproducible program for this bug, but we attach the report and log.
>     > 
>     >  
>     > 
>     > For “INFO: task hung in cec_claim_log_addrs”, the kernel hangs when the cec device ` wait_for_completion(&adap->config_completion);`
>     > (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L1579__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxKP44OE0$  <https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L1579__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxKP44OE0$ >). We have a
>     > reproducible C program for this.
>     > 
>     >  
>     > 
>     > For “general protection fault in cec_transmit_done_ts”, the cec device tries derefencing a non-canonical address 0xdffffc00000000e0: 0000 [#1], which is related to the invocation `
>     > cec_transmit_attempt_done_ts ` (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L697__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxGnBFZv0$ 
>     > <https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c*L697__;Iw!!DZ3fjg!9_O4Tm7W1dKV8lXOcDFUTmIqAd6eUmsffQg3gwvypxBR3WFuQkIlRr2vAsIpwMt7lt86UlzdOTV_jBaVO8pkIiZxGnBFZv0$ >). It seems that the address of cec_adapter is totally wrong. We do not have a reproducible program for this
>     > bug, but the log and report for it are attached.
>     > 
>     >  
>     > 
>     > If you have any questions or require more information, please feel free to contact us.
> 
>     Can you retest with the patch below? I'm fairly certain this will fix issues 1 and 2.
>     I suspect at least some of the others are related to 1 & 2, but since I could never
>     get the reproducers working reliably, I had a hard time determining if there are more
>     bugs or if this patch resolves everything.
> 
>     Your help testing this patch will be appreciated!
> 
>     Regards,
> 
>     	Hans
> 
>     Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     ---
>      drivers/media/cec/core/cec-adap.c | 3 +--
>      drivers/media/cec/core/cec-api.c  | 3 +++
>      2 files changed, 4 insertions(+), 2 deletions(-)
> 
>     diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
>     index 5741adf09a2e..079c3b142d91 100644
>     --- a/drivers/media/cec/core/cec-adap.c
>     +++ b/drivers/media/cec/core/cec-adap.c
>     @@ -936,8 +936,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
>      	 */
>      	mutex_unlock(&adap->lock);
>      	wait_for_completion_killable(&data->c);
>     -	if (!data->completed)
>     -		cancel_delayed_work_sync(&data->work);
>     +	cancel_delayed_work_sync(&data->work);
>      	mutex_lock(&adap->lock);
> 
>      	/* Cancel the transmit if it was interrupted */
>     diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
>     index 67dc79ef1705..d64bb716f9c6 100644
>     --- a/drivers/media/cec/core/cec-api.c
>     +++ b/drivers/media/cec/core/cec-api.c
>     @@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
>      		list_del_init(&data->xfer_list);
>      	}
>      	mutex_unlock(&adap->lock);
>     +
>     +	mutex_lock(&fh->lock);
>      	while (!list_empty(&fh->msgs)) {
>      		struct cec_msg_entry *entry =
>      			list_first_entry(&fh->msgs, struct cec_msg_entry, list);
>     @@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
>      			kfree(entry);
>      		}
>      	}
>     +	mutex_unlock(&fh->lock);
>      	kfree(fh);
> 
>      	cec_put_device(devnode);
>     -- 
>     2.42.0
> 
> 
> 


