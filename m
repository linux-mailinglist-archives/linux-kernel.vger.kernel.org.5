Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92ED7CDC65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjJRM4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjJRM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:56:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24A6A3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697633780; x=1729169780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c8mxHA+E1x8eDcLDLE3ni7UvknH57dwh7FXKHdFgtTk=;
  b=YjLP/ZnuQCp2LD9L1N5qthLa+5G9dDEFLew9xv5KOTi7+Eh+atqqf12r
   YBpsFMtRsgxl5H34Y7WTlsasJfDNDI9XDtpkuGxqVZOMtvfnmd9zi1Jv/
   UBF3fWNuRK/Enf58LFoW9x4Vm26AaQHQqopJlnZp76uEFhLtm3HD2nNZ1
   Kzzrk2fEgCjP/eyfFivPBcfa4nFWBY3n0DSVh2YKXtPDi8aqx7yc1GSIW
   JrIlHSlK9qu8JD/Jkgjif88fMiQkB8p56UsniGvoTxnLvShHeaQwb/+sE
   +pNE1I83zvUDmjOIjQhp63kEQfd/+vgU0sMnqvFIJqeicJS3IEqZvb8Vl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="450228519"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="450228519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="930177872"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="930177872"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:56:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qt65v-00000006amG-0jc3;
        Wed, 18 Oct 2023 15:56:15 +0300
Date:   Wed, 18 Oct 2023 15:56:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, linux@rasmusvillemoes.dk,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] lib/vsprintf: Remove redundant code
Message-ID: <ZS/V7uS/7cGMpDJD@smile.fi.intel.com>
References: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 02:48:17PM +0800, Jiapeng Chong wrote:
> When variable needcolon is assigned a value of false, it must be
> assigned a value of true later on, which is redundant code.
> 
> lib/vsprintf.c:1411:4: warning: Value stored to 'needcolon' is never read.

...

> @@ -1406,10 +1406,9 @@ char *ip6_compressed_string(char *p, const char *addr)
>  			i += longest - 1;
>  			continue;
>  		}
> -		if (needcolon) {
> +		if (needcolon)
>  			*p++ = ':';
> -			needcolon = false;
> -		}
> +
>  		/* hex u16 without leading 0s */
>  		word = ntohs(in6.s6_addr16[i]);
>  		hi = word >> 8;

Logically you may remove then the assignment to true as well.

But I would double check if it's not a continue missing somewhere or so.

-- 
With Best Regards,
Andy Shevchenko


