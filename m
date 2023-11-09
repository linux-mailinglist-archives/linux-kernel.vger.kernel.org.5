Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE577E66D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjKIJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjKIJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:31:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D092D44;
        Thu,  9 Nov 2023 01:30:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDABC433C8;
        Thu,  9 Nov 2023 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699522257;
        bh=PZQMPnYlGnEWT673t/5m3TU6f1iHCeG8oTv/I5ehW6E=;
        h=From:To:Cc:Subject:Date:From;
        b=GisZhfwZ84diDIDf2mIw/gX/FvfZ8/audX+9nlBrRhzVfNzmDtcOqvnUBTEuRM+j1
         WOREsxZdXozH9LmIYVGU9PekDEJgyKuD+e1HgAA+HiOxxBcbRC0k1OleQeBVe+Q4Bw
         7nqzTA1P6Lw17xkWMGbgPG8HIBq2vsdGBDIKjPv6KGrZ8cFRfvHdKFmrVyAgXOG6Pc
         skpnCj4ersGD6W7EDfezauoeHQeK4v24oUKayIjJMLOTbpJ4dcJLELRNiVJY0P3nE+
         jbM0tjOJ+e4zEoIUrg9pLqhjiZnWnCJ3hjiq8D3h4TU3Ngj9pDV/7sgmC9QT1Vnvx8
         34v1C4stiuB5Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r11OB-0005CW-1Q;
        Thu, 09 Nov 2023 10:31:51 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] soc: qcom: pmic_glink_altmode: fix port sanity check
Date:   Thu,  9 Nov 2023 10:31:00 +0100
Message-ID: <20231109093100.19971-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC GLINK altmode driver currently supports at most two ports.

Fix the incomplete port sanity check on notifications to avoid
accessing and corrupting memory beyond the port array if we ever get a
notification for an unsupported port.

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Cc: stable@vger.kernel.org	# 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 974c14d1e0bf..561d6ba005f4 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -285,7 +285,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
 
 	svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
 
-	if (!altmode->ports[port].altmode) {
+	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
 		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
 		return;
 	}
@@ -328,7 +328,7 @@ static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmod
 	hpd_state = FIELD_GET(SC8280XP_HPD_STATE_MASK, notify->payload[8]);
 	hpd_irq = FIELD_GET(SC8280XP_HPD_IRQ_MASK, notify->payload[8]);
 
-	if (!altmode->ports[port].altmode) {
+	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
 		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
 		return;
 	}
-- 
2.41.0

