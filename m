Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8117D849C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbjJZOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbjJZOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:24:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D121B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698330281; x=1729866281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJndrHrOXUiiFrLeo6KN+w75k8epoGoi9EtFUnIB18s=;
  b=MQ0ozVdv2jM4QpB1H5ZdJbkdRr4Sbjt9xsEICEkdZMWpmo8FoYCGOuSI
   pEXce+mYfEyav1pGQImiBK3wPIb1tLLJtl2QjUNl6EymVTeqZYmBtUdp2
   Wy/fR156/n6FFTq+pN0qVJ9eIg44voCSbg2V7f12scW+nEiFSP3Xxnx43
   /ZzTVH1jXmEMq/ajMf0L3bfncF4PJprCofduuv3Q9kmt5LTC2SaHCigYZ
   QZKCJW88P9Gtl4AMXvOvfNLt+oupD2X48VyWvetNSlBV1we58cEHVvczY
   qVigAVcpHt0AF7/8ZIh47t0088TxB0MeYJslZ7MI48KK1y83nfatuEOqr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="384766951"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="384766951"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 07:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="932757730"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="932757730"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 07:24:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qw1Hk-00000008sxg-1Kst;
        Thu, 26 Oct 2023 17:24:32 +0300
Date:   Thu, 26 Oct 2023 17:24:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 1/2] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZTp2oLST3nR9AZk4@smile.fi.intel.com>
References: <20231026135912.1214302-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026135912.1214302-1-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:59:11PM +0200, Alexander Potapenko wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One nit below, though.

...

> +/**
> + * bitmap_write - write n-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: value to write, clamped to nbits
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
> + *
> + * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
> + * i.e. bits beyond @nbits are ignored:
> + *
> + *   for (bit = 0; bit < nbits; bit++)
> + *           __assign_bit(start + bit, bitmap, val & BIT(bit));
> + *
> + * For @nbits > BITS_PER_LONG no writes are performed.

nbits == 0 hasn't been mentioned.

(no, the main nit below)

> + */
> +static inline void bitmap_write(unsigned long *map,
> +				unsigned long value,
> +				unsigned long start, unsigned long nbits)

While noticing strange indentation (you have space for the parameter on
the previous line, I realized that this is a counter-intuitive interface.
Can you actually make value the last parameter?

-- 
With Best Regards,
Andy Shevchenko


