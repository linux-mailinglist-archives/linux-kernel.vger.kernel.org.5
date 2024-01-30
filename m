Return-Path: <linux-kernel+bounces-44457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B584223A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E274B1F2E523
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39D66B37;
	Tue, 30 Jan 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EwcKsWm7"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AE66B36;
	Tue, 30 Jan 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612717; cv=none; b=p78aaRyf9UVwZI0lgp+/VXkE0KKL0m0A0r3G7SJ5wv2hxvN4wVzgLFm1pvBwuCAoGm85ogbUgVzNwx+zdi17aAPBYOCjsQM8RG0BhUazqDx30JwOd5Vi0NBAQqnqseBRwsUBB/QzDNpPuhhWtYtjoKPPJMu2fqoM/l0NjCjbgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612717; c=relaxed/simple;
	bh=YWoRr++LtmqrklpXT4FN730vpyGR9Vt9NvXbQgTv6DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eaUHTxT+z5/88NuX4JqLnS9yl08Yr8VuekQyRFq+85aO2NMvtKxHR31lchYnBgKCkQlqwoXtlWBVHAAVq8bxx2jdVYKMsuOnKL6Y4sZzizS4Pv6IMIzzxl7WtqkWywJhlRQDCYOkGHD3dH/YsGLimrMLR43tX59W1vpWowuV9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EwcKsWm7; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U6m6fK015755;
	Tue, 30 Jan 2024 05:04:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=7fkoap6tDn5V09KItRc07wxlB0r/CaVc096KyiaEmTw=; b=
	EwcKsWm7Xv5RXOP9O+rQrFl4ul+uzXVB0OJTT3xwOV6klHLMs2dGIgCByBaFSHZC
	TnbzGFdvLP9CKEw2DPjacbeYvpB7fG4KHRZZSfTFtITvqkyOEI/eHViWDi+rf/oZ
	soEXABvXy1qbsmy5IA0q5DBoynwKcsAwfTAMKXV5erT2BSNs2NlRcTNom9BrtxS5
	+RelvvnNHudCp6XyH6Fn7Io3/FWtGWeUNEpgB5jNnkMov1rQhHKGIsws3s+8VuTg
	uIJ+fliAEobFWKx/rzA5gNMhywqZwvDSbUhMIFDj0H/JLieIXXwFeaCVHXCADUnW
	ICAtk2fZjF8CGglzOLYQmQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vw043u6s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 05:04:56 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 11:04:54 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 11:04:54 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5F753820247;
	Tue, 30 Jan 2024 11:04:54 +0000 (UTC)
Message-ID: <a8432725-6dc6-4765-831f-178dcee8b829@opensource.cirrus.com>
Date: Tue, 30 Jan 2024 11:04:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] ASoC: cs35l56: Fix default SDW TX mixer registers
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
 <20240129162737.497-9-rf@opensource.cirrus.com>
 <4f54a12c-c8a3-414c-b4df-3f7b25e6d524@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <4f54a12c-c8a3-414c-b4df-3f7b25e6d524@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oet1IvvhAV8hsmYkbAJ3mUff-NWRGpf-
X-Proofpoint-GUID: oet1IvvhAV8hsmYkbAJ3mUff-NWRGpf-
X-Proofpoint-Spam-Reason: safe

On 29/01/2024 17:15, Pierre-Louis Bossart wrote:
> 
> 
> On 1/29/24 17:27, Richard Fitzgerald wrote:
>> Patch the SDW TX mixer registers to silicon defaults.
>>
>> CS35L56 is designed for SDCA and a generic SDCA driver would
>> know nothing about these chip-specific registers. So the
>> firmware sets up the SDW TX mixer registers to whatever audio
>> is relevant on a specific system.
>>
>> This means that the driver cannot assume the initial values
>> of these registers. But Linux has ALSA controls to configure
>> routing, so the registers can be patched to silicon default and
>> the ALSA controls used to select what audio to feed back to the
>> host capture path.
> 
> humm, which has the precedence then?
> a) the values set by firmware
> b) the default values set by the driver?
> 
> Also if the firmware touches those registers shouldn't they be marked as
> 'volatile'?
>

The firmware was designed to work with Windows, so it looks a bit
strange if you are coming at it from ALSA. There's not really any
defined 'precedence'. The firmware will setup the feedback monitor paths
to something that satisfies SDCA and Windows expectations.

We don't care about that in Linux, the firmware on the Intel DSP
probably isn't running the same algorithms for Linux, and we have ALSA
controls to configure those paths. So we patch the mixers back to their
silicon defaults and take over complete control of them.

The firmware only writes them during its power-up sequence so they
will only change when we are rebooting the firmware or coming out of
low-power standby, which is under the control of the driver. When that
happens regmap will re-apply the patch and then sync up the registers
again. The firmware won't touch them after boot, so we can avoid having
to mark them volatile (which would mean implementing our own manual
caching of the settings).

> 
>> Backport note:
>> This won't apply to kernels older than v6.6.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
>> ---
>>   sound/soc/codecs/cs35l56-shared.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
>> index 35789ffc63af..a812abf90836 100644
>> --- a/sound/soc/codecs/cs35l56-shared.c
>> +++ b/sound/soc/codecs/cs35l56-shared.c
>> @@ -12,6 +12,15 @@
>>   #include "cs35l56.h"
>>   
>>   static const struct reg_sequence cs35l56_patch[] = {
>> +	/*
>> +	 * Firmware can change these to non-defaults to satisfy SDCA.
>> +	 * Ensure that they are at known defaults.
>> +	 */
>> +	{ CS35L56_SWIRE_DP3_CH1_INPUT,		0x00000018 },
>> +	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
>> +	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
>> +	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
>> +
>>   	/* These are not reset by a soft-reset, so patch to defaults. */
>>   	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
>>   	{ CS35L56_MAIN_RENDER_USER_VOLUME,	0x00000000 },


