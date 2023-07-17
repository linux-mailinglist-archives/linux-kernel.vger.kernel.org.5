Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9F756585
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjGQNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGQNxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:53:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A8BD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689602032; x=1721138032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wFdVfTs7bwCHPiF9tKeb/4/2QCO1PgW97PqZHVQwldg=;
  b=OcScKaZhxPCs8mPACGEvHHtJB5I3wBr3WflSu5SMo/LjAgg63Lx4JTiZ
   JDQc2YAipieUG2BKk/gqht7yehbcbM/Hx0F44NXE54AHsWI5mHdmqSGl1
   E8Pho7s2CWhg9YZrod+5p0J3FE+I15rOZ6VUaKrm2h156UQ1LeDu1a1tV
   ljQwSCCptit9XqDrW8/O29U9iYHeVV6gkl7uim75LeK2sCgbvqGeIegtp
   YG0FEvz6RpbhgwSyC/y/xYI/IofqksQW59HCilAzb8I6TFV+Wtngbs3UN
   0qyeNutKBUhBkwKoMQQBN1m/XHhOakJky8Dt+R/Ic4i7ur+OL1N8AxbIC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="396763236"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="396763236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726554213"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726554213"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 06:53:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLOfb-00H276-0H;
        Mon, 17 Jul 2023 16:53:47 +0300
Date:   Mon, 17 Jul 2023 16:53:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 5/5] arm64: mte: add compression support to mteswap.c
Message-ID: <ZLVH6t25HD+HhCka@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-6-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717113709.328671-6-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:37:08PM +0200, Alexander Potapenko wrote:
> Define the internal mteswap.h interface:
>  - _mte_alloc_and_save_tags()
>  - _mte_free_saved_tags()
>  - _mte_restore_tags()
> 
> , that encapsulates saving tags for a struct page (together with memory
> allocation), restoring tags, and deleting the storage allocated for them.
> 
> These functions accept opaque pointers, which may point to 128-byte
> tag buffers, as well as smaller buffers containing compressed tags, or
> have compressed tags stored directly in them.
> 
> The existing code from mteswap.c operating with uncompressed tags is split
> away into mteswap_nocomp.c, and the newly introduced mteswap_comp.c
> provides compression with the EA0 algorithm. The latter implementation
> is picked if CONFIG_ARM64_MTE_COMP=y.
> 
> Soon after booting Android, tag compression saves ~2.5x memory previously
> spent by mteswap.c on tag allocations. With the growing uptime, the
> savings reach 20x and even more.

...

> +#ifndef ARCH_ARM64_MM_MTESWAP_H_
> +#define ARCH_ARM64_MM_MTESWAP_H_

> +#include <linux/mm_types.h>

But you actually don't use that.

struct page;

forward declaration is enough.

> +void *_mte_alloc_and_save_tags(struct page *page);
> +void _mte_free_saved_tags(void *tags);
> +void _mte_restore_tags(void *tags, struct page *page);
> +
> +#endif // ARCH_ARM64_MM_MTESWAP_H_

...

> +void _mte_free_saved_tags(void *storage)
> +{
> +	unsigned long handle = xa_to_value(storage);
> +	int size;
> +
> +	if (!handle)
> +		return;

Perhaps

	unsigned long handle;

	handle = xa_to_value(storage);
	if (!handle)
		return;

> +	size = ea0_storage_size(handle);
> +	ea0_release_handle(handle);
> +}

> +void _mte_restore_tags(void *tags, struct page *page)
> +{

As per above.

> +	if (try_page_mte_tagging(page)) {
> +		if (!ea0_decompress(handle, tags_decomp))
> +			return;
> +		mte_restore_page_tags(page_address(page), tags_decomp);
> +		set_page_mte_tagged(page);
> +	}

I think you may drop an indentation level by

	if (!try_page_mte_tagging(page))
		return;

> +}

...

> +void _mte_restore_tags(void *tags, struct page *page)
> +{
> +	if (try_page_mte_tagging(page)) {
> +		mte_restore_page_tags(page_address(page), tags);
> +		set_page_mte_tagged(page);
> +	}

Ditto.

> +}

-- 
With Best Regards,
Andy Shevchenko


