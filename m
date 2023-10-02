Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4687B4B75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjJBGaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjJBGaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:30:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA19B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XKqktRgZJ9kzBiEPkUUVphTY5hbUfnFM86CuOM3EvbY=; b=bGmIi2RbBBQ68IW4awuPgghjA0
        bg8A7VVnJrSg+QryNVBhMjSFHVLEDLilkMlWK/XOxYwpItZgilPWVvlc8/A5gwXDcGGLRuGZaZW8v
        vNqCWakUQfMlVR6v0vtK/VZ1Lt7drz38jnH3hRShMwLP3Eaz9P8HL53bvtZGz5MOvpbdmo2nfvapB
        HQrxlpJ7N+Nqxj3JdDVoFKPLPQXghoy4nPUXAxwW9FtGK63+NcsdxgxJvrLGV73NoQCG4JtrgAsp5
        1/xAqbbDF7wmI/iUVdzrEmNZSwYSqAH7AsrWtw0Pt0lNRZimVP3E4mJokzPrqtcvXgZelfiESPQsw
        JY7D3eQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnCRY-00C1mG-0L;
        Mon, 02 Oct 2023 06:30:12 +0000
Date:   Sun, 1 Oct 2023 23:30:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelly Devilliv <kelly.devilliv@outlook.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Message-ID: <ZRpjdPC4eSCA/jOk@infradead.org>
References: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, dma_map_resources must never be used for PCIe P2P mappings, you
absolutely must use dma_map_sg as only that handles all the corner cases
correctly.

And we need to figure out a way to put a check into dma_map_resources
so that people stop abusing it.

