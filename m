Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183775CAFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGUPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjGUPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:09:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DC30C8;
        Fri, 21 Jul 2023 08:09:05 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433276670"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="433276670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="814991639"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="814991639"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2023 08:09:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qMrkZ-009iAE-0s;
        Fri, 21 Jul 2023 18:08:59 +0300
Date:   Fri, 21 Jul 2023 18:08:59 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: Use passed in GFP_ flags
Message-ID: <ZLqfizx5Xi9fOF6z@smile.fi.intel.com>
References: <df051844-0a73-4cf9-9719-a6001f1c9d5c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df051844-0a73-4cf9-9719-a6001f1c9d5c@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:57:00PM +0300, Dan Carpenter wrote:
> This patch doesn't affect runtime because all the callers pass GFP_KERNEL
> as the allocation flags.  However, it should use the passed in "gfp" as
> the allocation flags.

Please, Cc Kees Cook as he stepped in as a maintainer of this in particular.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

> Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  lib/string_helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index d3b1dd718daf..be517c25737d 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -668,7 +668,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
>  	char *buffer, *quoted;
>  	int i, res;
>  
> -	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	buffer = kmalloc(PAGE_SIZE, gfp);
>  	if (!buffer)
>  		return NULL;
>  
> @@ -704,7 +704,7 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
>  		return kstrdup("<unknown>", gfp);
>  
>  	/* We add 11 spaces for ' (deleted)' to be appended */
> -	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
> +	temp = kmalloc(PATH_MAX + 11, gfp);
>  	if (!temp)
>  		return kstrdup("<no_memory>", gfp);
>  
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


