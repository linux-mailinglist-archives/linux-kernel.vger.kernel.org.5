Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C997B2FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjI2KR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjI2KRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:17:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30ECCFB;
        Fri, 29 Sep 2023 03:17:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0C1C433C7;
        Fri, 29 Sep 2023 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695982660;
        bh=Fi+IDHGlBgmNRYu1rK859S59T3doLUrBZChLlDSK6B4=;
        h=From:To:Cc:Subject:Date:From;
        b=HTpXzlSV1r3+kMFhGBJEbYO0Kx/5XXFGf7QJcGdXmb8luEww4sON51bn8Bv8kSDiP
         3pRXSVPdnopll4AxB9MLiD2lVogHCm0JoezvpTGiy0A645WHLH6o2O9TsYKfF4WmTj
         VfAsI01gYSB/yYy6TFtVvfN6+AW0If6RoZhBgZkxnateA5hrGPpB0i99ukvmJq1Kks
         CXSHfjmO1q1Z3errqrDbYxnaYuFon14ZCICGYX+dzbQABtdnYf9iPLJq6VrtfeuEuT
         v8yFYvBzri+yMDc9i8+dW9cwL+R/Nn0rODKVdLuCGjnZdvUIin0DKaVeeq4pJLJwBO
         4k5zhc1vd2qYg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qmAZ1-0005GE-1y;
        Fri, 29 Sep 2023 12:17:39 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] power: supply: qcom_battmgr: fix enable request endianness
Date:   Fri, 29 Sep 2023 12:16:49 +0200
Message-ID: <20230929101649.20206-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
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

Add the missing endianness conversion when sending the enable request so
that the driver will work also on a hypothetical big-endian machine.

This issue was reported by sparse.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org      # 6.3
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index de77df97b3a4..6ec71276bb70 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1282,9 +1282,9 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 {
 	struct qcom_battmgr *battmgr = container_of(work, struct qcom_battmgr, enable_work);
 	struct qcom_battmgr_enable_request req = {
-		.hdr.owner = PMIC_GLINK_OWNER_BATTMGR,
-		.hdr.type = PMIC_GLINK_NOTIFY,
-		.hdr.opcode = BATTMGR_REQUEST_NOTIFICATION,
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_NOTIFY),
+		.hdr.opcode = cpu_to_le32(BATTMGR_REQUEST_NOTIFICATION),
 	};
 	int ret;
 
-- 
2.41.0

