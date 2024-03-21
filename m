Return-Path: <linux-kernel+bounces-110270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E7885C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410D71F232F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685886268;
	Thu, 21 Mar 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bAdJz/Hh"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC048627F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035823; cv=none; b=qgvfnDRGdg7pgJzEcb2L/Dj/EAPHR0uKjc/uEB4opO1orQfPzeUwzuHk8SyL9qI7d1Wp/yBuAM37MvsGlr8t+A6BlTAbV9qkRBbHUGcpMeLBSqgbA2PRC0VHYMU/zykKEkiyWS3AhHjXyzVs0Ti9qAuW7ChkQdwONKvJLmzEyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035823; c=relaxed/simple;
	bh=3x0w5eYh24hpBQZAyEsp6m1w9k0+4zwudOuErkymjIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yxy4ql1gV8aruVVb9V4gozWTFDGM7JbF8DlwDXcH3J+mNXgdp/lxIZr3ek4xgVy7/yV+1toTtzBlcdZlaIsJ+wIAHKeSRJhurFT6+AIrcqsc/zFPxCzl+8MmRdXnpvLSfDCYU28LZ5J2bOCpbzeWryT4dYwirSK3TJfSxeL22AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bAdJz/Hh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8bd19526-58a3-440b-a6ba-4cd123cb55e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711035819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAqr+Kh0pd5iVKk+9UAPP+8a88O2dFbNCftmA8HIzPY=;
	b=bAdJz/HhBTSXa6vzDHoacsKsawlkppq5eHwxMv5aUEBYQpNImRC2AN72JF/BNsHQYkIfMt
	al1NlPk//7C85L/GL9c12fCUvtt6/mrehLLfjRUHecgu/l/pjhUVmFPpUV53AUWAlEfUtE
	0q32A/8bbe50YlgKQ+hhQUcsxSNc4Gs=
Date: Thu, 21 Mar 2024 11:43:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/8] drm: zynqmp_dp: Rearrange zynqmp_dp for better
 padding
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
 <20240319225122.3048400-5-sean.anderson@linux.dev>
 <0fdbb6e4-6be8-4a21-8cf3-2a419b4b44ed@ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <0fdbb6e4-6be8-4a21-8cf3-2a419b4b44ed@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/20/24 02:14, Tomi Valkeinen wrote:
> On 20/03/2024 00:51, Sean Anderson wrote:
>> Sort the members of struct zynqmp_dp to reduce padding necessary for
>> alignment.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>> Changes in v2:
>> - New
>>
>>   drivers/gpu/drm/xlnx/zynqmp_dp.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> index 8635b5673386..f1834c8e3c02 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
>> @@ -255,10 +255,10 @@ struct zynqmp_dp_link_config {
>>    * @fmt: format identifier string
>>    */
>>   struct zynqmp_dp_mode {
>> -    u8 bw_code;
>> -    u8 lane_cnt;
>> -    int pclock;
>>       const char *fmt;
>> +    int pclock;
>> +    u8 bw_code;
>> +    u8 lane_cnt;
>>   };
>>     /**
>> @@ -295,27 +295,27 @@ struct zynqmp_dp_config {
>>    * @train_set: set of training data
>>    */
>>   struct zynqmp_dp {
>> +    struct drm_dp_aux aux;
>> +    struct drm_bridge bridge;
>> +    struct delayed_work hpd_work;
>> +
>> +    struct drm_bridge *next_bridge;
>>       struct device *dev;
>>       struct zynqmp_dpsub *dpsub;
>>       void __iomem *iomem;
>>       struct reset_control *reset;
>> -    int irq;
>> -
>> -    struct drm_bridge bridge;
>> -    struct drm_bridge *next_bridge;
>> -
>> -    struct zynqmp_dp_config config;
>> -    struct drm_dp_aux aux;
>>       struct phy *phy[ZYNQMP_DP_MAX_LANES];
>> -    u8 num_lanes;
>> -    struct delayed_work hpd_work;
>> +
>>       enum drm_connector_status status;
>> +    int irq;
>>       bool enabled;
>>   -    u8 dpcd[DP_RECEIVER_CAP_SIZE];
>> -    struct zynqmp_dp_link_config link_config;
>>       struct zynqmp_dp_mode mode;
>> +    struct zynqmp_dp_link_config link_config;
>> +    struct zynqmp_dp_config config;
>> +    u8 dpcd[DP_RECEIVER_CAP_SIZE];
>>       u8 train_set[ZYNQMP_DP_MAX_LANES];
>> +    u8 num_lanes;
>>   };
>>     static inline struct zynqmp_dp *bridge_to_dp(struct drm_bridge *bridge)
> 
> If you change the order of the fields, you should change the order in the kernel doc accordingly.

The kernel doc is documentation, so it should continue to group similar
functionality together.

> To be honest, I'm not sure if I like this patch. We have usually one instance of these structs allocated. How many bytes do we save?

Actually, the main reason is to make it easy to determine where to
insert new members. Stick the pointers with the pointers, u8s with u8s,
etc.

> I'm fine with getting easy savings by changing the field order in some cases, but I think the "human" side of the order is important too: usually the fields are grouped in some way, and ordered so that the more base or generic ones are first, and fields for some specific feature are later. And fields protected by a lock should be grouped together, with their lock being first/last in that group.
> 
> Looking at the zynqmp_dp struct with this patch, I get an urge to start moving things around: dev, dpsub, iomem, etc first, hpd somewhere later. Base config fields like config, num_lanes, irq would be grouped together. Etc.

--Sean

