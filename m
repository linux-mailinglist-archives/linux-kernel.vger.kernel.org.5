Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7187DDD58
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjKAHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjKAHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:39:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CAD10A;
        Wed,  1 Nov 2023 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698824349; x=1730360349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OV8RDN4Bd1h5BCWBvIEygF8kScSzkr9HTkdiwgabNdQ=;
  b=MGWbMVROvCPDxaUTNeEs+0wnNKXWI2Vy9lmow5DFZeNW+h7nlsa4A1ZP
   iyPCv4mKyw3Qtk2qKKgeRdiAzZgD9Cx7h6mW8F1nUDjn5TxFlellSNVNN
   M9FWHWAHp3jFbnKJSXIVZ/1JgFROWYZQJ8jvN9ygh750g2fpkgctchoxi
   TKO7/saiOMILCSaMLoQSyqrMTiKoWiG2N/3kqMi5RdD8/Xenv+QMfdNVM
   HmR5fBQo4qquZsGlebuVTk0E32fX09JKJeOd+YM0dM5mlm9kQRENykIRF
   91q2q5Fy5QuZutYeVV5GmPd3MqZpqoxOaIrgTbrXc0+SdmgFnsjOQjGR6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="9982762"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="9982762"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="934357556"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="934357556"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.34.17])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:39:01 -0700
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
Subject: [PATCH 4/5] mmc: block: Retry commands in CQE error recovery
Date:   Wed,  1 Nov 2023 09:38:26 +0200
Message-Id: <20231101073827.4772-5-adrian.hunter@intel.com>
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

It is important that MMC_CMDQ_TASK_MGMT command to discard the queue is
successful because otherwise a subsequent reset might fail to flush the
cache first.  Retry it and the previous STOP command.

Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index befde2bd26d3..a8c17b4cd737 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -551,7 +551,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, MMC_BUSY_IO);
 
@@ -561,10 +561,13 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err)
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
 	mmc_retune_release(host);
 
 	return err;
-- 
2.34.1

