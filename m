Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5C78EA15
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbjHaKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbjHaKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:19:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D9CF3;
        Thu, 31 Aug 2023 03:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE55DB82171;
        Thu, 31 Aug 2023 10:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C177C433C7;
        Thu, 31 Aug 2023 10:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693477189;
        bh=YkOxDXBCUDLl6Cguo4+rc9hRV8tH3QYa5BZ+A8uztWA=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=bRBzAiUkzGOjkp1o+lGoEBBKUuDzEpGZJWeKDbbWfrMueA9BPcSG8omcTONDiizi0
         r/EBGGaC2EMxnjAgVWbCkD9XPJIiS87jqXmxVbr1u8t95YU1XapGAvPolyIp2rFy+P
         OWGkQ330jnV5IbaVwuvvIpaMTo3OguF3BTy49JqeuIwtRj+JRxV8Lqy5t1xJt5ggqx
         irRZCz/Lh80ZGLLSmXPZmLREdjYp23Cm47nm6uXApGZJZ13AnDoHwKbGjZ5Jp6/Va+
         IB72gXhVKGQngK2vsJvNPBVbT7ovUMTm67Ax14nrfGc4ASHkhKvDu9uq2hBpCAeJ0W
         hBg8P4HlEQsOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE31C83F12;
        Thu, 31 Aug 2023 10:19:49 +0000 (UTC)
From:   Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date:   Thu, 31 Aug 2023 18:19:45 +0800
Subject: [PATCH v5] usb: typec: qcom: Update the logic of regulator enable
 and disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230831-qcom-tcpc-v5-1-5e2661dc6c1d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEJp8GQC/2XMyw6CMBCF4VchXVvTyxRaV76HcVGmRbqQu0RDe
 HcLiUkNyzOZ71/I6IfgR3LJFjL4OYyhbeJQp4xgbZuHp8HFTQQTkmkhaI/tk07YIXXAjQKLuao
 sif/d4Kvw3lu3e9x1GKd2+OzpmW/XX0UmlZlTTiuruWUGLVP5tX8FDA2e4wvZOrNILaRWRCud0
 yhBgMrhaGVqdWpltN6osrCVleDM0UJiJUstRIvclMxo0IUp/+26rl978+U1WAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693477188; l=3206;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=2oArl3p3f4nGra9OaL8wrTdlGSIGZy5nArkkLq2X1WQ=;
 b=wOFTaj5NpC1jhXmeOUvbOaohgy/Xu/GtXVUzhJKflZyqduIAuYv5G39xqA53jvCNzGTHHKqpR
 Bfc2iH5VL1UAyHiaeHQ/Ns4YOJLUt+SFai/7v3Un2em5H1yxHpyAkSq
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received: by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Liu <quic_huliu@quicinc.com>

Removed the call logic of disable and enable regulator
in reset function. Enable the regulator in qcom_pmic_typec_start
function and disable it in qcom_pmic_typec_stop function to
avoid unbalanced regulator disable warnings.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # rb5
Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
Changes in v5:
- Removed Reviewed-by: Guenter Roeck <linux@roeck-us.net>
- Updated V4 history
- Link to v4: https://lore.kernel.org/r/20230830-qcom-tcpc-v4-1-c19b0984879b@quicinc.com

Changes in v4:
- Rephrased commit text
- Link to v3: https://lore.kernel.org/r/20230828-qcom-tcpc-v3-1-e95b7afa34d9@quicinc.com

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

