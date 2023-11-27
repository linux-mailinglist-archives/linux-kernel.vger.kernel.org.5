Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A287F9AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjK0HO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjK0HO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:14:27 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7959C3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:14:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D98568AFE; Mon, 27 Nov 2023 08:14:30 +0100 (CET)
Date:   Mon, 27 Nov 2023 08:14:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
Message-ID: <20231127071430.GA28214@lst.de>
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:09:30AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> memremap within dma_init_coherent_memory will map the given phys_addr
> into vmalloc area if the pa is not found during iterating iomem_resources,
> which conflict the rejection of vmalloc area in dma_map_single_attrs.

I can't parse this sentence.

> IMO, it is find to let all valid virtual address be valid for DMA as the
> user will keep corresponding RAM safe for transfer.

No, vmalloc address can't be passed to map_single.  You need to pass
the page to dma_map_page, and explicitly mange cache consistency
using the invalidate_kernel_vmap_range and flush_kernel_vmap_range
helpers.

