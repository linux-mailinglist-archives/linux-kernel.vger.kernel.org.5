Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D802F7E017F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjKCIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346130AbjKCIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:48:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68241D4E;
        Fri,  3 Nov 2023 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699001321; x=1730537321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAFnkZjCEfVfLAK7KrRDYxSV98mreyDoOmktfPkz9T8=;
  b=EAYuVz3f2lClSgtM2RSUPVYMj9S0Of5Gbsa/B4PXfWcNw3qZ1GMNhkOp
   qDU2Mk0O1vFKxWUWZt/kYbAbHLeuDM47x55pn8btRglA80I0jNWoELfa0
   E7/d7ergo2NekkcshsxT/xkfzLgjqjbFXhFhrL19Za7JLhGOQpGRDgMb5
   JFCj6+ZuNxpji4jDXZH+Ujq6TBuPankpxMMYn8BBJ19WhvK8fhZCCTFNS
   ZjDlQVmMHW66H8qnTOjVWGlOaL2MZspi7IdkFXvGVJW83e0VSXuwaocuQ
   ErXnVK2aJLqg2nRlKT660u8hGy/3guR+jtcNqZBW9vMKL3cgpLCgPM+Ge
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391774620"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391774620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796556695"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796556695"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] mmc: cqhci: Fix task clearing in CQE error recovery
Date:   Fri,  3 Nov 2023 10:47:20 +0200
Message-Id: <20231103084720.6886-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103084720.6886-1-adrian.hunter@intel.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task completion notification (TCN) is received when there is no
outstanding task, the cqhci driver issues a "spurious TCN" warning. This
was observed to happen right after CQE error recovery.

When an error interrupt is received the driver runs recovery logic.
It halts the controller, clears all pending tasks, and then re-enables
it. On some platforms, like Intel Jasper Lake, a stale task completion
event was observed, regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.

This results in either:
a) Spurious TC completion event for an empty slot.
b) Corrupted data being passed up the stack, as a result of premature
   completion for a newly added task.

Rather than add a quirk for affected controllers, ensure tasks are cleared
by toggling CQHCI_ENABLE, which would happen anyway if
cqhci_clear_all_tasks() timed out. This is simpler and should be safe and
effective for all controllers.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Reported-by: Kornel Dulęba <korneld@chromium.org>
Tested-by: Kornel Dulęba <korneld@chromium.org>
Co-developed-by: Kornel Dulęba <korneld@chromium.org>
Signed-off-by: Kornel Dulęba <korneld@chromium.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/cqhci-core.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 948799a0980c..41e94cd14109 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -1075,28 +1075,28 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 
 	ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
 
-	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-		ok = false;
-
 	/*
 	 * The specification contradicts itself, by saying that tasks cannot be
 	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it should
 	 * be disabled/re-enabled, but not to disable before clearing tasks.
 	 * Have a go anyway.
 	 */
-	if (!ok) {
-		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
-		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-		cqcfg &= ~CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		cqcfg |= CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		/* Be sure that there are no tasks */
-		ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
-		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-			ok = false;
-		WARN_ON(!ok);
-	}
+	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
+		ok = false;
+
+	/* Disable to make sure tasks really are cleared */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
+
+	if (!ok)
+		cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
 
 	cqhci_recover_mrqs(cq_host);
 
-- 
2.34.1

