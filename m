Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340E7B8360
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbjJDPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbjJDPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:16:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8D93;
        Wed,  4 Oct 2023 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696432597; x=1727968597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vH2FpBp/Jh+emhQL+yQf5eMDW7Ker5BK1A4xOIPfb8c=;
  b=e7RNUZ42PYiIA633DOjjbHCO0xrlys0Dp0wv0AOiis/Lm4mCVou1H7Hh
   6h9pEQ2HoGAYrXlxFAtOEy5ixN3LQJxdzSIs0gvjEX3PCfFmk8Q2oNawl
   JdJQOzuqpo7OkGLpsMIs6sRZtaNKYXR0Srx7+iUrq5qXKyw+2cHoRwLqR
   lYo3hcjB5lUPMW+OGfVqIW/YuCrZhl8P25APNHfz1dCAZHovIj2HIikZP
   gdiIgpq1326hm2TuyZbp6teJdDf8SxSshGicChpZOyRUCMLsoXFfz0M9f
   px7/KoIJVLHSup85kQD/dKSg0rKQkEnoAKXot7ZwSrW5djTFV6JGGmE+M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383101087"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="383101087"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="751336493"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="751336493"
Received: from mfmousa-mobl1.amr.corp.intel.com (HELO [10.212.98.56]) ([10.212.98.56])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:16:11 -0700
Message-ID: <04c5911a-a894-44b3-9f0e-fe9e6de203f2@linux.intel.com>
Date:   Wed, 4 Oct 2023 11:16:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
 <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
 <2023100452-craziness-unpopular-7d97@gregkh>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2023100452-craziness-unpopular-7d97@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> If same devices with same device IDs are present on different soundwire
>>>>> buses, the probe fails due to conflicting device names and sysfs
>>>>> entries:
>>>>>
>>>>>   sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'
>>>>>
>>>>> The link ID is 0 for both devices, so they should be differentiated by
>>>>> bus ID.  Add the bus ID so, the device names and sysfs entries look
>>>>> like:
>>>>
>>>> I am pretty sure this will break Intel platforms by changing the device
>>>> names.
>>>>
>>>> sof_sdw.c:      else if (is_unique_device(adr_link, sdw_version, mfg_id,
>>>> part_id,
>>>> sof_sdw.c:
>>>> "sdw:%01x:%04x:%04x:%02x", link_id,
>>>> sof_sdw.c:
>>>> "sdw:%01x:%04x:%04x:%02x:%01x", link_id,
>>>
>>> device id name changes shouldn't break things, what is requring them to
>>> look a specific way?
>>
>> it's the ASoC dailink creation that relies on strings, we have similar
>> cases for I2C.
>>
>> There's no requirement that the name follows any specific convention,
>> just that when you want to rely on a specific device for an ASoC card
>> you need to use the string that matches its device name.
> 
> matching the name is fine (if you are matching it against an existing
> name) but expecting the name to be anything specific is not going to
> work as the name is dynamic and can/will change each boot.

Not following, sorry.

In the SoundWire context, the device name directly follows the ACPI or
Device Tree information, I don't really see how its name could change on
each boot (assuming no DSDT override or overlays of course). The
platform descriptors are pretty much fixed, aren't they?

Intel and AMD make such assumptions on names for pretty much all machine
drivers, it's not really something new - probably 15+ years? Adding Mark
Brown in CC: to make sure he's aware of this thread.
