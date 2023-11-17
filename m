Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B77EF4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjKQOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjKQOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:41:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E8C5;
        Fri, 17 Nov 2023 06:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700232064; x=1731768064;
  h=from:to:cc:subject:date:message-id;
  bh=oJMlxIX+xGl6Bb9PQ7qfp+lKIWOfx1gEg/uC2QjrdSE=;
  b=arKd14o0v7nbIweOaAPYgdzMIc7MsXFDT2kiUlM3rGXEc/zk3uoNPZeb
   sizsEy9P9/1Ke5KgyyhPUSx8XR+yo4h7/bSJQzzvR/yIUYr12Z8i0LRTD
   y8N82ISCYdU3dmmeybiDPpODiPgcOgtSnsPLJWoLPhtMXxGCVaqY8mtMl
   CVgWoCmOzD8yzzBWPSP0WqOht06xwbwnRr8W+YidkQyqFTxhp/OKZWTVo
   yHRin+4EYFAO8Z2y4FHjQQe8OPPTSg21/ruh3lu3i4okuLnJfPqhxe49A
   W+sI6qUkyge6LXqgoL1F/ZPpFeSeGt+bRXGRi06l2K3FcS1YD6dALIyPK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="370661074"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="370661074"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 06:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="742092615"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="742092615"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2023 06:41:01 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     broonie@kernel.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] spi: intel: make mem_ops comparison unique to opcode match
Date:   Fri, 17 Nov 2023 20:10:53 +0530
Message-Id: <20231117144053.24005-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of comparing parameters for every supported mem_ops, only compare
on opcode match, which is relatively more efficient.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/spi/spi-intel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 98ec4dc22b81..3654ae35d2db 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -711,8 +711,7 @@ static bool intel_spi_cmp_mem_op(const struct intel_spi_mem_op *iop,
 {
 	if (iop->mem_op.cmd.nbytes != op->cmd.nbytes ||
 	    iop->mem_op.cmd.buswidth != op->cmd.buswidth ||
-	    iop->mem_op.cmd.dtr != op->cmd.dtr ||
-	    iop->mem_op.cmd.opcode != op->cmd.opcode)
+	    iop->mem_op.cmd.dtr != op->cmd.dtr)
 		return false;
 
 	if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
@@ -737,11 +736,12 @@ intel_spi_match_mem_op(struct intel_spi *ispi, const struct spi_mem_op *op)
 	const struct intel_spi_mem_op *iop;
 
 	for (iop = ispi->mem_ops; iop->mem_op.cmd.opcode; iop++) {
-		if (intel_spi_cmp_mem_op(iop, op))
-			break;
+		if (iop->mem_op.cmd.opcode == op->cmd.opcode &&
+		    intel_spi_cmp_mem_op(iop, op))
+			return iop;
 	}
 
-	return iop->mem_op.cmd.opcode ? iop : NULL;
+	return NULL;
 }
 
 static bool intel_spi_supports_mem_op(struct spi_mem *mem,
-- 
2.17.1

