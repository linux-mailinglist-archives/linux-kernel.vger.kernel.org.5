Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D542878304C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHUSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHUSfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7645132
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 271EE6163E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8801C433C8;
        Mon, 21 Aug 2023 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692642945;
        bh=8yk/R2kDXtm3Pd5U4VORfeiun1GGVUmVaxKT10ojq6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OnRimz2io58zcoWtM4426PWfJGDtAXnBedJFhoX2+7gCTY1cWgAAaxwvIuuaK3gxW
         A6uyKnatUSpF3HuavB6c5JVnIF82NZko6FbjkcCDDlEpakhYnvpvnS1mNP5jVsrDiA
         GxfhxF+874GNW2oJdATmtcMLqt2kQl1NsO5nxuCcuwOCOp4q8HAEUR+m44g+RYHqZj
         PQMm4pksQQCx0f3Rkhv3nvw6YQt3X1os/152UvCT9/D9Y43rEVMAIzcez+yXtD8HfY
         gFgCZkklDsuzjKiRr82KXXqmZ10aXAwXTKS68v+2EJxAGdxa2cEHe5Q6kmYO9NvLnX
         sIhJLmrTXDswA==
Date:   Mon, 21 Aug 2023 11:35:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230821113543.536b7375@kernel.org>
In-Reply-To: <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
        <20230816100113.41034-2-linyunsheng@huawei.com>
        <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
        <20230817091554.31bb3600@kernel.org>
        <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
        <20230817165744.73d61fb6@kernel.org>
        <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
        <20230818145145.4b357c89@kernel.org>
        <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 20:18:55 +0800 Yunsheng Lin wrote:
> > -	page_pool_set_dma_addr(page, dma);
> > +	if (page_pool_set_dma_addr(page, dma))
> > +		goto unmap_failed;  
> 
> What does the driver do when the above fails?
> Does the driver still need to implement a fallback for 32 bit arch with
> dma addr with more than 32 + 12 bits?
> If yes, it does not seems to be very helpful from driver's point of view
> as the driver might still need to call page allocator API directly when
> the above fails.

I'd expect the driver to do nothing, we are operating under 
the assumption that "this will never happen". If it does 
the user should report it back to us. So maybe..

> >  	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> >  		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
> >  
> >  	return true;
> > +
> > +unmap_failed:

.. we should also add a:

	WARN_ONCE(1, "misaligned DMA address, please report to netdev@");

here?

> > +	dma_unmap_page_attrs(pool->p.dev, dma,
> > +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> > +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> > +	return false;
