Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43FD7A2FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjIPLTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjIPLT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:19:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5707A199;
        Sat, 16 Sep 2023 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694863164; x=1726399164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28CXMS/F/59wSEgJdT75kdHNhUkNdqDaK7+0AF2byx8=;
  b=f+X6/NskvkW9NWFejuan12v/DrjEFypwZ1Ts4f6TJhBUL4Hx3VCeTnL5
   /i6xLKwK9FeBxCZkEpkmpSuBQixYaYDKBnvPzS71N00fCd3d3NN9lP5N/
   sxI3p3RjPjK7R9yflxfNBFFBAvxha0NM/nPJYEPIeNxQ+OI0T2uujtItY
   7gXPoU39mIMilspRa8EP4viauWFqFVnW8RYO6IQvgZYJlrxzM2Y+UbZ9X
   t0++ni2JFzqd9IJxg2wavlEgmsGdirh6qOrMOPEACqevEs2g2fUpDGSXa
   DKrUXfMWK1RqGwmmoIoQIc5h/fsNN2lrBaJjM13NU2Jh9O34sGY87eD71
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445882735"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="445882735"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 04:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="748493833"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="748493833"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 04:19:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qhTKY-0000000GqlV-2ZrN;
        Sat, 16 Sep 2023 14:19:18 +0300
Date:   Sat, 16 Sep 2023 14:19:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpio: sim: fix an invalid __free() usage
Message-ID: <ZQWPNrrGLwfEj1tj@smile.fi.intel.com>
References: <20230915123423.75948-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915123423.75948-1-brgl@bgdev.pl>
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

On Fri, Sep 15, 2023 at 02:34:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpio_sim_make_line_names() returns NULL or ERR_PTR() so we must not use
> __free(kfree) on the returned address. Let's rework the function so that
> it returns the size of the gpio-line-names array or a negative error
> code on failure. This way we know that the string array will either stay
> NULL or be set to a correct, kcalloc()'ed address.

...

> +	names = kcalloc(line_names_size, sizeof(*line_names), GFP_KERNEL);

sizeof(*line_names) is a bit unusual here. names is typed as double pointer,
while line_names as a tripple one.

-- 
With Best Regards,
Andy Shevchenko


