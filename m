Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5438378E048
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243648AbjH3TNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343623AbjH3QSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:18:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A429D2;
        Wed, 30 Aug 2023 09:18:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbTwG0jV1z67j6l;
        Thu, 31 Aug 2023 00:17:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 17:18:37 +0100
Date:   Wed, 30 Aug 2023 17:18:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] iio: Add buffer write() support
Message-ID: <20230830171836.000045c3@Huawei.com>
In-Reply-To: <20230830171118.00007726@Huawei.com>
References: <20230807112113.47157-1-paul@crapouillou.net>
        <20230830171118.00007726@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 17:11:18 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon,  7 Aug 2023 13:21:07 +0200
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
> > [V3 was: "iio: new DMABUF based API, v3"][1]
> > 
> > Hi Jonathan,
> > 
> > This is a subset of my patchset that introduced a new interface based on
> > DMABUF objects [1]. It adds write() support to the IIO buffer
> > infrastructure.
> > 
> > The reason it is not the full IIO-DMABUF patchset, is because you
> > requested performance benchmarks - and our current numbers are barely
> > better (~ +10%) than the fileio interface. There is a good reason for
> > that: V3 of the patchset switched from having the IIO core creating the
> > DMABUFs backed by physically contiguous memory, to having the IIO core
> > being a simple DMABUF importer, and having the DMABUFs created
> > externally. We now use the udmabuf driver to create those, and they are
> > allocated from paged memory. While this works perfectly fine, our
> > buffers are now cut in 4 KiB chunks (pages), non-contiguous in memory,
> > which causes the DMA hardware to create an IRQ storm, as it raises an
> > interrupt after each 4 KiB in the worst case scenario.  
> 
> Interesting. I'm guessing you don't necessarily need contiguous memory
> and huge pages would get rid of most of that overhead?
> 
> Given embedded target those huge pages are hard to get so you need
> hugetlb support to improve the chances of it working.  Some quick searching
> suggests there is possible support on the way.
> https://lore.kernel.org/linux-mm/20230817064623.3424348-1-vivek.kasireddy@intel.com/
> 
> 
> > 
> > Anyway, this is not directly a problem of the IIO-DMABUF code - but I
> > can't really upstream a shiny new interface that I claim is much faster,
> > without giving numbers.
> > 
> > So while we fix this (either by updating the DMA IP and driver to
> > support scatter-gather)  
> 
> Long run you almost always end up needing that unless contig requirements
> are small and you want a robust solution.  I'm guessing no IOMMU to pretend
> it's all contiguous... 
> 
> > or by hacking something quick to give us
> > physically contiguous DMABUFs just for the benchmark), I thought it
> > would make sense to upstream the few patches of the V3 patchset that are
> > needed for the IIO-DMABUF interface but aren't directly related.  
> 
> Good idea.
> 
> > 
> > As for write() support, Nuno (Cc'd) said he will work on upstreaming the
> > DAC counterpart of adc/adi-axi-adc.c in the next few weeks, so there
> > will be a user for the buffer write() support. I hope you are okay with
> > this - otherwise, we can just wait until this work is done and submit it
> > all at once.  
> 
> Absolutely fine, though I won't pick this up without the user also being
> ready to go.


Having looked through these again, they are straight forward so no changes
requested from me.  Nuno, if you can add this set into appropriate
point in your series that will make use of it that will make my life easier
and ensure and minor rebasing etc happens without having to bother Paul.

Thanks,

Jonathan

> 
> > 
> > Changelog since v3:
> > - [PATCH 2/6] is new;
> > - [PATCH 3/6]: Drop iio_dma_buffer_space_available() function, and
> >   update patch description accordingly;
> > - [PATCH 6/6]: .space_available is now set to iio_dma_buffer_usage
> >   (which is functionally the exact same).
> > 
> > Cheers,
> > -Paul
> > 
> > [1] https://lore.kernel.org/all/20230403154800.215924-1-paul@crapouillou.net/
> > 
> > Alexandru Ardelean (1):
> >   iio: buffer-dma: split iio_dma_buffer_fileio_free() function
> > 
> > Paul Cercueil (5):
> >   iio: buffer-dma: Get rid of outgoing queue
> >   iio: buffer-dma: Rename iio_dma_buffer_data_available()
> >   iio: buffer-dma: Enable buffer write support
> >   iio: buffer-dmaengine: Support specifying buffer direction
> >   iio: buffer-dmaengine: Enable write support
> > 
> >  drivers/iio/adc/adi-axi-adc.c                 |   3 +-
> >  drivers/iio/buffer/industrialio-buffer-dma.c  | 187 ++++++++++++------
> >  .../buffer/industrialio-buffer-dmaengine.c    |  28 ++-
> >  include/linux/iio/buffer-dma.h                |  11 +-
> >  include/linux/iio/buffer-dmaengine.h          |   5 +-
> >  5 files changed, 160 insertions(+), 74 deletions(-)
> >   
> 

