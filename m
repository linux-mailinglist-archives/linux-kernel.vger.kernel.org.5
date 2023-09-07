Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9979769B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjIGQNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbjIGQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:12:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40981AD20;
        Thu,  7 Sep 2023 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102977; x=1725638977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KiWWo5ZdTxhRmlpWM3C4+Ct7kECXOtwevYtY5xYN8cE=;
  b=e6XcuZlL9UViTu2QNuwoqsNp8p3WlbygM6LxaXPShQRnlOPHz9vSUW4p
   asTZY4QuNiBypi5G+Tu9uzc+a7bH8KIrQ//BdoEtgzItHz2jAq8ZT6HW3
   icbztfGVrUfmRx4v5fyqK6bUukNDi8pobofbm7NC6isMDLhJg2dW8YzO8
   D/pkwt1zKy1w1Ufj8GKGBNkCuAhf4VAHPR3hvaFLx/dY9eP08axInAQTo
   zk5DtZIXxhP1QPPNmpI5jTBTjTlL7XnD2CCXxmt5wixj4DwPC6hrZ83S1
   gFuEooC4590FOruRAMSQ6gchE/m3dAHeAzpNrmI2GowqEZVgCgxZW0LrU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="362448233"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="362448233"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="777113375"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="777113375"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.29.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:46:05 -0700
Date:   Thu, 7 Sep 2023 08:46:04 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Message-ID: <ZPnwPDZrKYT7hp6X@aschofie-mobl2>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:20:54PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Devices can optionally support Dynamic Capacity (DC).  These devices are
> known as Dynamic Capacity Devices (DCD).

snip

> 
> +static enum cxl_region_mode
> +cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
> +	case CXL_DECODER_NONE:
> +		return CXL_REGION_NONE;
> +	case CXL_DECODER_RAM:
> +		return CXL_REGION_RAM;
> +	case CXL_DECODER_PMEM:
> +		return CXL_REGION_PMEM;
> +	case CXL_DECODER_DEAD:
> +		return CXL_REGION_DEAD;
> +	case CXL_DECODER_MIXED:
> +	default:
> +		return CXL_REGION_MIXED;
> +	}
> +
> +	return CXL_REGION_MIXED;

Can the paths to return _MIXED be simplified here?


> +}
> +
snip

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cd4a9ffdacc7..ed282dcd5cf5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -374,6 +374,28 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  	return "mixed";
>  }
>  
> +enum cxl_region_mode {
> +	CXL_REGION_NONE,
> +	CXL_REGION_RAM,
> +	CXL_REGION_PMEM,
> +	CXL_REGION_MIXED,
> +	CXL_REGION_DEAD,
> +};

I'm concerned about _DEAD.
At first I was going to say name these as CXL_REGION_MODE_*, but it's
pretty obvious that these are mode words...except for DEAD. Is that 
an actual mode or is it some type of status? I don't think I see it
used yet.

> +
> +static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
> +{
> +	static const char * const names[] = {
> +		[CXL_REGION_NONE] = "none",
> +		[CXL_REGION_RAM] = "ram",
> +		[CXL_REGION_PMEM] = "pmem",
> +		[CXL_REGION_MIXED] = "mixed",
> +	};
> +
> +	if (mode >= CXL_REGION_NONE && mode <= CXL_REGION_MIXED)
> +		return names[mode];
> +	return "mixed";
> +}

snip

> +
>  /**
>   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
>   *
> @@ -449,6 +464,8 @@ struct cxl_dev_state {
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
>   * @total_bytes: sum of all possible capacities
> + * @static_cap: Sum of RAM and PMEM capacities
> + * @dynamic_cap: Complete DPA range occupied by DC regions

Wondering about renaming RAM and PMEM caps as 'static'.
They are changeable via set partition commands.


>   * @volatile_only_bytes: hard volatile capacity
>   * @persistent_only_bytes: hard persistent capacity
>   * @partition_align_bytes: alignment size for partition-able capacity
> @@ -456,6 +473,10 @@ struct cxl_dev_state {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> + * @nr_dc_region: number of DC regions implemented in the memory device
> + * @dc_region: array containing info about the DC regions
> + * @dc_event_log_size: The number of events the device can store in the
> + * Dynamic Capacity Event Log before it overflows
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @fw: firmware upload / activation state
> @@ -473,7 +494,10 @@ struct cxl_memdev_state {
>  	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> +
>  	u64 total_bytes;
> +	u64 static_cap;
> +	u64 dynamic_cap;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> @@ -481,6 +505,11 @@ struct cxl_memdev_state {
>  	u64 active_persistent_bytes;
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
> +
> +	u8 nr_dc_region;
> +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +	size_t dc_event_log_size;
> +
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
> @@ -587,6 +616,7 @@ struct cxl_mbox_identify {
>  	__le16 inject_poison_limit;
>  	u8 poison_caps;
>  	u8 qos_telemetry_caps;
> +	__le16 dc_event_log_size;
>  } __packed;
>  

snip

>  /*
