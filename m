Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D287CD473
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjJRGZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjJRGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:25:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B810E;
        Tue, 17 Oct 2023 23:24:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB69768BEB; Wed, 18 Oct 2023 08:24:39 +0200 (CEST)
Date:   Wed, 18 Oct 2023 08:24:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 06/10] dma: Use free_decrypted_pages()
Message-ID: <20231018062439.GA18260@lst.de>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com> <20231017202505.340906-7-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017202505.340906-7-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 01:25:01PM -0700, Rick Edgecombe wrote:
>  struct cma;
>  
> @@ -165,7 +166,7 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
>  static inline void dma_free_contiguous(struct device *dev, struct page *page,
>  		size_t size)
>  {
> -	__free_pages(page, get_order(size));
> +	free_decrypted_pages((unsigned long)page_address(page), get_order(size));

CMA can be highmem, so this won't work totally independent of what
free_decrypted_pages actually does.  Also please avoid the overly long line.
