Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F4C7AD257
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjIYHwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIYHwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:52:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBED3;
        Mon, 25 Sep 2023 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695628352; x=1727164352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R3k1cgOSQuf5VQnqBsn2JYn/UDWAa7+Sl2h6BSrBoL8=;
  b=iFRlb5qWWqc7LFe75b6UP5zrA5u9lo5Ul7nQHpFUM6Xgr1IhMH5hQ7OS
   MP+bW+wojOnK1Yuioz3/fmDgxjx94bkPx97tBF/q5/WrZT2Lpw2piZpYP
   6JnMQxyzaTVJvKa9U4IebXpSFITU394iB3lt1jmHpMy7/vtVUkw2YhaWP
   C0zr5qTm89bJVQPFxraqbsM8SOHsgICPrgdouFW2YFFOd1PExybm7S0eH
   NjZyqlN0z+OJCe+1tzXGxkNLwhcT1ewn/YoAar3K/ACDpCkgHa7ZzNWTi
   cCdYiVZVC7cSQDKcI/8ByXssAiwU3b95peYqozv1DXBHgbhRJJiWJnZIi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412123669"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="412123669"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="697902091"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="697902091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:52:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qkgOJ-00000000HfP-0zU6;
        Mon, 25 Sep 2023 10:52:27 +0300
Date:   Mon, 25 Sep 2023 10:52:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: mcp23s08: Simplify
 probe()/mcp23s08_spi_regmap_init()
Message-ID: <ZRE8Oq4Xpklvism9@smile.fi.intel.com>
References: <20230924172320.15165-1-biju.das.jz@bp.renesas.com>
 <20230924172320.15165-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924172320.15165-4-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 06:23:20PM +0100, Biju Das wrote:
> Add struct mcp23s08_info and simplify probe()/mcp23s08_spi_regmap_init() by
> replacing match data 'type' with 'struct mcp23s08_info'.
> 
> While at it, replace 'dev_err()'->'dev_err_probe()' and drop printing
> 'type' in error path for i2c_get_match_data().

No need to duplicate info in the name of variables (see below).
With this fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +static const struct mcp23s08_info mcp23s08_i2c_0008 = {

static const struct mcp23s08_info mcp23008_i2c = {

> +	.regmap = &mcp23x08_regmap,
> +	.label = "mcp23008",
> +	.type = MCP_TYPE_008,
> +	.ngpio = 8,
> +	.reg_shift = 0,
> +};
> +
> +static const struct mcp23s08_info mcp23s08_i2c_0017 = {

static const struct mcp23s08_info mcp23017_i2c = {

> +	.regmap = &mcp23x17_regmap,
> +	.label = "mcp23017",
> +	.type = MCP_TYPE_017,
> +	.ngpio = 16,
> +	.reg_shift = 1,
> +};
> +
> +static const struct mcp23s08_info mcp23s08_i2c_0018 = {

static const struct mcp23s08_info mcp23018_i2c = {

> +	.regmap = &mcp23x17_regmap,
> +	.label = "mcp23018",
> +	.type = MCP_TYPE_018,
> +	.ngpio = 16,
> +	.reg_shift = 1,
> +};

...

> +static const struct mcp23s08_info mcp23s08_spi_s08 = {

static const struct mcp23s08_info mcp23s08_spi = {

> +	.regmap = &mcp23x08_regmap,
> +	.type = MCP_TYPE_S08,
> +	.ngpio = 8,
> +	.reg_shift = 0,
> +};
> +
> +static const struct mcp23s08_info mcp23s08_spi_s17 = {

static const struct mcp23s08_info mcp23s17_spi = {

> +	.regmap = &mcp23x17_regmap,
> +	.type = MCP_TYPE_S17,
> +	.ngpio = 16,
> +	.reg_shift = 1,
> +};
> +
> +static const struct mcp23s08_info mcp23s08_spi_s18 = {

static const struct mcp23s08_info mcp23s18_spi = {

> +	.regmap = &mcp23x17_regmap,
> +	.label = "mcp23s18",
> +	.type = MCP_TYPE_S18,
> +	.ngpio = 16,
> +	.reg_shift = 1,
> +};

-- 
With Best Regards,
Andy Shevchenko


