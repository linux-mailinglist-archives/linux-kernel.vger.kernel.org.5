Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA657C769B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442009AbjJLTWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLTV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:21:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57AB7;
        Thu, 12 Oct 2023 12:21:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF8BC433C8;
        Thu, 12 Oct 2023 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697138517;
        bh=wmAcJHNXIbXS2mL72Nqv5JNfiEX38pTlqswII+cQDeI=;
        h=From:To:Cc:Subject:Date:From;
        b=Iz6QB+RKMbsnELvBdNMZG0SFsuTbIWHMTTnVZDSIalACMaPtvi879bZbZwXYfeMGo
         /XTjW8VC/5kZW2VoeS6Q+G8OWZza5GZpYBy/YZyQhV+CnclGYbjPuVEqax02ZmbhCh
         jhXvfznEk8pPvBGPs8FlqueqYX5RCi/ULIAv9qBF0+PP0jFPIkyfCu71xRTB2kipv+
         8dJNKcOZOTUzlmMiR6S8QWaiXq+iEfv5c/LFFYvqmXUDFQdgH5p85wwu+Ctk4rHcxk
         GkWrLd749DW7MQrHoLGYJZHLefVMcwvJAhUPBSSEzQxA6onub4ZRqF6G5Vc3SsXPS9
         FRBGxkiIZuEgA==
Received: (nullmailer pid 1546513 invoked by uid 1000);
        Thu, 12 Oct 2023 19:21:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     kernel test robot <lkp@intel.com>, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: xilinx-pr-decoupler: Fix unused xlnx_pr_decoupler_of_match warning for !CONFIG_OF
Date:   Thu, 12 Oct 2023 14:21:48 -0500
Message-ID: <20231012192149.1546368-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c966aadcc02 ("fpga: Use device_get_match_data()") dropped the
unconditional use of xlnx_pr_decoupler_of_match resulting in this
warning:

drivers/fpga/xilinx-pr-decoupler.c:94:34: warning: unused variable 'xlnx_pr_decoupler_of_match' [-Wunused-const-variable]

The fix is to drop of_match_ptr() which is not necessary because DT is
always used for this driver.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310100247.Y7BFcalX-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 0c012d0f616d..68835896f180 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -167,7 +167,7 @@ static struct platform_driver xlnx_pr_decoupler_driver = {
 	.remove = xlnx_pr_decoupler_remove,
 	.driver = {
 		.name = "xlnx_pr_decoupler",
-		.of_match_table = of_match_ptr(xlnx_pr_decoupler_of_match),
+		.of_match_table = xlnx_pr_decoupler_of_match,
 	},
 };
 
-- 
2.42.0

