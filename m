Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3767A29E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjIOV5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjIOV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:57:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69820118;
        Fri, 15 Sep 2023 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694815042; x=1726351042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6hO70gqgOmSzHdBwhYaT2sixpZXe4bhY694b9GTBrYY=;
  b=mX2jt0XpfjEYDIl+1oxhJr5aEXH/H5i1k6Cfrsl2dn1OmAYEqm7Lmun6
   2woBwG0ZbaBlJso8lJe9+miffp154BANZzQlZrysqe8kaEDzUj5m/YsRH
   haiA1eo+9QuIcNGXj1K7CZDuGkKWPHPmMKrmO1L6mHORQlcyjMojn13wT
   PbJDXItvrrhQZBp5H6ZGs3oaoRptriCoTHk/b8YbhonMWCnkB2FsbgsrN
   ZbYbR0Frvpi0IOwXsYBXzuvtQM9envBf5tFrgcFHP5s6iDAIqSzvA52Bj
   Pa48Kx9pz7UNF0zr8nGnPE5D01G+oyAbTuQ9jU18A04CDh2NgLHTgQLAU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="376680817"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="376680817"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 14:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810663939"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="810663939"
Received: from spswartz-mobl.amr.corp.intel.com (HELO [10.209.21.97]) ([10.209.21.97])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 14:57:20 -0700
Message-ID: <386c175e-bd10-2d5d-6051-4065f6f9b84a@intel.com>
Date:   Fri, 15 Sep 2023 14:57:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 11/14] mm/slub: allocate slabs from virtual memory
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-12-matteorizzo@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230915105933.495735-12-matteorizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 03:59, Matteo Rizzo wrote:
> +	spin_lock_irqsave(&slub_kworker_lock, irq_flags);
> +	list_splice_init(&slub_tlbflush_queue, &local_queue);
> +	list_for_each_entry(slab, &local_queue, flush_list_elem) {
> +		unsigned long start = (unsigned long)slab_to_virt(slab);
> +		unsigned long end = start + PAGE_SIZE *
> +			(1UL << oo_order(slab->oo));
> +
> +		if (start < addr_start)
> +			addr_start = start;
> +		if (end > addr_end)
> +			addr_end = end;
> +	}
> +	spin_unlock_irqrestore(&slub_kworker_lock, irq_flags);
> +
> +	if (addr_start < addr_end)
> +		flush_tlb_kernel_range(addr_start, addr_end);

I assume that the TLB flushes in the queue are going to be pretty sparse
on average.

At least on x86, flush_tlb_kernel_range() falls back pretty quickly from
individual address invalidation to just doing a full flush.  It might
not even be worth tracking the address ranges, and just do a full flush
every time.

I'd be really curious to see how often actual ranged flushes are
triggered from this code.  I expect it would be very near zero.
