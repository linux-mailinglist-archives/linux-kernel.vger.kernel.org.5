Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF90575A68C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGTGeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGTGdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592D3C2A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689834612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCoF85LwxElSFY5o7HroSG4lMnByeeIZNvm2+XicB/I=;
        b=OwuS3wAD0UAmS8SUXfWWHOwOlxFTBzvPNZE//qINIrqJ8/VCVtbUBlFUDxwa2X3+n4zRIg
        54NTJwfxg60h0L66/SG0EeRd+IsaIM23gUDsZDqgKM7GIrj67ZQcGnBY6Oea5bVbdKyjDT
        Bu28rLl1W/x77lwDfNiWBUeyxhiKFDw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-hl5ufZKwMBK2nZy5I_mBcA-1; Thu, 20 Jul 2023 02:30:10 -0400
X-MC-Unique: hl5ufZKwMBK2nZy5I_mBcA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314256aedcbso244197f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834608; x=1690439408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCoF85LwxElSFY5o7HroSG4lMnByeeIZNvm2+XicB/I=;
        b=gYJ5/HhLgkntgVoDKh4tlBgMtA1Ropb2+OyRlx5XrcNk/jsJPT0iLi+WhDygk9I7SJ
         sKKrAsSxfstjwTI2feaerEqQVyfLwTPZzvWF5VhABh1f/0dGk7eWR1YFaFHXFwDNX8p7
         yUK8ftFe0R1jqVl3ChFBTa4XNdIYFMvcRzf5FcpAW76YtVEvTO1BfDLWGUvD07Tf/2Er
         a/hxBuxdZZr6kybzlPxw30UnW/i8zZK6wX/vDzLuUYNiplIL2oxyLxhulg3lnRnrOFq5
         9vFYMnHx97adzrWGJ9bTuIBQ3p/4QVGAix9lAYM5xN/jiGnYkkN3Ur888fkUp/3f8zQj
         TrOw==
X-Gm-Message-State: ABy/qLZnRi+aGGjb7JJlVlr3vgTcXFXkONwck7/5tRdDyb51WPm2wlFF
        YkFYGcxSr42xFBhPrEEvLTyzMHYemIHA0/bRlskVg7sefZ8b86wuOQbg5rzNeZpObwZhmtpZzdN
        xjWKQIwCLfQAO6oWS+7rgsD+mw7DsFGnL
X-Received: by 2002:a5d:46c3:0:b0:314:545f:6e8e with SMTP id g3-20020a5d46c3000000b00314545f6e8emr1017503wrs.62.1689834608675;
        Wed, 19 Jul 2023 23:30:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEqrDGYDr/wLn3dkPeB6zRw5yF1tiHMkpVYfjV66pB+FXnX+Hssa21Ln+BRV1RLzzgO6PpFfg==
X-Received: by 2002:a5d:46c3:0:b0:314:545f:6e8e with SMTP id g3-20020a5d46c3000000b00314545f6e8emr1017490wrs.62.1689834608389;
        Wed, 19 Jul 2023 23:30:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:65c:3b05:aa8f:9ec2:7e3e])
        by smtp.gmail.com with ESMTPSA id r15-20020adff70f000000b003143ba62cf4sm284488wrp.86.2023.07.19.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:30:07 -0700 (PDT)
Date:   Thu, 20 Jul 2023 02:30:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720022702-mutt-send-email-mst@kernel.org>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
 <20230720060742.GA2987@lst.de>
 <20230720021914-mutt-send-email-mst@kernel.org>
 <20230720062525.GA3723@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720062525.GA3723@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:25:25AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 20, 2023 at 02:21:05AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 20, 2023 at 08:07:42AM +0200, Christoph Hellwig wrote:
> > > On Wed, Jul 19, 2023 at 06:15:59AM -0400, Michael S. Tsirkin wrote:
> > > > A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
> > > > might be easily misunderstood.
> > > 
> > > .. just curious: what patchset is that?  DMA_ATTR_SKIP_CPU_SYNC is
> > > often a bad idea and all users probably could use a really good
> > > audit..
> > 
> > Message-Id: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
> 
> Do you have an actual link?

sure, they are not hard to generate ;)

https://lore.kernel.org/all/20230710034237.12391-11-xuanzhuo%40linux.alibaba.com

> > 
> > 
> > Looks like there's really little else can be done: there's a
> > shared page we allow DMA into, so we sync periodically.
> > Then when we unmap we really do not need that data
> > synced again.
> > 
> > What exactly is wrong with this?
> 
> A "shared" page without ownership can't work with the streaming
> DMA API (dma_map_*) at all.  You need to use dma_alloc_coherent
> so that it is mapped uncached.

Hmm confused.  Based on both documentation and code I think this works:

	dma_map
	dma_sync
	dma_sync
	dma_sync
	dma_sync
	dma_unmap(DMA_ATTR_SKIP_CPU_SYNC)

right?

-- 
MST

