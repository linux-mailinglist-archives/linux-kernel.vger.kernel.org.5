Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD5785448
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjHWJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjHWJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD5A4EC2;
        Wed, 23 Aug 2023 02:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC20861FCE;
        Wed, 23 Aug 2023 09:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB187C433C7;
        Wed, 23 Aug 2023 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692782158;
        bh=be/C8m+z+Od5rOnUlwnva1yDeuaE30t+Hcjy24kPcJk=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=NlPnwTz2fJqAG2DoYUFrG2gnnxjeqRhJsMevsyaoQQHDYnQRZoq36ibcFW34fWsUa
         W5H3U6OnZ4xmgpYl8MEJOfV+e0y90T2jUJdSJV75erSHrt5c82ECabaWXr/U+miwh+
         roqm1eUL29Kwm1XX+8EKeO3msL2Df2AsULwVcJkJxkN4IyFi05W6tbc8G+VBI1mKc/
         j/Z/y4k/n+Pn5qGM0hs5SJLkC0nYOWMlsu/jcHMXZIMcDTlwn5zbTgZpZ3AOgFHyy9
         80ZYDG080Fl8sLIaBGFfrjvkIYtTXe0gpws7BdMG4+EbrE2roX6yPoUZEWmBfEae6G
         zdcOuEmnkuLFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id CC171EE4993;
        Wed, 23 Aug 2023 09:15:57 +0000 (UTC)
From:   Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date:   Wed, 23 Aug 2023 17:15:53 +0800
Subject: [PATCH] usb: typec: qcom: check regulator enable status before
 disabling it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEnO5WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMj3cLk/FzdkuSCZN0UE0NLU5PEZDPTtEQloPqCotS0zAqwWdGxtbU
 AqbU6oVsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692782156; l=1109;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=Eq7q1VhxzBMiiLW046ihxgswENpgBh2pfv7VGXtEKDE=;
 b=7tSyma7eOKcwSWhtFR3YWbPboVUNtB1aFtgl+IJz8Z5x79QAvbVQgQRdLLt4yr2C5EQp28ApZ
 +uFnUcgg7SYADBTV3R07hBfaXnBJsVtbi3JZo7lHwWYqkzHNvz5R+5u
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

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
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

