Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B06979E56F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbjIMK4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbjIMK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:56:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83119AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694602568; x=1726138568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7zKWllqNpufIGQKkp3M02DaPOPfaIyuVruYujMZGUaI=;
  b=TBicL/mAeNx1CoK8V4Lh0lotIXBzAy7nEGWnnMAH/gWFwm9GmiRDcCWu
   qM/EQPZSokebmMIMd3B60Cs78f1vQrhm6V44tIJJ9jHGk7gJhX2a4g2zh
   +o0i4VhuiXE5Z+YVtP5OwTiz6KT4rKNNKFBFU7tRJ3zeu88NzoKWL+Zmc
   3Ro8+Qj78I+ACOPhVT+2zI5PjPnyktZzyUPoPW1o8oeT32XXVy7URXti1
   Io1rV+8uAAzFmyALSu9/09UvEUlsH5P8l7nu4BQx8etjYkKdV41afaPhj
   piVLjl7zS/dUBGig5b0Freh/hcn5Poqc48Ljk/P3xhx95BkNf8hq+v471
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464996430"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="464996430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693810585"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693810585"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:56:05 -0700
Message-ID: <92b2b69e-3175-651f-45bb-d9ae11eaec82@linux.intel.com>
Date:   Wed, 13 Sep 2023 12:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] ASoC: soc-card: Add storage for PCI SSID
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
 <20230912163207.3498161-2-rf@opensource.cirrus.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230912163207.3498161-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 6:32 PM, Richard Fitzgerald wrote:
> Add members to struct snd_soc_card to store the PCI subsystem ID (SSID)
> of the soundcard.
> 
> The PCI specification provides two registers to store a vendor-specific
> SSID that can be read by drivers to uniquely identify a particular
> "soundcard". This is defined in the PCI specification to distinguish
> products that use the same silicon (and therefore have the same silicon
> ID) so that product-specific differences can be applied.
> 
> PCI only defines 0xFFFF as an invalid value. 0x0000 is not defined as
> invalid. So the usual pattern of zero-filling the struct and then
> assuming a zero value unset will not work. A flag is included to
> indicate when the SSID information has been filled in.
> 
> Unlike DMI information, which has a free-format entirely up to the vendor,
> the PCI SSID has a strictly defined format and a registry of vendor IDs.
> 
> It is usual in Windows drivers that the SSID is used as the sole identifier
> of the specific end-product and the Windows driver contains tables mapping
> that to information about the hardware setup, rather than using ACPI
> properties.
> 
> This SSID is important information for ASoC components that need to apply
> hardware-specific configuration on PCI-based systems.
> 
> As the SSID is a generic part of the PCI specification and is treated as
> identifying the "soundcard", it is reasonable to include this information
> in struct snd_soc_card, instead of components inventing their own custom
> ways to pass this information around.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>   include/sound/soc-card.h | 37 +++++++++++++++++++++++++++++++++++++
>   include/sound/soc.h      | 11 +++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
> index fc94dfb0021f..e8ff2e089cd0 100644
> --- a/include/sound/soc-card.h
> +++ b/include/sound/soc-card.h

...

> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 509386ff5212..81ed08c5c67d 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -929,6 +929,17 @@ struct snd_soc_card {
>   #ifdef CONFIG_DMI
>   	char dmi_longname[80];
>   #endif /* CONFIG_DMI */
> +
> +#ifdef CONFIG_PCI
> +	/*
> +	 * PCI does not define 0 as invalid, so pci_subsystem_set indicates
> +	 * whether a value has been written to these fields.
> +	 */
> +	unsigned short pci_subsystem_vendor;
> +	unsigned short pci_subsystem_device;
> +	bool pci_subsystem_set;
> +#endif /* CONFIG_PCI */
> +
>   	char topology_shortname[32];
>   
>   	struct device *dev;

This looks bit weird to me, snd_soc_card is _generic_ struct which is 
not device specific in any way, and now you add fields for PCI, can't 
this somehow be done using drvdata or something?

