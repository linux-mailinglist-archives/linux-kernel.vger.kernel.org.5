Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0D7AE986
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjIZJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjIZJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:46:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CF0B3;
        Tue, 26 Sep 2023 02:46:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 45ECF68D05; Tue, 26 Sep 2023 11:46:17 +0200 (CEST)
Date:   Tue, 26 Sep 2023 11:46:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tomasz Figa <tfiga@chromium.org>,
        Fang Hui <hui.fang@nxp.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, anle.pan@nxp.com, xuegang.liu@nxp.com
Subject: Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Message-ID: <20230926094616.GA14877@lst.de>
References: <20230914145812.12851-1-hui.fang@nxp.com> <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com> <353919fd-932e-5d81-6ac5-7b51117366cd@arm.com> <20230926065143.GB5606@lst.de> <4d0f3de5-1d34-d998-cb55-7ce7bfaf3f49@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d0f3de5-1d34-d998-cb55-7ce7bfaf3f49@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:21:15AM +0100, Robin Murphy wrote:
> On 2023-09-26 07:51, Christoph Hellwig wrote:
>> On Wed, Sep 20, 2023 at 05:54:26PM +0100, Robin Murphy wrote:
>>> As I mentioned before, I think it might make the most sense to make the
>>> whole thing into a "proper" dma_alloc_sgtable() function, which can then be
>>> used with dma_sync_sgtable_*() as dma_alloc_pages() is used with
>>> dma_sync_single_*() (and then dma_alloc_noncontiguous() clearly falls as
>>> the special in-between case).
>>
>> Why not just use dma_alloc_noncontiguous if the caller wants an sgtable
>> anyway?
>
> Because we don't need the restriction of the allocation being 
> DMA-contiguous (and thus having to fall back to physically-contiguous in 
> the absence of an IOMMU). That's what vb2_dma_contig already does, whereas 
> IIUC vb2_dma_sg is for devices which can handle genuine scatter-gather DMA 
> (and so are less likely to have an IOMMU, and more likely to need the best 
> shot at piecing together large allocations).

Let's just extent dma_alloc_noncontiguous with a max_dma_segments
parameter instead of adding yet another API.

