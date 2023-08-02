Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E376D8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjHBUu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjHBUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:50:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255D26B0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691009455; x=1722545455;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nss3SPFs8sZFuONovQ6d4ok5xV7bZTjvxM1WKEfFBPk=;
  b=MdZpoQKm1hN/eY4dXJSMklxO20QAG8vQ7ufvlQKw7VNPbZnmyvkQRY1N
   mWC8TZa9+2fCtPEu7FtstYdQocJS8yV08oofqBHPYaK44YKVbA6HvaMS/
   A4gszSdnDgxoim42S8XW5/g3aLiNcLGbCa0qtEwLDGSNlQDOg3vOhAVbJ
   YkvVqGZSzgl2tPLZLMw9UJsYozC/DgQrzDVH5ArLqiSFo2G1maTTFCJSO
   zh9Y137WiRIHB5s877lzL/ZayhWSNiL2L5VA+JvDiQq1Mz+UvlTsUpMx8
   mK8OzcBWN6p+zFqqQRUvkyiVETRBh9ssvGl3aY14Xp6s8W3JLUGwU04Tk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373335816"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="373335816"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 13:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819370808"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="819370808"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 13:50:21 -0700
Date:   Wed, 2 Aug 2023 13:55:29 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v11 2/8] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230802135529.7a4ed681@jacob-builder>
In-Reply-To: <ZMpsr3FbcEYRs/G8@nvidia.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
        <20230724222538.3902553-3-jacob.jun.pan@linux.intel.com>
        <ZMpsr3FbcEYRs/G8@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, 2 Aug 2023 11:48:15 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jul 24, 2023 at 03:25:32PM -0700, Jacob Pan wrote:
> > Global PASID can be used beyond SVA. For example, drivers that use
> > Intel ENQCMD to submit work must use global PASIDs in that PASID
> > is stored in a per CPU MSR. When such device need to submit work
> > for in-kernel DMA with PASID, it must allocate PASIDs from the same
> > global number space to avoid conflict.  
> 
> This is a bit misleading, maybe:
> 
> ==
> Intel ENQCMD requires a single PASID to be shared between multiple
> devices, as the PASID is stored in a single MSR register per-process
> and userspace can use only that one PASID.
> 
> This means that the PASID allocation for any ENQCMD using device driver
> must always come from a shared global pool, regardless of what kind of
> domain the PASID will be used with.
> 
> Split the code for the global PASID allocator into
> iommu_alloc/free_global_pasid() so that drivers can attach non-SVA
> domains to PASIDs as well.
> ==
Much better. Let me update.

Thanks,

Jacob
