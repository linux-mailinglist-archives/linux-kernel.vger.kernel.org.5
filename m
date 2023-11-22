Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702A57F3DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjKVGD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:03:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76C195;
        Tue, 21 Nov 2023 22:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700633001; x=1732169001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yATNtj3wW2LygmD49BqRPnSuheX1Fu8t/llE27t5hB4=;
  b=imO+seTEQ9stykD7UNrqjG9xY2m+ad4XPEjtICspw/aFNBPVUNd3EWja
   MY1CvqfSBXo+/i3SEb9Ig24CxHBfry/XOxg+gvqBO/niRXek/olivGl3b
   giqBeFqgoEqzP1OiaqfwwMisQoMG302R9pGViyGrVAMwxPRwkkj4arJPK
   uwjFynY+cmZnKTrydfp6ucXmyyFlB1I+vqQLWmur6s5uBpiL99fgkPIlR
   Rq1wowtKlEWYjyBiYEyS1fG71Fb+tunaE5HaCRU24uNLefhaN5dpCbrtU
   il9dkSgIQsck6NXdkSFGnICN92f7vlLM9AqSzOr1Q1acC6asFKcaGzB3m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5127747"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="5127747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 22:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743284439"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="743284439"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2023 22:03:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 67E49291; Wed, 22 Nov 2023 08:03:16 +0200 (EET)
Date:   Wed, 22 Nov 2023 08:03:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <Sanath.S@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        stable@vger.kernel.org
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
Message-ID: <20231122060316.GT1074920@black.fi.intel.com>
References: <20231122050639.19651-1-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122050639.19651-1-Sanath.S@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 22, 2023 at 10:36:39AM +0530, Sanath S wrote:
> Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
> very minimal buses for PCIe downstream ports. This results in
> failure to extend the daisy chain.
> 
> Add quirk to reset the downstream port to help reset the topology
> created by boot firmware.

But this resets the USB4 side of ports, how does this help with the PCIe
side? Or this also resets the PCIe side? Please add this information to
the changelog too.

I suppose it is not possible to fix the boot firmware?

> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> Fixes: e390909ac763 ("thunderbolt: Add vendor specific NHI quirk for auto-clearing interrupt status")
> Cc: <stable@vger.kernel.org>
> ---
> Changes since v1:
>  - Initialize ret variable to avoid compiler warning.
>  - Add Fixes tag with commit id. 
> ---
> 
>  drivers/thunderbolt/quirks.c  | 14 ++++++++++++++
>  drivers/thunderbolt/switch.c  | 28 ++++++++++++++++++++++++++++
>  drivers/thunderbolt/tb.h      |  2 ++
>  drivers/thunderbolt/tb_regs.h |  1 +
>  4 files changed, 45 insertions(+)
> 
> diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
> index e6bfa63b40ae..45e9d6c43e4a 100644
> --- a/drivers/thunderbolt/quirks.c
> +++ b/drivers/thunderbolt/quirks.c
> @@ -27,6 +27,12 @@ static void quirk_clx_disable(struct tb_switch *sw)
>  	tb_sw_dbg(sw, "disabling CL states\n");
>  }
>  
> +static void quirk_amd_downstream_port_reset(struct tb_switch *sw)
> +{
> +	sw->quirks |= QUIRK_DPR;
> +	tb_sw_dbg(sw, "Resetting Down Stream Port\n");

That's "resetting downstream ports\n"

> +}
> +
>  static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
>  {
>  	struct tb_port *port;
> @@ -93,6 +99,14 @@ static const struct tb_quirk tb_quirks[] = {
>  	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
>  	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
>  	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
> +	/*
> +	 * Reset Down Stream Ports on AMD USB4 Yellow Carp and
> +	 * Pink Sardine platforms.
> +	 */
> +	{ 0x0438, 0x0208, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
> +	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
> +	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
> +	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
>  };
>  
>  /**
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 1e15ffa79295..1c4b1dd5f472 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -1547,6 +1547,23 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>  	       regs->__unknown1, regs->__unknown4);
>  }
>  
> +static int tb_switch_reset_downstream_port(struct tb_switch *sw)
> +{
> +	struct tb_port *port;
> +	uint32_t val = 0;

u32

> +	int ret = -1;

What is -1? Please use proper error codes.

> +
> +	tb_switch_for_each_port(sw, port) {
> +		if (port->config.type == TB_TYPE_PORT) {

You mean 

	tb_port_is_null()

also please make it a separate function, tb_port_reset() following the
similar tb_port_unlock() and friends. With the matching kernel-doc and
everything.

> +			val = val | PORT_CS_19_DPR;
> +			ret = tb_port_write(port, &val, TB_CFG_PORT,
> +					port->cap_usb4 + PORT_CS_19, 1);

Since it is using cap_usb4 you probably need to make usb4_port_reset()
as well that gets called from tb_port_reset() (try to make it as simple
as possible though).

> +			break;

It is OK just to reset one port?

> +		}
> +	}
> +	return ret;
> +}
> +
>  /**
>   * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
>   * @sw: Switch to reset
> @@ -3201,6 +3218,17 @@ int tb_switch_add(struct tb_switch *sw)
>  			return ret;
>  	}
>  
> +	/*
> +	 * PCIe resource allocated by boot firmware is not utilizing all the
> +	 * available buses, So perform reset of topology to avoid failure in
> +	 * extending daisy chain.
> +	 */

This comment should be inside the quirk, not here.

> +	if (sw->quirks & QUIRK_DPR) {
> +		ret = tb_switch_reset_downstream_port(sw);

And the name of the function should be tb_switch_reset_ports() or so.

> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = tb_switch_port_hotplug_enable(sw);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e299e53473ae..7a9ff53be67a 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -23,6 +23,8 @@
>  #define QUIRK_FORCE_POWER_LINK_CONTROLLER		BIT(0)
>  /* Disable CLx if not supported */
>  #define QUIRK_NO_CLX					BIT(1)
> +/* Reset Down Stream Port */
> +#define QUIRK_DPR					BIT(2)
>  
>  /**
>   * struct tb_nvm - Structure holding NVM information
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 87e4795275fe..d49530bc0d53 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>  #define PORT_CS_18_CSA				BIT(22)
>  #define PORT_CS_18_TIP				BIT(24)
>  #define PORT_CS_19				0x13
> +#define PORT_CS_19_DPR				BIT(0)
>  #define PORT_CS_19_PC				BIT(3)
>  #define PORT_CS_19_PID				BIT(4)
>  #define PORT_CS_19_WOC				BIT(16)
> -- 
> 2.34.1
