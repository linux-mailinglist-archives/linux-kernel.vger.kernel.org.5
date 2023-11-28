Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF67FC251
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbjK1Pfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346888AbjK1Pfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:35:44 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E5FD4F;
        Tue, 28 Nov 2023 07:35:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9EA4FF80D;
        Tue, 28 Nov 2023 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701185748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocmY2rTbsBcnpJcCLqop9OYoHfDfDmIGmzhdSEl8zaY=;
        b=PN9gFLyCfcdftiOVVVcveMQGH2DcAO1mDq2SuICwIszsZkmF/92H3KUx1YfWmvqCESl+cA
        QSnrmNhlMVaDdCoAlRS4g4alcL+SN3jxI9iOihI73+r/qVK3Mq3ZBarG5tzJPe02It6Wko
        6pipFyH1uU4VlSJpRwUP8EZWL6Ag883qsSyNVfG93UQyWKXWobuhoXZZjOUSUoAjOPWqmC
        u4qq5rqx6Vdtj3zfXhI14ET2rwmCTHxyr4gqOwO0hq1CJx7pdLCbywZwzLkUPWq0FQUfo6
        cz04O527KEihxGSxlzu5cHYETNB9Hv3F9pl8/7ct5RfKXGk3bSKVfRuSH+ghGQ==
From:   Thomas Richard <thomas.richard@bootlin.com>
Date:   Tue, 28 Nov 2023 16:35:00 +0100
Subject: [PATCH 2/3] pinctrl: pinctrl-single: add ti,j7200-padconf
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-j7200-pinctrl-s2r-v1-2-704e7dc24460@bootlin.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
        u-kumar1@ti.com, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On j7200, during suspend to ram pinctrl contexts are lost. To save and
restore contexts during suspend/resume, the flag PCS_CONTEXT_LOSS_OFF
shall be set.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pinctrl/pinctrl-single.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 8267be769635..19cc0db771a5 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1955,6 +1955,10 @@ static const struct pcs_soc_data pinctrl_single_am654 = {
 	.irq_status_mask = (1 << 30),   /* WKUP_EVT */
 };
 
+static const struct pcs_soc_data pinctrl_single_j7200 = {
+	.flags = PCS_CONTEXT_LOSS_OFF,
+};
+
 static const struct pcs_soc_data pinctrl_single = {
 };
 
@@ -1969,6 +1973,7 @@ static const struct of_device_id pcs_of_match[] = {
 	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
+	{ .compatible = "ti,j7200-padconf", .data = &pinctrl_single_j7200 },
 	{ .compatible = "pinctrl-single", .data = &pinctrl_single },
 	{ .compatible = "pinconf-single", .data = &pinconf_single },
 	{ },

-- 
2.39.2

