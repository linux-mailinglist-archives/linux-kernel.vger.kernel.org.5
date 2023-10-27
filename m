Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2537D8E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJ0FYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJ0FYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:24:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08011A7;
        Thu, 26 Oct 2023 22:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YAsKIDzf4gfIILb946Asaebuapv/jhJwoXiTxwG1mzc=; b=Yz5gNp6lCx2bdtSt09UjsOV2D/
        cWTbXqSmKRKy6Ppwecx5a0JfqmX/wgWxa7NSCMJzxVrF9SyLYghv6VsvgCoxup32SR1NYEjqOzqhL
        Yg9e7twQ+pQZj6TmRGdmxTIOd3LvCDxxp8Nyw0+ugpiccx1RJnzSl2LPkTyvNl/YC2xufil6+BAC6
        TGO1bXTr/VM0ZcuNFtp7pkKM8gGPOOvoG+h142c2f9M0io3RjGzD0M+lvm7aRa+yehzGhe7vxKWTj
        2XYSpcOXgLsqI54UfZUmoGb9y6J9CeSToHdoc/aq2FmGwVouq49hBetgHILisweJoQB4pEOIFW8et
        3gtzro6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwFKH-00FcK0-20;
        Fri, 27 Oct 2023 05:24:05 +0000
Date:   Thu, 26 Oct 2023 22:24:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     jeshwank <JESHWANTHKUMAR.NK@amd.com>
Cc:     thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jens.wiklander@linaro.org, sumit.garg@linaro.org,
        jarkko.nikula@linux.intel.com, mario.limonciello@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
        Rijo-john.Thomas@amd.com, nimesh.easow@amd.com
Subject: Re: [PATCH 1/3] crypto: ccp - Add function to allocate and free
 memory using DMA APIs
Message-ID: <ZTtJdU5a/P4kg/Ss@infradead.org>
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
 <20231025065700.1556152-2-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025065700.1556152-2-JESHWANTHKUMAR.NK@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:26:58PM +0530, jeshwank wrote:
> +	tee_buf->vaddr = dma_alloc_coherent(psp->dev, size, &tee_buf->dma, gfp);
> +	if (!tee_buf->vaddr || !tee_buf->dma) {
> +		kfree(tee_buf);
> +		return NULL;
> +	}
> +
> +	tee_buf->size = size;
> +
> +	/* Check whether IOMMU is present. If present, translate IOVA
> +	 * to physical address, else the dma handle is the physical
> +	 * address.
> +	 */
> +	dom = iommu_get_domain_for_dev(psp->dev);
> +	if (dom)
> +		tee_buf->paddr = iommu_iova_to_phys(dom, tee_buf->dma);
> +	else

No, you can't mix the DMA API and iommu API.  You need to stick to one
or the other.

