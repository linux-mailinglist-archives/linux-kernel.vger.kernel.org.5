Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98338792A17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjIEQds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354620AbjIEM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:56:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089CF1A8;
        Tue,  5 Sep 2023 05:56:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9338e4695so37616951fa.2;
        Tue, 05 Sep 2023 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693918606; x=1694523406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UhzA8XSGVCuKKYnfBOKwjgBkteIxN0UPAGvmE+dfX0=;
        b=mu90wKFv7POwPfWoN7x8dXtQXcEOZGh2Hnd3eBvhpMu9fuiXO59atiaSv2lxc1uEU/
         rvPjW1ATv7hcOIxa+lMSpZSL/SPi04yxICJ5dWdvOLBjlIKAyHiMJMSMzv4pLHjCKsNw
         CbnqJYAt2cVcChFnK8c3kNwEaMIz/Ni9uPNtYQmAaa/O+xna22HCMbeL+Lx5mm6J4sKn
         0o7q/lVmfBr5SHgA7M/x/izey3eQmgaDNJrg/ltzHh5otRS4SwQJwigwlfClLddUee9d
         W9e0W46w0x0R+X0XektDOMJ/CPJMbnjUJIcmuRva1a81O1ptEN53+e3o89jZAEe7lZFz
         sBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693918606; x=1694523406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UhzA8XSGVCuKKYnfBOKwjgBkteIxN0UPAGvmE+dfX0=;
        b=Y/o2QH7m++nKugmXcKL8zDkgYuhIVjKxDZKOeqZz7j9feSU4DTEfNbH3a7xKjKQqk5
         C2ZeZicTfMdKpJ5OyPqF02/HnBCnemgZmoLm4/K/g1ic62+qSij+mdmfAz5WKsX8bh5a
         z9WOpLlivcpve/lhN7it+CBsuy9LGgoioNI5PyFjaGEDgKFVEzalOz+vd99uujnr9qNv
         9IX2TfftUuh8JAjyJKMG9XbwFkWAAv10bg1FxzRB/U24QaHvA4LWHKHNln63aKzvkrAE
         AiAeD2RPQYrSA6HtN/yk9LaaAFv7mUsv3mIMbBZGRxRpdFp5tEg4/Qk0xSNZPw0gnrEs
         eIqg==
X-Gm-Message-State: AOJu0Yxxl9UuEROLLchdVbeukOQpzkXmjSCRapXnnS77sH+Hdn48PVFV
        4FUsjtVsgxoAXc0Zfbh6Kb8=
X-Google-Smtp-Source: AGHT+IFN6dIuEYAFAeh9yLMH0Umds7V4Gz6vEzYtzLwlFLejVtQwSpZmueW/N3HZo5D5Mix6iYn1dw==
X-Received: by 2002:a2e:8012:0:b0:2bd:1908:4432 with SMTP id j18-20020a2e8012000000b002bd19084432mr9333259ljg.3.1693918605899;
        Tue, 05 Sep 2023 05:56:45 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:2837:58dc:b622:9e39])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b003fe1c332810sm20085767wme.33.2023.09.05.05.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 05:56:45 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Add validation of GPIO pin in rzg2l_gpio_request()
Date:   Tue,  5 Sep 2023 13:56:03 +0100
Message-Id: <20230905125603.74528-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 37cdfe4b04f9..4ad08a4b786a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -795,12 +795,18 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
 static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[offset];
+	u64 *pin_data = pin->drv_data;
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
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

