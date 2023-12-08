Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8D80A84B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjLHQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:12:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69012171C;
        Fri,  8 Dec 2023 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702051931; x=1733587931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SCc+h/WjvofFtNe2bbco7f5hKadCjOtqFUzt0REamCY=;
  b=AuZDHwZESUxvHk8tbf7pGBTW04LGwfuctMdoHZlPat9WyraASH7y9hxu
   zLKdQEZNuFxO60tSdJbTUjNLOwGsPxDiowx5FnMCYCbRFVxVtS81iyVCl
   vzz1PCC0K2RANWn++WJg0WhUY4tIgs54X3ao0MLlzUsl95lF66IGogNmK
   OEnSEk1KnxJ+YN5rjUfBlNrDBFLJgAWFIM4ajld0KYXKtlkAM4U/2YPul
   /mGiFhCaPi+ljOEATIFndViroMW36t3az/RZl0nUJgO8E9tu5xhVL7dE5
   iP1VfPgkSGl90D6V1e1xTJcBvuaJgLnAZA13MfRpPMGxtliDUQM4GfVKK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1495523"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1495523"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 08:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="895584266"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="895584266"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 08:12:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rBdSQ-000000047UA-0ac9;
        Fri, 08 Dec 2023 18:12:06 +0200
Date:   Fri, 8 Dec 2023 18:12:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: Update DMA mapping and using logic
 in the documentation
Message-ID: <ZXNAVXRG9aXWlwsu@smile.fi.intel.com>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
 <20231207221426.3259806-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207221426.3259806-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:13:40AM +0200, Andy Shevchenko wrote:
> Update DMA mapping and using logic in the documentation to follow what
> the code does.

...

> -  if !enable_dma then
> -	always use PIO transfers
> +  if spi_message.len > 65536 then
> +        if spi_message.is_dma_mapped or rx_dma_buf != 0 or tx_dma_buf != 0 then
> +              reject premapped transfers

Here seems inconsistent indentation. I'll fix it in the next version.
Mark, should I resend patch 1 as well?

-- 
With Best Regards,
Andy Shevchenko


