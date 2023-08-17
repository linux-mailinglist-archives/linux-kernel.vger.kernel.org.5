Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A475577F499
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350070AbjHQK6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350058AbjHQK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:57:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9F32D4A;
        Thu, 17 Aug 2023 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692269863; x=1723805863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rm4f5NsR1biahPa3QrDVvCHt5rax9gbe6J/pvQJg2lA=;
  b=Y5B0bR6khgZUpMTiMxy0CfCMsC+PnyVU9VOe4vAgV5juveCso9X9mTfR
   eggmXe1E1ksez87FzVpCbgxlC4I3yOXLv2kye6wIrzGW3ntkvNdIAZPhI
   AzxpV9yTQ15QdoGI2Ajn6ujt6WWg06fczFoutQc10Cla7F3hk0P8ACB6b
   3E2kw3GDG90DHeqNAnbAYquOtqruANVAN9fphG3WiLYqE4WhzFkUkd4jO
   RAxUKbqCcW2tkkahnLUng/X8X5nlnq8GD5Kwu618Ek8NKtBMoLDW+5Y8S
   eSCgHQwTCoj0q7sjQ9d2CAiSyMhabuIHN0TKcRJlyg+8OM3nNR/IuRMHa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403758776"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403758776"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 03:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737674762"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="737674762"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 03:57:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWah9-008F1l-12;
        Thu, 17 Aug 2023 13:57:39 +0300
Date:   Thu, 17 Aug 2023 13:57:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] of/platform: increase refcount of fwnode
Message-ID: <ZN39I7w4ARc0WLnI@smile.fi.intel.com>
References: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

I was thinking about this and it's kind quite a tricky thing.
So, let's go with your patch after some modifications, see below.

With that, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	device_set_node(&dev->dev, of_fwnode_handle(np));
> +	device_set_node(&dev->dev, fwnode_handle_get(fwnode));

We know that we only handle OF node here, let's not involve other APIs,
so

	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));

...

> -	device_set_node(&dev->dev, of_fwnode_handle(node));
> +	device_set_node(&dev->dev, fwnode_handle_get(fwnode));

Ditto.

-- 
With Best Regards,
Andy Shevchenko


