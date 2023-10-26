Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41787D829E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344933AbjJZM1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbjJZM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:27:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C1194;
        Thu, 26 Oct 2023 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698323257; x=1729859257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tqtDdD4xvu4zyFQWZK9HVGuWrLui8+ZbecV2jxa/D7U=;
  b=N6WDbtEo+fYNGc7VpPh3MYquGO5wdb4GYjXCC8h6cNBxfrZPoDNXUlKO
   /rbu2LX9cHkJs9QxAMW0pthYlVKFh8cz6wxgyew65L1f1cxFY7vLVNS91
   /TIUHbgsfXeY4xU/yqgb8mX3KPQOFcbnv8m2qJnGfOQKFnRC/NL3JHxng
   1vWeniNp+C5LYs5moMgun6a8dtthDghtmuzZPoH+Bg25tmEp2qSt2lQmG
   4JBsIRR3y0IAG3F9WhFV4vg6hNv+Pnx+HKvtINLiuccQa4rVrsxA42doX
   fTReoFlzxcCJ3jQnETIa0votrE8sh1IiAbz31i80nLttlOMrsmJ6QQH7a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391397268"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391397268"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="794185006"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="794185006"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:27:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvzSU-00000008qtb-0Q5s;
        Thu, 26 Oct 2023 15:27:30 +0300
Date:   Thu, 26 Oct 2023 15:27:29 +0300
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
Message-ID: <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102624-moonshine-duller-3043@gregkh>
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

On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > Some users want to use the struct device pointer to see if the
> > device is big endian in terms of Open Firmware specifications,
> > i.e. if it has a "big-endian" property, or if the kernel was
> > compiled for BE *and* the device has a "native-endian" property.
> > 
> > Provide inline helper for the users.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you, Greg.

Bart, would it be still possible to take this into next?
I would like to have at least this patch applied (with the first user)
to allow conversion of others (I have some more users of new API).

-- 
With Best Regards,
Andy Shevchenko


