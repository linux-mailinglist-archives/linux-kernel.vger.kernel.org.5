Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85BE805B71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346874AbjLEQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346946AbjLEQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:01:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199A1D40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792071; x=1733328071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eX8OhMZSokhyU5v3JSffkIZ6nySYH16Uvt5sYcjUftY=;
  b=VtLYzU3dimITen+LWO7xKXkTG6+1Bkla028AUm4ZWNPmvcw+u3GTCMWk
   AOlsFLG0Hy3ABZha0u78MvTU9xEnMZPIBwqwwYwNd0OYUuPWDfrZ0avz/
   2QZpNlBig2cmb8Qrmg5bp5x6IHsHwoTW3Fi6p2HlbUjiqR2tDqDWUB/iV
   L8PrtA5UXpOHZq88tiTG0qKJGr54U8pDTm4UpsMX49rT+X/sIaxvWbZ7j
   XVlDdp9SIrLvdm3KYRjUm4pU9paRAMqhPlDSuXTWxqmoGAMyVfN9V+NVI
   0gNSBmmQMYXRh1v6GCyykbalvMutUvpfW6dDyRhE/FZemVRUNp09gELKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="758200"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="758200"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:01:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="914845112"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="914845112"
Received: from mbapna-mobl1.amr.corp.intel.com (HELO [10.212.151.198]) ([10.212.151.198])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:01:09 -0800
Message-ID: <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
Date:   Tue, 5 Dec 2023 10:01:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
Content-Language: en-US
To:     Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <cover.1701733441.git.soyer@irl.hu>
 <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
 <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
 <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +
>>> +static void tas2563_fixup_i2c(struct hda_codec *cdc,
>>> +	const struct hda_fixup *fix, int action)
>>> +{
>>> +	 tas2xxx_generic_fixup(cdc, action, "i2c", "INT8866");
>>
>> Any specific reason to use an Intel ACPI identifier? Why not use
>> "TIAS2563" ?
>>
> INT8866 is in the ACPI.
> I don't know why Lenovo uses this name.
> I think it's more internal than intel.
> 
>    Scope (_SB.I2CD)
>     {
>         Device (TAS)
>         {
>             Name (_HID, "INT8866")  // _HID: Hardware ID

Ouch, I hope they checked with Intel that this isn't an HID already in
use...

>             Name (_UID, Zero)  // _UID: Unique ID
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource
> Settings
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     I2cSerialBusV2 (0x004C, ControllerInitiated,
> 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.I2CD",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                     I2cSerialBusV2 (0x004D, ControllerInitiated,
> 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.I2CD",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                     GpioInt (Edge, ActiveLow, SharedAndWake, PullNone,
> 0x0000,
>                         "\\_SB.GPIO", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0020
>                         }
>                 })
>                 Return (RBUF) /* \_SB_.I2CD.TAS_._CRS.RBUF */
>             }
> 
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }
>         }
>     }

>>> +static int tas2563_system_resume(struct device *dev)
>>> +{
>>> +	int ret;
>>> +	struct tas2563_data *tas2563 = dev_get_drvdata(dev);
>>> +
>>> +	dev_dbg(tas2563->dev, "System Resume\n");
>>> +
>>> +	ret = pm_runtime_force_resume(dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	for (int i = 0; i < tas2563->ndev; ++i)
>>> +		tas2563_tasdev_setup(tas2563, &tas2563->tasdevs[i]);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops tas2563_hda_pm_ops = {
>>> +	SYSTEM_SLEEP_PM_OPS(tas2563_system_suspend, tas2563_system_resume)
>>
>> where's the pm_runtime stuff?
>>
> 
> The amp stores its state in software shutdown mode.
> The tas2563_hda_playback_hook wakes/shutdowns the amp, not the
> pm_runtime.

My point was that you have all these pm_runtime_ calls in the code, but
nothing that provides pm_runtime suspend-resume functions so not sure
what exactly the result is?


