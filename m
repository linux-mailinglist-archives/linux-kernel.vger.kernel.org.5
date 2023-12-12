Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82880EEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376574AbjLLOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376451AbjLLOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:25:31 -0500
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3A8F;
        Tue, 12 Dec 2023 06:25:32 -0800 (PST)
Received: from amadeus-Vostro-3710.lan (unknown [113.118.189.146])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 0AA0C800015;
        Tue, 12 Dec 2023 22:25:13 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] hwspinlock: qcom: fix tcsr data for ipq6018
Date:   Tue, 12 Dec 2023 22:25:09 +0800
Message-Id: <20231212142509.655094-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEtNVkwdSh8ZTEoZQxhNGFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVKSkNVSkNCVUpPTVlXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8c5e6ae656b03akuuu0aa0c800015
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6Agw5Cjw6Pz9PUR9JKRdK
        CS8aCR5VSlVKTEtJSEJKSkpIQ0tJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        SFVKSkNVSkNCVUpPTVlXWQgBWUFJQ0xINwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tcsr_mutex hwlock register of the ipq6018 SoC is 0x20000[1], which
should not use the max_register configuration of older SoCs. This will
cause smem to be unable to probe, further causing devices that use
smem-part to parse partitions to fail to boot.

[    2.118227] qcom-smem: probe of 4aa00000.memory failed with error -110
[   22.273120] platform 79b0000.nand-controller: deferred probe pending

Remove 'qcom,ipq6018-tcsr-mutex' setting from of_match to fix this.

[1] commit 72fc3d58b87b ("arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size")
Fixes: 5d4753f741d8 ("hwspinlock: qcom: add support for MMIO on older SoCs")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index a0fd67fd2934..814dfe8697bf 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -115,7 +115,6 @@ static const struct of_device_id qcom_hwspinlock_of_match[] = {
 	{ .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
 	{ .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
 	{ .compatible = "qcom,apq8084-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
-	{ .compatible = "qcom,ipq6018-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
 	{ .compatible = "qcom,msm8226-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
 	{ .compatible = "qcom,msm8974-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
 	{ .compatible = "qcom,msm8994-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
-- 
2.25.1

