Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023798087A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379269AbjLGMYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjLGMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:24:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40AD7F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:24:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E23DC433C8;
        Thu,  7 Dec 2023 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701951889;
        bh=b3k0yhQCgpeSi1OnQRtgWWkuB5o+fZqueJOQrN6jfe8=;
        h=From:To:Cc:Subject:Date:From;
        b=mhrl3Zmr2Ew3ZZuhVVg12Z+dT/1mE7EANZGjTFyJh+xPhnzBEjegNLcld66ck5exh
         043MkAUSqVwETMpAq+Bw+6eHaFjfrcrLY0dlX002ETNxTMLMtTlNTSACVI/LRxtMM/
         Vn7QERquBX0p++zvfvpkmO7UQSYOGHij0ysPDLm1eQAYtmRf7ppnNODwXeUwch7ORN
         zH+bET+s9i8xX4bvZ2FGUgH2zxptfW02Lwar8e3xIg4jnLJmh29XE45GKNap/0vZEl
         XDtSc0UT/zzlxXahfNbSowiD3yz+edhtNjRILGWSl3U2K0apk6vuPnSiyzfO+Id3wA
         20iYAf0MkpCgw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Ariel Suller <asuller@habana.ai>
Subject: [PATCH 1/5] accel/habanalabs: report 3 instances of Infineon second stage
Date:   Thu,  7 Dec 2023 14:24:40 +0200
Message-Id: <20231207122444.50512-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ariel Suller <asuller@habana.ai>

Infineon controller second stage has 3 instances that their version
need to be reported by driver.

Signed-off-by: Ariel Suller <asuller@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/sysfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index 8d2164691d81..c940c5f1d109 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -8,6 +8,7 @@
 #include "habanalabs.h"
 
 #include <linux/pci.h>
+#include <linux/types.h>
 
 static ssize_t clk_max_freq_mhz_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -80,12 +81,27 @@ static ssize_t vrm_ver_show(struct device *dev, struct device_attribute *attr, c
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	struct cpucp_info *cpucp_info;
+	u32 infineon_second_stage_version;
+	u32 infineon_second_stage_first_instance;
+	u32 infineon_second_stage_second_instance;
+	u32 infineon_second_stage_third_instance;
+	u32 mask = 0xff;
 
 	cpucp_info = &hdev->asic_prop.cpucp_info;
 
+	infineon_second_stage_version = le32_to_cpu(cpucp_info->infineon_second_stage_version);
+	infineon_second_stage_first_instance = infineon_second_stage_version & mask;
+	infineon_second_stage_second_instance =
+					(infineon_second_stage_version >> 8) & mask;
+	infineon_second_stage_third_instance =
+					(infineon_second_stage_version >> 16) & mask;
+
 	if (cpucp_info->infineon_second_stage_version)
-		return sprintf(buf, "%#04x %#04x\n", le32_to_cpu(cpucp_info->infineon_version),
-				le32_to_cpu(cpucp_info->infineon_second_stage_version));
+		return sprintf(buf, "%#04x %#04x:%#04x:%#04x\n",
+				le32_to_cpu(cpucp_info->infineon_version),
+				infineon_second_stage_first_instance,
+				infineon_second_stage_second_instance,
+				infineon_second_stage_third_instance);
 	else
 		return sprintf(buf, "%#04x\n", le32_to_cpu(cpucp_info->infineon_version));
 }
-- 
2.34.1

