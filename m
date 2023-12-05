Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABBC8060D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjLEVau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbjLEVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:25:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739B1B9;
        Tue,  5 Dec 2023 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811553; x=1733347553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hdHLETQMuJ0KalGVNJ3eGU0gg0ZdzTgPv56YEW+tSc=;
  b=XjMxsy/fS+8LV4nFnviAZFpwyL72E9C9ULE4zGVu99T02ZNkYnT2CdwB
   u2Nu9MCajNgyLyTgha2VCgHcSQWdAeEno9AUc5UD7j2B0rRyfEqOWOKDA
   KgTvR9LGGDabgtNpEUV75ZdC0s834ZFNzIGlwxBvqhj5gSPLBsU9U22fM
   vxgLHOQJxsSGbh3qiRQn+4em2caNklGSI6ByunwrEHZ/3ib48aEKYL7W9
   5CoO3+PJMSZnBWe0/kZag/OdId96r7LidA3P1FKXANLDZccHzWgLB20Bn
   +gVBIMRK9p7bVoRe3b0q5UfRxTjvhWsdTrFnzcV2D6T2KmoOykYqubU/t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396751609"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="396751609"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="19102583"
Received: from jsamonte-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.71.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:25:50 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v12 04/14] dmaengine: idxd: Export wq resource management functions
Date:   Tue,  5 Dec 2023 15:25:20 -0600
Message-Id: <20231205212530.285671-5-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
References: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

