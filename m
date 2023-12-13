Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA581099D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjLMFtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLMFtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:49:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46BD5;
        Tue, 12 Dec 2023 21:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702446559; x=1733982559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SsaQkpHhN6qwDUl/4cB55YY56chz5bCm3Ro9s3TVmKM=;
  b=dQl/4FVOeDEG0GoZjjoax0TKTaMEZjWbDLCvjFezGzwmQ0ClcIB+DF3z
   PalY1rztemxAYFLgx/i0Mp5+Rn/ZjrGG3w8FNFG7HNkAjKXrok2qomVQZ
   bfMYbxmvNWi9E+y2/1olJ/uS2oeCCWU8P6kKgAtoZOpONaxi7cS6dlrUX
   3QUpqo/VTiVGGn5htyne0/06zv/8ej7TKugHPEC3QSYY6qZnaSLKpErpT
   CowMGwspMOQoKvD39ZIg5F64k7LFmHXwfTLNFKEUaHgva8Go6ftjfRmz2
   E++JzfxwYXx+1LlCeP4hFN3jpZEuumqtZlgUAz2dyrUMbrxdYgwuFFIRW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8277349"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8277349"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 21:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="749989441"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="749989441"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 21:49:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 62FE91A7; Wed, 13 Dec 2023 07:49:14 +0200 (EET)
Date:   Wed, 13 Dec 2023 07:49:14 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <Sanath.S@amd.com>
Cc:     mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231213054914.GI1074920@black.fi.intel.com>
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212191635.2022520-3-Sanath.S@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
> Boot firmware might have created tunnels of its own. Since we cannot
> be sure they are usable for us. Tear them down and reset the ports
> to handle it as a new hotplug for USB3 routers.
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> ---
>  drivers/thunderbolt/tb.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index fd49f86e0353..febd0b6972e3 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
>  	tb_switch_tmu_enable(tb->root_switch);
>  	/* Full scan to discover devices added before the driver was loaded. */
>  	tb_scan_switch(tb->root_switch);
> +	/*
> +	 * Boot firmware might have created tunnels of its own. Since we cannot
> +	 * be sure they are usable for us, Tear them down and reset the ports
> +	 * to handle it as new hotplug for USB4 routers.
> +	 */
> +	if (tb_switch_is_usb4(tb->root_switch)) {
> +		tb_switch_discover_tunnels(tb->root_switch,
> +					   &tcm->tunnel_list, false);

Why this is needed?

It should be enough, to do simply something like this:

	if (tb_switch_is_usb4(tb->root_switch))
		tb_switch_reset(tb->root_switch);

and continue with the rest of the function. The tb_switch_reset() then
resets the downstream ports synchronously so when it returns there is
nothing to be discover.

(We can use the tb_switch_reset() here, it already exists and is
performing TBT 1 specific things but you can make it handle downstream
port reset in case of USB4).

You don't need to touch the ->hotplug_active or anything else here.

> +		tcm->hotplug_active = true;
> +		return tb_switch_reset_ports(tb->root_switch);
> +	}
>  	/* Find out tunnels created by the boot firmware */
>  	tb_discover_tunnels(tb);
>  	/* Add DP resources from the DP tunnels created by the boot firmware */
> -- 
> 2.34.1
