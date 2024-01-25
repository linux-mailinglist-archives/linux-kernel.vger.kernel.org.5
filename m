Return-Path: <linux-kernel+bounces-38398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7D83BEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF954B23E67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD91CD05;
	Thu, 25 Jan 2024 10:35:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314C1CAA5;
	Thu, 25 Jan 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178923; cv=none; b=TksjSyfP+UMppCYyP3YLpZLAaplQKt9+AKFAKuKJiTloJFYAimZMnr3H4r/YOZa/tNw7byTO9JXs0Jn8mEfRRu4AJ5DR9Np4W4wgMH4eSimsHcIAmNvoyVgXQd4WB8AN4Rsu6xZN99lww4e6lL4bkK4aGChYUrhPKD+rngMIDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178923; c=relaxed/simple;
	bh=1C0aCqfqyBTMwwnHrg5/KQ6WSYj5J+UY6F50mVDHc8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R23lRIXRBYucULLHO48WsykVQ3zbAm4+/ybjXmDmMqCG6k9UupUau3VopM6N2T7GhQeI4VWolA8Zb0FkMjAmciwHLeVd/Wu8vYCedZKwmihyy6rUOzy2lYacvqJIsjTpZvRA/ZW/gqZpvqB5WBDKMGyli1man7dYMFccccNjnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B03C433C7;
	Thu, 25 Jan 2024 10:35:21 +0000 (UTC)
Message-ID: <a0ba0375-a96e-4ab1-840e-a00d3133728e@xs4all.nl>
Date: Thu, 25 Jan 2024 11:35:19 +0100
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
 <89ED2612-DFEA-448A-9637-3522B9E92B74@illinois.edu>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <89ED2612-DFEA-448A-9637-3522B9E92B74@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chenyuan,

On 24/01/2024 14:33, Yang, Chenyuan wrote:
> Hi Hans,
> 
> Thanks for your prompt response!
> 
> After applying the new patch, the system hang issue persists. I also tested with the latest Linux version, but the problem remains. The error displayed is 'INFO: task syz-executor372:16736 blocked for more than 143 seconds.' Could it be that the timeout setting for the CEC is too extensive, contributing to this hang?

Again, thank you for testing this.

After investigation I suspect the issue is elsewhere.

Can you test with the patch below instead?

Thank you!

	Hans

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 079c3b142d91..e5c86bc5ed93 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1562,10 +1562,12 @@ static int cec_config_thread_func(void *arg)
 			cec_transmit_msg_fh(adap, &msg, NULL, false);
 		}
 	}
+	mutex_unlock(&adap->lock);
+	call_void_op(adap, configured);
+	mutex_lock(&adap->lock);
 	adap->kthread_config = NULL;
 	complete(&adap->config_completion);
 	mutex_unlock(&adap->lock);
-	call_void_op(adap, configured);
 	return 0;

 unconfigure:
@@ -1591,6 +1593,12 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 	if (WARN_ON(adap->is_configuring || adap->is_configured))
 		return;

+	if (adap->kthread_config) {
+		mutex_unlock(&adap->lock);
+		wait_for_completion(&adap->config_completion);
+		mutex_lock(&adap->lock);
+	}
+
 	init_completion(&adap->config_completion);

 	/* Ready to kick off the thread */
@@ -1598,8 +1606,8 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 	adap->kthread_config = kthread_run(cec_config_thread_func, adap,
 					   "ceccfg-%s", adap->name);
 	if (IS_ERR(adap->kthread_config)) {
-		adap->kthread_config = NULL;
 		adap->is_configuring = false;
+		adap->kthread_config = NULL;
 	} else if (block) {
 		mutex_unlock(&adap->lock);
 		wait_for_completion(&adap->config_completion);


