Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D327D4FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjJXMRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJXMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:17:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A29A2;
        Tue, 24 Oct 2023 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698149854; x=1729685854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wuBMd3mo+5ZEGiZ3gwI9A1ReTEQWMLj66Y1biRz0ulw=;
  b=ZgR1IZJWSokh3u0a7yTLfBwAkCRlBUy8LxFeMaMfA4JEU4gApFx3Temh
   YZmEHXh8QAOZpvyPIxgoFYY2alVw30Ln8Q9v5gYC3T1Pvppkuo4WzmxcK
   LF/x+x93Xgmf0SuT6Xyf8syTVaYyKojxy8ou6YFgrkECx0Ky+Qztbity9
   vSfd+k/ohoSdnZSRn1/5pv4seV20LhavZrixmHZsMiTJL9pzDMY/f/32c
   +3cAh75M7PNMIr+1DTky2Bx3pd+eNwoQofdlic8KnzQu5YdJhudQoS8SN
   DNeSJ4eprHsaAbxQVpQc+XjA3lsMkZLBELb57tVbWzn00cZXq2AD6auKM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="451273155"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="451273155"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="902149502"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="902149502"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:15:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qvGLe-00000008HMX-3G6I;
        Tue, 24 Oct 2023 15:17:26 +0300
Date:   Tue, 24 Oct 2023 15:17:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <ZTe11rbKgcusPRD/@smile.fi.intel.com>
References: <20231024113624.54364-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024113624.54364-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 02:36:18PM +0300, Tony Lindgren wrote:
> Let's move tty and serdev controller to be children of the serial core port
> device. This way the runtime PM usage count of a child device propagates
> to the serial hardware device.
> 
> The tty and serdev devices are associated with a specific serial port of
> a serial hardware controller device, and we now have serial core hierarchy
> of controllers and ports.
> 
> The tty device moves happily with just a change of the parent device.
> The serdev device init needs some changes to separate the serial hardware
> controller device from the parent device.

...

> -	ctrl->dev.of_node = parent->of_node;
> +	ctrl->dev.of_node = host->of_node;

Even above should have been using device_set_node(&ctrl->dev, dev_fwnode(host)).

...

>  	/* Make sure controller and ResourceSource handle match */
> -	if (ACPI_HANDLE(ctrl->dev.parent) != lookup.controller_handle)
> +	if (ACPI_HANDLE(ctrl->host) != lookup.controller_handle)

This can be changed to use device_match_acpi_handle().

>  		return -ENODEV;

...

> -	if (!has_acpi_companion(ctrl->dev.parent))
> +	if (!has_acpi_companion(ctrl->host))

I prefer is_acpi_device_node(dev_fwnode(...)) check, but here seems no other
use for fwnode (haven't checked the full context, though).

>  		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko


