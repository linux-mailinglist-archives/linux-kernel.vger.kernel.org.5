Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772167A3EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbjIQWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjIQWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE9130;
        Sun, 17 Sep 2023 15:40:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40413ccdd4cso22025245e9.0;
        Sun, 17 Sep 2023 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990434; x=1695595234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJPaLL3gJNqPRX6sTrQa6Jnq3juPdy0EeCdpo1oNzQw=;
        b=jeDqhSr6FI7PiMIYasG3rO2uXEgINeM15EI7HhFzBc5HHTAKN127bTEjvbYvy1P8Kd
         knX3QlSVpxGiQqgfTOn8CYA7FQimcw5AMZwgeYouYtcN7GRQlJMHhkCAtbBTw2HIFlFM
         XLRsYPsEOqN6ugvVYmW8cIOhvRMVZm0a9xJxSSV+uswCDof2Z1w3dT/sVNVbJViiT8Vl
         F6lARTx/LRWztFQfdC+KWdgnmVfHlOtpuSiVSYNHSPXTgi5qBnUo05YFgiCl/KhGFI3c
         9vM9Q5TWSETk0LvIjckAyryjGedplRRBY/NF9kgnIsi+T193nT7Hf7qzVpld6WGtgA/c
         U5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990434; x=1695595234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJPaLL3gJNqPRX6sTrQa6Jnq3juPdy0EeCdpo1oNzQw=;
        b=CStjJfPMMOf+LyBbcvVhhNbPFEeNYbbBZrFlWHIrBCMJJTsFz5FaXavEPHbVrHIEiM
         COI4NgKaZqJvCXFjuklDh3GN9VSVUGAVFTeD2nhLeLXhOiU2zHDWHlDbQDPgmnkidlqX
         +xA+y9OhgofBQbc9MmhUJg0+sqVSIScQ3McI15Y+1mnIYlVQhCr/id2OX1/AXmZli/2K
         xM5owkAU+IP37XT4aV7gKUlUfiLydHUSHB2r/w8G7Wgy9c0BsmlVDDuECfJ7NiwYmBuA
         avVZWZ3SagjXMhq/wnaobbcJHH6uiuRczR7bPTmkGahbyFGoBa5BC1ns0VPFjMz0pDYA
         dV+A==
X-Gm-Message-State: AOJu0Ywt4aX2+DXIs4PRf/rHjbYZ0ELMVYrS/gRwpKaFO6FiIdiGJCfj
        b8I0pZ5XtXJ4E06EBfjXXpk=
X-Google-Smtp-Source: AGHT+IHAtcxw7kNPCGsfPeyvRci6B2TGJjm5SaBwDRo/wssjZoEUG1YriSdAYHy4qrPTLAuYhmg79A==
X-Received: by 2002:a05:600c:1914:b0:401:bcec:be3e with SMTP id j20-20020a05600c191400b00401bcecbe3emr7808004wmq.17.1694990433512;
        Sun, 17 Sep 2023 15:40:33 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:33 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:39:59 +0200
Subject: [PATCH 03/13] clk: implement clk_hw_set_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-3-1d008b3237c0@skidata.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

This function can be used to set the rate of a clock hardware from a
driver, e.g. to adapt the rate to a clock change coming from the parent.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c            | 15 +++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..3e222802b712 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2462,6 +2462,21 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	return ret;
 }
 
+int clk_hw_set_rate(struct clk_hw *hw, unsigned long req_rate)
+{
+	/* A rate change is ongoing, so just target the required rate.
+	 * Note: this does not work if one clock along the line has
+	 * CLK_RECALC_NEW_RATES active, as this overwrites the new_rate again.
+	 */
+	if (hw->core->new_rate != hw->core->rate) {
+		hw->core->new_rate = req_rate;
+		return 0;
+	}
+
+	return clk_core_set_rate_nolock(hw->core, req_rate);
+}
+EXPORT_SYMBOL_GPL(clk_hw_set_rate);
+
 /**
  * clk_set_rate - specify a new rate for clk
  * @clk: the clk whose rate is being changed
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index ec32ec58c59f..3fb99ed5e8d9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1316,6 +1316,7 @@ int clk_hw_get_parent_index(struct clk_hw *hw);
 int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
+int clk_hw_set_rate(struct clk_hw *hw, unsigned long req_rate);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
 #define clk_hw_can_set_rate_parent(hw) \
 	(clk_hw_get_flags((hw)) & CLK_SET_RATE_PARENT)

-- 
2.34.1

