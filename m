Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2087E80615B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbjLEWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346425AbjLEWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:05:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E431B8;
        Tue,  5 Dec 2023 14:05:33 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393698772"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393698772"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018352864"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="1018352864"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:05:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rAdXj-00000002C6W-2AhU;
        Wed, 06 Dec 2023 00:05:27 +0200
Date:   Wed, 6 Dec 2023 00:05:27 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     tanzirh@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZW-epz8hZGJLWHcB@smile.fi.intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Jonathan, who tried IWYU with kernel a year or so ago.

On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5232 lines (-80%).
> 
> If there are any problems with the output of the tool please raise an
> issue on the github.
> 
> Link: https://github.com/ClangBuiltLinux/IWYUScripts
> 
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
> 
> ---
>  lib/string.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index be26623953d2..aff066e9da9f 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -16,16 +16,16 @@
>  
>  #define __NO_FORTIFY
>  #include <linux/types.h>
> +#include <asm/bitsperlong.h>
> +#include <asm/bug.h>
> +#include <asm/errno.h>
> +#include <asm/rwonce.h>
> +#include <linux/linkage.h>
> +#include <linux/stddef.h>
> +#include <vdso/limits.h>
>  #include <linux/string.h>
>  #include <linux/ctype.h>
> -#include <linux/kernel.h>
> -#include <linux/export.h>
> -#include <linux/bug.h>
> -#include <linux/errno.h>
> -#include <linux/slab.h>
> -
>  #include <asm/unaligned.h>
> -#include <asm/byteorder.h>
>  #include <asm/word-at-a-time.h>
>  #include <asm/page.h>
>  

-- 
With Best Regards,
Andy Shevchenko


