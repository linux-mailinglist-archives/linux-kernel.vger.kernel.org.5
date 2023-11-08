Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825E37E587D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjKHOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjKHOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:18:35 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB8171B;
        Wed,  8 Nov 2023 06:18:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2F3C67373; Wed,  8 Nov 2023 15:18:28 +0100 (CET)
Date:   Wed, 8 Nov 2023 15:18:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations with
 CONFIG_SWIOTLB_DYNAMIC
Message-ID: <20231108141828.GA1574@lst.de>
References: <20231108111249.261-1-petrtesarik@huaweicloud.com> <20231108132120.0538a778@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231108132120.0538a778@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 01:21:20PM +0100, Petr Tesařík wrote:
> On Wed,  8 Nov 2023 12:12:49 +0100
> Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> 
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > 
> > Limit the free list length to the size of the IO TLB. Transient pool can be
> > smaller than IO_TLB_SEGSIZE, but the free list is initialized with the
> > assumption that the total number of slots is a multiple of IO_TLB_SEGSIZE.
> > As a result, swiotlb_area_find_slots() may allocate slots past the end of
> > a transient IO TLB buffer.
> 
> Just to make it clear, this patch addresses only the memory corruption
> reported by Niklas, without addressing the underlying issues. Where
> corruption happened before, allocations will fail with this patch.

Thanks, I've applied so that we can get it into -rc1.

