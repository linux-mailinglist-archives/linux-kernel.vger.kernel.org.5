Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10277F4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350142AbjHQLDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350164AbjHQLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:03:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C262D71;
        Thu, 17 Aug 2023 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692270181; x=1723806181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4KDflPvYHYsI19UNCE8oAXqAdU7EggqC7jF4teYZRr4=;
  b=brC/X9OnB+h99sIDW30H2GFJZVIv/TjQAbV7kHyNzfkrum5KHWyS+TeQ
   kD7ZuaDAcN57RytD25GrejBjVNX2wLJGb0jVAJ+ATWVNNkjq/V+pjTgri
   YxRtQsSnhcPrjNtVjOaKmXjxCdNbEN5utGfgeEHl/0//9nNNHq6B1aWeR
   azyfR7Xa+DQDI+IADMZ/QnJ1Zo7Q8b1TEIG3vxQ788OJRc7YYTu1ymxts
   F4kIy9PE/WsbptZHyzquJG7YgJpI60Y9fNCF75o62aoJxpI3yXZhvaelC
   0oziO+zFWfhHFCb1NHyFqdgTxlN/+OiEPRUR0yjE+4oaXjeBJDmRMd4Pu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376516536"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="376516536"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 04:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824590709"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="824590709"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 04:02:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWamF-008QUh-36;
        Thu, 17 Aug 2023 14:02:55 +0300
Date:   Thu, 17 Aug 2023 14:02:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] of/platform: increase refcount of fwnode
Message-ID: <ZN3+XzfK00vXPiHO@smile.fi.intel.com>
References: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
 <ZN39I7w4ARc0WLnI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN39I7w4ARc0WLnI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:57:39PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 12, 2023 at 08:24:11PM +0800, Peng Fan (OSS) wrote:

...

> > -	device_set_node(&dev->dev, of_fwnode_handle(node));
> > +	device_set_node(&dev->dev, fwnode_handle_get(fwnode));
> 
> Ditto.

Actually no, amba_device_alloc() does not use platform_device_alloc() and
defines it's own .release method. There is no reference count drop there
AFAICS.

-- 
With Best Regards,
Andy Shevchenko


