Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07EB7C02DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjJJRlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjJJRls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:41:48 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34F9E;
        Tue, 10 Oct 2023 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696959704; bh=UZbm7PGXwJJdTRYWTAu1jNKNALiw75akx1Jn15Evhis=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ufQ0ChRsMarY7Z3eUQzykI914DeZMzdpDAMzeZ2A9E7ouQjDsvHuNYbSoClyKk5Zf
         8rkAWeOnPTaBc/Yuhkpav4YthtOErsDiL4zywPiysggXWakOwADR8ssLLi/WD+xrAU
         IoTIfNZDqIk5qjT2T6yNBtYQ+ELKHCkrOUEAsS98=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mfd: rk8xx: Add support for standard system-power-controller property
Date:   Tue, 10 Oct 2023 19:41:18 +0200
Message-ID: <20231010174138.1888396-4-megi@xff.cz>
In-Reply-To: <20231010174138.1888396-1-megi@xff.cz>
References: <20231010174138.1888396-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

DT property rockchip,system-power-controller is now deprecated.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/mfd/rk8xx-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 11a831e92da8..a50a181b18e9 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -685,7 +685,8 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
 
-	if (device_property_read_bool(dev, "rockchip,system-power-controller")) {
+	if (device_property_read_bool(dev, "rockchip,system-power-controller") ||
+	    device_property_read_bool(dev, "system-power-controller")) {
 		ret = devm_register_sys_off_handler(dev,
 				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
 				    &rk808_power_off, rk808);
-- 
2.42.0

