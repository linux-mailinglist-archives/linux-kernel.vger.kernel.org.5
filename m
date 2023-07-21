Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06B75C5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGULZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGULZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:25:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24F1998
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689938707; x=1721474707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fX+P+Vn6+9w3G4Oh7llREegNj9wGkwnxSWXtt3ditgI=;
  b=EAJw6Bcqu4kB6hXIoBnX1dcABgG32mhOs3WEhZioapPDkbBVCsGlTP7y
   hsouVlCRQksJmOB/199JauL6ZMKMX0JGcEz2S/udzTpfSqdcD/anKwZGB
   P9Xhzg9qAM/aj8ne3jaXMriARk9DUKTvr9ZHmS99BLzqbJOAQVxqBAVV9
   R/gJDGlsp+tzTnYDXLK/i+l9K+wLpy+VkC3EGqJjwO+PV3Lk8+Blc08Xx
   djmegfcsH0nl/F+JRwi1y7tfPEoELQEnaAz5TLp+B0ZxC7S+eCj/IxfNx
   7QJnrGki2syOYcMySLBQIxL6o/Lv0kiYSJ/J+PfZrb5jSvU4ooJ8bmRvD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433229586"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433229586"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838519744"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838519744"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 04:25:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMoFq-001zoV-04;
        Fri, 21 Jul 2023 14:25:02 +0300
Date:   Fri, 21 Jul 2023 14:25:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v4 4/5] arm64: mte: add a test for MTE tags compression
Message-ID: <ZLprDcPQYdY0ytpc@smile.fi.intel.com>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-5-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720173956.3674987-5-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:39:55PM +0200, Alexander Potapenko wrote:
> Ensure that tag sequences containing alternating values are compressed
> to buffers of expected size and correctly decompressed afterwards.

...

> +#include <linux/bits.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>

> +#include <kunit/test.h>

Keep this in a separate group outside of linux/*.

> +#include <linux/types.h>
> +
> +#include <asm/mtecomp.h>

...

> +/* Functions exported from mtecomp.c for this test. */
> +void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_sizes,
> +			size_t *out_len);
> +void mte_ranges_to_tags(u8 *r_tags, unsigned short *r_sizes, size_t r_len,
> +			u8 *tags);

This is interesting. Have you run `make W=1` on this code?

-- 
With Best Regards,
Andy Shevchenko


