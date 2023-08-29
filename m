Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEEC78C844
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbjH2PEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbjH2PEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:04:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200BEC9;
        Tue, 29 Aug 2023 08:04:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C41C46732D; Tue, 29 Aug 2023 17:04:42 +0200 (CEST)
Date:   Tue, 29 Aug 2023 17:04:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, Anle Pan <anle.pan@nxp.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Message-ID: <20230829150442.GA3929@lst.de>
References: <20230828075420.2009568-1-anle.pan@nxp.com> <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com> <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:14:44PM +0100, Robin Murphy wrote:
> dma_get_max_seg_size() represents a capability of the device itself, namely 
> the largest contiguous range it can be programmed to access in a single DMA 
> descriptor/register/whatever.

Yes.  In a way it's a bit odd that it ended up in a field in
struct device, as the feature might actually be different for different
DMA engines or features in a device.  If I was to redesign it from
scratch I'd just pass it to dma_map_sg.

>> Generally looking at videobuf2-dma-sg, I feel like we would benefit
>> from some kind of dma_alloc_table_from_pages() that simply takes the
>> struct dev pointer and does everything necessary.
>
> Possibly; this code already looks lifted from drm_prime_pages_to_sg(), and 
> if it's needed here then presumably vb2_dma_sg_get_userptr() also needs it, 
> at the very least.

Yes, there's tons of them.  But I'd feel really bad adding even more
struct scatterlist based APIs given how bad of a data structure that is.
