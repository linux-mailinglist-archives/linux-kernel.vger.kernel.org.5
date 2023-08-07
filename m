Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09CD772965
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjHGPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHGPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:37:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD421703;
        Mon,  7 Aug 2023 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691422640; x=1722958640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WyY4m65TBzl1YIFH+NrWYCcN8qNM7vHmyLpIsh9nJDU=;
  b=Bok/7IScVQPnQ5yIJ8+YvltqXhG+uKggPngq9Ej4mBzO4hRwVyzDKC0+
   Xs3oogrPEm3V6mFpRXqBGSEPROOXbqSD5jDGXC3cuNHhYT+UHSGpSSTSN
   KiWn6qo143Yw5VSHM+1kO9VznYCf80H0Zbk1nWa9XrRLQozKMgmJJgefM
   94iEtaIH5SGJ7nKlvjtUg1afZW/6lrAAr0JYKU11uRUE0CWDfEPokt98O
   VoLhvcYVsTVF9V+iYiFhG1UdYwtId6Jen7yqXA36YiK5d9PIggQse8UQ0
   diayYrajPrG28voCHU6/GrFnZe/wRjSyedCiQyG56Exj+DD6+IqG1xw3H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="456960583"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="456960583"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845083880"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="845083880"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2023 08:37:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT2IG-0005qR-08;
        Mon, 07 Aug 2023 18:37:16 +0300
Date:   Mon, 7 Aug 2023 18:37:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] of: dynamic: Move dead property list check into
 property add/update functions
Message-ID: <ZNEPqwQ0H9srkxxq@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-5-c2b701579dee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v2-5-c2b701579dee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:41:55PM -0600, Rob Herring wrote:
> The changeset code checks for a property in the deadprops list when
> adding/updating a property, but of_add_property() and
> of_update_property() do not. As the users of these functions are pretty
> simple, they have not hit this scenario or else the property lists
> would get corrupted.

Suggested-by: ? :-)

...

> +static void __of_remove_dead_property(struct device_node *np, struct property *prop)
> +{
> +	struct property **next;
> +
> +	/* If the property is in deadprops then it must be removed */
> +	for (next = &np->deadprops; *next; next = &(*next)->next) {
> +		if (*next != prop)
> +			continue;
> +
> +		*next = prop->next;
> +		prop->next = NULL;
> +		break;

Why not

		if (*next == prop) {
			*next = prop->next;
			prop->next = NULL;
			break;
		}

which seems to me clearer?

> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


