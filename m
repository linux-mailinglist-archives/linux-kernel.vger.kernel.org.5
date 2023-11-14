Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE67EB2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjKNO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:59:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354F410D;
        Tue, 14 Nov 2023 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699973984; x=1731509984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H6JgOrMWyNBE8lmLNEKEsKkqYtrg2+o4Iewg4oHBr6c=;
  b=BZGAnZl1CRUzgZ9lc9U1Tw7l7jRXpGdgq2sDGrbdEW5/Qg3Fwe4OY8zW
   MlWJrZTGW2xSyux0P2RvmFT2VcdMot+M8jZ7cNNtw6V5UZC6m72AdokzA
   E8AdtzY1a68iaIGChkNrtuDCJMkq/swq5iedHpywlPqueb5Us420hzR6v
   lWbDQbPI8aokVYs7ytuVIPubGSugcfypankWXGHPrjOau86zv2q570BwT
   EPg+yHA/kX0SYaBd686LMmB1RVucZHM84+nsya3ru3YLQqE4HldjOfhJm
   pDQGmRnhzCDP+QZB5tvnWIBco54GF5w/UPKm45qubNEOLiffU4ECTDfH6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="476880566"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="476880566"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="830619991"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="830619991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:59:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2ut6-0000000DqjM-2PtH;
        Tue, 14 Nov 2023 16:59:36 +0200
Date:   Tue, 14 Nov 2023 16:59:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Fix %pfwf when current node
 refcount == 0
Message-ID: <ZVOLV008PaKFXRy9@smile.fi.intel.com>
References: <20231114143558.356259-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114143558.356259-1-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 03:35:58PM +0100, Herve Codina wrote:
> A refcount issue can appeared in __fwnode_link_del() due to the
> pr_debug() call:
>   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
>   Call Trace:
>   <TASK>
>   ...
>   of_node_get+0x1e/0x30
>   of_fwnode_get+0x28/0x40
>   fwnode_full_name_string+0x34/0x90
>   fwnode_string+0xdb/0x140
>   ...
>   vsnprintf+0x17b/0x630
>   ...
>   __fwnode_link_del+0x25/0xa0
>   fwnode_links_purge+0x39/0xb0
>   of_node_release+0xd9/0x180
>   ...
> 
> Indeed, an fwnode (of_node) is being destroyed and so, of_node_release()
> is called because the of_node refcount reached 0.
> From of_node_release() several function calls are done and lead to
> a pr_debug() calls with %pfwf to print the fwnode full name.
> The issue is not present if we change %pfwf to %pfwP.
> 
> To print the full name, %pfwf iterates over the current node and its
> parents and obtain/drop a reference to all nodes involved.
> 
> In order to allow to print the full name (%pfwf) of a node while it is
> being destroyed, do not obtain/drop a reference to this current node.

One nit-pick below, otherwise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  	/* Loop starting from the root node to the current node. */
>  	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> -		struct fwnode_handle *__fwnode =
> -			fwnode_get_nth_parent(fwnode, depth);
> +		/*
> +		 * Only get a reference for other nodes (ie parents node).

"parent's node" (doesn't look right)? Or "parent nodes"?

> +		 * fwnode refcount may be 0 here.
> +		 */
> +		struct fwnode_handle *__fwnode = depth ?
> +			fwnode_get_nth_parent(fwnode, depth) : fwnode;
>  
>  		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
>  			     default_str_spec);
>  		buf = string(buf, end, fwnode_get_name(__fwnode),
>  			     default_str_spec);
>  
> -		fwnode_handle_put(__fwnode);
> +		if (depth)
> +			fwnode_handle_put(__fwnode);
>  	}

-- 
With Best Regards,
Andy Shevchenko


