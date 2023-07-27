Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448B765082
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjG0KEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjG0KEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:04:11 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE2136
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690452250; x=1721988250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBZZEriPxsfpYqO8zqzGjVnlZmwHnBcOIkwsvLj7ubg=;
  b=FFLnT7cJoOME1t2nKnl/iGwjmVJl+J0yDX0Xl73SxQYSYxGJrKlOjaoG
   qW/i2YZR8708J+WtXx8rxDaK/n6ZcT6rSvQp44cJ5BJjoBCGoPfUEvaTM
   oPex6aAuW6aMVxSXb2lI6bSQU1q23bIjZA9+gioJucSCEyLHjNxiC6DWc
   n9VzSUnhFgXKdz/Gzex4RZcMedLwLnrOj+ST1OHa5PUez9Zs5WddlSX1n
   BfcBS4ohQDzlO6bFcdR8dEPir9LKLFF1KIwQGAEDTeWsFewYJwvheaHZm
   joEw0zc1CevCe8WxtA4RuMmkRcawUD+ZbuVFjGc57fWDeOBFubiMsTPqS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="432065305"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="432065305"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 03:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756591459"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="756591459"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 03:04:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOxqp-00GPYn-2E;
        Thu, 27 Jul 2023 13:04:07 +0300
Date:   Thu, 27 Jul 2023 13:04:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/6] bitmap: fix opencoded bitmap_allocate_region()
Message-ID: <ZMJBF8rEKCSpij+D@smile.fi.intel.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
 <20230727020207.36314-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727020207.36314-2-yury.norov@gmail.com>
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

On Wed, Jul 26, 2023 at 07:02:02PM -0700, Yury Norov wrote:
> bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

...

> +	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end)

In the other patch you use BIT(order), why not here?

> +		if (!bitmap_allocate_region(bitmap, pos, order))
> +			return pos;

-- 
With Best Regards,
Andy Shevchenko


