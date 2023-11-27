Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89767F9F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjK0Mfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjK0Mfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:35:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293F18A;
        Mon, 27 Nov 2023 04:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701088543; x=1732624543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yp/ah/6UfzXck55VRxpB/2AJtviOqVShHgC1pzKlQDc=;
  b=ZgcmVlP/Cz54Mrei0r+T/O9KoOKlxaKSPkosK6JYb6b3Co4C30Ep4IGs
   9UQsCH3JI/nNCrUL2Nqlpqmj+KQxw2H8W8S4JLPQa+OstA5bEHbhnaeTc
   a5Z3D4NO4cvBdNOMryNfoTA/ZV0GFqm18rg16LD1hUZlruYAOZlp4Fnke
   gsWcHADFTIPX7QWqZ6dWnsWNolZTlHOljMqm04Tl22QRZ1K8XH/mz8OOy
   Of3Vj+TIlM9ePk4scTY0Ou5CFn7Xmyi8WAL75d5ocy3U6nN8p1hf3OKny
   FZatHwLKmLcWd8D4PcxGRa5pPmJKo37RMn37VgU4cqByehgygAl/XhzSg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="5882343"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="5882343"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="718021893"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="718021893"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:35:40 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     linux-sound@vger.kernel.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel_ace2x: fix AC timing setting for ACE2.x
Date:   Mon, 27 Nov 2023 20:47:35 +0800
Message-Id: <20231127124735.2080562-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

From: Chao Song <chao.song@linux.intel.com>

Start from ACE1.x, DOAISE is added to AC timing control
register bit 5, it combines with DOAIS to get effective
timing, and has the default value 1.

The current code fills DOAIS, DACTQE and DODS bits to a
variable initialized to zero, and updates the variable
to AC timing control register. With this operation, We
change DOAISE to 0, and force a much more aggressive
timing. The timing is even unable to form a working
waveform on SDA pin.

This patch uses read-modify-write operation for the AC
timing control register access, thus makes sure those
bits not supposed and intended to change are not touched.

Signed-off-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 82672fcbc2aa..8280baa3254b 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -23,8 +23,9 @@
 static void intel_shim_vs_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim_vs = sdw->link_res->shim_vs;
-	u16 act = 0;
+	u16 act;
 
+	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
 	u16p_replace_bits(&act, 0x1, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
 	act |= SDW_SHIM2_INTEL_VS_ACTMCTL_DACTQE;
 	act |=  SDW_SHIM2_INTEL_VS_ACTMCTL_DODS;
-- 
2.25.1

