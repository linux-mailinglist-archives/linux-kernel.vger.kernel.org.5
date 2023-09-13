Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8279F307
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjIMUiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjIMUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:38:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C50E1BCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:38:48 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-410af8f75d9so1221471cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694637527; x=1695242327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFV0nPzxlwpYvcTCAFxySpk2VpqZA+lU9+zcwgGraWU=;
        b=I5blnutOkYUm/HPlTlc5XcxvZOSqFsAe7qmpD2yR2v0j4/C65Crp1TYq8nAia9xXLe
         G85Lus0oERiObc0C+BQl1lLugowU00OdZ9gzipruAF5w+AvG/A18ie+8SuEu/2ffxwyO
         1pbvaF1mqtEedkne5j+m3nb+zu6cbGK8dL8VoBAwUO226FdikNSMlABI+Ph+eTUav3D/
         2loIs/XOrQF2iECikk3z7ZC782UIsQ7bXKiHyl/ME38UXNBX6ykKDGpcOP0GvWegmPFM
         lZyvyrxunFQRXj5BfGlKycKpZXH21thuZD3xH+kGaKPczGiavceeYbTaCF3oq8mkILNe
         ivAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694637527; x=1695242327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFV0nPzxlwpYvcTCAFxySpk2VpqZA+lU9+zcwgGraWU=;
        b=cvj8zmr65ABO6IulJQwGwfswr6Rw6HGf1ZRBk4DmP+U6iblgTzqghOQS8IoUClYlNH
         O1lj1qF6QK3YIrfCEP4rNToaA5EqtFdHQko+2IXfxeS15AJVU316xG5H6dBxEQ4qyK/u
         YNRMd+Mxc0Watj0c0VpBavIyKHBX+ZcYvN8TK++6t22SP8tuCffjdmXCTYrrI2RO7bRD
         GzNFbqGKaUQn2wBGOuSIEJ4DeLHynO7PAXcN7R/f9fsb+PgxZUsvHZslD1Ouoc7TdmXc
         f60R5VFDE/v+8zUPFvrrjQrMQFFmSAwf+ZqBK+X6gkERt3qpHuT0W5oa3HtzcauIw6Im
         IUBg==
X-Gm-Message-State: AOJu0YwcqyqjF7LQWCVrVtyI6tlAcJKy786XEqlwi5poaDuV62F/ESxo
        rkHA5TiJoaPmRxatsOX0GguJUA==
X-Google-Smtp-Source: AGHT+IE9VK0xKqVBMpvrsWkJ292bfmYqakJjqbQth6bwXD8cSXlj6WVNB8Ey9VObNpAbknkocU/Owg==
X-Received: by 2002:ac8:5708:0:b0:412:2f5e:2779 with SMTP id 8-20020ac85708000000b004122f5e2779mr3959703qtw.24.1694637527734;
        Wed, 13 Sep 2023 13:38:47 -0700 (PDT)
Received: from maple.home ([174.94.49.189])
        by smtp.gmail.com with ESMTPSA id j6-20020ac85506000000b0040f200feb4fsm24203qtq.80.2023.09.13.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 13:38:47 -0700 (PDT)
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v2 2/2] clk: renesas: r9a06g032: name anonymous structs
Date:   Wed, 13 Sep 2023 16:38:05 -0400
Message-Id: <20230913203805.465780-2-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913203805.465780-1-ralph.siemsen@linaro.org>
References: <20230913203805.465780-1-ralph.siemsen@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the content of the r9a06g032_clkdesc structure by naming the
remaining anonymous structures defined inside. Renaming each field and
updating the doc then becomes necessary in order to avoid name
duplications and kdoc warnings.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
--
Changes in v2:
- split this out as a separate commit
---
 drivers/clk/renesas/r9a06g032-clocks.c | 63 ++++++++++++++------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index aa00543fe865..61296c81f9b5 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -102,20 +102,22 @@ enum gate_type {
  * @source:    the ID+1 of the parent clock element.
  *             Root clock uses ID of ~0 (PARENT_ID);
  * @gate:      clock enable/disable
- * @div_min:   smallest permitted clock divider
- * @div_max:   largest permitted clock divider
- * @reg:       clock divider register offset, in 32-bit words
- * @div_table: optional list of fixed clock divider values;
+ * @div:       substructure for clock divider
+ * @div.min:   smallest permitted clock divider
+ * @div.max:   largest permitted clock divider
+ * @div.reg:   clock divider register offset, in 32-bit words
+ * @div.table: optional list of fixed clock divider values;
  *             must be in ascending order, zero for unused
- * @div:       divisor for fixed-factor clock
- * @mul:       multiplier for fixed-factor clock
+ * @ffc:       substructure for fixed-factor clocks
+ * @ffc.div:   divisor for fixed-factor clock
+ * @ffc.mul:   multiplier for fixed-factor clock
  * @dual:      substructure for dual clock gates
- * @group:     UART group, 0=UART0/1/2, 1=UART3/4/5/6/7
- * @sel:       select either g1/r1 or g2/r2 as clock source
- * @g1:        1st source gate (clock enable/disable)
- * @r1:        1st source reset (module reset)
- * @g2:        2nd source gate (clock enable/disable)
- * @r2:        2nd source reset (module reset)
+ * @dual.group: UART group, 0=UART0/1/2, 1=UART3/4/5/6/7
+ * @dual.sel:  select either g1/r1 or g2/r2 as clock source
+ * @dual.g1:   1st source gate (clock enable/disable)
+ * @dual.r1:   1st source reset (module reset)
+ * @dual.g2:   2nd source gate (clock enable/disable)
+ * @dual.r2:   2nd source reset (module reset)
  *
  * Describes a single element in the clock tree hierarchy.
  * As there are quite a large number of clock elements, this
@@ -132,13 +134,13 @@ struct r9a06g032_clkdesc {
 		struct r9a06g032_gate gate;
 		/* type = K_DIV  */
 		struct {
-			unsigned int div_min:10, div_max:10, reg:10;
-			u16 div_table[4];
-		};
+			unsigned int min:10, max:10, reg:10;
+			u16 table[4];
+		} div;
 		/* type = K_FFC */
 		struct {
 			u16 div, mul;
-		};
+		} ffc;
 		/* type = K_DUALGATE */
 		struct {
 			uint16_t group:1;
@@ -179,26 +181,26 @@ struct r9a06g032_clkdesc {
 	.type = K_FFC, \
 	.index = R9A06G032_##_idx, \
 	.name = _n, \
-	.div = _div, \
-	.mul = _mul \
+	.ffc.div = _div, \
+	.ffc.mul = _mul \
 }
 #define D_FFC(_idx, _n, _src, _div) { \
 	.type = K_FFC, \
 	.index = R9A06G032_##_idx, \
 	.source = 1 + R9A06G032_##_src, \
 	.name = _n, \
-	.div = _div, \
-	.mul = 1 \
+	.ffc.div = _div, \
+	.ffc.mul = 1 \
 }
 #define D_DIV(_idx, _n, _src, _reg, _min, _max, ...) { \
 	.type = K_DIV, \
 	.index = R9A06G032_##_idx, \
 	.source = 1 + R9A06G032_##_src, \
 	.name = _n, \
-	.reg = _reg, \
-	.div_min = _min, \
-	.div_max = _max, \
-	.div_table = { __VA_ARGS__ } \
+	.div.reg = _reg, \
+	.div.min = _min, \
+	.div.max = _max, \
+	.div.table = { __VA_ARGS__ } \
 }
 #define D_UGATE(_idx, _n, _src, _g, _g1, _r1, _g2, _r2) { \
 	.type = K_DUALGATE, \
@@ -1064,14 +1066,14 @@ r9a06g032_register_div(struct r9a06g032_priv *clocks,
 
 	div->clocks = clocks;
 	div->index = desc->index;
-	div->reg = desc->reg;
+	div->reg = desc->div.reg;
 	div->hw.init = &init;
-	div->min = desc->div_min;
-	div->max = desc->div_max;
+	div->min = desc->div.min;
+	div->max = desc->div.max;
 	/* populate (optional) divider table fixed values */
 	for (i = 0; i < ARRAY_SIZE(div->table) &&
-	     i < ARRAY_SIZE(desc->div_table) && desc->div_table[i]; i++) {
-		div->table[div->table_size++] = desc->div_table[i];
+	     i < ARRAY_SIZE(desc->div.table) && desc->div.table[i]; i++) {
+		div->table[div->table_size++] = desc->div.table[i];
 	}
 
 	clk = clk_register(NULL, &div->hw);
@@ -1334,7 +1336,8 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 		case K_FFC:
 			clk = clk_register_fixed_factor(NULL, d->name,
 							parent_name, 0,
-							d->mul, d->div);
+							d->ffc.mul,
+							d->ffc.div);
 			break;
 		case K_GATE:
 			clk = r9a06g032_register_gate(clocks, parent_name, d);
-- 
2.25.1

