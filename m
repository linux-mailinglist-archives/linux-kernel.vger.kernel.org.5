Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207497C5AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjJKSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjJKSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:00:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3138F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697047209; x=1728583209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AJ0S+DAt2SitBJZ/5xUuzE4Df3wqn0GzCcki41rYKII=;
  b=C//TP3SrWL25LEDOJeo4i00fPno+HKln2J/jz1AFUVzO9ltfgNYe5KO5
   s+QaURRbLatpHhdTNlWBkRVG/lGovAcgsSXUM8+yEi/UbIyJ5zZufrLnp
   90tuH+yWxPu1x5vrAcm7jLvcfjfmneC7xdKV3cJQENP6J8VwoZkkFieZp
   Td0U8GgTKU2puABtQIZ8YTsjDb/gs9QJETO15h3sn8W6JdJW6Zz+7rw2Q
   nDNw7ZMHYqSZpSRRFuQQTyRVQHkVwVQ+fmXRLY21H0mGOpGrpGNkB2JTy
   dBn8sM8YhKpVUDi5fwzyHlCXjFchfH+3IuIo2YsXFkcTZ7D9lebzA1lsL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369796557"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="369796557"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 11:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="753922795"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="753922795"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 11:00:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqdV2-00000004nkl-02v3;
        Wed, 11 Oct 2023 21:00:00 +0300
Date:   Wed, 11 Oct 2023 20:59:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 1/5] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZSbinxApgdd+aif2@smile.fi.intel.com>
References: <20231011172836.2579017-1-glider@google.com>
 <20231011172836.2579017-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011172836.2579017-2-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:28:31PM +0200, Alexander Potapenko wrote:
> From: Syed Nayyar Waris <syednwaris@gmail.com>
> 
> The two new functions allow reading/writing values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
> 
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a number of changes and simplifications:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value());
>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>    and bitmap_write();
>  - some redundant computations are omitted.

I realized that the corner case with these functions is when agnostic user
wants to read / write > 32 bits at a time without ifdeffery applied.

At bare minimum this has to be documented explicitly, that callers
may have an issue of the above calls on 32-bit platforms.

-- 
With Best Regards,
Andy Shevchenko


