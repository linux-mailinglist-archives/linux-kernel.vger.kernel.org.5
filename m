Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC17FA57C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjK0QAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjK0QAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:00:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E3BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701100851; x=1732636851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c2cu0vMGg8Ol2YSa4yfd/4bw6RpgEUsUJKa+9vCAoF0=;
  b=SHJEez3dgl0oKTdlJvt/sfTxpkux513qVnFcLcTzXEUys8tAgfmwuOkd
   82T4gwW+X8qWapY4MUoJ+vZuTiOu7BRbOfE1cbO8GZu79krQAjHwR3Ii6
   Ex/uT3Eo+MYQrkbkC3Rvie7zPRfgq0AK5YGkiLtxJMPZLYEgdsoIhRJyK
   /tgkYavcXFtitx4YhC6OocCN62q6ilyuoiyP3Wicx35yEs+Vt+POgV++H
   F7IQ1xCM5C3gYJR9xH/lpZemMR+n2NeErU55Bgq+s7yi2qw3I2m2irLSW
   UqcUs34FHZiLbUgqPAIAhki3rDKHPElFInwhSQepoQfUsaU/O/2dhILZl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372901008"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="372901008"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1015611212"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="1015611212"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.15.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:00:48 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1007/1007] mm/zswap: Replace kmap_atomic() with kmap_local_page()
Date:   Mon, 27 Nov 2023 17:00:46 +0100
Message-ID: <4529535.LvFx2qVVIh@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231127154636.585898-1-fabio.maria.de.francesco@linux.intel.com>
References: <20231127154636.585898-1-fabio.maria.de.francesco@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard this patch for a mistake in the subject.

Fabio

On Monday, 27 November 2023 16:46:22 CET Fabio M. De Francesco wrote:
> kmap_atomic() has been deprecated in favor of kmap_local_page().
> 
> Therefore, replace kmap_atomic() with kmap_local_page() in
> zswap.c.
> 
> kmap_atomic() is implemented like a kmap_local_page() which also
> disables page-faults and preemption (the latter only in !PREEMPT_RT
> kernels). The kernel virtual addresses returned by these two API are
> only valid in the context of the callers (i.e., they cannot be handed to
> other threads).
> 
> With kmap_local_page() the mappings are per thread and CPU local like
> in kmap_atomic(); however, they can handle page-faults and can be called
> from any context (including interrupts). The tasks that call
> kmap_local_page() can be preempted and, when they are scheduled to run
> again, the kernel virtual addresses are restored and are still valid.
> 
> In mm/zswap.c, the blocks of code between the mappings and un-mappings
> do not depend on the above-mentioned side effects of kmap_aatomic(), so
> that the mere replacements of the old API with the new one is all that is
> required (i.e., there is no need to explicitly call pagefault_disable()
> and/or preempt_disable()).
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco
> <fabio.maria.de.francesco@linux.intel.com> ---
>  mm/zswap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 74411dfdad92..699c6ee11222 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1267,16 +1267,16 @@ bool zswap_store(struct folio *folio)
>  	}
> 
>  	if (zswap_same_filled_pages_enabled) {
> -		src = kmap_atomic(page);
> +		src = kmap_local_page(page);
>  		if (zswap_is_page_same_filled(src, &value)) {
> -			kunmap_atomic(src);
> +			kunmap_local(src);
>  			entry->swpentry = swp_entry(type, offset);
>  			entry->length = 0;
>  			entry->value = value;
>  			atomic_inc(&zswap_same_filled_pages);
>  			goto insert_entry;
>  		}
> -		kunmap_atomic(src);
> +		kunmap_local(src);
>  	}
> 
>  	if (!zswap_non_same_filled_pages_enabled)
> @@ -1422,9 +1422,9 @@ bool zswap_load(struct folio *folio)
>  	spin_unlock(&tree->lock);
> 
>  	if (!entry->length) {
> -		dst = kmap_atomic(page);
> +		dst = kmap_local_page(page);
>  		zswap_fill_page(dst, entry->value);
> -		kunmap_atomic(dst);
> +		kunmap_local(dst);
>  		ret = true;
>  		goto stats;
>  	}




