Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1537578656D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbjHXCc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjHXCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D7170D;
        Wed, 23 Aug 2023 19:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8989D653E0;
        Thu, 24 Aug 2023 02:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E99A4C433C7;
        Thu, 24 Aug 2023 02:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692844342;
        bh=S2hy4pS5Z/UZBGkbRPkomY+VtflG1CjDdzyvk1uK9OQ=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=MxuXB9Xkrd7llmsNmc6JDHijITWpLThHWmqewtDZUx13WzXx0P96HGZhAEQ8iKKaL
         33TKpHDEMxN+2aiU7G/JQ6TfKB8tY8OnwXKa57aPxaz90wXMyB0x/MsQ2uuCN64x4J
         uyx93Qm8fWJwCeseBnz4LuP70PaJyKpHrpn3xEZmfL8Y7nmit40AIGOXiZ0PzKP0XG
         Xk5VwbeCDsJAS5GQhu0bgZq7t+yn4Z4mI1HeswaE0AX+FJzzzudy47Zh2AYxaVbdym
         /9T6Eq9xWqhmlee3BUaiT+HtHGZ64nipIZ8IEWYFEAWyV8Tg1Tr5D4uCwEtog1uSYb
         wTtDIFONhm5ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C8E5BC3DA6F;
        Thu, 24 Aug 2023 02:32:21 +0000 (UTC)
From:   Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date:   Thu, 24 Aug 2023 10:32:03 +0800
Subject: [PATCH v2] usb: typec: qcom: check regulator enable status before
 disabling it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACTB5mQC/03MQQ6CMBCF4auQWVvTFkrAlfcwLCZDK7OwQIuNh
 vTuVhITl//Ly7dDtIFthEu1Q7CJI8++hD5VQBP6uxU8lgYtdS07rcVK80NstJAYG9WbBqk1DqH
 8l2Advw7rNpSeOG5zeB90Ut/1p9R/SlJCCYedQtkTStNe1ycTezqXCww55w+PsU6OpAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692844340; l=1421;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=RCxBxOmCdTDGIzvmHMT7qgcrSyfaH/WPRHb6SCAOpuk=;
 b=rPA/Tw4FDHy3n9OoyyeOWS1qi2tjEcPxU8Gs5vUKx3yx7nHtxv4tqcjwQXGAKuLMQRLlMnE/u
 CTNkGOEVUYfCHdNp8w0JTsFJaTgEWMyw1+qt8KD362Y+Ch+JvN8n4rR
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received: by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
Changes in v2:
- Add Fixes tag
- Link to v1: https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index bb0b8479d80f..ca616b17b5b6 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -422,7 +422,8 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
 	ret = regmap_write(pmic_typec_pdphy->regmap,
 			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
 
-	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
+	if (regulator_is_enabled(pmic_typec_pdphy->vdd_pdphy))
+		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
 
 	return ret;
 }

---
base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
change-id: 20230822-qcom-tcpc-d41954ac65fa

Best regards,
-- 
Hui Liu <quic_huliu@quicinc.com>

