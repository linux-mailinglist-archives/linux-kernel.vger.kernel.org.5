Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484907D8F08
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJ0G5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjJ0G5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:57:42 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 091C61BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:57:38 -0700 (PDT)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 52EF41A4E27;
        Fri, 27 Oct 2023 08:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1698389857;
        bh=tsFzkWcWhsxpfd/M+Xd0Blp+9KhEvDyR0wnVjhOfiS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMHFZFCPVlWNbE4xV4sa7KNNp3Ep7Fmv4vo9izUuFGJVhk4VMkS1kUsRmZW5lfan0
         P3dMgTxGv77hqVscNpEwk9MueoVG8vycfFfiJmTYOImxhmjk0827UCumx6t5kRbLLF
         0E4Pu4Nt9rMyNuJR5ZxOx8z7KriwteojmZc/ONE0HqC0935r6RYcHsiLRDeBrkzv44
         jTvpNVWCkkx7cIk6SY/BcRk+0fSOCuhYrUq080oCzumVc9FyUG1shmAVRqU+2drqqQ
         iP6sYXIKKP3vG5BDIzPVR/ZI0ZBfKH0ByAblIwkZkSTSZzBvYj/R+VDLgS5yKxgGQ1
         Cy1JjwCoAACwg==
Date:   Fri, 27 Oct 2023 08:57:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid unnecessary cache invalidations
Message-ID: <ZTtfYPenwmd6W3nX@8bytes.org>
References: <20231026084942.17387-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026084942.17387-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 04:49:42PM +0800, Lu Baolu wrote:
> The iommu_create_device_direct_mappings() only needs to flush the caches
> when the mappings are changed in the affected domain. This is not true
> for non-DMA domains, or for devices attached to the domain that have no
> reserved regions. To avoid unnecessary cache invalidations, add a check
> before iommu_flush_iotlb_all().
> 
> Fixes: a48ce36e2786 ("iommu: Prevent RESV_DIRECT devices from blocking domains")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
