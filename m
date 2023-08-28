Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB978A531
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjH1FZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjH1FYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E4129;
        Sun, 27 Aug 2023 22:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3033460AAF;
        Mon, 28 Aug 2023 05:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A537C433C7;
        Mon, 28 Aug 2023 05:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693200289;
        bh=0Xk4uK/2TRf9VsLF/92kL0q0rtsuDOsk2AN3vjKX7jA=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=abUTbwgSeH3Oe6ZIl78vZ9Knd56LOALemfma5QsXC9wDcEx0KVsmi7CkgQzh4rcIx
         qoXEKu03RIld5TNF1owSlkqIF+piz2cFMG4VxUIxf4E+ImZ0ngKOxr+0Lp9kpysyp5
         6izzAXCJ66p6vNJ1tsehheY5PaTQKeCTBGOg5RmalSZK80hZclPMIf+g70luNJJ0zN
         kLmZlSKQlafURgBNCW2MkTEN7YYOTXqnRBfmbH81VpguKJ03LP4+mDfNd0enhWVxkf
         wYXCWdzWY1WwTv5pmiasYTkI6Rr3MDQ9AMDxr9SDmHM7CoBc+MAaIGgt6+u8JCjsWb
         uxqvLWQMiT2KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC1BC83F13;
        Mon, 28 Aug 2023 05:24:49 +0000 (UTC)
From:   Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date:   Mon, 28 Aug 2023 13:16:30 +0800
Subject: [PATCH v3] usb: typec: qcom: check regulator enable status before
 disabling it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-qcom-tcpc-v3-1-e95b7afa34d9@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAK4t7GQC/1WMyw7CIBBFf6VhLQYGaFpX/odxQQZqZ2EfUImm4
 d+lTUzq8tzcc1YWfSAf2aVaWfCJIo1DAXWqGPZ2eHhOrjADAUo0AHzG8ckXnJA7LVujLdams6z
 8p+A7eu+t271wT3EZw2dPJ7mtv4o6VJLkkne2kVa0aIWpr/OLkAY8lwvbOgmOrj66UFzlXINKg
 za1/ndzzl/z4Xkg4AAAAA==
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        subbaram@quicinc.com, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693200287; l=2740;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=PhtbUNi497LxsIT+PR23WnfyXiZjybQwxlZzIfUUR5o=;
 b=bCWEQzBXl080+WyLCKcjD4QwE7Jc4U3EfZtl4SMmaP4uobY/tBzbcihL2B/CSc8GrXaGvCs7L
 oyP1VIASZIlCv9FXNhvkMmx5I99EYk1it1tDwbhIU6H6eFNX/h7KMBC
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received: by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Liu <quic_huliu@quicinc.com>

Check regulator enable status before disabling it to avoid
unbalanced regulator disable warnings.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
Changes in v3:
- Take Bryan's proposal to remove enable/disable operation in pdphy
enable and pdphy disable function, then enable regulator in pdphy start
function and disable it in pdphy stop function.
- Link to v2: https://lore.kernel.org/r/20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com

Changes in v2:
- Add Fixes tag
- Link to v1: https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index bb0b8479d80f..52c81378e36e 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -381,10 +381,6 @@ static int qcom_pmic_typec_pdphy_enable(struct pmic_typec_pdphy *pmic_typec_pdph
 	struct device *dev = pmic_typec_pdphy->dev;
 	int ret;
 
-	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
-	if (ret)
-		return ret;
-
 	/* PD 2.0, DR=TYPEC_DEVICE, PR=TYPEC_SINK */
 	ret = regmap_update_bits(pmic_typec_pdphy->regmap,
 				 pmic_typec_pdphy->base + USB_PDPHY_MSG_CONFIG_REG,
@@ -422,8 +418,6 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
 	ret = regmap_write(pmic_typec_pdphy->regmap,
 			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
 
-	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
-
 	return ret;
 }
 
@@ -447,6 +441,10 @@ int qcom_pmic_typec_pdphy_start(struct pmic_typec_pdphy *pmic_typec_pdphy,
 	int i;
 	int ret;
 
+	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
+	if (ret)
+		return ret;
+
 	pmic_typec_pdphy->tcpm_port = tcpm_port;
 
 	ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
@@ -467,6 +465,8 @@ void qcom_pmic_typec_pdphy_stop(struct pmic_typec_pdphy *pmic_typec_pdphy)
 		disable_irq(pmic_typec_pdphy->irq_data[i].irq);
 
 	qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
+
+	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
 }
 
 struct pmic_typec_pdphy *qcom_pmic_typec_pdphy_alloc(struct device *dev)

---
base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
change-id: 20230822-qcom-tcpc-d41954ac65fa

Best regards,
-- 
Hui Liu <quic_huliu@quicinc.com>

