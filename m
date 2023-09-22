Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2557AB3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjIVOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjIVOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:35:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD6100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695393327; x=1726929327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBdjcYkSZ8EzFUwfpHhwC6yu0/jZkLM6N9BlmSP/mkw=;
  b=llhFVD7/yMHIldxsd3iH42WBt0SEybeL/jNyQoVLmxL2X2Li/b0KYM3P
   OqBl7RU8kmiqoClSStUSZa8YcaknsMIZUT24OjXiy1er/T9WT96ujO6zv
   Q0lJZde28UOas63krdxnkNDnuorbFajYale1OfSKWQ3bwqHKVPVb7xuDH
   FQrV/34Q73b6RhPcUD2m7tnF+gPNHG3ZHzizX3fw22VYJC7k/5V3Av/kO
   tSTn9c7xAx/oN5yqAJAmDdjcd+Ymzg9FoAKBvkdo+AdMyFuFhygd5B7PD
   ikwdowges1vP9RAn2RCgXOrLUdfqI5j2mK7xpd5ZEd6OGEfuHKRzAQOQA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="467138061"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="467138061"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="921181698"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="921181698"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:35:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjhFX-0000000HD0X-3fE8;
        Fri, 22 Sep 2023 17:35:19 +0300
Date:   Fri, 22 Sep 2023 17:35:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v5 0/5] Implement MTE tag compression for swapped pages
Message-ID: <ZQ2mJ9rK7xNoMykL@smile.fi.intel.com>
References: <20230922080848.1261487-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922080848.1261487-1-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Olek, who internally is being developed something similar to your first
patch here.

On Fri, Sep 22, 2023 at 10:08:42AM +0200, Alexander Potapenko wrote:
> Currently, when MTE pages are swapped out, the tags are kept in the
> memory, occupying PAGE_SIZE/32 bytes per page. This is especially
> problematic for devices that use zram-backed in-memory swap, because
> tags stored uncompressed in the heap effectively reduce the available
> amount of swap memory.
> 
> The RLE-based algorithm suggested by Evgenii Stepanov and implemented in
> this patch series is able to efficiently compress fixed-size tag buffers,
> resulting in practical compression ratio between 2.5x and 4x. In most
> cases it is possible to store the compressed data in 63-bit Xarray values,
> resulting in no extra memory allocations.
> 
> Our measurements show that the proposed algorithm provides better
> compression than existing kernel compression algorithms (LZ4, LZO,
> LZ4HC, ZSTD) can offer.
> 
> To implement compression/decompression, we also extend <linux/bitmap.h>
> with methods to read/write bit values at arbitrary places in the map.
> 
> We refactor arch/arm64/mm/mteswap.c to support both the compressed
> (CONFIG_ARM64_MTE_COMP) and non-compressed case. For the former, in
> addition to tag compression, we move tag allocation from kmalloc() to
> separate kmem caches, providing greater locality and relaxing the
> alignment requirements.
> 
> v5:
>  - fixed comments by Andy Shevchenko, Catalin Marinas, and Yury Norov
>  - added support for 16K- and 64K pages
>  - more efficient bitmap_write() implementation
> 
> v4:
>  - fixed a bunch of comments by Andy Shevchenko and Yury Norov
>  - added Documentation/arch/arm64/mte-tag-compression.rst
> 
> v3:
>  - as suggested by Andy Shevchenko, use
>    bitmap_get_value()/bitmap_set_value() written by Syed Nayyar Waris
>  - switched to unsigned long to reduce typecasts
>  - simplified the compression code
> 
> v2:
>  - as suggested by Yuri Norov, replace the poorly implemented struct
>    bitq with <linux/bitmap.h>
> 
> 
> 
> Alexander Potapenko (4):
>   lib/test_bitmap: add tests for bitmap_{read,write}()
>   arm64: mte: implement CONFIG_ARM64_MTE_COMP
>   arm64: mte: add a test for MTE tags compression
>   arm64: mte: add compression support to mteswap.c
> 
> Syed Nayyar Waris (1):
>   lib/bitmap: add bitmap_{read,write}()
> 
>  Documentation/arch/arm64/index.rst            |   1 +
>  .../arch/arm64/mte-tag-compression.rst        | 245 +++++++++
>  arch/arm64/Kconfig                            |  21 +
>  arch/arm64/include/asm/mtecomp.h              |  13 +
>  arch/arm64/mm/Makefile                        |   7 +
>  arch/arm64/mm/mtecomp.c                       | 467 ++++++++++++++++++
>  arch/arm64/mm/mtecomp.h                       |  12 +
>  arch/arm64/mm/mteswap.c                       |  20 +-
>  arch/arm64/mm/mteswap.h                       |  12 +
>  arch/arm64/mm/mteswap_comp.c                  |  60 +++
>  arch/arm64/mm/mteswap_nocomp.c                |  38 ++
>  arch/arm64/mm/test_mtecomp.c                  | 287 +++++++++++
>  include/linux/bitmap.h                        |  68 +++
>  lib/test_bitmap.c                             | 115 +++++
>  14 files changed, 1355 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
>  create mode 100644 arch/arm64/include/asm/mtecomp.h
>  create mode 100644 arch/arm64/mm/mtecomp.c
>  create mode 100644 arch/arm64/mm/mtecomp.h
>  create mode 100644 arch/arm64/mm/mteswap.h
>  create mode 100644 arch/arm64/mm/mteswap_comp.c
>  create mode 100644 arch/arm64/mm/mteswap_nocomp.c
>  create mode 100644 arch/arm64/mm/test_mtecomp.c
> 
> -- 
> 2.42.0.515.g380fc7ccd1-goog
> 

-- 
With Best Regards,
Andy Shevchenko


