Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182777436A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjHHSD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjHHSDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:03:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024ED9282;
        Tue,  8 Aug 2023 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512280; x=1723048280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vdeuurTFaZQKhbFyW+6Tv/hjCwIufVCn/vBK6Sa8C78=;
  b=IgZAhqXGoho8BxksK9QQJyEWebG+ahF5C+z4PNoYnQDaopDzbjg8ZghD
   ++bGyqguC74AXc9nOsfqj0Th6xo92MClTDIlahA+s5wON0NucNPEplGA0
   8bmS2ANG14tLU71hcPs6gyKBnQr659DPB1SjXgObHoaRrAJab3ovohHOb
   QfL750RoGwVCgv4xTdRMEXIRFVqduc3XQlzk4EFFufF1WNhk4Vwwg2qEX
   89xi72yOfLY6YbiPgNuVEqDBDT5ezMCnsB9gFmdvd5/cwv8VXmCuht5Q7
   x3MaMFiMo5yg0XohEa+gyX4pr6pDXShXGyi4LlTahVfDiHNG+lvRalu75
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401778704"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="401778704"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1062012375"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="1062012375"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2023 06:09:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMSi-0097P4-1E;
        Tue, 08 Aug 2023 16:09:24 +0300
Date:   Tue, 8 Aug 2023 16:09:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] pinctrl: iproc-gpio: Silence probe deferral messages
Message-ID: <ZNI+hLy4jYgctYXX@smile.fi.intel.com>
References: <20230807213022.1862903-1-florian.fainelli@broadcom.com>
 <20230807213022.1862903-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807213022.1862903-2-florian.fainelli@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:30:21PM -0700, Florian Fainelli wrote:
> We can have gpiochip_add_data() return -EPROBE_DEFER which will make us
> produce the "unable to add GPIO chip" message which is confusing. Use
> dev_err_probe() to silence probe deferral messages.

...

>  	ret = gpiochip_add_data(gc, chip);
>  	if (ret < 0) {
> -		dev_err(dev, "unable to add GPIO chip\n");
> +		dev_err_probe(dev, ret, "unable to add GPIO chip\n");
>  		return ret;

	return dev_err_probe(...);

>  	}

-- 
With Best Regards,
Andy Shevchenko


