Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29617F1FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjKTVtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjKTVtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:49:20 -0500
X-Greylist: delayed 76 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 13:47:04 PST
Received: from mxe-2-51b.seznam.cz (mxe-2-51b.seznam.cz [IPv6:2a02:598:64:8a00::1000:51b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530F1BF0;
        Mon, 20 Nov 2023 13:47:04 -0800 (PST)
Received: from email.seznam.cz
        by smtpc-mxe-b7dc65f8c-qmjdq
        (smtpc-mxe-b7dc65f8c-qmjdq [2a02:598:64:8a00::1000:51b])
        id 32da761acc2ec4b03254f802;
        Mon, 20 Nov 2023 22:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
        s=szn20221014; t=1700516812;
        bh=KOJZarIYC0hLYr1MwPUV/ajt9MnhOl+KmxMTugbvoGU=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:References:
         In-Reply-To:Mime-Version:X-Mailer:Content-Type:
         Content-Transfer-Encoding;
        b=KJ/6pVNO1V+y0QqY9jKv6+XtzvHtQ+zC6vwIpPB2NsT1x45qIpKyEVoe5pYgi+Trt
         C9F4cZdgqcxr4n/Uu77DliKwtv/sAkUDR8x58a6evwEBoLF8ocVPyCkb6UKdMq1hTs
         KLM8/9okKP8E997qDKekMDF2HiJCi+bScRhd37Xv8mpFfm0DodVs4H4vXdwnx6zWwI
         8lCPOBXOuucauVcdVLna0FAyg7hapfs8qDl0jYUDd5g6Tfe3qYC0Rbnm3B4/9DhNhT
         ULEtboLukD3/2obT7fAqJU/lKikARYmIwH48WLt5o3EsgGzS3QDDxFAWHTcxmnoDds
         cVto6ht5VmSFQ==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
        by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
        Mon, 20 Nov 2023 22:45:20 +0100 (CET)
From:   "Tomas Paukrt" <tomaspaukrt@email.cz>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     <linux-serial@vger.kernel.org>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v3_1/2=5D_serial=3A_core=3A_Add_option_t?=
        =?utf-8?q?o_enable_RS485_mode_via_GPIO_?=
Date:   Mon, 20 Nov 2023 22:45:20 +0100 (CET)
Message-Id: <3Nj.ZZr}.5RaPRe7D8AB.1bMzDm@seznam.cz>
References: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
        <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
        <2cZ.ZZqF.1YADr1CLFoQ.1bMn3d@seznam.cz>
        <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
In-Reply-To: <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to enable the RS485 mode at boot time based on
the state of a GPIO pin (DIP switch or configuration jumper).
The GPIO is defined by the device tree property "rs485-mode-gpio".

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/tty/serial/serial_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_=
core.c
index f1348a5..f1bf0b9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3603,6 +3603,18 @@ int uart_get_rs485_mode(struct uart_port *port)
 	}
 
 	/*
+	 * Enable the RS485 mode based on the state of a GPIO pin.
+	 */
+	desc =3D devm_gpiod_get_optional(dev, "rs485-mode", GPIOD_IN);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-mode-gpio\n"=
);
+	if (desc) {
+		if (gpiod_get_value(desc))
+			rs485conf->flags |=3D SER_RS485_ENABLED;
+		devm_gpiod_put(dev, desc);
+	}
+
+	/*
 	 * Disabling termination by default is the safe choice:  Else if many
 	 * bus participants enable it, no communication is possible at all.
 	 * Works fine for short cables and users may enable for longer cables.=

-- 
2.7.4
 
