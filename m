Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84E758D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGSFhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGSFhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:37:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD731BF2;
        Tue, 18 Jul 2023 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689745026; x=1721281026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rPqXENO5Ww3+OUQyh7MYgkuNKyGTe81yjcRh9MURA/4=;
  b=a4OI7mymA4rw0ras2vlMpGYmvpXmV5duxPnNLippLhdGyNZ3xI1NOk7z
   NgeLsTrkMkxQrkfhm5c9wSr665A87MM69mLLwAmdba6XKfgdGhD7vO20P
   pSxUScLXqGJwpDN1YikQHJMlYfsQy03F8KuKFkNqlGHRYwSvE12V6xRYk
   cZNtaMaMrZI7Nx2YU832LipQ21gPtTxITtNwdch3V182liRixiqGB7f1l
   9sE22MRRUHsQLWxBzca8IBy8mHsNUgykdsQcCxcbxcR2acUF8AmH/o+Tf
   E18EomBwHCYCfQuOVTG/r7K3RAqo6P6FE/E4gYNHv6bwoJKQzhrZesMpx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369936135"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="369936135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="970491162"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="970491162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2023 22:37:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qLzrx-00DQ5T-0I;
        Wed, 19 Jul 2023 08:37:01 +0300
Date:   Wed, 19 Jul 2023 08:37:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Add support for dev_name:0.0 naming for
 kernel console
Message-ID: <ZLd2fIiz9Leb1xjg@smile.fi.intel.com>
References: <20230719051525.46494-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719051525.46494-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:15:23AM +0300, Tony Lindgren wrote:
> With the serial core controller related changes we can now start
> addressing serial ports with dev_name:0.0 naming. The names are something
> like 00:04.0:0.0 on qemu, and 2800000.serial.0:0.0 on ARM for example.
> 
> The dev_name is unique serial port hardware controller device name, also

Maybe for the sake of consistency you may use DEVNAME here and everywhere else
to link this to the DEVNAME uevent environment variable?

> known as port->dev, and 0.0 are the serial core controller id and port id.
> 
> Typically 0.0 are used for each controller and port instance unless the
> serial port hardware controller has multiple controllers or ports.

-- 
With Best Regards,
Andy Shevchenko


