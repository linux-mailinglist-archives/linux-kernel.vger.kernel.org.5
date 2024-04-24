Return-Path: <linux-kernel+bounces-156928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E18B0A73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2132856D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DDF15B54B;
	Wed, 24 Apr 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Qpl6h0ft"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24015B150;
	Wed, 24 Apr 2024 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964145; cv=none; b=QK/J9Cuq3RlXy9Oxq3ozAGg5ESNzOCx0ajT5Coxgh9bZMly7JgD66bgc8wMxlINKvKJC/RyEsqr3iyArcznumMePf9I3Ov2vffr5nT+itazwfbSZFOlS3hFszU7Lpeo4s5R0gElcAM74PjvzmHYXbNTlv1ZMhQP/ChchJr4VuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964145; c=relaxed/simple;
	bh=nkxmjGp+7afBGnElLOCQCHJpVST55UrZekzCug24NYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcT+qWcBCbVsBsiH+3wxaKKRGLDG27lshavuRBPG6Byc5eVPT9ErzW+JGxxggIlyIK/GshbwK9mQhovFoXPUWabIXc7qnK3mvxRTNjLJvTnR5MxkTntgnulK0kLv/2vYIZOI4XbrNgybofFHWcVnm9b7rjGUDwLFArbpyM0/7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Qpl6h0ft; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF3EDB1;
	Wed, 24 Apr 2024 15:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713964090;
	bh=nkxmjGp+7afBGnElLOCQCHJpVST55UrZekzCug24NYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qpl6h0ftNWrwI8DzcJTXwIiPI4mLTQcN1xaYDYQD7e4dpXjXiPYhS0sn3mSN8kDB3
	 /CrV/qNlttKJYTWHwn9fxJ2IV99Zz0oXe1jy25KCWi+GHC8NNx8Gqf18/FMQ6FuYer
	 2jUsyXH59x3wsFoSE2mQel7XhQy8L+qaSBnyXdRE=
Message-ID: <891d564c-bf0b-42f7-8938-407c8f6d8f8b@ideasonboard.com>
Date: Wed, 24 Apr 2024 16:08:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
To: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
 <20240416-enable-streams-impro-v5-8-bd5fcea49388@ideasonboard.com>
 <7483a57b-b499-49bb-bd10-cdcf311a8470@xs4all.nl>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <7483a57b-b499-49bb-bd10-cdcf311a8470@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 11:41, Hans Verkuil wrote:
> On 16/04/2024 15:55, Tomi Valkeinen wrote:
>> Add two internal helper functions, v4l2_subdev_collect_streams() and
>> v4l2_subdev_set_streams_enabled(), which allows us to refactor
>> v4l2_subdev_enable/disable_streams() functions.
>>
>> This (I think) makes the code a bit easier to read, and lets us more
>> easily add new functionality in the helper functions in the following
>> patch.
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-subdev.c | 109 +++++++++++++++++++---------------
>>   1 file changed, 60 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>> index 38388b223564..e45fd42da1e3 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -2100,6 +2100,42 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
>>   }
>>   EXPORT_SYMBOL_GPL(v4l2_subdev_routing_validate);
>>   
>> +static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
>> +					struct v4l2_subdev_state *state,
>> +					u32 pad, u64 streams_mask,
>> +					u64 *found_streams,
>> +					u64 *enabled_streams)
>> +{
>> +	*found_streams = 0;
>> +	*enabled_streams = 0;
>> +
>> +	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
>> +		const struct v4l2_subdev_stream_config *cfg =
>> +			&state->stream_configs.configs[i];
>> +
>> +		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
>> +			continue;
>> +
>> +		*found_streams |= BIT_ULL(cfg->stream);
>> +		if (cfg->enabled)
>> +			*enabled_streams |= BIT_ULL(cfg->stream);
>> +	}
>> +}
>> +
>> +static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>> +					    struct v4l2_subdev_state *state,
>> +					    u32 pad, u64 streams_mask,
>> +					    bool enabled)
>> +{
>> +	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
>> +		struct v4l2_subdev_stream_config *cfg =
>> +			&state->stream_configs.configs[i];
>> +
>> +		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
>> +			cfg->enabled = enabled;
>> +	}
>> +}
>> +
>>   static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>>   					       u64 streams_mask)
>>   {
>> @@ -2151,8 +2187,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>   	struct device *dev = sd->entity.graph_obj.mdev->dev;
>>   	struct v4l2_subdev_state *state;
>>   	bool already_streaming;
>> -	u64 found_streams = 0;
>> -	unsigned int i;
>> +	u64 enabled_streams;
>> +	u64 found_streams;
>>   	int ret;
>>   
>>   	/* A few basic sanity checks first. */
>> @@ -2173,22 +2209,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>   	 * Verify that the requested streams exist and that they are not
>>   	 * already enabled.
>>   	 */
>> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
>> -		struct v4l2_subdev_stream_config *cfg =
>> -			&state->stream_configs.configs[i];
>>   
>> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
>> -			continue;
>> -
>> -		found_streams |= BIT_ULL(cfg->stream);
>> -
>> -		if (cfg->enabled) {
>> -			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
>> -				cfg->stream, sd->entity.name, pad);
>> -			ret = -EALREADY;
>> -			goto done;
>> -		}
>> -	}
>> +	v4l2_subdev_collect_streams(sd, state, pad, streams_mask,
>> +				    &found_streams, &enabled_streams);
>>   
>>   	if (found_streams != streams_mask) {
>>   		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
>> @@ -2197,6 +2220,13 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>   		goto done;
>>   	}
>>   
>> +	if (enabled_streams) {
>> +		dev_dbg(dev, "streams 0x%llx already enabled on %s:%u\n",
>> +			enabled_streams, sd->entity.name, pad);
>> +		ret = -EINVAL;
>> +		goto done;
>> +	}
>> +
>>   	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
>>   
>>   	already_streaming = v4l2_subdev_is_streaming(sd);
>> @@ -2211,13 +2241,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>   	}
>>   
>>   	/* Mark the streams as enabled. */
>> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
>> -		struct v4l2_subdev_stream_config *cfg =
>> -			&state->stream_configs.configs[i];
>> -
>> -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
>> -			cfg->enabled = true;
>> -	}
>> +	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
>>   
>>   	if (!already_streaming)
>>   		v4l2_subdev_enable_privacy_led(sd);
>> @@ -2279,8 +2303,8 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>>   {
>>   	struct device *dev = sd->entity.graph_obj.mdev->dev;
>>   	struct v4l2_subdev_state *state;
>> -	u64 found_streams = 0;
>> -	unsigned int i;
>> +	u64 enabled_streams;
>> +	u64 found_streams;
>>   	int ret;
>>   
>>   	/* A few basic sanity checks first. */
>> @@ -2301,22 +2325,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>>   	 * Verify that the requested streams exist and that they are not
>>   	 * already disabled.
>>   	 */
>> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
>> -		struct v4l2_subdev_stream_config *cfg =
>> -			&state->stream_configs.configs[i];
>> -
>> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
>> -			continue;
>>   
>> -		found_streams |= BIT_ULL(cfg->stream);
>> -
>> -		if (!cfg->enabled) {
>> -			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
>> -				cfg->stream, sd->entity.name, pad);
>> -			ret = -EALREADY;
> 
> This used to return -EALREADY...
> 
>> -			goto done;
>> -		}
>> -	}
>> +	v4l2_subdev_collect_streams(sd, state, pad, streams_mask,
>> +				    &found_streams, &enabled_streams);
>>   
>>   	if (found_streams != streams_mask) {
>>   		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
>> @@ -2325,6 +2336,13 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>>   		goto done;
>>   	}
>>   
>> +	if (enabled_streams != streams_mask) {
>> +		dev_dbg(dev, "streams 0x%llx already disabled on %s:%u\n",
>> +			streams_mask & ~enabled_streams, sd->entity.name, pad);
>> +		ret = -EINVAL;
> 
> ...but now it returns -EINVAL.
> 
> Is that intentional?

No. I think it was a copy-paste thing.

> I prefer EINVAL to be honest, but I was just wondering about this change.
> 
> It looks like the next patch removes the last of the EALREADY error returns
> as well.

Good catch. We document that the enable_streams() returns EALREADY if a 
stream is already enabled, so lets stick to that. I'll update the patches.

  Tomi


