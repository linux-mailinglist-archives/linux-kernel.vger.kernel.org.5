Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6176C385
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHBD26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHBD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:28:54 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEE1705;
        Tue,  1 Aug 2023 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690946933; x=1722482933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GlBMlOPwMn2zttkWwq8RvFv9+vv3ZhBYRTq06yArZY8=;
  b=UtUD+2POTDustXG+YivvfGFCGQgjLLjiIBR3vCye4wEvt2m865k6wAo2
   3XxBgh9v2LtrhiVAY4V0BBZGHCCU4KpoYHpuL4hrCaccsEQcUpMgcjWb3
   Y0zU5hfYkT1o3RAWN4qXXkEBcw2LzuC7tieyyn99ytvQu6RBaPyqzw7zZ
   epiCpk0YG/o+uT7YShDxIA5VDiI5niV1bxeKmoExKcggR+B/9ainJCGFQ
   64/uYVytJwgI8UboRzb6uzaVg5NGI25vQ0XzhEQqHOKFQKHMj0LRV7B62
   KXwalGTlVcunlAI3PyIfMGbZvC9wvEXO6s4L6IU5RML1M5JUjZ/4o9k4V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="366933309"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="366933309"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 20:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="728950596"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="728950596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2023 20:28:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qR2XY-00FJCa-2E;
        Wed, 02 Aug 2023 06:28:48 +0300
Date:   Wed, 2 Aug 2023 06:28:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
Message-ID: <ZMnNcJ2KW1qUZUA5@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:54:45PM -0600, Rob Herring wrote:
> While originally it was fine to format strings using "%pOF" while
> holding devtree_lock, this now causes a deadlock.  Lockdep reports:
> 
>     of_get_parent from of_fwnode_get_parent+0x18/0x24
>     ^^^^^^^^^^^^^
>     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
>     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
>     fwnode_full_name_string from device_node_string+0x1a0/0x404
>     device_node_string from pointer+0x3c0/0x534
>     pointer from vsnprintf+0x248/0x36c
>     vsnprintf from vprintk_store+0x130/0x3b4
> 
> To fix this, move the printing in __of_changeset_entry_apply() outside the
> lock. As there's already similar printing of the same changeset actions,
> refactor all of them to use a common action print function. This has the
> side benefit of getting rid of some ifdefs.

...

> v3:
>  - Add missing 'static' reported by 0-day

It reported two issues (at least what I see).

...

> +	if (pr_debug("notify "))

This is weird. How did you compile it?

> +		of_changeset_action_print(action, pr->dn, pr->prop ? pr->prop->name : NULL);

-- 
With Best Regards,
Andy Shevchenko


