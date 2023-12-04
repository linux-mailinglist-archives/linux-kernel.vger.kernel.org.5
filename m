Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A98035A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbjLDNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjLDNzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:55:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482990;
        Mon,  4 Dec 2023 05:55:42 -0800 (PST)
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 404936607090;
        Mon,  4 Dec 2023 13:55:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701698141;
        bh=rc5z0F8Kx/z+8iRI8N73XFwXfGPlHr+ZADWzQGOaWT4=;
        h=From:To:Cc:Subject:Date:From;
        b=TqzVjrnSas5WSvUk/WyXzci3l+kuks+ivbA8tf2ngWGM3LnZOW9E0g3MelxVFEvHG
         6DTBe67rrHQlL0/ux/IPu8+V2gTfW0ukIAxod1BI9BB9iKxYRjHADM+aJN33wSp8pu
         Qc2IKgX1oIS98mxVi+7joP9GKOOd6X6HrXAeDvnIVsG8jRzb6w6/QxT3KfOEOqwx7T
         0Kqa/QvUYnFYZTURWcT6VwsUGaa3yfm5IW60TXryko6XduEUhJjoXchY2N43iNKLxH
         ZSj5b1MSAMxP0creAgNmS2Kgqn6tpQY2sGD2YMFhFo686JhAu0q0WrEBw6W0T6JCr+
         46SjkloX+h4hw==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt8186: fix address warning for ADSP mailboxes
Date:   Mon,  4 Dec 2023 15:55:33 +0200
Message-Id: <20231204135533.21327-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings reported by dtbs_check :

arch/arm64/boot/dts/mediatek/mt8186.dtsi:1163.35-1168.5: Warning (simple_bus_reg):
 /soc/mailbox@10686000: simple-bus unit address format error, expected "10686100"
arch/arm64/boot/dts/mediatek/mt8186.dtsi:1170.35-1175.5: Warning (simple_bus_reg):
 /soc/mailbox@10687000: simple-bus unit address format error, expected "10687100"

by having the right bus address as node name.

Fixes: 379cf0e639ae ("arm64: dts: mediatek: mt8186: Add ADSP mailbox nodes")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index d57d8ed487b8..ae06f987ac3b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1160,14 +1160,14 @@ adsp: adsp@10680000 {
 			status = "disabled";
 		};
 
-		adsp_mailbox0: mailbox@10686000 {
+		adsp_mailbox0: mailbox@10686100 {
 			compatible = "mediatek,mt8186-adsp-mbox";
 			#mbox-cells = <0>;
 			reg = <0 0x10686100 0 0x1000>;
 			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
-		adsp_mailbox1: mailbox@10687000 {
+		adsp_mailbox1: mailbox@10687100 {
 			compatible = "mediatek,mt8186-adsp-mbox";
 			#mbox-cells = <0>;
 			reg = <0 0x10687100 0 0x1000>;
-- 
2.34.1

