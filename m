Return-Path: <linux-kernel+bounces-30887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B783258D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317782817DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEEC24B2C;
	Fri, 19 Jan 2024 08:17:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840AD50F;
	Fri, 19 Jan 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652241; cv=none; b=olh6BH2QsLQsMpQhZXsDajSt2DsR59T5Wh0BeDGeONwg7I/cGgguh9BBmKV0zzSP2AeMlwLTmj/nxg11WPpW+cj0NFd+pmQIPBBOBHsJPutbwFMmtn01BlZfXt9wUDsFO6G9eSKWBLDVOFYw3n3m7/4RyMI3F7ztlLCsO5X6hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652241; c=relaxed/simple;
	bh=fK4VruREjGzv4G2JJRe3w7i5qBgYFCIiHSzEs1R5aUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OETkj8136Fm82jnm3amm0U/FDVCYenIePtbrW3wMDb2ZJphDtyxUZP4y8hfsFIRYFfucq/M/Qwdp0l6QryaEmH46G2G6YEHUuwkkLOy+DOiO+iVR5LtArPJpDbSx0cx17mrnSrPp2COfDeMQzpuKhyA59ryw4NuHppDFisNipMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9940EC433F1;
	Fri, 19 Jan 2024 08:17:19 +0000 (UTC)
Message-ID: <f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
Date: Fri, 19 Jan 2024 09:17:17 +0100
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
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chenyuan,

On 28/12/2023 03:33, Yang, Chenyuan wrote:
> Hello,
> 
>  
> 
> We encountered 5 different crashes in the cec device by using our generated syscall specification for it, here are the descriptions of these 5 crashes and the related files are attached:
> 
> 1. KASAN: slab-use-after-free Read in cec_queue_msg_fh (Reproducible)
> 
> 2. WARNING: ODEBUG bug in cec_transmit_msg_fh
> 
> 3. WARNING in cec_data_cancel
> 
> 4. INFO: task hung in cec_claim_log_addrs (Reproducible)
> 
> 5. general protection fault in cec_transmit_done_ts
> 
>  
> 
> For “KASAN: slab-use-after-free Read in cec_queue_msg_fh”, we attached a syzkaller program to reproduce it. This crash is caused by ` list_add_tail(&entry->list, &fh->msgs);`
> (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L224 <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L224>), which reads a
> variable freed by `kfree(fh);` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-api.c#L684
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-api.c#L684>). The reproducible program is a Syzkaller program, which can be executed following this document:
> https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md <https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md>.
> 
>  
> 
> For “WARNING: ODEBUG bug in cec_transmit_msg_fh”, unfortunately we failed to reproduce it but we indeed trigger this crash almost every time when we fuzz the cec device only. We attached the report
> and log for this bug. It tries freeing an active object by using `kfree(data);` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L930
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L930>).
> 
>  
> 
> For “WARNING in cec_data_cancel”, it is an internal warning used in cec_data_cancel (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L365
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L365>), which checks whether the transmit is the current or pending. Unfortunately, we also don't have the
> reproducible program for this bug, but we attach the report and log.
> 
>  
> 
> For “INFO: task hung in cec_claim_log_addrs”, the kernel hangs when the cec device ` wait_for_completion(&adap->config_completion);`
> (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L1579 <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L1579>). We have a
> reproducible C program for this.
> 
>  
> 
> For “general protection fault in cec_transmit_done_ts”, the cec device tries derefencing a non-canonical address 0xdffffc00000000e0: 0000 [#1], which is related to the invocation `
> cec_transmit_attempt_done_ts ` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L697
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L697>). It seems that the address of cec_adapter is totally wrong. We do not have a reproducible program for this
> bug, but the log and report for it are attached.
> 
>  
> 
> If you have any questions or require more information, please feel free to contact us.

Can you retest with the patch below? I'm fairly certain this will fix issues 1 and 2.
I suspect at least some of the others are related to 1 & 2, but since I could never
get the reproducers working reliably, I had a hard time determining if there are more
bugs or if this patch resolves everything.

Your help testing this patch will be appreciated!

Regards,

	Hans

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/cec/core/cec-adap.c | 3 +--
 drivers/media/cec/core/cec-api.c  | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 5741adf09a2e..079c3b142d91 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -936,8 +936,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	 */
 	mutex_unlock(&adap->lock);
 	wait_for_completion_killable(&data->c);
-	if (!data->completed)
-		cancel_delayed_work_sync(&data->work);
+	cancel_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);

 	/* Cancel the transmit if it was interrupted */
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 67dc79ef1705..d64bb716f9c6 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
 		list_del_init(&data->xfer_list);
 	}
 	mutex_unlock(&adap->lock);
+
+	mutex_lock(&fh->lock);
 	while (!list_empty(&fh->msgs)) {
 		struct cec_msg_entry *entry =
 			list_first_entry(&fh->msgs, struct cec_msg_entry, list);
@@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
 			kfree(entry);
 		}
 	}
+	mutex_unlock(&fh->lock);
 	kfree(fh);

 	cec_put_device(devnode);
-- 
2.42.0



