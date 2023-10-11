Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A21E7C4908
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjJKFLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:11:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730092
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:11:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 38E5F6732A; Wed, 11 Oct 2023 07:11:01 +0200 (CEST)
Date:   Wed, 11 Oct 2023 07:11:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jia He <justin.he@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Message-ID: <20231011051100.GB32642@lst.de>
References: <20231010020835.3678-1-justin.he@arm.com> <20231010074816.GA9082@lst.de> <39d5aabd-4c09-4135-a3d7-00f6da7a1684@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d5aabd-4c09-4135-a3d7-00f6da7a1684@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:40:44AM +0100, Robin Murphy wrote:
> On 2023-10-10 08:48, Christoph Hellwig wrote:
>> dma_addressing_limited is called for every dma (direct) map, and this
>> new code is way to heavy for that.  We'll need to cache the information
>> somehow.
>
> But is it? That was my instinctive reaction as well, but AFAICS it is only 
> actually used by drivers in setup paths, either directly or via 
> dma_max_mapping_size(). The dma_capable() check which we *do* use for every 
> actual mapping still just checks whether the given physical address exists 
> in the range map. I believe the underlying problem here is when 
> dma_capable() say the mapping needs bouncing, but then it's too big for 
> that to succeed, since dma_max_mapping_size() gave the wrong answer to 
> start with.

Ah, indeed, I somehw misremembered calling it in the mapping code.

Justing, can you still respin this a bit, add a prep patch to move
dma_addressing_limited so that it is exported instead of the new
low-level helper, and fix up coding style issues like the overly
long lines of possible?  If it's not perfect I'll fix up the rest
later.
