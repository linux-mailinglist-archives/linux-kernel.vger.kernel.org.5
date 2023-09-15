Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8927A1F04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjIOMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjIOMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:44:50 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB205D3;
        Fri, 15 Sep 2023 05:44:43 -0700 (PDT)
Received: from [192.168.42.133] (host-178-72-203-90.ip.nej.cz [178.72.203.90])
        by mx.gpxsee.org (Postfix) with ESMTPSA id A35BE326A6;
        Fri, 15 Sep 2023 14:44:41 +0200 (CEST)
Message-ID: <4b0fe0ec-79fd-42fc-afe8-c44eef471621@gpxsee.org>
Date:   Fri, 15 Sep 2023 14:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v9 1/2] Added Digiteq Automotive MGB4 driver
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20230912120745.902-1-tumic@gpxsee.org>
 <20230912120745.902-2-tumic@gpxsee.org>
 <c38400f8-6193-46b6-9e26-0094af6627ca@xs4all.nl>
From:   =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <c38400f8-6193-46b6-9e26-0094af6627ca@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 15. 09. 23 13:50, Hans Verkuil wrote:
> Hi Martin,
> 
> On 12/09/2023 14:07, tumic@gpxsee.org wrote:
>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>
>> Digiteq Automotive MGB4 is a modular frame grabber PCIe card for automotive
>> video interfaces. As for now, two modules - FPD-Link and GMSL - are
>> available and supported by the driver. The card has two inputs and two
>> outputs (FPD-Link only).
>>
>> In addition to the video interfaces it also provides a trigger signal
>> interface and a MTD interface for FPGA firmware upload.
>>
>> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
>> ---
> 
> <snip>
> 
>> +static ssize_t video_source_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct video_device *vdev = to_video_device(dev);
>> +	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
>> +	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
>> +	  voutdev->config->regs.config);
>> +
>> +	return sprintf(buf, "%u\n", (config & 0xc) >> 2);
>> +}
>> +
>> +static ssize_t video_source_store(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct video_device *vdev = to_video_device(dev);
>> +	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
>> +	struct mgb4_dev *mgbdev = voutdev->mgbdev;
>> +	struct mgb4_vin_dev *loopin_new = 0, *loopin_old = 0;
>> +	unsigned long val;
>> +	unsigned long flags_in[MGB4_VIN_DEVICES], flags_out[MGB4_VOUT_DEVICES];
>> +	ssize_t ret;
>> +	u32 config;
>> +	int i;
>> +
>> +	memset(flags_in, 0, sizeof(flags_in));
>> +	memset(flags_out, 0, sizeof(flags_out));
>> +
>> +	ret = kstrtoul(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +	if (val > 3)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < MGB4_VIN_DEVICES; i++)
>> +		if (mgbdev->vin[i])
>> +			spin_lock_irqsave(&mgbdev->vin[i]->vdev.fh_lock,
>> +					  flags_in[i]);
>> +	for (i = 0; i < MGB4_VOUT_DEVICES; i++)
>> +		if (mgbdev->vout[i])
>> +			spin_lock_irqsave(&mgbdev->vout[i]->vdev.fh_lock,
>> +					  flags_out[i]);
> 
> I missed this in my review: never use fh_lock, that's for internal use only.
> 
> Instead, use the vdev->lock mutex.
> 
>> +
>> +	ret = -EBUSY;
>> +	for (i = 0; i < MGB4_VIN_DEVICES; i++)
>> +		if (mgbdev->vin[i] && !list_empty(&mgbdev->vin[i]->vdev.fh_list))
>> +			goto error;
> 
> This is also wrong, the key moment at which such changes are no longer allowed
> is when you allocate buffers for the first time. Use vb2_is_busy() to detect that.
> 
>  From what I can see in the code most store functions operate on a single video device,
> so for those using mutex_lock_interruptible(vdev->lock) and vb2_is_busy() will do the
> trick.
> 

Ok, I will change the check to vb2_is_busy() under the vdev->lock for 
all the "standard" cases (which are all, except the video_source_store() 
case).

> For this store function that needs to check all devices it is more complicated.
> 
> I think the best approach would be to create a top-level field 'reconfig_in_progress'
> (or something along those lines), protected by a spinlock.
> 
> At the start this function will take the lock, check if reconfig is already in progress
> and just return EBUSY here. Otherwise it sets reconfig_in_progress to true and unlocks
> the lock.
> 
> After that for each video device you take the vdev->lock, check if vb2_is_busy() and
> unlock vdev->lock. If any is busy, then set reconfig_in_progress back to false and
> return EBUSY here.
> 
> To prevent another process from creating buffers, you have to check in the queue_setup
> functions if a reconfig is in progress and return EBUSY there.
> 
> This scheme avoids having to lock ALL video devices (bad practice), and it should
> also avoid this smatch warning.
> 

Ok, for this "ugly" one configuration I will add a PCIe device-based 
field and check it in all the v4l2 device's queue_setup() functions. 
Sounds better than locking all the devices at the same time.

Thanks for your help, I will send you a v10 with this two changes 
(together with the sparse/smatch fixes) soon.

M.

> Note: instead of using a spinlock I think you can also use test_and_set_bit: that's
> atomic and you can avoid adding a spinlock.
> 
> Regards,
> 
> 	Hans
> 
>> +	for (i = 0; i < MGB4_VOUT_DEVICES; i++)
>> +		if (mgbdev->vout[i] && !list_empty(&mgbdev->vout[i]->vdev.fh_list))
>> +			goto error;
>> +
>> +	config = mgb4_read_reg(&mgbdev->video, voutdev->config->regs.config);
>> +
>> +	if (((config & 0xc) >> 2) < MGB4_VIN_DEVICES)
>> +		loopin_old = mgbdev->vin[(config & 0xc) >> 2];
>> +	if (val < MGB4_VIN_DEVICES)
>> +		loopin_new = mgbdev->vin[val];
>> +	if (loopin_old && loopin_cnt(loopin_old) == 1)
>> +		mgb4_mask_reg(&mgbdev->video, loopin_old->config->regs.config,
>> +			      0x2, 0x0);
>> +	if (loopin_new)
>> +		mgb4_mask_reg(&mgbdev->video, loopin_new->config->regs.config,
>> +			      0x2, 0x2);
>> +
>> +	if (val == voutdev->config->id + MGB4_VIN_DEVICES)
>> +		mgb4_write_reg(&mgbdev->video, voutdev->config->regs.config,
>> +			       config & ~(1 << 1));
>> +	else
>> +		mgb4_write_reg(&mgbdev->video, voutdev->config->regs.config,
>> +			       config | (1U << 1));
>> +
>> +	mgb4_mask_reg(&mgbdev->video, voutdev->config->regs.config, 0xc,
>> +		      val << 2);
>> +
>> +	ret = count;
>> +
>> +error:
>> +	for (i = MGB4_VOUT_DEVICES - 1; i >= 0; i--)
>> +		if (mgbdev->vout[i])
>> +			spin_unlock_irqrestore(&mgbdev->vout[i]->vdev.fh_lock,
>> +					       flags_out[i]);
>> +	for (i = MGB4_VIN_DEVICES - 1; i >= 0; i--)
>> +		if (mgbdev->vin[i])
>> +			spin_unlock_irqrestore(&mgbdev->vin[i]->vdev.fh_lock,
>> +					       flags_in[i]);
>> +
>> +	return ret;
>> +}
> 

