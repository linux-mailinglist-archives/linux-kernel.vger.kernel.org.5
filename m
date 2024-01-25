Return-Path: <linux-kernel+bounces-37990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52183B95A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31622827EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431310A0A;
	Thu, 25 Jan 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5BlWM6E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A023D7A;
	Thu, 25 Jan 2024 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162512; cv=none; b=DrY41froJO6LALEhL8T3W6serSk714tTNXWvg3x7PG990aHTeIPYIW/F5HZZmcKCi2xeyggUL9iw16rEah3Mjrr2EPzR2WmiXhBQsTATAzQXFnHQjghjg4i5fNjUI4eE2YkyuFr53bveRrrQKaZTKhMh+rrEQR6fUirK8tgsmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162512; c=relaxed/simple;
	bh=X2wOBcaHXv5XxgS3cOlWt1VvbHnOngRdJ9fhiP5fF/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc98VV8AXtnqJYXUFPpkdral+NDpWxMO9xo4MuRcxP9cwLPks7vd8LOAs19Fn/KyA3s1oAgbZSDSJWTAuyntLKR9CCkBRAszu+UX/f91e8fK5iWYM70/JRp5d8nmFOTYZkZVlXOpZVLeV5COIWfzNFg8DWFERBvMe2Vhb406MZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5BlWM6E; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706162511; x=1737698511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X2wOBcaHXv5XxgS3cOlWt1VvbHnOngRdJ9fhiP5fF/M=;
  b=G5BlWM6EQqUGExBKe3KWUUrisLQXKUrMeZby7W0HudFLxwfQaL6pAo14
   /PXhZayetjY5iCZbXBBS7dK7I8xGwDP5+5JYqmE2680AObpCYehuePevc
   PaeqCd00O2kKaPw01yYL+uhO5GEYjV0jxiiNH23oA9bXThB3HNwfp6nuh
   CZEOj4UI2z8RFHCDgZVsm05V7TSxnWIbaj1sUIOmR/HrTO0ksxNt0W7Hy
   4DXOoEv3LPPHHWUBEYU0I6YHwMsvx0Ud/FXHbyWHXP5vKhvKwr59Gjuhu
   4ogeo5T4/ao1OtoI/v/fmTh/7imkMS+//gU3TEpXC18C7M8kYB6IK9DGx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15600713"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15600713"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="856963839"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="856963839"
Received: from kvmadhux-mobl.gar.corp.intel.com (HELO [10.213.88.45]) ([10.213.88.45])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:01:40 -0800
Message-ID: <eb6a1c2f-a773-4db5-812d-df7680e46f5b@linux.intel.com>
Date: Wed, 24 Jan 2024 22:01:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iio: hid-sensor-als: Assign channels dynamically
Content-Language: en-US
To: Basavaraj Natikar <bnatikar@amd.com>, jikos@kernel.org, jic23@kernel.org,
 lars@metafoo.de, Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
 <20240109180007.3373784-2-srinivas.pandruvada@linux.intel.com>
 <20defa34-f275-4d9f-95d8-788cb2eb55dc@amd.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20defa34-f275-4d9f-95d8-788cb2eb55dc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Basavraj,

On 1/24/24 21:51, Basavaraj Natikar wrote:
> Hi Srinivas,
>
>
> On 1/9/2024 11:30 PM, Srinivas Pandruvada wrote:
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
>>
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
> Could you please use original above change which works fine for some reason if
> we use this change als_state->scan.scan_index we are getting garbage value.

I think this is because of the issue which you found later for this patch.


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
> Could you please change CHANNEL_SCAN_INDEX_ILLUM to CHANNEL_SCAN_INDEX_MAX
> which helps remaining 2 patches in the series.
>
Makes sense.


Thanks,

Srinivas


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

