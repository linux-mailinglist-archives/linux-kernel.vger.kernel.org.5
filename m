Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A577F9CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjK0JcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjK0JcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:32:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7825BE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:32:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D49C67373; Mon, 27 Nov 2023 10:32:10 +0100 (CET)
Date:   Mon, 27 Nov 2023 10:32:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
Message-ID: <20231127093210.GA3662@lst.de>
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com> <20231127071430.GA28214@lst.de> <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:56:45PM +0800, Zhaoyang Huang wrote:
> Sorry for the confusion, please find below codes for more information.
> dma_init_coherent_memory
>     memremap
>         addr = ioremap_wt(offset, size);
> What I mean is addr is a vmalloc address, which is implicitly mapped
> by dma's framework and not be aware of to the driver.

Yes.  And it is only returned from dma_alloc_coherent, which should
never be passed to dma_map_<anything>.

> Please correct me if I am wrong. According to my understanding, cache
> consistency could be solved inside dma_map_page via either
> dma_direct_map_page(swio/arch_sync_dma_for_device) or ops->map_page.
> The original thought of rejecting vmalloc is that this pa is not safe
> as this mapping could go in any time. What I am suggesting is to let
> this kind of va be enrolled.

But that only works for the direct mapping.  It does not work for the
additional aliases created by vmap/ioremap/memremap.  Now that only
matters if the cache is virtually indexed, which is rather unusual
these days.
