Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721687B8182
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbjJDN6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbjJDN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:58:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1350A1;
        Wed,  4 Oct 2023 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696427904; x=1727963904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3SSmzrdVmTT6GBfds2/816bKP42VZdCHe8cLBHXrSF0=;
  b=LbDsEN5BD8DSNQPhJ4cc2TH2vzN03NxKfGcExX3vNhlmhs6xjKK29Gob
   bALuygOTdK0NKDnRp/kwxpsraRdYKRgS0OcDnLRRthWvHMODTivXxkA4Q
   cZRIl7pLXSP0/i9FFh22EAcPZhydzdVYs4znYPQAaopeL1dST4ptF7scD
   dUA5r2nF7AYMpgS1dqRifvvoh5mLcueMBruQ8pz8cwyQ74yAYs5vKvj+Y
   37ZsggouO3z5Ddwu9Tb9VfId+1KFj3hERwT/N0FvOWUlPFYlhJdA9sRBS
   lFP7OPRjILjkz18/dyKleGM899Ze6QMCY1LTmwYanS4IXSRWV9lxnj9JX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363442889"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="363442889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="894959510"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="894959510"
Received: from mfmousa-mobl1.amr.corp.intel.com (HELO [10.212.98.56]) ([10.212.98.56])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:56:24 -0700
Message-ID: <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
Date:   Wed, 4 Oct 2023 09:57:49 -0400
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
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2023100453-perfected-palm-3503@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 09:38, Greg Kroah-Hartman wrote:
> On Wed, Oct 04, 2023 at 09:16:47AM -0400, Pierre-Louis Bossart wrote:
>>
>>
>> On 10/4/23 09:02, Krzysztof Kozlowski wrote:
>>> If same devices with same device IDs are present on different soundwire
>>> buses, the probe fails due to conflicting device names and sysfs
>>> entries:
>>>
>>>   sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'
>>>
>>> The link ID is 0 for both devices, so they should be differentiated by
>>> bus ID.  Add the bus ID so, the device names and sysfs entries look
>>> like:
>>
>> I am pretty sure this will break Intel platforms by changing the device
>> names.
>>
>> sof_sdw.c:      else if (is_unique_device(adr_link, sdw_version, mfg_id,
>> part_id,
>> sof_sdw.c:
>> "sdw:%01x:%04x:%04x:%02x", link_id,
>> sof_sdw.c:
>> "sdw:%01x:%04x:%04x:%02x:%01x", link_id,
> 
> device id name changes shouldn't break things, what is requring them to
> look a specific way?

it's the ASoC dailink creation that relies on strings, we have similar
cases for I2C.

There's no requirement that the name follows any specific convention,
just that when you want to rely on a specific device for an ASoC card
you need to use the string that matches its device name.

I am not sure how we would modify the Intel machine driver though
because the bus ID is IDA-based, so there's no way to predict what it
might be.
