Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D627B6D23
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjJCP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJCP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:29:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103695;
        Tue,  3 Oct 2023 08:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D75C433C8;
        Tue,  3 Oct 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696346974;
        bh=tuSq7yhyHWSvaiKeFaqV7WZhQUAQixug8q4HdZYlAno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtpKhBPfJ74lU82drgA2oKf+YX3mFR/c11kgGMzndTWpPgOi2hEmENkWW/RUWIKv/
         oh5Dc+skDITF3WJQnuoVlHm6/mVWDpQkP0KirEUByb3CB8vIdg1p6Fi22woNdGNiN9
         co1KQ++cpjOaRrFfa9mbrrixxxpW1IO4bUCFUzx2a9zr1lZVVEK0+AqM/LzJjKKdqY
         94P4HEV9pQQq0kFDPiZjWyPVo8TUZHU/d/LN6AXLrgRclPZV2MdYQ8T6IbkQ/BvcYa
         2RHOoi0f+7TTAzD7U84ETiymULbdd37n79WUMPjOY/K/rh3LbCMLgDFuBxIZpVqfeS
         176Y8xHTs98QQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhLF-0003uL-2L;
        Tue, 03 Oct 2023 17:29:45 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 1/5] mfd: qcom-spmi-pmic: fix reference leaks in revid helper
Date:   Tue,  3 Oct 2023 17:29:23 +0200
Message-ID: <20231003152927.15000-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003152927.15000-1-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SPMI PMIC revid implementation is broken in multiple ways.

First, it totally ignores struct device_node reference counting and
leaks references to the parent bus node as well as each child it
iterates over using an open-coded for_each_child_of_node().

Second, it leaks references to each spmi device on the bus that it
iterates over by failing to drop the reference taken by the
spmi_device_from_of() helper.

Fix the struct device_node leaks by reimplementing the lookup using
for_each_child_of_node() and adding the missing reference count
decrements. Fix the sibling struct device leaks by dropping the
unnecessary lookups of devices with the wrong USID.

Note that this still leaves one struct device reference leak in case a
base device is found but it is not the parent of the device used for the
lookup. This will be addressed in a follow-on patch.

Fixes: e9c11c6e3a0e ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
Cc: stable@vger.kernel.org	# 6.0
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 7e2cd79d17eb..47738f7e492c 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -81,7 +81,7 @@ static struct spmi_device *qcom_pmic_get_base_usid(struct device *dev)
 	struct spmi_device *sdev;
 	struct qcom_spmi_dev *ctx;
 	struct device_node *spmi_bus;
-	struct device_node *other_usid = NULL;
+	struct device_node *child;
 	int function_parent_usid, ret;
 	u32 pmic_addr;
 
@@ -105,28 +105,34 @@ static struct spmi_device *qcom_pmic_get_base_usid(struct device *dev)
 	 * device for USID 2.
 	 */
 	spmi_bus = of_get_parent(sdev->dev.of_node);
-	do {
-		other_usid = of_get_next_child(spmi_bus, other_usid);
-
-		ret = of_property_read_u32_index(other_usid, "reg", 0, &pmic_addr);
-		if (ret)
-			return ERR_PTR(ret);
+	sdev = ERR_PTR(-ENODATA);
+	for_each_child_of_node(spmi_bus, child) {
+		ret = of_property_read_u32_index(child, "reg", 0, &pmic_addr);
+		if (ret) {
+			of_node_put(child);
+			sdev = ERR_PTR(ret);
+			break;
+		}
 
-		sdev = spmi_device_from_of(other_usid);
 		if (pmic_addr == function_parent_usid - (ctx->num_usids - 1)) {
-			if (!sdev)
+			sdev = spmi_device_from_of(child);
+			if (!sdev) {
 				/*
 				 * If the base USID for this PMIC hasn't probed yet
 				 * but the secondary USID has, then we need to defer
 				 * the function driver so that it will attempt to
 				 * probe again when the base USID is ready.
 				 */
-				return ERR_PTR(-EPROBE_DEFER);
-			return sdev;
+				sdev = ERR_PTR(-EPROBE_DEFER);
+			}
+			of_node_put(child);
+			break;
 		}
-	} while (other_usid->sibling);
+	}
+
+	of_node_put(spmi_bus);
 
-	return ERR_PTR(-ENODATA);
+	return sdev;
 }
 
 static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
-- 
2.41.0

