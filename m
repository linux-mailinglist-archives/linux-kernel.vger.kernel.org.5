Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF678F864
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348351AbjIAGKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbjIAGKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:10:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D5EA;
        Thu, 31 Aug 2023 23:10:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31E5F68B05; Fri,  1 Sep 2023 08:10:15 +0200 (CEST)
Date:   Fri, 1 Sep 2023 08:10:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, Tomasz Figa <tfiga@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Anle Pan <anle.pan@nxp.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Message-ID: <20230901061014.GA32166@lst.de>
References: <20230828075420.2009568-1-anle.pan@nxp.com> <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com> <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com> <20230829150442.GA3929@lst.de> <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com> <20230830143341.GA25574@lst.de> <ZO9xzf727b/YvZB/@ziepe.ca> <20230831123532.GA11156@lst.de> <ZPCylmcRD0hwluZf@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPCylmcRD0hwluZf@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:32:38PM -0300, Jason Gunthorpe wrote:
> The entry is variable sized, so it depends on what is stuffed in
> it. For alot of common use cases, especially RDMA page lists, it will
> be able to use an 8 byte entry. This is pretty much the most space
> efficient it could be.

How do you get away with a 8 byte entry for addr+len?

> The primary alternative I see is a fixed 16 bytes/entry with a 64 bit
> address and ~60 bit length + ~4 bits of flags. This is closer to bio,
> simpler and faster, but makes the RDMA cases 2x bigger.

That's what I'd expect.

> With your direction I felt we could safely keep bio as it is and
> cheaply make a fast DMA mapper for it. Provide something like this as
> the 'kitchen sink' version for dmabuf/rdma/etc that are a little
> different.

So for the first version I see no need to change the bio_vec
representation as part of this project, but at the same time the
bio_vec representation causes problems for other reasons.  So I want
to change it anyway.
