Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3657ADC04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjIYPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjIYPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:46:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE12B6;
        Mon, 25 Sep 2023 08:46:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so57725925e9.3;
        Mon, 25 Sep 2023 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695656764; x=1696261564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/CuCsB7lG3PrLf1A3sCZl+ySqyxlyn/r1ko2GPt+iQ=;
        b=UQ3GGGZ8J4zyR2Tyntaqv/clPTx6NJQ7+nM/rJ0+1n2B4qv8f1uLzZyQzdPYcOH/Ro
         ykRlAn3kkYYqnGvISSYdJvn07/N0LNawnynVMUN/DB1aSpjVnwgQWpEZS4v8EuTRKpSv
         1emRT8edQkSkDXlWemNnm3jtdm53A4WEUM4oq4xoUv9y2WCBzjtEcbFvZYr9VTEKAasK
         ACGqVG0Hf0cRDUwpUbTk8K3y+SSadqOVKnUo1vq5BIA+TzAaqHuiAeV86PmLqLKoFN5D
         eodCcIRw5w4gXGDkaeCmpfCbjcVkJIsmbIaxa+BUaRRhoHDekFy2md4BMXr9oUgmsJqO
         pTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656764; x=1696261564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/CuCsB7lG3PrLf1A3sCZl+ySqyxlyn/r1ko2GPt+iQ=;
        b=e0ZTiP3oAaVfymM700uBWMR8gByVW3k2wqlINWuQF28uphUtA7E05ckHsXSg3mr5Jz
         Cz3GAjsjEZ3fNjCuf5V2PNAYDZBl+PW2leR7ajh8HAj35quWtHeinnsfS2xElQg6PS6d
         Wue4tzs0Eg/42az+MlH1B55KmcxA0ge4wrniFZs7I31SyQI1JNPFfBpWc80neTTvNeQL
         svc5ZxCYEVhVjRayTyP/SRzUI+3xfcRa+6GAFdSamfgYm6D2VO1qh+KMzoIxdG7kkz4j
         Onkrqxsko6bChXbdayEOL4N3/HWOaD9PMAF612in7CV86YIr4z1sP5/KhBTwscOk583V
         TzqA==
X-Gm-Message-State: AOJu0Yxlyeh9eC1ebm/sJomAS5smuLgL19pec3eHqVbjVpLMt8j9qk4I
        Q/dIXnXYVhYSHV61KneVdjE=
X-Google-Smtp-Source: AGHT+IEqH8vnp7oGDLXNvXEzzA8KHjMo2VSGDWnuhLGbauwCA13b7XYuMFX5nIb7A+/w6QlViZl4jQ==
X-Received: by 2002:a7b:ce92:0:b0:405:3f19:fc49 with SMTP id q18-20020a7bce92000000b004053f19fc49mr5972338wmj.34.1695656764282;
        Mon, 25 Sep 2023 08:46:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:47ed:1dba:e442:ccf2])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b003140f47224csm12097377wru.15.2023.09.25.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:46:03 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3] pinctrl: renesas: pinctrl-rzg2l: Add validation of GPIO pin in rzg2l_gpio_request()
Date:   Mon, 25 Sep 2023 16:45:48 +0100
Message-Id: <20230925154548.27048-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Validate the GPIO pin request in rzg2l_gpio_request() callback using
rzg2l_validate_gpio_pin() function. This stops any accidental usage
of GPIO pins which are not supported by the SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v2->v3
* Updated pin_data variable to be u32 instead of u64.

v1->v2
* Maintained reverse christmas tree order.
* Included RB/TB tags from Claudiu.
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 37cdfe4b04f9..94984966084d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -795,12 +795,18 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
 static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[offset];
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
+	u32 *pin_data = pin->drv_data;
 	unsigned long flags;
 	u8 reg8;
 	int ret;
 
+	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
+	if (ret)
+		return ret;
+
 	ret = pinctrl_gpio_request(chip->base + offset);
 	if (ret)
 		return ret;
-- 
2.34.1

