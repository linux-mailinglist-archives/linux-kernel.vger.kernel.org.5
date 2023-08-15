Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4125477C80E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjHOGpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjHOGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:45:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27110D4;
        Mon, 14 Aug 2023 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692081923; x=1723617923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvkfSiHy79k9Iz4p/AVVmgGnM9X12fXMJvvLNDHBJVE=;
  b=PvUldLZoLCFOk/WRrAboRwqGe5TmTjl3ubAD2tzqBujz0F7SZFHKAur9
   ly93F9+uRfhpjHhRuQM6lezw1QrGqsZIKUMxOqLx7Xs8HnKUjVKGSoBZI
   a22nyL6/KxEYt8Uargzr1417Bij5Lvv/xhQaCkK/Dv0uVFKHRM1zA27fu
   xs3jjFk3Rt8H2O+AHeDn08vT+uWq7CcfnHWAQqrs30F7FyuBgbt1tG4FW
   lFcnm/n9TKLFvDefDKfGhha/TguQ0Kw/RfaIsLN7Idwi8/WJ+C1uKWrdg
   CiVlva1vU31FVzrjvgzbp7cfFT8IkGLrwiUKKy3uM07j1+M9XifwSnLlx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372210526"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372210526"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803705192"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="803705192"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 23:45:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVnnq-006uvN-1Z;
        Tue, 15 Aug 2023 09:45:18 +0300
Date:   Tue, 15 Aug 2023 09:45:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] of/platform: increase refcount of fwnode
Message-ID: <ZNse/kwnG9WTc9cL@smile.fi.intel.com>
References: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 08:24:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> commit 0f8e5651095b
> ("of/platform: Propagate firmware node by calling device_set_node()")
> use of_fwnode_handle to replace of_node_get, which introduces a side
> effect that the refcount is not increased. Then the out of tree
> jailhouse hypervisor enable/disable test will trigger kernel dump in
> of_overlay_remove, with the following sequence
> "
>    of_changeset_revert(&overlay_changeset);
>    of_changeset_destroy(&overlay_changeset);
>    of_overlay_remove(&overlay_id);
> "
> 
> So increase the refcount to avoid issues.

Right, thank you for the report!
I was too busy to send myself a fix (I realized about the issue).
But what I think about this the actual platform code has to be balanced with
this. I dunno why we have OF code do one part and the platform core do the
other. It's not obvious and prone to mistakes (like I made).

Let me look to this closer.

-- 
With Best Regards,
Andy Shevchenko


