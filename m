Return-Path: <linux-kernel+bounces-77739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD3860998
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C651C248A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2C18028;
	Fri, 23 Feb 2024 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hJmsP4vc"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998116428;
	Fri, 23 Feb 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660117; cv=none; b=lKlN52AYWWS5OhSK+nqv08bbhXceCfTAjnl4AdaDeURgh1vSMGdSP7OkvBK/VKStlB6ghdBTTH5FzmO2LTvhniFnGEYaOFB+65Pstvp/tpbb643wN4jWUBRgo3fq5x9S7HHh+j4QvJUpGyfcpU9RX1Nc94dm7vFKUU4UxTPI5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660117; c=relaxed/simple;
	bh=w50MmwQoRzVkuX4F/IPvMazeJ04ok/bzThtfo0MpKFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RtwUiuguJ5MBh5xpqDEMPHsgh+i1TcXykN8oXCG3v2+MSuWh6cNcgEmqX38clNN1jfNdNbaaWMwJJkmswziI2w35iKWnHYtgt3w0tbYbLJAp7NVleF4AJzdih+EwnDwEcZz9jVTygTS2fuRyoR9LSFC5cND4EJAJPmn30McO2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hJmsP4vc; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8D4D9C001C10;
	Thu, 22 Feb 2024 19:48:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8D4D9C001C10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708660111;
	bh=w50MmwQoRzVkuX4F/IPvMazeJ04ok/bzThtfo0MpKFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJmsP4vczPk+TDrmhnZPh36fICCN+Ihc9+w88ZGBJPbR6Qlgex+0Km8gJYMWFUO5u
	 a6OhhkKUPeNwfDAgJ1r9wdSsEyMZm+B+yTiwzHk4ltif2mdmTfn6OOgscK3uOpoqtq
	 3uGNKnLQ69r1RGIyexqZZx5N5tl8KItkN3vv0gMw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 219FA18041CAC4;
	Thu, 22 Feb 2024 19:48:30 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v6 09/13] arm64: dts: broadcom: bcmbca: Update router boards
Date: Thu, 22 Feb 2024 19:47:54 -0800
Message-Id: <20240223034758.13753-10-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240223034758.13753-1-william.zhang@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the nand controller and add WP pin connection property in actual
board dts as they are board level properties now that they are disabled
and moved out from SoC dtsi.

Also remove the unnecessary brcm,nand-has-wp property from AC5300 board.
This property is only needed for some old controller that this board
does not apply.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts     | 5 +++++
 .../dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts  | 5 +++++
 .../boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts     | 6 +++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
index 78204d71ecd2..999d93730240 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
@@ -125,6 +125,11 @@ port@7 {
 	};
 };
 
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
 &nandcs {
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
index fcf092c81b59..19fc03ef47a0 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
@@ -155,6 +155,11 @@ port@7 {
 	};
 };
 
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
 &nandcs {
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
index d94a53d68320..52f928dbfa3c 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
@@ -166,11 +166,15 @@ led@19 {
 	};
 };
 
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
 &nandcs {
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
 	nand-on-flash-bbt;
-	brcm,nand-has-wp;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.37.3


