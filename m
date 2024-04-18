Return-Path: <linux-kernel+bounces-150426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E98A9F14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBFF286258
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E152616F846;
	Thu, 18 Apr 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmBi38Yp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3916EBFB;
	Thu, 18 Apr 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455487; cv=none; b=mvNMQK5ZJEDSmfTVZZgtRMEnac2XM8Gt2+7VE+a0WTOBhuqGIn4Q64KpMuwsEmaGWMoKD+J751u4QgVpB4yrm2H0sJp/dY8+0vBAp1TUtk4Nnyr+nF3LfaEp8yggg3sdIxxnxf/wCQjnPuDE7mRqgbymCs1ImU02WoknCHOGlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455487; c=relaxed/simple;
	bh=2gdhwgFNM0LV5/DhpOw5l/Tz9tLKHivDA52KLsPKnfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXdlT4dU4DTpvGkiSLZHwtt2/UaXjnY3Qa4C1miT3gzxgZNrKB5lUG/YRw4b7y30hLmhSMEvCxYoz0IHV+D+57eXuyWqI7IeXVYG1r33mkQjqqmqr7V/24PoWPRzkBVWmpWKyzRih7tuMnh6g19Ymrzx09rXvgBbD/qTgldnDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmBi38Yp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713455486; x=1744991486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2gdhwgFNM0LV5/DhpOw5l/Tz9tLKHivDA52KLsPKnfE=;
  b=lmBi38YpskEIOXaUS2N3oUXcw+ifZ00wOZsyV11mjQgx0UxzaVgx9HcM
   TtfF4nTp/h9rl5L+ggBA07hp+t6wfwx+FUDznjQgMCj9t/nUssNPj1ZPV
   MH2Qo0RrWxEj3I+iuUAV6rzc/y8ESNMTx+CLahMpIih4Gs2COM1GSRarj
   yTYjgVZKGVp2ix3X3Zn0oGGx/d640SzqtR8vVAfNGURWMEYLQ7fSZXtH/
   3gAY3vkKt2eUKcYo1lJxs+DPRxLwebQmkpHMKOt9ojGPgzkPd6cBcx3sV
   E58YA2atFDECPQXQOwurgkb/U2LrpSWXD7FC1fm11Mzg97NKeQevUZkVk
   A==;
X-CSE-ConnectionGUID: caaG8fpJQ+CKsopAC0AwQg==
X-CSE-MsgGUID: fKRZ4x+ORjOzhIKgSMx/iQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12849198"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12849198"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:51:26 -0700
X-CSE-ConnectionGUID: kV+DTLX5TM2e1mcBMw+bfg==
X-CSE-MsgGUID: lVQtMgJXRa2VAYNdoCWVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27606891"
Received: from rswoodsx-mobl.amr.corp.intel.com (HELO [10.213.167.100]) ([10.213.167.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:51:24 -0700
Message-ID: <848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
Date: Thu, 18 Apr 2024 08:24:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14
 NBLB-WAX9N quirk detection
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Brady Norander <bradynorander@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>, Mark Hasemeyer <markhas@chromium.org>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
 <20240418110453.10efcb60@sal.lan>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240418110453.10efcb60@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/18/24 05:04, Mauro Carvalho Chehab wrote:
> Em Thu, 18 Apr 2024 09:48:27 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> 
>> Newer Matebook D14 model comes with essx8336 and supports SOF,
>> but the initial models use the legacy driver, with a Realtek ALC 256
>> AC97 chip on it.
>>
>> The BIOS seems to be prepared to be used by both models, so
>> it contains an entry for ESSX8336 on its DSDT table.
>>
>> Add a quirk, as otherwise dspconfig driver will try to load
>> SOF, causing audio probe to fail.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> Worth to mention that I opened an issue on Github about that:
> 
> https://github.com/thesofproject/linux/issues/4934
> 
> I added there the ACPI DSDT table as a reference.

This sounds like an 'easy enough' fix, but I don't have a burning desire
to start adding quirks of this nature. To be clear, the entire support
of the ES8336 is an absolute nightmare that I've stopped looking at
completely given the lack of support of vendor/OEMs.

In this case, the ACPI table is completely wrong, we should try to
'mark' the ES8336 device as 'not present' or detect the presence of HDaudio.

Andy, what do you think and what would be your recommendation?

>> ---
>>  sound/hda/intel-dsp-config.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
>> index 6a384b922e4f..8e728f0585dd 100644
>> --- a/sound/hda/intel-dsp-config.c
>> +++ b/sound/hda/intel-dsp-config.c
>> @@ -46,6 +46,22 @@ static const struct snd_soc_acpi_codecs __maybe_unused essx_83x6 = {
>>   * - the first successful match will win
>>   */
>>  static const struct config_entry config_table[] = {
>> +	/* Quirks */
>> +	{
>> +		.flags = 0,	/* Model uses AC97 with Realtek ALC 256 */
>> +		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
>> +		.dmi_table = (const struct dmi_system_id []) {
>> +			{
>> +				.ident = "Huawei NBLB-WAX9N",
>> +				.matches = {
>> +					DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
>> +					DMI_MATCH(DMI_PRODUCT_NAME, "NBLB-WAX9N"),
>> +				}
>> +			},
>> +			{}
>> +		}
>> +	},
>> +
>>  /* Merrifield */
>>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
>>  	{

