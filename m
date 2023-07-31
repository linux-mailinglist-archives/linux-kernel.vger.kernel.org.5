Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C601876930A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGaKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGaKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:23:52 -0400
X-Greylist: delayed 1184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 03:23:42 PDT
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B317E78
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:23:42 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=6590db4e63=fe@dev.tdt.de>)
        id 1qQPkq-0074df-Bv
        for linux-kernel@vger.kernel.org; Mon, 31 Jul 2023 12:03:56 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qQPkp-0074ZW-VV
        for linux-kernel@vger.kernel.org; Mon, 31 Jul 2023 12:03:55 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id A812C240050
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:03:54 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 6B60524004B;
        Mon, 31 Jul 2023 12:03:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id E9C61312A1;
        Mon, 31 Jul 2023 12:03:53 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     mturquette@baylibre.com, sboyd@kernel.org, yzhu@maxlinear.com,
        rtanwar@maxlinear.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: [PATCH 1/2] clk: mxl: add mxl,control-gate dts property
Date:   Mon, 31 Jul 2023 12:03:48 +0200
Message-ID: <20230731100349.184553-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731100349.184553-1-fe@dev.tdt.de>
References: <20230731100349.184553-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1690797836-25E01C1B-4C3D6A58/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gate clocks can be controlled either from this cgu clk driver or directly
from power management driver/daemon. It is dependent on the power
policy/profile requirements of the end product. To take control of gate
clks from this driver.

Until now, the source code had to be changed for this purpose by adding
the flag 'GATE_CLK_HW' to the LGM_GATE macro in the source file
'drivers/clk/x86/clk-lgm.c'.

This can be better handled via the device tree, so that the source no
longer needs to be changed. For this purpose, a new option
'mxl,control-gate' is added, which specifies that the gate is controlled
by this driver.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/clk/x86/clk-cgu.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 89b53f280aee..cb4e92ea54bf 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -339,6 +339,8 @@ int lgm_clk_register_branches(struct lgm_clk_provider=
 *ctx,
 {
 	struct clk_hw *hw;
 	unsigned int idx;
+	const char *name;
+	unsigned int count, i;
=20
 	for (idx =3D 0; idx < nr_clk; idx++, list++) {
 		switch (list->type) {
@@ -355,19 +357,21 @@ int lgm_clk_register_branches(struct lgm_clk_provid=
er *ctx,
 			hw =3D lgm_clk_register_fixed_factor(ctx, list);
 			break;
 		case CLK_TYPE_GATE:
-			if (list->gate_flags & GATE_CLK_HW) {
-				hw =3D lgm_clk_register_gate(ctx, list);
-			} else {
-				/*
-				 * GATE_CLKs can be controlled either from
-				 * CGU clk driver i.e. this driver or directly
-				 * from power management driver/daemon. It is
-				 * dependent on the power policy/profile requirements
-				 * of the end product. To override control of gate
-				 * clks from this driver, provide NULL for this index
-				 * of gate clk provider.
-				 */
-				hw =3D NULL;
+			/* Check if cgu should control the gate clock */
+			hw =3D NULL;
+			count =3D of_property_count_strings(ctx->np,
+							  "mxl,control-gate");
+			if (count <=3D 0)
+				break;
+			for (i =3D 0; i < count; i++) {
+				of_property_read_string_index(ctx->np,
+							      "mxl,control-gate",
+							      i, &name);
+				if (!strncmp(list->name, name, strlen(list->name))) {
+					dev_err(ctx->dev, "enable gate control for %s\n",
+						list->name);
+					hw =3D lgm_clk_register_gate(ctx, list);
+				}
 			}
 			break;
=20
--=20
2.30.2

