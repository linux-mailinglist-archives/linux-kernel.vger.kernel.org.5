Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DDE7A6BED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjISUAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjISUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:00:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E49C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695153598; x=1726689598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Y/kPWfHSLMXWuuYRqGMpSEQwEy1zNDIFt8sUJBQjYY=;
  b=MyQ0u2BWRpETldU4f5xoNF2iuVIjK7hBM2l9yKaeV/2pQnstZBscU4Eq
   6w7jOBnj2sCuk9peNQhm58N1sy2UHC+lDefawirafEYMBjvOT5R1J19Mo
   P85Bs+j9RgFwVePeRxA+vCM6loiW30zjVj+A57IdrGKAPQk0ezeZIlDY6
   z+kj85kmuZxV27/mh/c0pw0PGRqZBAHpp2Jo6Yfn9CI56dRH/uSXDWbKW
   2YIgCTuGvW1O+qZu0b/7xq7+ru9N53IbAM10dIU8Gpd9QEhmviUG9GnSx
   IfWiwPn6PdpG3x1LBQz1X3ym8RsDoLwLcdyQ5bxi6rD2SGcRtCrqhjCoJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="444126019"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="444126019"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816573077"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="816573077"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:59:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qigsz-0000000Eulh-1EwC;
        Tue, 19 Sep 2023 22:59:53 +0300
Date:   Tue, 19 Sep 2023 22:59:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] irqdomain: Check virq for 0 before use in
 irq_dispose_mapping()
Message-ID: <ZQn9uR0o8QHXjN69@smile.fi.intel.com>
References: <20230822135136.2138380-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822135136.2138380-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:51:36PM +0300, Andy Shevchenko wrote:
> It's a bit hard to read the logic since we use virq before checking
> it for 0. Rearrange the code to make it better to understand.
> 
> This, in particular, should clearly answer the question whether caller
> need to perform this check or not, and we have plenty places for both
> variants, confirming a confusion.
> 
> Fun fact that the new code is shorter:
> 
>   Function                                     old     new   delta
>   irq_dispose_mapping                          278     271      -7
>   Total: Before=11625, After=11618, chg -0.06%
> 
> when compiled by GCC on Debian for x86_64.

Any comment on this?

-- 
With Best Regards,
Andy Shevchenko


