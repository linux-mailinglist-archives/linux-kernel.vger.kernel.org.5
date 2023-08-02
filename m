Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDBA76D124
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjHBPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHBPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:12:15 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020B2103;
        Wed,  2 Aug 2023 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690989134; x=1722525134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qjoRO+86zoiQJt1dgEUpx5MbAiDYWWKhC+5c7+9nClw=;
  b=ZKPZt9IOhG/MRsb4UHb49yS7thrjCL7Jsog5KzYLHsNBJ4qJL1s3E5n9
   na5qrY4F+B1Wq3N2wGT8K/EQFkAWhE4z9kKW6pGLpIlsj9t3XTklk1cuE
   4cjk/nvWY4Vj10Blr8RXBvdngipBkZLbjOOoZyPvaLgRyuxRvUhhO5t/U
   qy5d9rFa1TIogx2obnh+V4YjqDlotPtvdfDW4VVSerBX7PAyMATn/g19g
   7qV5rPCX1G4QS9WoboYqx6xW+qM/n0a2bI53xw9R2GGVqRjXiOOrsD0Fl
   tUw0fFMMN9te7T9zSiyTqzEE8DYrf1kW5uLMQl9qi1qeVUehsVtXRy86w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="367074793"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="367074793"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="843190688"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="843190688"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2023 08:12:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRDWD-003zxb-1Y;
        Wed, 02 Aug 2023 18:12:09 +0300
Date:   Wed, 2 Aug 2023 18:12:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] of: dynamic: Move dead property list check into
 property add/update functions
Message-ID: <ZMpySdEBHaPfUiyt@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-4-b5203e3fc22f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v1-4-b5203e3fc22f@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:54:47PM -0600, Rob Herring wrote:
> The changeset code checks for a property in the deadprops list when
> adding/updating a property, but of_add_property() and
> of_update_property() do not. As the users of these functions are pretty
> simple, they have not hit this scenario or else the property lists
> would get corrupted.

...

Seems like this...

> +	/* If the property is in deadprops then it must be removed */
> +	for (next = &np->deadprops; *next; next = &(*next)->next) {
> +		if (*next == prop) {
> +			*next = prop->next;
> +			break;
> +		}
> +	}

>  	prop->next = NULL;

...

> +	for (next = &np->deadprops; *next; next = &(*next)->next) {
> +		if (*next == newprop) {
> +			*next = newprop->next;
> +			newprop->next = NULL;
> +			break;
> +		}
> +	}

...is a dup of this. Are you planing to have a helper or at least conditional
for_each_*() macro for them?

-- 
With Best Regards,
Andy Shevchenko


