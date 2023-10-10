Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD887BF79E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjJJJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjJJJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:40:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FE9294
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:40:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A606D1FB;
        Tue, 10 Oct 2023 02:41:27 -0700 (PDT)
Received: from [10.57.69.45] (unknown [10.57.69.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19A553F762;
        Tue, 10 Oct 2023 02:40:45 -0700 (PDT)
Message-ID: <39d5aabd-4c09-4135-a3d7-00f6da7a1684@arm.com>
Date:   Tue, 10 Oct 2023 10:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>, Jia He <justin.he@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231010020835.3678-1-justin.he@arm.com>
 <20231010074816.GA9082@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231010074816.GA9082@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 08:48, Christoph Hellwig wrote:
> dma_addressing_limited is called for every dma (direct) map, and this
> new code is way to heavy for that.  We'll need to cache the information
> somehow.

But is it? That was my instinctive reaction as well, but AFAICS it is 
only actually used by drivers in setup paths, either directly or via 
dma_max_mapping_size(). The dma_capable() check which we *do* use for 
every actual mapping still just checks whether the given physical 
address exists in the range map. I believe the underlying problem here 
is when dma_capable() say the mapping needs bouncing, but then it's too 
big for that to succeed, since dma_max_mapping_size() gave the wrong 
answer to start with.

Thanks,
Robin.
