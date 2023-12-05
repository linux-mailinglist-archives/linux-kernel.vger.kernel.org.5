Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC53804404
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbjLEB0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjLEB0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:26:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE8B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701739602; x=1733275602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bkkpqs/4u4rtpGgvFYZ8AVk/jZfzha1HLmAg3v2cthU=;
  b=dsdSO3FIG0/ylEWmEqvSRJCdj/QpY93FuIN+YWrMvd5E6fKJu/nWYV0P
   ECCn2ZwIFkN9XmdmA61diZFaB/3MJ4mVPV/VlSdxQTt7iFC+VbsPTvHuk
   7f1MRjE4iTYZuPGeM8Vh5Rf0WqGMYmqHuwOg06Q8X/UsjE+eXRkfzLX8l
   y9pD6vz0JhyWOoTAQcjJLEYZbIBkUcZvDzyQuztL+06T8D6ESZFDhJMfE
   +ya/iUTq5yESbzbYDJAbMnbl2ZaM9YKdNOOpSAv3Aj7pMpUn1qYn3MhBv
   N2Wmn1Uxpsm4w03cw9+C3osDJOjLzOLY08z93ODGPav+4qOmIw1NPNF4A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460313322"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="460313322"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102276164"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1102276164"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2023 17:26:39 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/6] iommu/vt-d: Convert to use static identity domain
Date:   Tue,  5 Dec 2023 09:21:57 +0800
Message-Id: <20231205012203.244584-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's IOMMU driver used a special domain called 1:1 mapping domain to
support the domain of type IOMMU_DOMAIN_IDENTITY, which enables device
drivers to directly utilize physical addresses for DMA access despite
the presence of IOMMU units.

The implementation of the 1:1 mapping domain is influenced by hardware
differences. While modern Intel VT-d implementations support hardware
passthrough translation mode, earlier versions lacked this feature,
which requires a more complex implementation approach.

The 1:1 mapping domain for earlier hardware was implemented by associating
a DMA domain with an IOVA (IO Virtual Address) equivalent to the
physical address. While, for most hardware supporting passthrough mode,
simply setting the hardware's passthrough mode is sufficient. These two
modes were merged together in si_domain, which is a special DMA domain
sharing the domain ops of an ordinary DMA domain.

As the iommu core has evolved, it has introduced global static identity
domain with "never fail" attach semantics. This means that the domain is
always available and cannot fail to attach. The iommu driver now assigns
this domain directly at iommu_ops->identity_domain instead of allocating
it through the domain allocation interface.

This converts the Intel IOMMU driver to embrace the global static
identity domain. For early legacy hardwares that don't support
passthrough translation mode, ask the iommu core to use a DMA type of
default domain. For modern hardwares that support passthrough
translation mode, implement a static global identity domain.

The whole series is also avaiable at

https://github.com/LuBaolu/intel-iommu/commits/vtd-static-identity-domain-v2

Very appreciated for your review comments and suggestions.

Change log:
v2:
 - Re-orgnize the patches by removing 1:1 mappings before implementing
   global static domain.

v1: https://lore.kernel.org/linux-iommu/20231120112944.142741-1-baolu.lu@linux.intel.com/ 

Lu Baolu (6):
  iommu/vt-d: Setup scalable mode context entry in probe path
  iommu/vt-d: Remove scalable mode context entry setup from attach_dev
  iommu/vt-d: Refactor domain_context_mapping_one() to be reusable
  iommu/vt-d: Remove 1:1 mappings from identity domain
  iommu/vt-d: Add support for static identity domain
  iommu/vt-d: Cleanup si_domain

 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/iommu.c | 568 +++++++++++++++---------------------
 drivers/iommu/intel/pasid.c | 180 ++++++++++++
 drivers/iommu/intel/svm.c   |   2 +-
 4 files changed, 415 insertions(+), 336 deletions(-)

-- 
2.34.1

