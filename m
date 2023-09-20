Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0377A7292
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjITGIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjITGI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:08:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878BAF;
        Tue, 19 Sep 2023 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190102; x=1726726102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GIaIXCqIGoxl1rQ/uxCgQqfwjzyvj08lMJhHPrSZpx0=;
  b=VZItf5AcbtNRS7v/SopXlt85Tm/OWsFU6Wbc6I4u8tStGPmuAIeoGpJm
   luNigWzawQxcfIid+OlYRABkHQT8w7mCACvhzdkH17FNBUhv5o4ZFDXQm
   xCOLEQkfN6H7PWcXKEfbCtYThw4KQ85B2yB/qrsgPkC1gqz2JlUDgQpqd
   92LckcTZeb6ooki12ug1mckXMxJPz/iKqH7TdmUESKvRdWJGLiKXfF0UM
   YdRCCHg2W+MhW03yUNMrdmddlquVb2Wm4BUHSGEB5hsIb4f3co9ALZ2k/
   u2u/G7pBbs/BQuDPLebFNPIkJgVSHuL7PilkCgMX4fX77BP4u4LXhdP+X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="382880382"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="382880382"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="1077294545"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="1077294545"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.20.10]) ([10.213.20.10])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:08:17 -0700
Message-ID: <81f332a3-2b30-465d-f026-bc203aada32d@intel.com>
Date:   Wed, 20 Sep 2023 08:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [Intel-gfx] [PATCH] i915: Limit the length of an sg list to the
 requested length
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
References: <20230919194855.347582-1-willy@infradead.org>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230919194855.347582-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.2023 21:48, Matthew Wilcox (Oracle) wrote:
> The folio conversion changed the behaviour of shmem_sg_alloc_table() to
> put the entire length of the last folio into the sg list, even if the sg
> list should have been shorter.  gen8_ggtt_insert_entries() relied on the
> list being the right langth and would overrun the end of the page tables.

s/langth/length/, I can fix it on applying.

> Other functions may also have been affected.
> 
> Clamp the length of the last entry in the sg list to be the expected
> length.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 0b62af28f249 ("i915: convert shmem_sg_free_table() to use a folio_batch")
> Cc: stable@vger.kernel.org # 6.5.x
> Link: https://gitlab.freedesktop.org/drm/intel/-/issues/9256
> Link: https://lore.kernel.org/lkml/6287208.lOV4Wx5bFT@natalenko.name/
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 8f1633c3fb93..73a4a4eb29e0 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -100,6 +100,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>   	st->nents = 0;
>   	for (i = 0; i < page_count; i++) {
>   		struct folio *folio;
> +		unsigned long nr_pages;
>   		const unsigned int shrink[] = {
>   			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
>   			0,
> @@ -150,6 +151,8 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>   			}
>   		} while (1);
>   
> +		nr_pages = min_t(unsigned long,
> +				folio_nr_pages(folio), page_count - i);
>   		if (!i ||
>   		    sg->length >= max_segment ||
>   		    folio_pfn(folio) != next_pfn) {
> @@ -157,13 +160,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>   				sg = sg_next(sg);
>   
>   			st->nents++;
> -			sg_set_folio(sg, folio, folio_size(folio), 0);
> +			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
>   		} else {
>   			/* XXX: could overflow? */
> -			sg->length += folio_size(folio);
> +			sg->length += nr_pages * PAGE_SIZE;
>   		}
> -		next_pfn = folio_pfn(folio) + folio_nr_pages(folio);
> -		i += folio_nr_pages(folio) - 1;
> +		next_pfn = folio_pfn(folio) + nr_pages;
> +		i += nr_pages - 1;
>   
>   		/* Check that the i965g/gm workaround works. */
>   		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);

