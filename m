Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFB07DF678
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376810AbjKBPeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376848AbjKBPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C226196;
        Thu,  2 Nov 2023 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698939231; x=1730475231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GolcTWF8+9TZeA5NDO2NrUBUnlZIS5zC0TJQcmHoZUU=;
  b=I7sY14BRvWPHuvCqzaHTVwPh28pnE8cZPhvdaSxnpGtYVT+U2cZBVJr+
   PKNu6LbSErlovbBXZ9Ma0lpqWV0RD2xmrPNgzFqJrThNYCO1U3gKqjB6r
   sgaCCkcELLpCwAig4vKtAazMMtLD0UdX0eCC8UvvELlOG5yVL4s6XZris
   07CStc+LVCajzxZq79gq979SY57a6xsw/WQThg+yMTlO+tZ75DBMJtzb1
   GNSgtGnRU8ZQVDs8pY8BAVF2MN5CIFSYMsm3Mxv0X22InKqfB//u77BSj
   mSZgRdoEnT8DXqMB0ZsOkVXLCPub/N2GyTfTnwoDbVvPEwD8Ix1itcKqZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="385915858"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="385915858"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="831719098"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="831719098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:33:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyZhV-0000000Aj1Z-02qV;
        Thu, 02 Nov 2023 17:33:41 +0200
Date:   Thu, 2 Nov 2023 17:33:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > Some users want to use the struct device pointer to see if the
> > > device is big endian in terms of Open Firmware specifications,
> > > i.e. if it has a "big-endian" property, or if the kernel was
> > > compiled for BE *and* the device has a "native-endian" property.
> > > 
> > > Provide inline helper for the users.
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thank you, Greg.
> 
> Bart, would it be still possible to take this into next?
> I would like to have at least this patch applied (with the first user)
> to allow conversion of others (I have some more users of new API).

Okay, seems we missed v6.7 with this, can you then prepare an immutable
branch / tag with this, so other maintainers can pull in case it's needed?
(I have something against tty already and perhaps something else, let's
 see.)

-- 
With Best Regards,
Andy Shevchenko


