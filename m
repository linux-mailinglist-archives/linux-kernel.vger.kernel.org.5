Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59267D29E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjJWGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:08:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE1D65
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:08:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC75468AA6; Mon, 23 Oct 2023 08:08:45 +0200 (CEST)
Date:   Mon, 23 Oct 2023 08:08:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jia He <justin.he@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v3 2/2] dma-mapping: fix dma_addressing_limited() if
 dma_range_map can't cover all system RAM
Message-ID: <20231023060845.GA11907@lst.de>
References: <20231016125254.1875-1-justin.he@arm.com> <20231016125254.1875-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016125254.1875-3-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + */
> +static int check_ram_in_range_map(unsigned long start_pfn,
> +				  unsigned long nr_pages, void *data)
> +{
> +	unsigned long end_pfn = start_pfn + nr_pages;
> +	struct device *dev = (struct device *)data;

No need for the cast here.

> +	struct bus_dma_region *bdr = NULL;
> +	const struct bus_dma_region *m;
> +
> +	while (start_pfn < end_pfn) {
> +		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
> +			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
> +
> +			if (start_pfn >= cpu_start_pfn
> +			    && start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {

Linux coding style keeps the && on the previous line.

> +				bdr = (struct bus_dma_region *)m;

If you also declared bdr as const this should be able to do away with
the cast.

>  bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> -			    dma_get_required_mask(dev);
> +	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> +			 dma_get_required_mask(dev))
> +		return true;
> +
> +	return !all_ram_in_dma_range_map(dev);

So, all the dma range map thing is really a dma-direct concept.  So I
think here in dma_addressing_limited we should just do a:

	if (likely(!ops))
		return !dma_direct_all_ram_mapped(dev));
	return false

with dma_direct_all_ram_mapped move to dma-direct.c.

