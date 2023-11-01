Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1267B7DDD54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjKAHjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjKAHjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:39:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C19F1;
        Wed,  1 Nov 2023 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698824336; x=1730360336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cUiL60Q4g/FFeKGo5RkMz2YZaR7uRt/yFxzYNEjO4gA=;
  b=HFMC2EjyhNFdp6DvAAJJNhT9T5VA8pjN30dI8XYcFTARdvBxSiC6T1Rt
   S1/LzCcPBKWfNMs7HNrhwjZ3Kh6eBFobtN/pC33fPGLPC4t6OJifmfXfc
   R9J0r8u8I69PncfIEbAQBd8q6wwxngXtTJvYbtqqpoH/WFRk8GyxX5zV/
   hFDTAt12dIowltk7xx36uOFL4qESbCnBFu9u9Xk5sBKs2jV5NrJpiHQJ2
   Q69GtM0fSQFXvGn2xlXXlSD5mvSe23BOhQchRuFUD9FsVR7z0aV9r+c5c
   Z9XZDt89WI1Ji94FUsrmsrJJEB9zRA/2GlZ//UUwtWHmfsD1XeAlhRNZ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="9982674"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="9982674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="934357534"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="934357534"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.34.17])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:38:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mmc: cqhci: Increase recovery halt timeout
Date:   Wed,  1 Nov 2023 09:38:24 +0200
Message-Id: <20231101073827.4772-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101073827.4772-1-adrian.hunter@intel.com>
References: <20231101073827.4772-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failing to halt complicates the recovery. Additionally, unless the card or
controller are stuck, which is expected to be very rare, then the halt
should succeed, so it is better to wait. Set a large timeout.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/cqhci-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..15f5a069af1f 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -984,10 +984,10 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 /*
  * After halting we expect to be able to use the command line. We interpret the
  * failure to halt to mean the data lines might still be in use (and the upper
- * layers will need to send a STOP command), so we set the timeout based on a
- * generous command timeout.
+ * layers will need to send a STOP command), however failing to halt complicates
+ * the recovery, so set a timeout that would reasonably allow I/O to complete.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	500
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {
-- 
2.34.1

