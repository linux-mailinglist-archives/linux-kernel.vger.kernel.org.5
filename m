Return-Path: <linux-kernel+bounces-167814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058268BAF97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D6D5B2171E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303834E1B3;
	Fri,  3 May 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="urYQiP8M"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24C1BF31
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749260; cv=none; b=R3/kix+xGPAnEdF38ibs2hTWNDBW8rJSl0xnVzwxWiHe4xXYJRxR4fn0PPkHJz1YYVyfUNYg+HFoIth70cwc/f1ZB1xuYa6CHIdfAsc5RaAaHJyqhd4jiYMAwgyWxVNejbtuiw91kaVZMEM/pfVhL2oiITem2LVRs8ObQDJWsF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749260; c=relaxed/simple;
	bh=xDdguUN/yGwVqMvoOr3gev43Xar4/4wzHsi1BswfBSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VRpVDKiVD0PfVRllKvXZfo6ZdULWiasnXGu06n1OJOGUYHG8mg9IPQY3kyWB9mwhXLtScImbiDWOQTSzACCNgDEiu7iOUyTMDDNR5QJmBCGgoub1Hug7IH+NkbnXiKNA7X26hio7ar93TOWuTaaj12SlrBpBy6Z0ziuW1GOVQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=urYQiP8M; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 443FE0dr022273;
	Fri, 3 May 2024 10:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714749240;
	bh=pXJAKxRZZcWDNZTuHwoEtDOpGE1n/3X/l3Ho5YAz60c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=urYQiP8MW4+DeGpiAb5f4GOkgiZsACi/Kra7P9hw5m0RlfyWvviSeRcj0P2HcxMkt
	 vExVCziEqceoJUAUV5VPyu18QAdR4wj+C64nIhvr8mLtjkKsmHPzGF6DY3ZryCKkdK
	 LHZ3SQo7mNDOv/Hs9hp3wC+GP6jK/rAzPir8zdNw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 443FE0DP046693
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 May 2024 10:14:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 10:14:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 10:13:59 -0500
Received: from [10.249.129.115] ([10.249.129.115])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 443FDsHo111504;
	Fri, 3 May 2024 10:13:55 -0500
Message-ID: <758be932-d791-48e5-ae36-de7542c7a2a3@ti.com>
Date: Fri, 3 May 2024 20:43:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: sii902x: Fix mode_valid hook
To: Maxime Ripard <mripard@kernel.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240408081435.216927-1-j-choudhary@ti.com>
 <20240415-venomous-enthusiastic-wildebeest-a7a446@houat>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240415-venomous-enthusiastic-wildebeest-a7a446@houat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Maxime,

Thanks for the review.

On 15/04/24 13:10, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Apr 08, 2024 at 01:44:35PM +0530, Jayesh Choudhary wrote:
>> Currently, mode_valid hook returns all mode as valid. Add the check
>> for the maximum and minimum pixel clock that the bridge can support
>> while validating a mode.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/sii902x.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 8f84e98249c7..658819199c84 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -163,6 +163,16 @@
>>   
>>   #define SII902X_AUDIO_PORT_INDEX		3
>>   
>> +/*
>> + * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
>> + * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
>> + * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
>> + *
>> + * (drm_display_mode clock is in kHz)
>> + */
>> +#define SII902X_MIN_PIXEL_CLOCK			25000
>> +#define SII902X_MAX_PIXEL_CLOCK			165000
>> +
> 
> You should probably add a KHZ suffix or something to make it obvious.
> The natural unit for a frequency is Hertz.

Okay.
Instead of adding the kHz in comments, I will add that in suffix
like SII902X_MIN_PIXEL_CLOCK_KHZ.

> 
>>   struct sii902x {
>>   	struct i2c_client *i2c;
>>   	struct regmap *regmap;
>> @@ -313,7 +323,11 @@ static int sii902x_get_modes(struct drm_connector *connector)
>>   static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
>>   					       struct drm_display_mode *mode)
>>   {
>> -	/* TODO: check mode */
>> +	if (mode->clock < SII902X_MIN_PIXEL_CLOCK)
>> +		return MODE_CLOCK_LOW;
>> +
>> +	if (mode->clock > SII902X_MAX_PIXEL_CLOCK)
>> +		return MODE_CLOCK_HIGH;
>>   
>>   	return MODE_OK;
>>   }
> 
> It's something you should do in atomic_check too
> 

Like using clock from adjusted mode in crtc_state?
Will update in the next revision.

Warm Regards,
-Jayesh

