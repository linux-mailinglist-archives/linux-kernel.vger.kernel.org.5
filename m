Return-Path: <linux-kernel+bounces-110258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B233E885C31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3190AB21B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14724128817;
	Thu, 21 Mar 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GQB1fSAL"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D286ADB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035325; cv=none; b=gzMAWiR2smc9wEECPsTVgSxGerF74CzRocxuuMKd9SOjweuqqlY7S/Yo+bg8xwXKfsgBOkPixsXXyyv913ezAXHJDZdom/Yj9NrS3Kom1zIW6tLXy0/zz6BUnuAETRO+LgSrg9Nju2+Jn9m76VK2o3C+C1YHyTebgPCpWt5NIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035325; c=relaxed/simple;
	bh=X3KlnD26UV/F+QSte0XUbF/JdhkazoSRjcXjjnMdd2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpnFICoxyfJ0rLjx8J4yeWUfcCipgCteexYi0O1crELVd6w0ft+EYUCCjGKTKjHAyWdczIAlw+UZeY6kz7FowKw+4WOtVYHYPxZ6S5wum7xuGqCDtjavGbPS2loPMGmG9tVkmmfxsFRzuhc2tnhYfFCrHn2sWgJ0yqW6C906Rmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GQB1fSAL; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6e5931a-22ab-4291-b1c5-9885be0b1b22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711035319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hMomlUeqjzcui/PNXNj+lcsYhOrH42hxxoUf3sOynU=;
	b=GQB1fSALASUYhhzxpdtat42BHs5CvVT0xVmi9dgflPlXquMmo4jwZoe6IFy6r8lpi0cbaf
	sfs6CdZBFxnEBnoDDsIK2mYSc4wX7VbMiqZ5Pmi6PJFdLB/yy6ISJNC4nZYMIb5zByANOH
	b3qryv4Nb8ukfM1svRdcRTSnsm3XSd0=
Date: Thu, 21 Mar 2024 11:35:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/8] drm: zynqmp_dp: Adjust training values per-lane
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Michal Simek <michal.simek@amd.com>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
 <20240319225122.3048400-4-sean.anderson@linux.dev>
 <c16665d3-ff3a-48d7-9f4e-076473a3b45d@ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <c16665d3-ff3a-48d7-9f4e-076473a3b45d@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/20/24 01:57, Tomi Valkeinen wrote:
> On 20/03/2024 00:51, Sean Anderson wrote:
>> The feedback we get from the DPRX is per-lane. Make changes using this
>> information, instead of picking the maximum values from all lanes. This
>> results in more-consistent training on marginal links.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/gpu/drm/xlnx/zynqmp_dp.c | 23 ++++++++---------------
>>   1 file changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> index 98a32e6a0459..8635b5673386 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> @@ -605,28 +605,21 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
>>                      u8 link_status[DP_LINK_STATUS_SIZE])
>>   {
>>       u8 *train_set = dp->train_set;
>> -    u8 voltage = 0, preemphasis = 0;
>>       u8 i;
>>         for (i = 0; i < dp->mode.lane_cnt; i++) {
>> -        u8 v = drm_dp_get_adjust_request_voltage(link_status, i);
>> -        u8 p = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
>> +        u8 voltage = drm_dp_get_adjust_request_voltage(link_status, i);
>> +        u8 preemphasis =
>> +            drm_dp_get_adjust_request_pre_emphasis(link_status, i);
>>   -        if (v > voltage)
>> -            voltage = v;
>> +        if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
>> +            voltage |= DP_TRAIN_MAX_SWING_REACHED;
>>   -        if (p > preemphasis)
>> -            preemphasis = p;
>> -    }
>> +        if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
>> +            preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
>>   -    if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
>> -        voltage |= DP_TRAIN_MAX_SWING_REACHED;
>> -
>> -    if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
>> -        preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
>> -
>> -    for (i = 0; i < dp->mode.lane_cnt; i++)
>>           train_set[i] = voltage | preemphasis;
>> +    }
>>   }
>>     /**
> 
> Looks fine to me, but a few cosmetic suggestions, feel free to ignore if not to your liking:
> 
> 1)
> 
> u8 voltage, preemphasis;
> 
> voltage = drm_dp_get_adjust_request_voltage(link_status, i);
> preemphasis = drm_dp_get_adjust_request_pre_emphasis(link_status, i);

If the comment here is about the line break, I agree that this looks
better but the second line is over 80 characters.

> 2)
> 
> for (unsigned int i = 0; i < dp->mode.lane_cnt; i++)

Is this allowed now?

> 3)
> 
> dp->train_set[i] = voltage | preemphasis;

This would be undone in patch 7/8.

--Sean

> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
>  Tomi
> 

