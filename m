Return-Path: <linux-kernel+bounces-123251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A0A890526
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5E11F27C17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DA12F399;
	Thu, 28 Mar 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QiXC52ON"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482A54673;
	Thu, 28 Mar 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643191; cv=none; b=a38dEIHZUnzeghVHZ1roEUpNPGT1q8t5SBL6X1oNFll7VCWQzb3jQ+m9ljaLO78GYSUPipqKmo9MlZN00zDWtmGLWlRJlCqgZ7mqJ38qSS0Nn4QEDUwIiqibg1ROMtVV+Sfn82pAZlSEJtuZUYv3ImioBrOWWzuMnDauBvZc75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643191; c=relaxed/simple;
	bh=UmScTq88cfl53jM8TjrVTFJdvXguvHkEnLR4nuT+0No=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i3m2F0D0XlHDeBnS0e5a8BM0Q6VD/21RxhCcpmE5ryfcZR31uEafcQcU9RD5rMerk14rcyLQ2fZUyJYGPw9oHpURPnVGKVdJViHLkrJe68ZAtk9HEHpEBb8CyMDabcfLcjyItYDC6B48FL7/XzAQ4cnLo3GB4kUYYRA0GFjwW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QiXC52ON; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SGQP16000815;
	Thu, 28 Mar 2024 11:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711643185;
	bh=hei07kTCLYDyZkCWh+ZyvIX04hDPX4vnUAD923iYyHE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QiXC52ONf8qYZL3aD0uqFVA0EWBVBoYHICQpJRfRuyCmJEYkItQu44SzJf8zY9EKh
	 nRbFSfLO25LTaqsOi5TxRN7IybIgIUeQbSRc6WXMCvjwU5uvWS7vN6Iz4YQHKkhnUM
	 DielPA40UNCLLGXMcJ7khTb0Hl/QYt2t+LkxIyO0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SGQPZg078449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 11:26:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 11:26:24 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 11:26:24 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SGQOID033455;
	Thu, 28 Mar 2024 11:26:24 -0500
Message-ID: <0697211f-4a28-4a74-8540-840c075d513c@ti.com>
Date: Thu, 28 Mar 2024 11:26:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] remoteproc: k3-dsp: Fix usage of omap_mbox_message
 and mbox_msg_t
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240325165808.31885-1-afd@ti.com> <ZgWMi088/zORh0m3@p14s>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <ZgWMi088/zORh0m3@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/28/24 10:28 AM, Mathieu Poirier wrote:
> Hi Andrew,
> 
> On Mon, Mar 25, 2024 at 11:58:06AM -0500, Andrew Davis wrote:
>> The type of message sent using omap-mailbox is always u32. The definition
>> of mbox_msg_t is uintptr_t which is wrong as that type changes based on
>> the architecture (32bit vs 64bit). Use u32 unconditionally and remove
>> the now unneeded omap-mailbox.h include.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/remoteproc/ti_k3_dsp_remoteproc.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>> index 3555b535b1683..33b30cfb86c9d 100644
>> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>> @@ -11,7 +11,6 @@
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_reserved_mem.h>
>> -#include <linux/omap-mailbox.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/remoteproc.h>
>>   #include <linux/reset.h>
>> @@ -113,7 +112,7 @@ static void k3_dsp_rproc_mbox_callback(struct mbox_client *client, void *data)
>>   						  client);
>>   	struct device *dev = kproc->rproc->dev.parent;
>>   	const char *name = kproc->rproc->name;
>> -	u32 msg = omap_mbox_message(data);
>> +	u32 msg = (u32)(uintptr_t)(data);
>>   
> 
> Looking at omap-mailbox.h and unless I'm missing something, the end result is
> the same.
> 
> 
>>   	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
>>   
>> @@ -152,11 +151,11 @@ static void k3_dsp_rproc_kick(struct rproc *rproc, int vqid)
>>   {
>>   	struct k3_dsp_rproc *kproc = rproc->priv;
>>   	struct device *dev = rproc->dev.parent;
>> -	mbox_msg_t msg = (mbox_msg_t)vqid;
>> +	u32 msg = vqid;
>>   	int ret;
>>
> 
> Here @vqid becomes a 'u32' rather than a 'uintptr'...
> 

u32 is the correct type for messages sent with OMAP mailbox. It
only sends 32bit messages, uintptr is 64bit when compiled on
64bit hardware (like our ARM64 cores on K3). mbox_msg_t should
have been defined as u32, this was a mistake we missed as we only
ever used to compile it for 32bit cores (where uintptr is 32bit).

>>   	/* send the index of the triggered virtqueue in the mailbox payload */
>> -	ret = mbox_send_message(kproc->mbox, (void *)msg);
>> +	ret = mbox_send_message(kproc->mbox, (void *)(uintptr_t)msg);
> 
> ... but here it is casted as a 'uintptr_t', which yields the same result.
> 

The function mbox_send_message() takes a void*, so we need to cast our 32bit
message to that first, it is cast back to u32 inside the OMAP mailbox driver.
Doing that in one step (u32 -> void*) causes a warning when void* is 64bit
(cast from int to pointer of different size).

> 
> I am puzzled - other than getting rid of a header file I don't see what else
> this patch does.
> 

Getting rid of the header is the main point of this patch (I have a later
series that needs that header gone). But the difference this patch makes is that
before we passed a pointer to a 64bit int to OMAP mailbox which takes a pointer
to a 32bit int. Sure, the result is the same in little-endian systems, but that
isn't a strictly correct in general.

Thanks,
Andrew

> Thanks,
> Mathieu
> 
>>   	if (ret < 0)
>>   		dev_err(dev, "failed to send mailbox message (%pe)\n",
>>   			ERR_PTR(ret));
>> -- 
>> 2.39.2
>>

