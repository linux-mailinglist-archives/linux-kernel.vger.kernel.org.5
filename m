Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09D77D33A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjJWLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjJWLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:32:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4714D7C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698060754; x=1729596754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXKl7wPSJSGDOuUODILncAIpxPR1MH9Gubv4M9DWQdo=;
  b=V5xhfHyA8f3T9Vpyrs/Km6bxyVxX6C8lAZaD3ru4/QmrXANAOvR+E67Y
   r2KyivHpV+OzRd0+UTLtPtKTFjwHlGwi5L6SWBZuVMiookRCqJn45gQ37
   YY2iAzydCwbEAJhJYwPZfMhX9HeR2KgUiwWAgxaHm8jI7Fhvywj67ccZj
   8VDB3l81o5UkhI4sVaSE8iIK7MG8abkcxsr6E7ob4SCgMtT009ihV59UJ
   wZzaldfakr+yL0loXvg8W7Rl9ODlJPzv13Cax3d7gjexhI7uupo0vg3bC
   2h/62UgVs2LgB2yisreJqfEE1Zd6WuMyW3bgOHGTAlm0LvzWuRbyNJYOT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="390706618"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="390706618"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707908843"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="707908843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:32:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qutAZ-00000007vEN-0tcu;
        Mon, 23 Oct 2023 14:32:27 +0300
Date:   Mon, 23 Oct 2023 14:32:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v8 2/2] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZTZZyuWKIMSGv+dF@smile.fi.intel.com>
References: <20231023102327.3074212-1-glider@google.com>
 <20231023102327.3074212-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023102327.3074212-2-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:23:27PM +0200, Alexander Potapenko wrote:
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.

...

> +				val = bitmap_read(bitmap, i, nbits);
> +				(void)val;

Is it marked with __must_check? Otherwise why do we need this?

-- 
With Best Regards,
Andy Shevchenko


