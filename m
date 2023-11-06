Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D307E1AE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKFHOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjKFHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:14:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D71D8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699254846; x=1730790846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gWxXYuEpy8G84pCRxEr8zR2qYt2dBXJPyl6P3BJNrtQ=;
  b=iCGJDlT80R6YCHX5t8JBh5lfoEhLNwqldMKYrIszg6vl+2jAWpg5MPKj
   fv+avqXdwNJAvcnaROHzr7Uj+ktrVGazLbsl9UNRcUx0SF30HdDfCqlpR
   QywpLBbS6x8zTZK6oaS4ifXvKn87imaFo7sF9SANme1m9GXEIvud7r/Um
   /Sqh1MKpPmzSx/91yGbI4BNHot85N1WZLNvrsCXRCntnYJacqJbkhIM+v
   TW8pa2lCHZxn9reEIlKOAs/agXepX84ib4yGF5wuVS68x+Qh1+Ub1PsxX
   JtQfbovuLeU9g2z3YGPNvEm6YbT6xLNd8k+i+Skz1m5nSRVnounzUB339
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759058"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="10759058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690893"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1093690893"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain) ([10.239.48.212])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:14:02 -0800
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 3/5] iommu/io-pgtable: Introduce struct vtd_cfg
Date:   Mon,  6 Nov 2023 02:12:24 -0500
Message-Id: <20231106071226.9656-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106071226.9656-1-tina.zhang@intel.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VT-d hardware cap/ecap information is needed for driver to generate VT-d
format IO page table. Add struct vtd_cfg to keep the info.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/io-pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index b2857c18f963..ae6a2e44b027 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -147,6 +147,11 @@ struct io_pgtable_cfg {
 			u32 n_ttbrs;
 		} apple_dart_cfg;
 
+		struct {
+			u64 cap_reg;
+			u64 ecap_reg;
+		} vtd_cfg;
+
 		struct {
 			dma_addr_t	pgd;
 		} virt;
-- 
2.39.3

