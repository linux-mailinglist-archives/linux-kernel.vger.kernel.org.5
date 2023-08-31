Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D978F061
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjHaPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbjHaPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:32:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5EE55
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:32:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bee12e842so770008b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693495961; x=1694100761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oic3RLhjJLFMRrnh/TLgKdT1bBdDLhHF0St+2zs/cM=;
        b=PQbw4+MA5oR9V7gfDDgDxXWUekmTc9PXT9hPcfvLEsT0E2WWtota7JLrpDkyYF12qC
         QGyIsZzcaZUCcIYnYQQfl1p3n7eyxkgARJR5VgCV1T8UObLXUKGB1LIQ++hAxa/TMIOn
         y6y0WQrl28afU5z3AJPjSG3RhsZIrWWQP8TWsd8Bu3NPSRGLJkC2AKsDkX8qf3gegtfK
         bu836x1VFxgBvQpsr7sp4Z5MvGrW3DUgVetEBxSHmNWrsylT7y31wXPVIaTUFugQ2kJY
         mqJ/ALmTY4ifCogB+NsdTnaxKxico+7U1EbXvbL8A9TFTwUxyz+g+YtWjneuXyIMrcrQ
         65Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495961; x=1694100761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oic3RLhjJLFMRrnh/TLgKdT1bBdDLhHF0St+2zs/cM=;
        b=hmHeTJB471dG0O9C2fEbnfUYz5r7J0J9XOvAu0hQ53DcRgqPU3aFVROsV00dYdKp+e
         hk9ywgQUPBWs7bsPQFTPU/cNe+T+rDmHzZAE6gs4PLSX+1T75+K0EqlzKl0l41IpBcFR
         RYcvDnrI5eO7lMW6fYbOx0VPS2Ssgk1m5n/nYK6j6WgcWydZFxIvI2w9W/f4E2+YAl3O
         KhsmMoMkCREiCyEl74u3umOeGFW/wVfAsGcFLyyKooNdBwv2E3lpdoANyMA8Uxp3Tgfr
         TPtHMdNBvpymMOPaG51T+x51FdW4FLeEK+7eiK16c/d5xDsHSixikAYu7jizl0mTn5BJ
         /3TA==
X-Gm-Message-State: AOJu0YyQ9ylWKGKeT13iJhukp17AEKXhd9eNyECtfljPjcx+VR5thtCd
        k003YmgL4tfYf9smW279ew691A==
X-Google-Smtp-Source: AGHT+IF5KLLO7/so1cpnK0Z4cYL6heHXJbzhg5chsQzO6cjO+0canVLzcMfdojFa0XNIv4ieQ/49cA==
X-Received: by 2002:a05:6a00:17a3:b0:68c:3f2:6006 with SMTP id s35-20020a056a0017a300b0068c03f26006mr2563pfg.16.1693495960988;
        Thu, 31 Aug 2023 08:32:40 -0700 (PDT)
Received: from ziepe.ca ([207.140.200.197])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00682a61fa525sm1499015pfb.91.2023.08.31.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:32:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qbjew-000Hon-9J;
        Thu, 31 Aug 2023 12:32:38 -0300
Date:   Thu, 31 Aug 2023 12:32:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Anle Pan <anle.pan@nxp.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Message-ID: <ZPCylmcRD0hwluZf@ziepe.ca>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
 <20230829150442.GA3929@lst.de>
 <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com>
 <20230830143341.GA25574@lst.de>
 <ZO9xzf727b/YvZB/@ziepe.ca>
 <20230831123532.GA11156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831123532.GA11156@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 02:35:32PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 30, 2023 at 01:43:57PM -0300, Jason Gunthorpe wrote:
> > > > conversion function for the drivers.
> > > 
> > > Jason said at LSF/MM that he had a prototype for a mapping API that
> > > takes a phys/len array as input and dma_addr/len a output, which really
> > > is the right thing to do, especially for dmabuf.
> > 
> > Yes, still a prototype. Given the change in direction some of the
> > assumptions of the list design will need some adjusting.
> > 
> > I felt there wasn't much justification to add a list without also
> > supporting the P2P and it was not looking very good to give the DMA
> > API proper p2p support without also connecting it to lists somehow.
> > 
> > Anyhow, I had drafted a basic list datastructure and starting
> > implementation that is sort of structured in away that is similar to
> > xarray (eg with fixed chunks, generic purpose, etc)
> > 
> > https://github.com/jgunthorpe/linux/commit/58d7e0578a09d9cd2360be515208bcd74ade5958
> 
> This seems fairly complicated complicated, and the entry seems pretty large
> for a bio_vec replacement or a dma_addr_t+len tuple, which both should
> be (sizeof(phys_addr_t) + sizeof(u32) + the size of flags if needed, which
> for 64-bit would fit into the padding from 96 bytes to 128 bytes anyway.

The entry is variable sized, so it depends on what is stuffed in
it. For alot of common use cases, especially RDMA page lists, it will
be able to use an 8 byte entry. This is pretty much the most space
efficient it could be.

There are RDMA use cases where we end up holding huge numbers of pages
for a long time just so we can eventually unpin them. It is a nice
outcome if that could use 8 bytes/folio.

The primary alternative I see is a fixed 16 bytes/entry with a 64 bit
address and ~60 bit length + ~4 bits of flags. This is closer to bio,
simpler and faster, but makes the RDMA cases 2x bigger.

Which are the right trade offs, or not, I don't know yet. I wanted to
experiment with what this would look like for a bit.

With your direction I felt we could safely keep bio as it is and
cheaply make a fast DMA mapper for it. Provide something like this as
the 'kitchen sink' version for dmabuf/rdma/etc that are a little
different.

Jason
