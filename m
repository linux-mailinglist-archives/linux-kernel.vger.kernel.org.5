Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C347AE7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjIZIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:21:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FE2EB4;
        Tue, 26 Sep 2023 01:21:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 555E2DA7;
        Tue, 26 Sep 2023 01:21:59 -0700 (PDT)
Received: from [10.57.0.188] (unknown [10.57.0.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C900C3F5A1;
        Tue, 26 Sep 2023 01:21:19 -0700 (PDT)
Message-ID: <4d0f3de5-1d34-d998-cb55-7ce7bfaf3f49@arm.com>
Date:   Tue, 26 Sep 2023 09:21:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>, Fang Hui <hui.fang@nxp.com>,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        anle.pan@nxp.com, xuegang.liu@nxp.com
References: <20230914145812.12851-1-hui.fang@nxp.com>
 <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
 <353919fd-932e-5d81-6ac5-7b51117366cd@arm.com> <20230926065143.GB5606@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230926065143.GB5606@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-26 07:51, Christoph Hellwig wrote:
> On Wed, Sep 20, 2023 at 05:54:26PM +0100, Robin Murphy wrote:
>> As I mentioned before, I think it might make the most sense to make the
>> whole thing into a "proper" dma_alloc_sgtable() function, which can then be
>> used with dma_sync_sgtable_*() as dma_alloc_pages() is used with
>> dma_sync_single_*() (and then dma_alloc_noncontiguous() clearly falls as
>> the special in-between case).
> 
> Why not just use dma_alloc_noncontiguous if the caller wants an sgtable
> anyway?

Because we don't need the restriction of the allocation being 
DMA-contiguous (and thus having to fall back to physically-contiguous in 
the absence of an IOMMU). That's what vb2_dma_contig already does, 
whereas IIUC vb2_dma_sg is for devices which can handle genuine 
scatter-gather DMA (and so are less likely to have an IOMMU, and more 
likely to need the best shot at piecing together large allocations).

Thanks,
Robin.
