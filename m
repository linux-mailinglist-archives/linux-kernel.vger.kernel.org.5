Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A57E3E11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjKGMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjKGMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:32:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97B32B6D;
        Tue,  7 Nov 2023 04:21:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299BCC433CB;
        Tue,  7 Nov 2023 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359676;
        bh=3dYMFclV7U3X0PDEb492CafxGf4JqQpklY/xi0vWZWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWF9uDSGhbBFfeEssCB/JHOkxRygfA8oDoxA+wXu0jxwlmMmdjKpw8oijm1aJJ25x
         eSTnJ2lU1b3GYfFpZlewwf60HipQycRg5KQG5KX8G9ZrgPivUNnKwG7b895TsNCzkF
         YuljHWeEt/ER2unyRZqIxNnO55Qjm+J3mJhWaW6MQ/ph1kIXcxflwws1NW4ejfDMra
         /w8bR05TJH0xZPh9XWRpUwK17Uf3rmZL2pkPb1Z8iIuQQEWav9DyzoIwf/QsYTwlCP
         0wspi4xI46NrGpGgzt8sAf1yTgXMKf1FmdQcUPgezuRrnA7shKhfMH1KftuTqiufdb
         aFmoccTh+27HQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 35/40] soc: qcom: pmic: Fix resource leaks in a device_for_each_child_node() loop
Date:   Tue,  7 Nov 2023 07:16:37 -0500
Message-ID: <20231107121837.3759358-35-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit 5692aeea5bcb9331e956628c3bc8fc9afcc9765d ]

The device_for_each_child_node loop should call fwnode_handle_put()
before return in the error cases, to avoid resource leaks.

Let's fix this bug in pmic_glink_altmode_probe().

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Link: https://lore.kernel.org/r/20230612133452.47315-1-luhongfei@vivo.com
[bjorn: Rebased patch, moved fw_handle_put() from jump target into the loop]
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 30 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index d05e0d6edf493..9569d999391d1 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -444,6 +444,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		ret = fwnode_property_read_u32(fwnode, "reg", &port);
 		if (ret < 0) {
 			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
+			fwnode_handle_put(fwnode);
 			return ret;
 		}
 
@@ -454,6 +455,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 
 		if (altmode->ports[port].altmode) {
 			dev_err(dev, "multiple connector definition for port %u\n", port);
+			fwnode_handle_put(fwnode);
 			return -EINVAL;
 		}
 
@@ -468,45 +470,59 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
 
 		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(fwnode);
 			return ret;
+		}
 
 		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
 		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
 		alt_port->dp_alt.active = 1;
 
 		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
-		if (IS_ERR(alt_port->typec_mux))
+		if (IS_ERR(alt_port->typec_mux)) {
+			fwnode_handle_put(fwnode);
 			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
 					     "failed to acquire mode-switch for port: %d\n",
 					     port);
+		}
 
 		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
 					       alt_port->typec_mux);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(fwnode);
 			return ret;
+		}
 
 		alt_port->typec_retimer = fwnode_typec_retimer_get(fwnode);
-		if (IS_ERR(alt_port->typec_retimer))
+		if (IS_ERR(alt_port->typec_retimer)) {
+			fwnode_handle_put(fwnode);
 			return dev_err_probe(dev, PTR_ERR(alt_port->typec_retimer),
 					     "failed to acquire retimer-switch for port: %d\n",
 					     port);
+		}
 
 		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_retimer,
 					       alt_port->typec_retimer);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(fwnode);
 			return ret;
+		}
 
 		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
-		if (IS_ERR(alt_port->typec_switch))
+		if (IS_ERR(alt_port->typec_switch)) {
+			fwnode_handle_put(fwnode);
 			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
 					     "failed to acquire orientation-switch for port: %d\n",
 					     port);
+		}
 
 		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
 					       alt_port->typec_switch);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(fwnode);
 			return ret;
+		}
 	}
 
 	altmode->client = devm_pmic_glink_register_client(dev,
-- 
2.42.0

