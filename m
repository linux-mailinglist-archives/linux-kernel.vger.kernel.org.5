Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0537FAB61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjK0U11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjK0U1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:27:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501810CA;
        Mon, 27 Nov 2023 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701116839; x=1732652839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hdHLETQMuJ0KalGVNJ3eGU0gg0ZdzTgPv56YEW+tSc=;
  b=lYO/8YU6/FEJ8oY6f3rzAAZlLsGJGCJHw/G/6fIN6R2QU9CdT1WH+v2C
   ToEo82V7foaCQpCgr3fkA1yYm3METTDRY5pA9XCcOSCVNBXsZgxRo5R1j
   LKG+ngyOo+4SfrulY8dKG4j7MZS1ZteF/+a5OvnZ8AVciGOSMkXf2nhzi
   cqTxXk7ICoGMbJgXsWB+3jWAyLuCDGg5oHHYQcGsHA3A/rlmMAYH70u1g
   1A5X6F63W2F4SzFw5+eL5cC4tktfdNnxpcwOaFm0repFuVdEXSMMLwPGp
   nh9YqirJo6cVfZKiSJxBjWuuyjjrMsFZtsN+DFlYH/c/R6NrgoMpbroyO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457115508"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457115508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16394533"
Received: from rpkulapa-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.213.183.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:18 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v10 04/14] dmaengine: idxd: Export wq resource management functions
Date:   Mon, 27 Nov 2023 14:26:54 -0600
Message-Id: <20231127202704.1263376-5-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow idxd sub-drivers to access the wq resource management
functions, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index feca8534a1c5..e6176de0e12b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -161,6 +161,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	free_hw_descs(wq);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_alloc_resources, IDXD);
 
 void idxd_wq_free_resources(struct idxd_wq *wq)
 {
@@ -174,6 +175,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
 	sbitmap_queue_free(&wq->sbq);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_free_resources, IDXD);
 
 int idxd_wq_enable(struct idxd_wq *wq)
 {
@@ -405,6 +407,7 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq)
 	reinit_completion(&wq->wq_resurrect);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_init_percpu_ref, IDXD);
 
 void __idxd_wq_quiesce(struct idxd_wq *wq)
 {
@@ -414,6 +417,7 @@ void __idxd_wq_quiesce(struct idxd_wq *wq)
 	complete_all(&wq->wq_resurrect);
 	wait_for_completion(&wq->wq_dead);
 }
+EXPORT_SYMBOL_NS_GPL(__idxd_wq_quiesce, IDXD);
 
 void idxd_wq_quiesce(struct idxd_wq *wq)
 {
@@ -421,6 +425,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq)
 	__idxd_wq_quiesce(wq);
 	mutex_unlock(&wq->wq_lock);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_quiesce, IDXD);
 
 /* Device control bits */
 static inline bool idxd_is_enabled(struct idxd_device *idxd)
-- 
2.34.1

