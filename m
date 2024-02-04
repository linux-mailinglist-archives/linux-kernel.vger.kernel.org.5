Return-Path: <linux-kernel+bounces-51656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FF848DFB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EC71F2333A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87644225AE;
	Sun,  4 Feb 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bedcR3mm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC1224CC;
	Sun,  4 Feb 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051987; cv=none; b=fCT1FkOgSlyDYkuglTOfzRq9tn1Tv+ZZ2ZXz1C7OlrMhrU4xwxZoBXAnLZz7AJd5hUtLrLj2deR6XcnYtYKvq6UCGE+qnW4ZzM0lG5EE4xsvzHrxOdjv/wrn6XL3xvHmc+1qdtUpGDGkO4QXuXmKseR8ML8pf9IjbvCPTzTsb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051987; c=relaxed/simple;
	bh=2NxSF8Uo9iXz3+G26oYcwWHF9OqRwdF1ojfNdo4qYHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuSliM37jXdFo+iHmVN2cT7srsK9LEmj9Rrgl364Ke9tAUu36HQofg0bSsnBETlA2+xYdzqms/vn1Ejzxgo3h0aZ1EAbaafkY1itGFL8t9fyC7dCLf4Gj96p+MVMHU0xzdM9UJjeOuoJWDgxECxnCPHAqA80GuYMda/0fJR3nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bedcR3mm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707051986; x=1738587986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2NxSF8Uo9iXz3+G26oYcwWHF9OqRwdF1ojfNdo4qYHg=;
  b=bedcR3mm+oHfbyky1bkA9j4Gx+idLD0b+YjZ6Xcu3Wn4l3/Stl/5pGyI
   U3RgiMVl3MLmyx3iCaJqqU3do0x17p+5OMvGPD7JzsLORmLHWICZX5QN7
   9CiHLsghXiZUc6RtUOJ1cCbTX9uKoygiaU1tbLtpyoqIEEfsLlL8lFcvS
   W53mQmARB7GYFHPF79h0aBtxUOVaK6KXuwQ6wDiWtksdz+0yJ8BY/9f1S
   lYj8B39I1QXtFMW93ywPoWDjj+MovSX9evrpPflQ800I8EnqYPl0BS5Sh
   VD3+umzDNhmMLegDzjW+uvfkOEYMpgGDQpZp1SNva2dqIXR/dW/gXGPdw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="285178"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="285178"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="823633695"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="823633695"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.212.77.228]) ([10.212.77.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:06:23 -0800
Message-ID: <2cb9b3af-61ea-44e9-8cd9-d502de2b43a5@linux.intel.com>
Date: Sun, 4 Feb 2024 05:06:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iio: hid-sensor-als: Assign channels dynamically
To: Jonathan Cameron <jic23@kernel.org>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
 <20240109180007.3373784-2-srinivas.pandruvada@linux.intel.com>
 <20240113160320.09584c4e@jic23-huawei>
Content-Language: en-US
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240113160320.09584c4e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 1/13/24 08:03, Jonathan Cameron wrote:
> On Tue,  9 Jan 2024 10:00:04 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>
>> Instead of assuming that every channel defined statically by
>> als_channels[] is present, assign dynamically based on presence of the
>> respective usage id in the descriptor. This will allow to register ALS
>> with limited channel support. Append the timestamp as the last channel.
>>
>> When not all usage ids are present, the scan index is adjusted to
>> exclude unsupported channels.
>>
>> There is no intentional function changes done.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>> v3:
>> Addressed comments from Jonthan:
>> 	- Remove channel allocation and move to iio_priv()
>> 	- Parse all usage IDs in a single loop and continue
>> 	for failure. This way the temperature and chromaticity
>> 	will not need any special processing to parse usage ids.
>> 	- Don't leave empty channel indexes
> There isn't really a problem if you did want to leave them.
> There are a number of other devices that do leave gaps and userspace
> code shouldn't mind that.  I don't mind them being more tightly packed
> though so this is also fine.
Submitted v4 leaving gaps.
>
>
> I was just looking at the driver and noticed one other oddity.
> In als_capture_sample, it always returns -EINVAL if the timestamp channel
> is being queried.

Correct. But hid-sensor-hub core ignores return value, so it doesn't 
cause any issue.

But I sent a separate patch to fix this.


>
>> v2:
>> New change
>>
>>   drivers/iio/light/hid-sensor-als.c | 56 +++++++++++++++++++++---------
>>   1 file changed, 39 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
>> index 5cd27f04b45e..72a7c01c97f8 100644
>> --- a/drivers/iio/light/hid-sensor-als.c
>> +++ b/drivers/iio/light/hid-sensor-als.c
>> @@ -25,17 +25,26 @@ struct als_state {
>>   	struct hid_sensor_hub_callbacks callbacks;
>>   	struct hid_sensor_common common_attributes;
>>   	struct hid_sensor_hub_attribute_info als[CHANNEL_SCAN_INDEX_MAX];
>> +	struct iio_chan_spec channels[CHANNEL_SCAN_INDEX_MAX + 1];
>>   	struct {
>>   		u32 illum[CHANNEL_SCAN_INDEX_MAX];
>> +		u32 scan_index[CHANNEL_SCAN_INDEX_MAX];
> This looks unlikely to end up right with a varying number of channels.
> I'm assuming the device always captures all available channels.
> As such, if there are 2 channels the timestamp will end up at byte 8 onwards.
> If there are 3 channels, byte 16 onwards etc.
>
> Usually when we have a floating timestamp like this we just rely on expanding
> the channel array to leave space and force the alignment of that to be suitable
> for taking a timestamp.
>
> I'm a bit confused not to see available_scan_mask being set though.
> If userspace previously requested illumination only would the data
> have ended up in the right location (offset 0?)
Add this.
> If you set available_scan_masks to specify all channels then the
> IIO core will move things around for you. If it's not provided then
> it is up to the driver to figure out where to put the data.
>
> Otherwise the patch looks fine to me.

Please check v4, if it solve the above issues.

Thanks,

Srinivas



> Jonathan
>
>
>
>>   		u64 timestamp __aligned(8);
>>   	} scan;
>>   	int scale_pre_decml;
>>   	int scale_post_decml;
>>   	int scale_precision;
>>   	int value_offset;
>> +	int num_channels;
>>   	s64 timestamp;
>>   };
>>   
>> +/* The order of usage ids must match scan index starting from CHANNEL_SCAN_INDEX_INTENSITY */
>> +static const u32 als_usage_ids[] = {
>> +	HID_USAGE_SENSOR_LIGHT_ILLUM,
>> +	HID_USAGE_SENSOR_LIGHT_ILLUM,
>> +};
>> +
>>   static const u32 als_sensitivity_addresses[] = {
>>   	HID_USAGE_SENSOR_DATA_LIGHT,
>>   	HID_USAGE_SENSOR_LIGHT_ILLUM,
>> @@ -216,11 +225,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>>   	struct als_state *als_state = iio_priv(indio_dev);
>>   	int ret = -EINVAL;
>>   	u32 sample_data = *(u32 *)raw_data;
>> +	int scan_index;
>>   
>>   	switch (usage_id) {
>>   	case HID_USAGE_SENSOR_LIGHT_ILLUM:
>> -		als_state->scan.illum[CHANNEL_SCAN_INDEX_INTENSITY] = sample_data;
>> -		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
>> +		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_INTENSITY];
>> +		als_state->scan.illum[scan_index] = sample_data;
>> +		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_ILLUM];
>> +		als_state->scan.illum[scan_index] = sample_data;
>>   		ret = 0;
>>   		break;
>>   	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>> @@ -237,27 +249,39 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>>   /* Parse report which is specific to an usage id*/
>>   static int als_parse_report(struct platform_device *pdev,
>>   				struct hid_sensor_hub_device *hsdev,
>> -				struct iio_chan_spec *channels,
>>   				unsigned usage_id,
>>   				struct als_state *st)
>>   {
>> -	int ret;
>> +	struct iio_chan_spec *channels;
>> +	int ret, index = 0;
>>   	int i;
>>   
>> +	channels = st->channels;
>> +
>>   	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
>>   		ret = sensor_hub_input_get_attribute_info(hsdev,
>>   						HID_INPUT_REPORT,
>>   						usage_id,
>> -						HID_USAGE_SENSOR_LIGHT_ILLUM,
>> +						als_usage_ids[i],
>>   						&st->als[i]);
>>   		if (ret < 0)
>> -			return ret;
>> -		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
>> +			continue;
>> +
>> +		channels[index] = als_channels[i];
>> +		st->scan.scan_index[i] = index;
>> +
>> +		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
>> +		++index;
>>   
>>   		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
>>   			st->als[i].report_id);
>>   	}
>>   
>> +	st->num_channels = index;
>> +	/* Return success even if one usage id is present */
>> +	if (index)
>> +		ret = 0;
>> +
>>   	st->scale_precision = hid_sensor_format_scale(usage_id,
>>   				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>>   				&st->scale_pre_decml, &st->scale_post_decml);
>> @@ -293,15 +317,7 @@ static int hid_als_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> -	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
>> -					   sizeof(als_channels), GFP_KERNEL);
>> -	if (!indio_dev->channels) {
>> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
>> -		return -ENOMEM;
>> -	}
>> -
>>   	ret = als_parse_report(pdev, hsdev,
>> -			       (struct iio_chan_spec *)indio_dev->channels,
>>   			       hsdev->usage,
>>   			       als_state);
>>   	if (ret) {
>> @@ -309,8 +325,14 @@ static int hid_als_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> -	indio_dev->num_channels =
>> -				ARRAY_SIZE(als_channels);
>> +	/* Add timestamp channel */
>> +	als_state->channels[als_state->num_channels] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
>> +	als_state->channels[als_state->num_channels].scan_index = als_state->num_channels;
>> +
>> +	/* +1 for adding timestamp channel */
>> +	indio_dev->num_channels = als_state->num_channels + 1;
>> +
>> +	indio_dev->channels = als_state->channels;
>>   	indio_dev->info = &als_info;
>>   	indio_dev->name = name;
>>   	indio_dev->modes = INDIO_DIRECT_MODE;

