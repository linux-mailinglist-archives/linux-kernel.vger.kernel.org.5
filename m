Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51CE7F3C65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbjKVDae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbjKVDad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:30:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D83D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623829; x=1732159829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4RFN6C5anem5Gt5zf3iTGGH/gQovytqONM6TO/5w4I=;
  b=b+95poE7izt6ZAT4AeKf1MEEqr8S0Qwu1gN0zGX+EzYeBUoCJk/SfCKs
   UTJdDe9A4EUS7EdfU6bbeufgBGETMLRAkzAMnr7qxykAClM5zCAS/HU6I
   B5jOkP0+xxs3riX2d8dGXiyi8G9KmPX4Xy9TPrL0SVjp8lT7xFfelSBVH
   bwCYPQOUIpLrrWbiV6Ki3ISwvVUOsdGerh01ylG1py+TUi7O0P5NA6NbH
   E9I0cBjW90xbjr7HnRDRNYjCFzlExc1hZUzjAH3VWDxZlxVAa5XuYAR+U
   vBh2vw87qlNaO/LTQyLzUSLtMi2KGjk+E4cZW15mJPuGem6k5+4aytcc4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742764"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742764"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090158"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:28 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     mohd.syazwan.abdul.halim@intel.com,
        Kunwu Chan <chentao@kylinos.cn>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] [PULL REQUEST] iommu/vt-d: Fixes for v6.7-rc3
Date:   Wed, 22 Nov 2023 11:26:01 +0800
Message-Id: <20231122032608.165144-1-baolu.lu@linux.intel.com>
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

Hi Joerg,

The following fixes have been queued for v6.7. They aim to:

- Do not support enforcing cache coherency for non-empty domains
- Avoid devTLB invalidation if iommu is off
- Disable PCI ATS in legacy passthrough mode
- Support non-PCI devices when clearing context
- Fix incorrect cache invalidation for mm notification
- Add MTL to quirk list to skip TE disabling
- Set variable intel_dirty_ops to static

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Abdul Halim, Mohd Syazwan (1):
  iommu/vt-d: Add MTL to quirk list to skip TE disabling

Kunwu Chan (1):
  iommu/vt-d: Set variable intel_dirty_ops to static

Lu Baolu (5):
  iommu/vt-d: Support enforce_cache_coherency only for empty domains
  iommu/vt-d: Omit devTLB invalidation requests when TES=0
  iommu/vt-d: Disable PCI ATS in legacy passthrough mode
  iommu/vt-d: Make context clearing consistent with context mapping
  iommu/vt-d: Fix incorrect cache invalidation for mm notification

 drivers/iommu/intel/iommu.h |  3 +++
 drivers/iommu/intel/dmar.c  | 18 ++++++++++++++++++
 drivers/iommu/intel/iommu.c | 18 +++++++++++-------
 drivers/iommu/intel/svm.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.34.1

