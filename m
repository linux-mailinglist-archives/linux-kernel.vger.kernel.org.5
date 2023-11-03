Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081F7E0070
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbjKCIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjKCIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:48:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E457CE;
        Fri,  3 Nov 2023 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699001301; x=1730537301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cUiL60Q4g/FFeKGo5RkMz2YZaR7uRt/yFxzYNEjO4gA=;
  b=NKXXyLYpweIc7hJ3SvY3EM5xJp2MFZk4bOIRRbMaVOO9jAHogMCWzVNo
   Edx3sTvdR9Wwfh4UEXZ1Zvz5qTFVi5ORIj3e68GcDmlQA8dpI4OKs4Qkw
   Xv4xOz0opBRTGYzaK4U4ud5AnFXS3GjIlI7uWpQ5uB1RL93EXs8lM4hK8
   FpmDNKtJBUnhlctjZx0imqMu7Vk2JEc5E1atDFzPPYlOp9C8Yb/wWuf+u
   fbGJQiXs3w3otEDJ6E8tUUOgjE7IOQ7ubWWff3pQjdwKicH0p2wuqCkHT
   2hDjrJfqdTcCHMOmnvPYTEGDPKaKro1NiEDQw00K3g2Qw3rgAK09sYZk6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391774512"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391774512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796556495"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796556495"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:15 -0700
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
Subject: [PATCH V2 2/6] mmc: cqhci: Increase recovery halt timeout
Date:   Fri,  3 Nov 2023 10:47:16 +0200
Message-Id: <20231103084720.6886-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103084720.6886-1-adrian.hunter@intel.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
MIME-Version: 1.0
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

