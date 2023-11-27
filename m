Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16097FA926
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjK0Slh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0Slg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:41:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD4119B;
        Mon, 27 Nov 2023 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701110502; x=1732646502;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ocdAfY8jzn+hMTXj3yEo5xBI/FMZYl5m4SnwH6zy1iQ=;
  b=WrP7Sepx1wpxKfH70ZtzRBacTYrA02L6m2GpkDbiicKWyc3gVgaEb2KE
   r0AuYGEMG8j4mprHXeCcerHlk0p53y5ns1N0x6hPPLwR0DDJR3eOqT6lj
   +iKBsFVqr9KqctPFYWuiTLnsX0DFKVTk+4JC7e1UuLEkzuxeVosZGSRNx
   sqVOTVMnNH/x5bqObRAogvXb0QjJBhoyTQLdtaThUgx9NzAQlviu8v3/T
   NL/orWzXZgMmwpJOFHhU5XfztdfYl0g9nuJ07keJMJOiPWvnXAbyxhGWa
   vlt4XnEgl0cIPQpJoYhaZZQ7HCXY1asxl0CwmjwYJrGxYagAUZEGNrf4X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="392517688"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="392517688"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="891820937"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="891820937"
Received: from alanpai-mobl.amr.corp.intel.com (HELO [10.209.65.171]) ([10.209.65.171])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:41:41 -0800
Message-ID: <a177e7c1-3a28-464e-888f-315df72d528c@linux.intel.com>
Date:   Mon, 27 Nov 2023 11:44:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix NULL pointer dereference for
 multi_link
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/23 12:01, Krzysztof Kozlowski wrote:
> If bus is marked as multi_link, but number of masters in the stream is
> not higher than bus->hw_sync_min_links (bus->multi_link && m_rt_count >=
> bus->hw_sync_min_links), bank switching should not happen.  The first
> part of do_bank_switch() code properly takes these conditions into
> account, but second part (sdw_ml_sync_bank_switch()) relies purely on
> bus->multi_link property.  This is not balanced and leads to NULL
> pointer dereference:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   ...
>   Call trace:
>    wait_for_completion_timeout+0x124/0x1f0
>    do_bank_switch+0x370/0x6f8
>    sdw_prepare_stream+0x2d0/0x438
>    qcom_snd_sdw_prepare+0xa0/0x118
>    sm8450_snd_prepare+0x128/0x148
>    snd_soc_link_prepare+0x5c/0xe8
>    __soc_pcm_prepare+0x28/0x1ec
>    dpcm_be_dai_prepare+0x1e0/0x2c0
>    dpcm_fe_dai_prepare+0x108/0x28c
>    snd_pcm_do_prepare+0x44/0x68
>    snd_pcm_action_single+0x54/0xc0
>    snd_pcm_action_nonatomic+0xe4/0xec
>    snd_pcm_prepare+0xc4/0x114
>    snd_pcm_common_ioctl+0x1154/0x1cc0
>    snd_pcm_ioctl+0x54/0x74
> 
> Fixes: ce6e74d008ff ("soundwire: Add support for multi link bank switch")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

LGTM, thanks for the patch.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  drivers/soundwire/stream.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 9dc6399f206a..f9c0adc0738d 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -742,14 +742,15 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
>   * sdw_ml_sync_bank_switch: Multilink register bank switch
>   *
>   * @bus: SDW bus instance
> + * @multi_link: whether this is a multi-link stream with hardware-based sync
>   *
>   * Caller function should free the buffers on error
>   */
> -static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
> +static int sdw_ml_sync_bank_switch(struct sdw_bus *bus, bool multi_link)
>  {
>  	unsigned long time_left;
>  
> -	if (!bus->multi_link)
> +	if (!multi_link)
>  		return 0;
>  
>  	/* Wait for completion of transfer */
> @@ -847,7 +848,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>  			bus->bank_switch_timeout = DEFAULT_BANK_SWITCH_TIMEOUT;
>  
>  		/* Check if bank switch was successful */
> -		ret = sdw_ml_sync_bank_switch(bus);
> +		ret = sdw_ml_sync_bank_switch(bus, multi_link);
>  		if (ret < 0) {
>  			dev_err(bus->dev,
>  				"multi link bank switch failed: %d\n", ret);
