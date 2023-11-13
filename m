Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939467E9B81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjKMLzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjKMLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:55:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039E5D71;
        Mon, 13 Nov 2023 03:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699876538; x=1731412538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KuVJPrj65vfM4OV91+tDFxw3gKSD9D4VLoDkOciGoN8=;
  b=K3S9fIz0QZv3B65UHxsVU61YZxs3+RhGuD4Gl6d05bSCPjBpThsI9FeB
   WfBvYmBYRgZ/9bLorlv2JPq7s2J6a74fbsbEG393ssUr7rXQnP+Qoxpnx
   qznd/nPZggp60O6gjlC0+5VZ1sl3O+vR0VRTJsVMDvqotS7+gDOfbPMAb
   NVBdklHc+9qKHcGtb+vsajz9fdRXaspIvy0guz2dZZ1MXNz0V/c8c1B64
   8t8SCcuwVGXIijyZhZC2wzqM7jpraycg1C5mudAaWtr5VR4WATJIMaHI9
   /fkSFn5yAFMbZAVy5E9bKJ1WmKJIcXdLI/PbC++MYAJQgR6BsYI3dPojq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="394321270"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="394321270"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="881643458"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="881643458"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:55:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2VXP-0000000DY4q-1ARc;
        Mon, 13 Nov 2023 13:55:31 +0200
Date:   Mon, 13 Nov 2023 13:55:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Refactor
 intel_pinctrl_get_soc_data()
Message-ID: <ZVIOs0IooJ1zGBfR@smile.fi.intel.com>
References: <20231030155906.3492801-1-andriy.shevchenko@linux.intel.com>
 <20231101063643.GE17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101063643.GE17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 08:36:43AM +0200, Mika Westerberg wrote:
> On Mon, Oct 30, 2023 at 05:59:06PM +0200, Andy Shevchenko wrote:
> > Refactor intel_pinctrl_get_soc_data() to drop initial assignment
> > of the data variable. It's only used in ACPI case and instead
> > we may always assign it there as the ACPI ID table has the terminator
> > entry that has driver data set to NULL.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!


-- 
With Best Regards,
Andy Shevchenko


