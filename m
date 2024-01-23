Return-Path: <linux-kernel+bounces-35108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67010838C40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDED1F260DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98C5C8E9;
	Tue, 23 Jan 2024 10:39:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A695C8E3;
	Tue, 23 Jan 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006345; cv=none; b=tzcnucRWZRvyvUG4M6Ie1xJyUDrEK7DDD0SSTp1E0S7fL0/yzgm3yTAg95xVoU0AVqAKwde6GFn3bavVVrl9ThfUN+gyXgkGhLksXQmVIhIvRHhhLcTzp/GoIn4c/FjJ9wnCc0yOVutzSFRHnO745wKeRzfT+jxlGk4u6oQMXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006345; c=relaxed/simple;
	bh=ibWco0qwRsQhGlxe5LirL6XlKz9BmJx5hlGiH39HD2g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CBVHqis+m7oDrc+gQp51KEbDDgvcBadEQjP0jR2BXlpWYLoA2DLnSIwv+CzKM4JBPqavlZ0VSvOZvRU6cxAnYRIjnGv95Lcyjax4EFwPEX8AZBhwTQIV5K5vopBJ+WkDzCBZe6KOGgIMCOFeY5TeC/gdtSIhX4vzOaF+iqFVO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D97C433C7;
	Tue, 23 Jan 2024 10:39:02 +0000 (UTC)
Message-ID: <a67a75da-a506-48c4-ac5e-21d84cfae2e3@xs4all.nl>
Date: Tue, 23 Jan 2024 11:39:00 +0100
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
 <89FAADA9-D4EC-4C27-9F8F-1D86B7416DE1@illinois.edu>
 <382c37c0-15c1-48ad-a8d0-a6bc4bd7160a@xs4all.nl>
In-Reply-To: <382c37c0-15c1-48ad-a8d0-a6bc4bd7160a@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 09:02, Hans Verkuil wrote:
> On 22/01/2024 20:11, Yang, Chenyuan wrote:
>> Hi Hans,
>>
>> Thank you very much for providing the patch!
>>
>> After running the reproducible programs and 24-hour fuzzing, it seems that this patch could fix the issues 1, 2, 3 and 5.
> 
> Ah, that's good news.
> 
>>
>> The 4th issue, "INFO: task hung in cec_claim_log_addrs", is still triggered after applying the patch.
> 
> I'll dig a bit deeper into this one, see if I can figure out the cause.
> 
> Thank you for your help in testing this!

Can you do another testrun with this patch on top of the previous one?

Thank you!

Regards,

	Hans

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 079c3b142d91..7b5dcdf775cc 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -935,7 +935,8 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	 * Release the lock and wait, retake the lock afterwards.
 	 */
 	mutex_unlock(&adap->lock);
-	wait_for_completion_killable(&data->c);
+	wait_for_completion_killable_timeout(&data->c,
+				msecs_to_jiffies(adap->xfer_timeout_ms + 1000));
 	cancel_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);



