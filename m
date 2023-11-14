Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6666D7EADC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjKNKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjKNKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:15:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C103D75
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:14:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a98517f3so7162893e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699956892; x=1700561692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=989mY4zS1x08vGe3jaH2doZ857QaMFqojYApjOFNcNA=;
        b=K3mS3ipEhVwAsgD0DlqqnryuN0O8I1RpncEbq+iHIAPBSUBFNyimf3EtQL+GDnG7sx
         v+Rip3pQ/D7r8O3qEkcx62naII1M2lqCRl9S/c9ii6VEUH990MjEC3KezrJF1aNNuRFc
         vbBZkCTTuwwddA405g8QgWkEl9DlC5htH2jNRjZJSCh84xchSqxz3gFuHTPfkfqmaZcd
         O8I8w7IDcQ6wozRZ7d0zj+YPhD5e4T6ttQNT9necDPYhyrqD+fK6DVuRsmGF9vc0ElHm
         LjaREFVBPe6lOGtMjiUvRMEGkI/IuzI99Rafq7dcuI6LNN5JRtzPFc+G/mr0k8n1Acxx
         y19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699956892; x=1700561692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=989mY4zS1x08vGe3jaH2doZ857QaMFqojYApjOFNcNA=;
        b=QKcZYsQtS4JuLA8LpYCYW4Keydg1awxcOnmiELi1aErKek1aW5UrTE9h/L5XHwQIx2
         JdePTnkpkBf7ur4TY8GGuVNcHOFnPIRAF21K1JXiTKAx8hHMQJMxqik4uWGcQ/OY1gfW
         YX4jczRR7TvtylzXA6Pa7QOpyssfTZeiAvjTi4Mlt9Z0Ne2v/QF5FaJzHGzbYFL6ePsD
         IFkHL54iKnk7mbitHIRmvhuK5gKBPFL4vjAXJIw1KT84+IFYrE1fYNxpP1X8T6TrxXM8
         +d6XCkvepxGI2J7jF3ar32/0zkv0lmdRLwL61UKAoQygZpmnmNnqraFQnE9oP4nhs7Y8
         4XpQ==
X-Gm-Message-State: AOJu0YwpjpaU3Sj6v0azQoWunsP2uR/hC/BHBcYKjXwHEIJaXczp+Q+9
        I5OXtuW+Oqjze59WDF0Mb1+j/w==
X-Google-Smtp-Source: AGHT+IEFDSgibpjMV4Y7PnvYBSXrksO4SQXgiQw6EKC+4nF+gMP8A5o+yNQNi1S3cVJxowIPQccVKg==
X-Received: by 2002:a05:6512:20d3:b0:503:653:5711 with SMTP id u19-20020a05651220d300b0050306535711mr4965401lfr.9.1699956892200;
        Tue, 14 Nov 2023 02:14:52 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4202000000b0032d886039easm7335585wrq.14.2023.11.14.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:14:51 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 14 Nov 2023 11:14:45 +0100
Subject: [PATCH 3/3] clk: meson: g12a: add CSI & ISP gates clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-topic-amlogic-upstream-isp-clocks-v1-3-223958791501@linaro.org>
References: <20231114-topic-amlogic-upstream-isp-clocks-v1-0-223958791501@linaro.org>
In-Reply-To: <20231114-topic-amlogic-upstream-isp-clocks-v1-0-223958791501@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=G6Kb72oGcBrPLl5eFs681WZSIgqU+YTJL+dNbC8hxWs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlU0iXw3tWEkFljMjnl008PiXXewEGfT3AHYBO+Wi+
 sQAl3i+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVNIlwAKCRB33NvayMhJ0QufD/
 0ceRMlDLWS+bur9qzpxRCQm4JTKJ6Kx+cIpmoZWH64KiPe9srQxK38q/CKawXo+wQvZjc1gWV+ldur
 BgqhGY/VxsjAwt8p+FO7NT8BotOl5Xhh9U4gbEf2DJqMUYjcZx7gLBrpWFNMFLId9cEXCdrmAbo7G/
 UfeW+cHrY5rOCkSvtcAWFUE12xUANkKlU/8VB/51OUcvrS4iyymlxA2qV6EKltNwJRTdLtuMBMFzHT
 0HzZH7C8MObagKeOiWT3MH4g8tk/sJk98dB3NkL1BH3p7NxCRc9Nsswrtw20S+Nn05Usfvty8mLEeY
 ugjrfY0vyBqZMqmrMxhApo6gmLeex65PpEjR+z7LENPXc46UoAel7LI5fV/y5HOlT+erymy1vPVf+S
 JSOSn1rJ/ESZMYCgdECBtjFXqbAwMt/qDb/NvLD4elGmYYPnbx2z7pytzdidK5CBvvsMYxjbsn3DDU
 WUMUXuwwPY2QNnFpxLic0Obir+1TsIsu+IcS5fnHPf2+2VRRLS27gijuuYvWrJl9GWCDRDqnC+8gIR
 JDuC2awJSuWNOfb//BOiZmN4H+6CyG0ARxAEfvdU2AXfaBC/tXnthHtxvVhHZFJeWAi1iN80IWqaYJ
 tMAOb2UldwqlNqZ1XqH2gzxt2oofds639E4P1jOIzqN0dGsX6tCB85evzSlQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gates entires for the CSI ISP domain and CSI PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a8312f29d1cc..b0bd37ae1a81 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4274,9 +4274,12 @@ static MESON_GATE(g12a_htx_hdcp22,		HHI_GCLK_MPEG2,	3);
 static MESON_GATE(g12a_htx_pclk,		HHI_GCLK_MPEG2,	4);
 static MESON_GATE(g12a_bt656,			HHI_GCLK_MPEG2,	6);
 static MESON_GATE(g12a_usb1_to_ddr,		HHI_GCLK_MPEG2,	8);
+static MESON_GATE(g12b_mipi_isp_gate,		HHI_GCLK_MPEG2,	17);
 static MESON_GATE(g12a_mmc_pclk,		HHI_GCLK_MPEG2,	11);
 static MESON_GATE(g12a_uart2,			HHI_GCLK_MPEG2,	15);
 static MESON_GATE(g12a_vpu_intr,		HHI_GCLK_MPEG2,	25);
+static MESON_GATE(g12b_csi_phy1,		HHI_GCLK_MPEG2,	28);
+static MESON_GATE(g12b_csi_phy0,		HHI_GCLK_MPEG2,	29);
 static MESON_GATE(g12a_gic,			HHI_GCLK_MPEG2,	30);
 
 static MESON_GATE(g12a_vclk2_venci0,		HHI_GCLK_OTHER,	1);
@@ -4792,6 +4795,9 @@ static struct clk_hw *g12b_hw_clks[] = {
 	[CLKID_MIPI_ISP_SEL]		= &g12b_mipi_isp_sel.hw,
 	[CLKID_MIPI_ISP_DIV]		= &g12b_mipi_isp_div.hw,
 	[CLKID_MIPI_ISP]		= &g12b_mipi_isp.hw,
+	[CLKID_MIPI_ISP_GATE]		= &g12b_mipi_isp_gate.hw,
+	[CLKID_MIPI_ISP_CSI_PHY0]	= &g12b_csi_phy0.hw,
+	[CLKID_MIPI_ISP_CSI_PHY1]	= &g12b_csi_phy1.hw,
 };
 
 static struct clk_hw *sm1_hw_clks[] = {
@@ -5287,6 +5293,9 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12b_mipi_isp_sel,
 	&g12b_mipi_isp_div,
 	&g12b_mipi_isp,
+	&g12b_mipi_isp_gate,
+	&g12b_csi_phy1,
+	&g12b_csi_phy0,
 };
 
 static const struct reg_sequence g12a_init_regs[] = {

-- 
2.34.1

