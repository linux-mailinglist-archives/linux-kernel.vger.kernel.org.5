Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB378275E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjHUKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjHUKt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:49:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F87D9;
        Mon, 21 Aug 2023 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692614966; x=1724150966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qPrTy6uEIUTzRjUGG1aBcMnx6Khjk6tUQRsS3AzknkY=;
  b=LJ8NufdoQcaHmuj6nys7YCOmcXuuydmA4d8msHj5Q2Yls6PEQ0kqnXkU
   xdg04pF8yEFKtA9BxiWpzgA1v34QkkzuD7l7BJTWxQi6IrRm3NoyXJBCw
   lABS4i+JPNrSIeCU3sYvsYQuPk2j4TQJKxyXhM1R8a8UjyLwoGOqolZDA
   3B4uIRCLF5oReIhKpYw4CBsslmaiH0HF7ovfnm4HTS1g2UWmwTUqF26zI
   fGyVPg7H2r0M9OQA9U0L3bd7UPl7Z/36K8NBsjOBsJTROH4ezgMHr54sb
   5xls8DyPZl68tgcJ8HFxbshVWMsWaVJJ36VN0+XSXETFTcyoB+08vAJyT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="353134681"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353134681"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="685608664"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="685608664"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 03:49:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY2TI-00ARTN-1e;
        Mon, 21 Aug 2023 13:49:20 +0300
Date:   Mon, 21 Aug 2023 13:49:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] of: dynamic: Move dead property list check into
 property add/update functions
Message-ID: <ZONBMMVrzuu53hwC@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
 <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:41:00PM -0500, Rob Herring wrote:
> The changeset code checks for a property in the deadprops list when
> adding/updating a property, but of_add_property() and
> of_update_property() do not. As the users of these functions are pretty
> simple, they have not hit this scenario or else the property lists
> would get corrupted.
> 
> With this there are 3 cases of removing a property from either deadprops
> or properties lists, so add a helper to find and remove a matching
> property.

...

> v3:
>  - Keep existing style in deadprops loop

Not sure where exactly in the code that one, but...

...

>  int __of_remove_property(struct device_node *np, struct property *prop)
>  {
> -	struct property **next;
> -
> -	for (next = &np->properties; *next; next = &(*next)->next) {
> -		if (*next == prop)
> -			break;
> +	if (__of_remove_property_from_list(&np->properties, prop)) {
> +		/* Found the property, add it to deadprops list */
> +		prop->next = np->deadprops;
> +		np->deadprops = prop;
> +		return 0;
>  	}
> -	if (*next == NULL)
> -		return -ENODEV;
> -
> -	/* found the node */
> -	*next = prop->next;
> -	prop->next = np->deadprops;
> -	np->deadprops = prop;
>  
> -	return 0;
> +	return -ENODEV;
>  }


...if it's this one, I don't see how it's better than

	if (!__of_remove_property_from_list(&np->properties, prop))
		return -ENODEV;

	/* Found the property, add it to deadprops list */
	prop->next = np->deadprops;
	np->deadprops = prop;
	return 0;

Note, with --patience in use it may produce even nice-looking diff.

-- 
With Best Regards,
Andy Shevchenko


