Return-Path: <linux-kernel+bounces-57017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4F84D2EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA901F26A71
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083411272BE;
	Wed,  7 Feb 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E1pS0UF2"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328E1272BC;
	Wed,  7 Feb 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337440; cv=none; b=pWlKmQT6Fe9F4VTT6zQz4wQvRsOtOXb5Dq9qp940nKuwyWGkkJeaRZ2LIQujccnlWs1aHyDaU3w9AzZMvO9z+hDxynTLyhbl3GCDWzc8K/qE//yvvJ5GwQaZUnNpZCbP2Jfh8chlUzMwFFJ1N65EqWqyU1OJnfeIGJUtH3eOU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337440; c=relaxed/simple;
	bh=aYqxL4BBe2rAkKvxSn/snRDQonR+FFPllbJPIAsOqLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbL0D2tRuFpnfFhaB9t1XU9mLdd+33JboczjJgDA9JKq7yurdfDg+7V+mnZII7dXnn6N3W+1z28wt97hIGnqcaeZF04mJ41H65wE3ubZtn5+UzeXHsRj/rcsagALt11uOpvTCVGY6e5P1b0/l3R+bUh3Ed/OyxETkzg7JUYlrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E1pS0UF2; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3010CC002E04;
	Wed,  7 Feb 2024 12:23:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3010CC002E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707337435;
	bh=aYqxL4BBe2rAkKvxSn/snRDQonR+FFPllbJPIAsOqLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1pS0UF2re5sLE5NhE8w83gdk+v0S2bGOfO/+ZKu2hGZMJg5ffuzCbhrx1VI81whO
	 fXjD7AbnocYRZCitxyssyYgkPaDl9jGra/XRKt61IUbX/+vLOvLE4Xs0Tn+vHhfdNr
	 Fws8s1be5lDzsbwBtM6KN/GZ8vf5sLTojvdvRgME=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id BF58118041CAC4;
	Wed,  7 Feb 2024 12:23:53 -0800 (PST)
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
Subject: [PATCH v5 06/12] arm64: dts: broadcom: bcmbca: Update router boards
Date: Wed,  7 Feb 2024 12:22:51 -0800
Message-Id: <20240207202257.271784-7-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240207202257.271784-1-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
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


