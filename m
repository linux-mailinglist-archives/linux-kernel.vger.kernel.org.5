Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3647B8099
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbjJDNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbjJDNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:16:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BDFE4;
        Wed,  4 Oct 2023 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696425410; x=1727961410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J7FWRujScPWtK9aYMSMLSqxeUcL9YGPo2NYKLZhT1DU=;
  b=ZhcgB74gh0utddU/FTDvguZr1Am7Hm2j4lIiKjP193R46WU9YH/fvK3I
   IXzy2RbqOiK9GclYtuuRaZlFqLRYWPqfZ8M41/ob2VG1fB8/mw6tM8LfQ
   xsTfDJDWgH66zYLPLRRpDB6TyeqCAss7VGJjw2tQUNEDAEItcMRPdiI98
   Ti9BIbB3d0Ah8LetRbJ+nXCe1rQvof8vgjtzym1UyABUjwZY6HLeQWRiF
   NDhw0ORJdWhP8fPi9gSMxAMai5Q6gXI2Pueqk6Bq+LDoDoDu8tUlGQVnW
   WmSg5Zu5nZ7RcPGcgLGhTUQcXOj/a3MOWxk2ntuqJKDklint56qQzqktF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383069838"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="383069838"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="821664266"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="821664266"
Received: from mfmousa-mobl1.amr.corp.intel.com (HELO [10.212.98.56]) ([10.212.98.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:16:48 -0700
Message-ID: <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
Date:   Wed, 4 Oct 2023 09:16:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
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



On 10/4/23 09:02, Krzysztof Kozlowski wrote:
> If same devices with same device IDs are present on different soundwire
> buses, the probe fails due to conflicting device names and sysfs
> entries:
> 
>   sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'
> 
> The link ID is 0 for both devices, so they should be differentiated by
> bus ID.  Add the bus ID so, the device names and sysfs entries look
> like:

I am pretty sure this will break Intel platforms by changing the device
names.

sof_sdw.c:      else if (is_unique_device(adr_link, sdw_version, mfg_id,
part_id,
sof_sdw.c:
"sdw:%01x:%04x:%04x:%02x", link_id,
sof_sdw.c:
"sdw:%01x:%04x:%04x:%02x:%01x", link_id,

> 
>   sdw:1:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6ab0000.soundwire-controller/sdw-master-1/sdw:1:0:0217:0204:00:0
>   sdw:3:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6b10000.soundwire-controller/sdw-master-3/sdw:3:0:0217:0204:00:0
> 
> Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Sending as RFT, because I did not test it on that many devices and
> user-spaces.
> ---
>  drivers/soundwire/slave.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index c1c1a2ac293a..4db43ea53d47 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -39,14 +39,14 @@ int sdw_slave_add(struct sdw_bus *bus,
>  	slave->dev.fwnode = fwnode;
>  
>  	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
> -		/* name shall be sdw:link:mfg:part:class */
> -		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
> -			     bus->link_id, id->mfg_id, id->part_id,
> +		/* name shall be sdw:bus:link:mfg:part:class */
> +		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x",
> +			     bus->id, bus->link_id, id->mfg_id, id->part_id,
>  			     id->class_id);
>  	} else {
> -		/* name shall be sdw:link:mfg:part:class:unique */
> -		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
> -			     bus->link_id, id->mfg_id, id->part_id,
> +		/* name shall be sdw:bus:link:mfg:part:class:unique */
> +		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x:%01x",
> +			     bus->id, bus->link_id, id->mfg_id, id->part_id,
>  			     id->class_id, id->unique_id);
>  	}
>  
