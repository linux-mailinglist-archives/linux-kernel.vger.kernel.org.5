Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D47AE63E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjIZGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZGvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:51:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01FE6;
        Mon, 25 Sep 2023 23:50:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2588267373; Tue, 26 Sep 2023 08:50:50 +0200 (CEST)
Date:   Tue, 26 Sep 2023 08:50:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Fang Hui <hui.fang@nxp.com>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, anle.pan@nxp.com, xuegang.liu@nxp.com
Subject: Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Message-ID: <20230926065049.GA5606@lst.de>
References: <20230914145812.12851-1-hui.fang@nxp.com> <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:41:08PM +0900, Tomasz Figa wrote:
> On Thu, Sep 14, 2023 at 4:41 PM Fang Hui <hui.fang@nxp.com> wrote:
> >
> > On system with "CONFIG_ZONE_DMA32=y", if the allocated physical address is
> 
> First of all, thanks a lot for the patch! Please check my review comments below.
> 
> Is CONFIG_ZONE_DMA32 really the factor that triggers the problem? My
> understanding was that the problem was that the hardware has 32-bit
> DMA, but the system has physical memory at addresses beyond the first
> 4G.

You should NEVER disable CONFIG_ZONE_DMA32 for a system that has
memory > 4GB.  I've made this point repeatedly, but the ARM64 maintainers
insist on making it configurable instead of selecting it like most other
64-bit architetures that aren't guaranteed to always use a IOMMU.

We need to stop that.

> Hmm, when I was proposing dma_alloc_pages(), I missed that it returns
> a DMA handle. That on its own can be handled by saving the returned
> handles somewhere in struct vb2_dma_sg_buf, but there is a bigger
> problem - the function would actually create a mapping if the DMA
> device requires some mapping management (e.g. is behind an IOMMU),
> which is undesirable, because we create the mapping ourselves below
> anyway...
> 
> @Christoph Hellwig @Robin Murphy  I need your thoughts on this as
> well. Would it make sense to have a variant of dma_alloc_pages() that
> only allocates the pages, but doesn't perform the mapping? (Or a flag
> that tells the implementation to skip creating a mapping.)

dma_map_pages needs to map the pages as part of finding out that the
allocation actually works.  So skipping it can't really be done.

So why do you want to create your own mapping anyway?

