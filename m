Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79AA784072
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjHVMML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjHVMMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:12:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010D5193;
        Tue, 22 Aug 2023 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692706329; x=1724242329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bMNqRaTXKeMhSmYsxEJBGG9KPMjo7EzITadHa8MbaRQ=;
  b=mwKP9eQBpkfy6LXFVw0eAw3OvTFi8A5RqsxWoGU+/Nz2i6Y7/V7NSOEP
   aT9Qyxe9qCg+xJXScuADSxAkZ0wWitEBi3jgS2bfFNF5oGYpy09upq0mH
   vwGW/9u+Srt6j4dUyw9L57S6RWkd4CaPadrEBt3pKnLQgcnY10Lf/yPn2
   SqTas2JV4q+BCfhK1Y+1ZsVVx8l5GvJR9Bpepan4b2qcb3CWgAisbuxyT
   1JavzX3juWw1NECPnyeNyEItetoGLmIbN8XJKwjm8x+PmFVRD+YoGkXmx
   HLA+N30EWauUnTq/MS3/SLNmugK5BHTfXxogcZSJ8ILdK2s2SiFPIqn7+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371284424"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="371284424"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739285939"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="739285939"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2023 05:12:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYQEu-009akW-14;
        Tue, 22 Aug 2023 15:12:04 +0300
Date:   Tue, 22 Aug 2023 15:12:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpio: sim: dispose of irq mappings before destroying
 the irq_sim domain
Message-ID: <ZOSmFGZHrLq3I+zF@smile.fi.intel.com>
References: <20230822075122.6900-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822075122.6900-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 09:51:21AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> If a GPIO simulator device is unbound with interrupts still requested,
> we will hit a use-after-free issue in __irq_domain_deactivate_irq(). The
> owner of the irq domain must dispose of all mappings before destroying
> the domain object.

...

> +static void gpio_sim_dispose_mappings(void *data)
> +{
> +	struct gpio_sim_chip *chip = data;
> +	unsigned int i, irq;
> +
> +	for (i = 0; i < chip->gc.ngpio; i++) {
> +		irq = irq_find_mapping(chip->irq_sim, i);

> +		if (irq)

This duplicates check in the following call.

> +			irq_dispose_mapping(irq);
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


