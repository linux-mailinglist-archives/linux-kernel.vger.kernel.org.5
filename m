Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D177B222
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjHNHLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjHNHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:11:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C59E7E;
        Mon, 14 Aug 2023 00:11:04 -0700 (PDT)
Received: from eugen-station.. (unknown [82.77.136.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A7CAE66071A3;
        Mon, 14 Aug 2023 08:11:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691997063;
        bh=KaHF1lu9ki5nM7dq9OdNk5QTWGSREzV+dbzYiF0kfQs=;
        h=From:To:Cc:Subject:Date:From;
        b=Lh/S4ftR+nP+CCpsb+ioiENM+dlFGA4xZOaCjxyACXSiqhZLm7SR5lvdxMlh5i1v1
         +Kp4mCia6yTn1WUwxDPzqbR5zhRSSZvJFa5ZgQhWvAYfUVv00BnVAo4eBzvrWZ0psB
         plQpCqi5TVe+rlVMjK8GfNiLfvULeZ3D3jVTba+OdwIa1pnYmjrkbfxuhkh/7NwT9p
         5R4NJcc89sO9BLIYEYpqrzxHx29ZNSL++U2sB/7b6ZK+KSwyPWC2Yx1O85S9wGHpe1
         4ceJwgPKveHAGxdxEZ25mVOZkGyAT+Yy/lNZu543VLRvwM+juL48l3FgbD1+4IXVe6
         aC49Q6tqDWB5g==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     linux-mediatek@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, kernel@collabora.com,
        hsinyi@chromium.org, Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties
Date:   Mon, 14 Aug 2023 10:10:53 +0300
Message-Id: <20230814071053.5459-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check throws a warning at the dsi node:
Warning (avoid_unnecessary_addr_size): /soc/dsi@14014000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Other DTS have a panel child node with a reg, so the parent dtsi
must have the address-cells and size-cells, however this specific DT
has the panel removed, but not the cells, hence the warning above.

If panel is deleted then the cells must also be deleted since they are
tied together, as the child node in this DT does not have a reg.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index bf97b60ae4d1..649477af2f41 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -91,6 +91,8 @@ cros_ec_pwm: pwm {
 
 &dsi0 {
 	status = "okay";
+	/delete-property/#size-cells;
+	/delete-property/#address-cells;
 	/delete-node/panel@0;
 	ports {
 		port {
-- 
2.34.1

