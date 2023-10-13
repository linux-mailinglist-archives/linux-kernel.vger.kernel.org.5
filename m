Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116597C8DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjJMTzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjJMTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:55:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC56AD;
        Fri, 13 Oct 2023 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697226913; x=1728762913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=68JJ7XqWYEhdYbfx8XacG3bVDmgPmxyq3uAcgh/iPk0=;
  b=b8hPO4coDHsZ0rJobn+z+deb/ozYCCDrPYjWoE23eaC+PiLjroWo5Wjh
   m5hqk2K/bPKWmCIwDnbPl5KbIxCwFRfvJWE+l6mqJsM/p1oWLMXW4Rjob
   ju4C5rFNbhLaCc0k9peEKVWzBMA/hnB+R5HaSdSgE20F3hLwO2BrVZjO+
   L1Kk3amqJQsOr/fElv12oKv8QFeuriby7x/G7aMdLar8NeH/ThglYFhmK
   0ui1ICr/B0hHZam7SKJpHpNbIEfCgp+2UACu5Qt3qVWnkwQdGTdhIFrI8
   IqFp66vTXUsePAwnNdPfFhnQ2t00/XWNeUgbc2qgh2F1/SdAXkBkbbflt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="365519011"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="365519011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 12:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="898685373"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="898685373"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 12:53:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qrOFY-00000005Js9-0vUI;
        Fri, 13 Oct 2023 22:55:08 +0300
Date:   Fri, 13 Oct 2023 22:55:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hongren Zheng <i@zenithal.me>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH -next] usb/usbip: fix wrong data added to platform device
Message-ID: <ZSmgmw+//ymBHtfN@smile.fi.intel.com>
References: <ZSkhWa5wmAGsAdCK@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkhWa5wmAGsAdCK@Sun>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 06:52:09PM +0800, Hongren Zheng wrote:
> .data of platform_device_info will be copied into .platform_data of
> struct device via platform_device_add_data.
> 
> However, vhcis[i] contains a spinlock, is dynamically allocated and
> used by other code, so it is not meant to be copied. The workaround
> was to use void *vhci as an agent, but it was removed in the commit
> suggested below.
> 
> This patch adds back the workaround and changes the way of using
> platform_data accordingly.

Thanks for fixing this.

...

> -	struct vhci *vhci = dev_get_platdata(hcd->self.controller);

> -

The blank line here is on purpose.

> +	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));

-- 
With Best Regards,
Andy Shevchenko


