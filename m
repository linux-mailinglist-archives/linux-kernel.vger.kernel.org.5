Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC97FF62F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjK3QgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjK3QgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:36:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CBCD48;
        Thu, 30 Nov 2023 08:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701362177; x=1732898177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LE+KzXKDtkhOouveakP6N161O03AwIeG2W05uTR6XE=;
  b=U/j4ZtAzYmM5Nz4IzzDWhmH4yxtZNHrJ6J+BTk5zVceNxGTg6kurCTw8
   d34oURqpXbqQ1hjWxief80ZjPn5FkBt4o7DtU3EJP8WIhSfow0F6duIDD
   0o1Fkpk4iAkSjI5LMritlUZjTNf2d7mDi57leSY/lYWj7dboXljYEah3Q
   h69cjsfIwA8Ex9m4qQpT21tyeyxL1rCN56TOPegS2obEDJMQzcXRZLQsj
   6h6WoQqpCu/fTLFkhJ+wMHQavtGzjYy0QbYHZGf1JQfxbJioC0nT0B4Wh
   hmnRfirDWkhvOpLOqcfKU79wCehrFzmY+F0Z79l6QCwEuKbdlOnW2W7dw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="479556036"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="479556036"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1016689506"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="1016689506"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:36:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8k1N-00000000kNZ-1tAA;
        Thu, 30 Nov 2023 18:36:13 +0200
Date:   Thu, 30 Nov 2023 18:36:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
Message-ID: <ZWi5_VHlUSmgpLiB@smile.fi.intel.com>
References: <20231130134630.18198-1-brgl@bgdev.pl>
 <20231130134630.18198-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130134630.18198-8-brgl@bgdev.pl>
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

On Thu, Nov 30, 2023 at 02:46:27PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new gpiochip_dup_line_label() helper to safely retrieve the
> descriptor label.

...

>  		seq_printf(s,
>  			   " gpio-%-3d (%-20.20s) %s %s %s pad-%-3d offset:0x%03x mux:%d %s%s%s",
>  			   pin,
> -			   label,
> +			   label ?: "Unrequested",

This already fourth (?) duplication among drivers.
Perhaps you want a helper:
gpiochip_dup_line_label_fallback() // naming is up to you
which will return the same for everybody and we don't need to hunt for
the different meaning of "Unrequested".

Also the word "Unrequested" is a bit doubtful as it can be a label, right?
Something with special characters / spaces / etc would suit better?
In any case it might require to add a warning (?) to the GPIO lib core
when label gets assigned if it clashes with the "reserved" word.

>  			   val & BYT_INPUT_EN ? "  " : "in",
>  			   val & BYT_OUTPUT_EN ? "   " : "out",
>  			   str_hi_lo(val & BYT_LEVEL),

-- 
With Best Regards,
Andy Shevchenko


