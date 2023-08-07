Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2995D772979
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjHGPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjHGPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:40:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD6E3;
        Mon,  7 Aug 2023 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691422831; x=1722958831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BAIx7FHNmCGdQOU29KO90M3ZGXMHjDFp6/H+S8A6D8=;
  b=kOfbWFR5igwkbNindwIJ+vB2IV+1WzOBQAMal+yuM2ZMzNJKkjWlqFRb
   KAPn4KhTwYYusCL+T8HHq8o3J/EQOOrGlC6u9m6MW//q+bpxL16geNiVQ
   dNVlwP/qCpcT7et8LW/gaCzR8r1vfqA0ZcbW90NDEhUfn3fvxLk6MynFg
   q1q5M47BTwIJ2dhNesjHoxOiyDUdqRdLLcfSN9PKrdOgT1dTxJ+2fvmxe
   MO56+0D4wKpGU6MskUL/xF5O3/x+8GMaeRC5veaW/Hm9SRLWYqj2awBt4
   /nijcNRPEsA0c5O8YqqKsAEZFtfVNjFWblV/po5uWXluBj/KXWsCmVV5L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374253438"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="374253438"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845085831"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="845085831"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2023 08:40:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT2LK-000Cjp-0v;
        Mon, 07 Aug 2023 18:40:26 +0300
Date:   Mon, 7 Aug 2023 18:40:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] of: Refactor node and property manipulation
 function locking
Message-ID: <ZNEQalGgikGLoZ3p@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-6-c2b701579dee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v2-6-c2b701579dee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:41:56PM -0600, Rob Herring wrote:
> All callers of __of_{add,remove,update}_property() and
> __of_{attach,detach}_node() wrap the call with the devtree_lock
> spinlock. Let's move the spinlock into the functions. This allows moving
> the sysfs update functions into those functions as well.

...

>  	for (next = &np->properties; *next; next = &(*next)->next) {
>  		if (*next == prop)
>  			break;
>  	}
> -	if (*next == NULL)
> -		return -ENODEV;
> -
> +	if (*next == NULL) {
> +		rc = -ENODEV;
> +		goto out_unlock;
> +	}
>  	/* found the node */
>  	*next = prop->next;
>  	prop->next = np->deadprops;

But this also looks like a dup for deadprop, maybe something like

static int __of_remove_property_dead_or_alive() // pun intended.

?

-- 
With Best Regards,
Andy Shevchenko


