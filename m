Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10F78ED3B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346280AbjHaMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHaMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:35:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146FD1A4;
        Thu, 31 Aug 2023 05:35:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F3FE68BEB; Thu, 31 Aug 2023 14:35:33 +0200 (CEST)
Date:   Thu, 31 Aug 2023 14:35:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, Tomasz Figa <tfiga@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Anle Pan <anle.pan@nxp.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Message-ID: <20230831123532.GA11156@lst.de>
References: <20230828075420.2009568-1-anle.pan@nxp.com> <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com> <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com> <20230829150442.GA3929@lst.de> <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com> <20230830143341.GA25574@lst.de> <ZO9xzf727b/YvZB/@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO9xzf727b/YvZB/@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:43:57PM -0300, Jason Gunthorpe wrote:
> > > conversion function for the drivers.
> > 
> > Jason said at LSF/MM that he had a prototype for a mapping API that
> > takes a phys/len array as input and dma_addr/len a output, which really
> > is the right thing to do, especially for dmabuf.
> 
> Yes, still a prototype. Given the change in direction some of the
> assumptions of the list design will need some adjusting.
> 
> I felt there wasn't much justification to add a list without also
> supporting the P2P and it was not looking very good to give the DMA
> API proper p2p support without also connecting it to lists somehow.
> 
> Anyhow, I had drafted a basic list datastructure and starting
> implementation that is sort of structured in away that is similar to
> xarray (eg with fixed chunks, generic purpose, etc)
> 
> https://github.com/jgunthorpe/linux/commit/58d7e0578a09d9cd2360be515208bcd74ade5958

This seems fairly complicated complicated, and the entry seems pretty large
for a bio_vec replacement or a dma_addr_t+len tuple, which both should
be (sizeof(phys_addr_t) + sizeof(u32) + the size of flags if needed, which
for 64-bit would fit into the padding from 96 bytes to 128 bytes anyway.
