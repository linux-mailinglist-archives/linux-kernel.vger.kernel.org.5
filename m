Return-Path: <linux-kernel+bounces-135311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D089BEBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C78F1C21537
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5FB6A8C1;
	Mon,  8 Apr 2024 12:16:27 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE06A33B;
	Mon,  8 Apr 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578585; cv=none; b=PIqg+67z3rO5qhxLe0BKxPfGCNCKyHEfZnK4EalcKuiaSs2xq7flzDFvkJgy2JZj3IkwIPVgIVLSXHTFUdGd0ZIig+XMOka0yOq+OBWEC3X3HVFNBzDVa1yT2Z7X2cS+E3YIiCXw3oNx3IwSXyU4mMUu1/0RT0d4ErhRzCiPHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578585; c=relaxed/simple;
	bh=7kyTgXF+l/D1yUkeDReKvPd+BApRODrhaVfvG8dm16U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eb3BXw7O3mD/ybPNmA8f5QuddDEuYYvFNmGVwsNp9OQdB7flFLHmSH+vxiGy+dNWXKDLhsUJ1F4WW9tDtQ2Dgok8li+I1vepQlVSI1E0NrC+wYxMyNJCd9V5mbCx4aC0bmgEauIPbrEGXGATr5LhEfrvriXk8E3lE7ODSvq/P+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from [192.168.4.14] (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id C3E1443C61;
	Mon,  8 Apr 2024 14:16:07 +0200 (CEST)
Message-ID: <c9525f1b-701a-4731-987a-43dbae51fa8c@gpxsee.org>
Date: Mon, 8 Apr 2024 14:16:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: mgb4: Fixed signal frame rate limit
 handling
To: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20240322151005.3499-1-tumic@gpxsee.org>
 <20240322151005.3499-4-tumic@gpxsee.org>
 <8a0cf515-e450-41b8-950c-4356f2fb9879@xs4all.nl>
Content-Language: en-US
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <8a0cf515-e450-41b8-950c-4356f2fb9879@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 08. 04. 24 12:47, Hans Verkuil wrote:
> On 22/03/2024 16:10, tumic@gpxsee.org wrote:
>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>
>> Properly document the function of the mgb4 output frame_rate sysfs parameter
>> and fix the corner case when the frame rate is set to zero causing a "divide
>> by zero" kernel panic.
> 
> This is mixing a fix and a documentation improvement into one patch. This
> should be split.
> 

Well, the "core" of the patch is really just the correct description 
what the "magic" frame_rate sysfs parameter really does. The code "just" 
adjusts the internal naming to better fit the real purpose of the parameter.

The remaining lines change the default timings parameters so that the 
default gives a correct "timings equation" without the need of 
"crippling" the signal using the frame rate limit. While the numbers are 
different, the outcome is the same - the defaults are still for the same 
default display (Škoda Octavia) as before, but the numbers make more 
sense (and the signal on the line is not "crippled")

> Also, shouldn't the fix be either part of the previous patch or come before
> that patch?
>

While "detected" when fiddling with the previous patch and "by name" it 
looks like it has something to do with it, in reality it is something 
different. In the V1 patch it was even send together with the 
V4L2_CAP_TIMEPERFRAME patch but I have then explicitly splitted it to 
make clear it is something different. This change (and our "magic" 
frame_rate sysfs parameter) affects the signal on the line while the 
V4L2_CAP_TIMEPERFRAME is about the frame rate the user uses to provide 
the frames to the card and should be a standard v4l2 mechanism.

M.

>>
>> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
>> ---
>>   Documentation/admin-guide/media/mgb4.rst |  8 ++++++--
>>   drivers/media/pci/mgb4/mgb4_sysfs_out.c  |  9 +++++----
>>   drivers/media/pci/mgb4/mgb4_vout.c       | 12 ++++++------
>>   drivers/media/pci/mgb4/mgb4_vout.h       |  2 +-
>>   4 files changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
>> index 2977f74d7e26..6fff886003e2 100644
>> --- a/Documentation/admin-guide/media/mgb4.rst
>> +++ b/Documentation/admin-guide/media/mgb4.rst
>> @@ -228,8 +228,12 @@ Common FPDL3/GMSL output parameters
>>       open.*
>>   
>>   **frame_rate** (RW):
>> -    Output video frame rate in frames per second. The default frame rate is
>> -    60Hz.
>> +    Output video signal frame rate limit in frames per second. Due to
>> +    the limited output pixel clock steps, the card can not always generate
>> +    a frame rate perfectly matching the value required by the connected display.
>> +    Using this parameter one can limit the frame rate by "crippling" the signal
>> +    so that the lines are not equal but the signal appears like having the exact
>> +    frame rate to the connected display. The default frame rate limit is 60Hz.
> 
> It's not clear what is meant with 'crippling'. Normally when dealing with video
> framerates the driver will pick the closest video timing to the requested framerate.
> It is understood that you can't always get the exact framerate, so drivers can
> make adjustments.
> 
> Regards,
> 
> 	Hans
> 
>>   
>>   **hsync_polarity** (RW):
>>       HSYNC signal polarity.
>> diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
>> index f67ff2a48329..573aa61c69d4 100644
>> --- a/drivers/media/pci/mgb4/mgb4_sysfs_out.c
>> +++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
>> @@ -229,9 +229,9 @@ static ssize_t frame_rate_show(struct device *dev,
>>   	struct video_device *vdev = to_video_device(dev);
>>   	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
>>   	u32 period = mgb4_read_reg(&voutdev->mgbdev->video,
>> -				   voutdev->config->regs.frame_period);
>> +				   voutdev->config->regs.frame_limit);
>>   
>> -	return sprintf(buf, "%u\n", MGB4_HW_FREQ / period);
>> +	return sprintf(buf, "%u\n", period ? MGB4_HW_FREQ / period : 0);
>>   }
>>   
>>   /*
>> @@ -245,14 +245,15 @@ static ssize_t frame_rate_store(struct device *dev,
>>   	struct video_device *vdev = to_video_device(dev);
>>   	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
>>   	unsigned long val;
>> -	int ret;
>> +	int limit, ret;
>>   
>>   	ret = kstrtoul(buf, 10, &val);
>>   	if (ret)
>>   		return ret;
>>   
>> +	limit = val ? MGB4_HW_FREQ / val : 0;
>>   	mgb4_write_reg(&voutdev->mgbdev->video,
>> -		       voutdev->config->regs.frame_period, MGB4_HW_FREQ / val);
>> +		       voutdev->config->regs.frame_limit, limit);
>>   
>>   	return count;
>>   }
>> diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
>> index a6b55669f0a8..cd001ceaae63 100644
>> --- a/drivers/media/pci/mgb4/mgb4_vout.c
>> +++ b/drivers/media/pci/mgb4/mgb4_vout.c
>> @@ -680,12 +680,12 @@ static void fpga_init(struct mgb4_vout_dev *voutdev)
>>   	mgb4_write_reg(video, regs->config, 0x00000011);
>>   	mgb4_write_reg(video, regs->resolution,
>>   		       (DEFAULT_WIDTH << 16) | DEFAULT_HEIGHT);
>> -	mgb4_write_reg(video, regs->hsync, 0x00102020);
>> -	mgb4_write_reg(video, regs->vsync, 0x40020202);
>> -	mgb4_write_reg(video, regs->frame_period, DEFAULT_PERIOD);
>> +	mgb4_write_reg(video, regs->hsync, 0x00283232);
>> +	mgb4_write_reg(video, regs->vsync, 0x40141F1E);
>> +	mgb4_write_reg(video, regs->frame_limit, DEFAULT_PERIOD);
>>   	mgb4_write_reg(video, regs->padding, 0x00000000);
>>   
>> -	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 70000 >> 1) << 1;
>> +	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 61150 >> 1) << 1;
>>   
>>   	mgb4_write_reg(video, regs->config,
>>   		       (voutdev->config->id + MGB4_VIN_DEVICES) << 2 | 1 << 4);
>> @@ -711,8 +711,8 @@ static void debugfs_init(struct mgb4_vout_dev *voutdev)
>>   	voutdev->regs[3].offset = voutdev->config->regs.hsync;
>>   	voutdev->regs[4].name = "VIDEO_PARAMS_2";
>>   	voutdev->regs[4].offset = voutdev->config->regs.vsync;
>> -	voutdev->regs[5].name = "FRAME_PERIOD";
>> -	voutdev->regs[5].offset = voutdev->config->regs.frame_period;
>> +	voutdev->regs[5].name = "FRAME_LIMIT";
>> +	voutdev->regs[5].offset = voutdev->config->regs.frame_limit;
>>   	voutdev->regs[6].name = "PADDING_PIXELS";
>>   	voutdev->regs[6].offset = voutdev->config->regs.padding;
>>   	if (has_timeperframe(video)) {
>> diff --git a/drivers/media/pci/mgb4/mgb4_vout.h b/drivers/media/pci/mgb4/mgb4_vout.h
>> index ab9b58b1deb7..adc8fe1e7ae6 100644
>> --- a/drivers/media/pci/mgb4/mgb4_vout.h
>> +++ b/drivers/media/pci/mgb4/mgb4_vout.h
>> @@ -19,7 +19,7 @@ struct mgb4_vout_regs {
>>   	u32 config;
>>   	u32 status;
>>   	u32 resolution;
>> -	u32 frame_period;
>> +	u32 frame_limit;
>>   	u32 hsync;
>>   	u32 vsync;
>>   	u32 padding;
> 


