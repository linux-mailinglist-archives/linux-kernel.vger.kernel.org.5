Return-Path: <linux-kernel+bounces-167734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338528BAE3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE76283693
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8672156873;
	Fri,  3 May 2024 13:55:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFA1553B6;
	Fri,  3 May 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744522; cv=none; b=tSZh4oVmPGtdi6zLcOeNiVkxpS3/vlzgws2nd8TkXip6v/kNCOTdhU4BtUgnnMUOdrcVr4z4WJb57Ocjs9ix9XleEM0vB530X5077YvUrmvWhIh10IWwijCeY2ZOAqasCOfdhPd+MF48feRjU0kthmsKcFyAGVuIrGqHA0XrIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744522; c=relaxed/simple;
	bh=mQ7rwau1oDV5A4WNzkBiLOPJh5dE2V4laWMjle9rIb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UG2tCqLLkL1P2H3GZ+LQ4+qOO8VHWkA2l0gyj4vG+/8ZZ3GziQenUwIlu9H+jJl+MtY/KxdcmRDNUfRhEQswM5+a8ROCxEn4fy2VtWH4Rd8nbnGT+LvZy9Nv3eUC7AiiAN4b/jCoUrLRijXcYW/FCcz6p7vsll282dAWkbPI73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E96B13D5;
	Fri,  3 May 2024 06:55:43 -0700 (PDT)
Received: from [10.1.39.24] (e133047.arm.com [10.1.39.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577DF3F73F;
	Fri,  3 May 2024 06:55:16 -0700 (PDT)
Message-ID: <a55e1bdc-7c6a-4720-b941-0ddfd764b87e@arm.com>
Date: Fri, 3 May 2024 14:55:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Ulf Hansson <ulf.hansson@linaro.org>, Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, ludovic.barre@st.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
 <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com>
 <3f69d64e-7c41-48de-a7a0-42ab99cd7e7d@intel.com>
 <CAKekbev6YG+yVnX-n9tsQSwujj5mD-vpJXrd+xwcF-K=z45q+w@mail.gmail.com>
 <CAPDyKFoE4+sQ3D-9SKtFcksQQ88GyYd_P88dVOj9SYyVFqLxig@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAPDyKFoE4+sQ3D-9SKtFcksQQ88GyYd_P88dVOj9SYyVFqLxig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/05/2024 14:09, Ulf Hansson wrote:
> On Fri, 26 Apr 2024 at 17:11, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>>
>> On Fri, Apr 26, 2024 at 2:17 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 25/04/24 19:18, Ulf Hansson wrote:
>>>> + Wolfram, Adrian (to see if they have some input)
>>>>
>>>> On Tue, 23 Apr 2024 at 22:02, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>>>>>
>>>>> When erase/trim/discard completion was converted to mmc_poll_for_busy(),
>>>>> optional ->card_busy() host ops support was added. sdhci card->busy()
>>>>> could return busy for long periods to cause mmc_do_erase() to block during
>>>>> discard operation as shown below during mkfs.f2fs :
>>>>>
>>>>> Info: [/dev/mmcblk1p9] Discarding device
>>>>> [   39.597258] sysrq: Show Blocked State
>>>>> [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tgid:1561  ppid:1542   flags:0x0000000d
>>>>> [   39.610609] Call trace:
>>>>> [   39.613098]  __switch_to+0xd8/0xf4
>>>>> [   39.616582]  __schedule+0x440/0x4f4
>>>>> [   39.620137]  schedule+0x2c/0x48
>>>>> [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
>>>>> [   39.628562]  schedule_hrtimeout_range+0x10/0x18
>>>>> [   39.633169]  usleep_range_state+0x5c/0x90
>>>>> [   39.637253]  __mmc_poll_for_busy+0xec/0x128
>>>>> [   39.641514]  mmc_poll_for_busy+0x48/0x70
>>>>> [   39.645511]  mmc_do_erase+0x1ec/0x210
>>>>> [   39.649237]  mmc_erase+0x1b4/0x1d4
>>>>> [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
>>>>> [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
>>>>> [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
>>>>> [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
>>>>> [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
>>>>> [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
>>>>> [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
>>>>> [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
>>>>> [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
>>>>> [   39.693539]  __submit_bio+0x1c/0x80
>>>>> [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
>>>>> [   39.701875]  submit_bio_noacct+0x1b0/0x22c
>>>>> [   39.706042]  submit_bio+0xac/0xe8
>>>>> [   39.709424]  blk_next_bio+0x4c/0x5c
>>>>> [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
>>>>> [   39.717835]  blkdev_common_ioctl+0x374/0x728
>>>>> [   39.722175]  blkdev_ioctl+0x8c/0x2b0
>>>>> [   39.725816]  vfs_ioctl+0x24/0x40
>>>>> [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
>>>>> [   39.733114]  invoke_syscall+0x68/0xec
>>>>> [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
>>>>> [   39.741609]  do_el0_svc+0x18/0x20
>>>>> [   39.744981]  el0_svc+0x68/0x94
>>>>> [   39.748107]  el0t_64_sync_handler+0x88/0x124
>>>>> [   39.752455]  el0t_64_sync+0x168/0x16c
>>>>
>>>> Thanks for the detailed log!
>>>>
>>>>>
>>>>> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
>>>>> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() function.
>>>>>
>>>>> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard")
>>>>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>>>>> ---
>>>>>  drivers/mmc/core/mmc_ops.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>>>> index 3b3adbddf664..603fbd78c342 100644
>>>>> --- a/drivers/mmc/core/mmc_ops.c
>>>>> +++ b/drivers/mmc/core/mmc_ops.c
>>>>> @@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>>>>>         u32 status = 0;
>>>>>         int err;
>>>>>
>>>>> -       if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
>>>>> +       if (data->busy_cmd != MMC_BUSY_IO &&
>>>>> +           data->busy_cmd != MMC_BUSY_ERASE && host->ops->card_busy) {
>>>>>                 *busy = host->ops->card_busy(host);
>>>>>                 return 0;
>>>>>         }
>>>>
>>>> So it seems like the ->card_busy() callback is broken in for your mmc
>>>> host-driver and platform. Can you perhaps provide the information
>>>> about what HW/driver you are using?
>>>>
>>
>> Using the sdhci-brcmstb driver on a Broadcom Settop based SoC.
>>
>>>> The point with using the ->card_busy() callback, is to avoid sending
>>>> the CMD13. Ideally it should be cheaper/faster and in most cases it
>>>> translates to a read of a register. For larger erases, we would
>>>> probably end up sending the CMD13 periodically every 32-64 ms, which
>>>> shouldn't be a problem. However, for smaller erases and discards, we
>>>> may want the benefit the ->card_busy() callback provides us.
>>>>
>>
>> I have tested two scenarios. One is like the mkfs.f2fs app that calls :
>> ioctl(fd, BLKSECDISCARD, &range);
>>
>> This has the following CMD and completion sequence:
>> {CMD35->CMD36->CMD38} and poll for  DAT0  signal via card->busy .
>> CMD38 has a response of R1b. The DAT0 (Busy line) will be driven by the device.
>> Busy (DAT0  = 0) is asserted by a device for  erasing blocks. Stays
>> busy in brcmstb sdhci controller.
> 
> How big is the "range"?
> 
> Just so I get this right, it stays busy and we are waiting for the
> timeout to fire? And ideally you think we should not be busy for that
> long, right?
> 
>>
>> With the additional change followed by CMD13 (response of R1), which
>> returns the device status, the
>> DAT0 will be pulled-up and next time we read the BUSY status it will
>> indicate it is not busy.
> 
> So you are referring to read the BUSY status with you ->card_busy()
> callback? Or did you actually verify that this is true from an
> electrical point of view, by monitoring the DAT0 signal?
> 
> If the latter, perhaps it's the card that is failing and simply
> requires CMD13 to be used to poll for busy. What card is this?
> 
> Have you tried different cards with the same platform/driver?
> 
>>
>> Also I tried the mmc util and that does not show the same issue with
>> exactly the same ranges, however in that case there are some
>> differences in the way the CMD sequence is sent for the entire discard
>> operation.
>> # mmc erase discard 0x000087a4 0x002effff /dev/mmcblk1
>> /* send erase cmd with multi-cmd */
>> ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>>
>> CMD35->CMD13->CMD36->CMD13->CMD38->CMD13
>> I do not see any hang in all the erase options discard, legacy, trim, trim2,
>> secure-trim used here with mmc util .
> 
> So CMD13 seems to do the trick for you. Although, I think we need to
> figure out if this a special "broken" card or if the problem is with
> the ->card_busy() implementation for your platform.
> 
>>
>> Also looking at JEDEC Standard No. 84-B51 Page 276, 277
>> "Once the erase groups are selected the host will send an ERASE
>> (CMD38) command. It is recom-
>> mended that the host terminates the sequence with a SEND_STATUS
>> (CMD13) to poll any additional
>> status information the Device may have (e.g., WP_ERASE_SKIP, etc.)."
> 
> Isn't that exactly what is being done? After the card has stopped
> signaling busy, we send a CMD13 in mmc_busy_cb() to read the
> additional status information.

Agreed with your interpretation FWIW.

> 
> I don't get it, why should the card stop signal busy, just because we
> send a CMD13. If so, the card should probably be considered broken.
> For broken cards, we can try to use a card-quirk instead - to enforce
> CMD13 polling.

I'll mention it here, I've seen some broken IP out there where the card's
FSM (including busy-signalling) was dependent on the host providing the
CLK, can't remember which one it was, though.
Anyway for Kamal, it might be interesting to know if your host controller
autostops the CLK (which it is allowed to) during the busy-signalling and
if not stopping it also works around the problem.

> [snip]

