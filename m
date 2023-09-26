Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729057AEF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjIZOis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjIZOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:38:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E01CFE6;
        Tue, 26 Sep 2023 07:38:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E101FB;
        Tue, 26 Sep 2023 07:39:16 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36D223F5A1;
        Tue, 26 Sep 2023 07:38:37 -0700 (PDT)
Message-ID: <06d476e5-ba85-1504-d69b-a8c1cf617d54@arm.com>
Date:   Tue, 26 Sep 2023 15:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
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
 <4d0f3de5-1d34-d998-cb55-7ce7bfaf3f49@arm.com>
 <20230926094616.GA14877@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230926094616.GA14877@lst.de>
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

On 26/09/2023 10:46 am, Christoph Hellwig wrote:
> On Tue, Sep 26, 2023 at 09:21:15AM +0100, Robin Murphy wrote:
>> On 2023-09-26 07:51, Christoph Hellwig wrote:
>>> On Wed, Sep 20, 2023 at 05:54:26PM +0100, Robin Murphy wrote:
>>>> As I mentioned before, I think it might make the most sense to make the
>>>> whole thing into a "proper" dma_alloc_sgtable() function, which can then be
>>>> used with dma_sync_sgtable_*() as dma_alloc_pages() is used with
>>>> dma_sync_single_*() (and then dma_alloc_noncontiguous() clearly falls as
>>>> the special in-between case).
>>>
>>> Why not just use dma_alloc_noncontiguous if the caller wants an sgtable
>>> anyway?
>>
>> Because we don't need the restriction of the allocation being
>> DMA-contiguous (and thus having to fall back to physically-contiguous in
>> the absence of an IOMMU). That's what vb2_dma_contig already does, whereas
>> IIUC vb2_dma_sg is for devices which can handle genuine scatter-gather DMA
>> (and so are less likely to have an IOMMU, and more likely to need the best
>> shot at piecing together large allocations).
> 
> Let's just extent dma_alloc_noncontiguous with a max_dma_segments
> parameter instead of adding yet another API.

Sure, that could work equally well, and might even help make its 
existing usage a bit clearer.

Cheers,
Robin.
