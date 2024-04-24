Return-Path: <linux-kernel+bounces-157334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5EC8B0FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9751C22768
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AD116D9D8;
	Wed, 24 Apr 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="bfZsS8xB"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8416C848;
	Wed, 24 Apr 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976466; cv=none; b=Ew5WSy3PJ83gUiwPMHzOUsKX51Pd/aIqnIp6xmgszYO2O6EugjHKaXBvxRziWPq5/LXHCpoJNyNrKo/Qct+YKwsENcigxrm9WGWVkNX5kDn1s1kbUhCHsIzyJ6qXqO+PeVia31Xo2RbSTzHomdkTVT6v6p/HJ1LROB9gs9KRBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976466; c=relaxed/simple;
	bh=T/HcisR2UIcbgArGuXsZIfK+Cy4lJBfreWW6I7UuzJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKTVd2fWkufEo+HTWvorANdlrIgKZW9NGROKMMmrFd6dpAd6WpgT8ibZSeBOk8TdUj2iRJkkxA3tuoq5hxzUNG2W+cM3VA5nx5++CYeHWDWlsDnqlJM76axEjDQ3PeVZ3Sz927Uu4Phy+BSHNzoN41J18md5V6ddifCCvzW3VYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=bfZsS8xB; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975864; bh=T/HcisR2UIcbgArGuXsZIfK+Cy4lJBfreWW6I7UuzJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bfZsS8xBUZ8n09cljicZ9F7WgkbE0KzMTFLKT1IADiSWVn7Ey3vqoWw33+BpjGIDA
	 5u7oB2EEGnFzZF1HIOxh72+OEVb8SMU/Gdsku7XuXrPksr9LZlkabKyccFr3s1P7Ll
	 uZC5/MCQxrqMHJtVLjWhGaI8Ozp0aIPn9somfq+Q=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 18:23:55 +0200
Subject: [PATCH 2/7] ARM: dts: qcom: msm8974: Use mboxes properties for
 APCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-apcs-mboxes-v1-2-6556c47cb501@z3ntu.xyz>
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
In-Reply-To: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=T/HcisR2UIcbgArGuXsZIfK+Cy4lJBfreWW6I7UuzJg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTIx82l/iOWVQcYwyxo2ipCDEb1hZTih+NxHs
 gP1/0HBDnGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyMQAKCRBy2EO4nU3X
 VgJFEADG3tSW6vL6ozetJ/js5B1C2Du/4KIimBN3lOMvC2aY0e4bXCFi2CKweDtIBJTHa0G5MVg
 Dpbm7ipWytLVEiQrkxQWUXE+CT2GuOoEXIR1jI17uDPiTiL9yX7a3dK3jvkJPomjSW5AnVrRq4L
 4jeMasg/YTs4YKxvXFnIPH38T13KFLwW5A5K4NkYRd8uUb0wwl1mQKT5izHIA0qLUM/8KBtKNqA
 SW+t5lITCZ6VPCtyBS9B3qk0GOdbHt+2vAbD1VzTa1AQrO7DtqkapL3xoYuPvTNIhh1znStl3jn
 vL1WOCl6aerSW7iKiKc1MeGmUeTQeA/pH4rul60iD1hcZJ5r3Sua4VPgqGYGVBPwIsAAOaDPIB5
 P7bCSvBd/dPBy8aoi8WrCh5vGJ3s5NS84mxJpYL8YNoAoJZ7pMkD4byahcWyHn7QMbyW09DGLj4
 NnVrUifEJkCPDZhNZHat5MvK5iikQGbftSGB4KPonXyhuatmGGzINLtUiEP8AOp7WY/MwL6j7Ae
 hfH5TLFLG9a1c6GAR0W0UHmgpkyVWV2BbRwfPUNKVklbaO1gSXZEeu245x95TFBLBy5bT8MzjSU
 LH4l3vV2FCUUwMzDKFnXGXWCcIGEOTXUZ0Y/E7mLLp2jZ3xHJ9mkWlpMDgPoJcpA2pW/YhSadVw
 +K9z18JknPvuZ8A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Instead of passing the syscon to the various nodes, use the mbox
interface using the mboxes property.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 20958c47ff3a..0f1dc4355c7a 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -130,7 +130,7 @@ master-stats {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
+			mboxes = <&apcs 0>;
 			qcom,smd-edge = <15>;
 
 			rpm_requests: rpm-requests {
@@ -217,7 +217,7 @@ smp2p-adsp {
 		interrupt-parent = <&intc>;
 		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 10>;
+		mboxes = <&apcs 10>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <2>;
@@ -242,7 +242,7 @@ smp2p-modem {
 		interrupt-parent = <&intc>;
 		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 14>;
+		mboxes = <&apcs 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;
@@ -267,7 +267,7 @@ smp2p-wcnss {
 		interrupt-parent = <&intc>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 18>;
+		mboxes = <&apcs 18>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <4>;
@@ -757,7 +757,7 @@ iris {
 			smd-edge {
 				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
 
-				qcom,ipc = <&apcs 8 17>;
+				mboxes = <&apcs 17>;
 				qcom,smd-edge = <6>;
 
 				wcnss {
@@ -1576,7 +1576,7 @@ bam_dmux: bam-dmux {
 			smd-edge {
 				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
 
-				qcom,ipc = <&apcs 8 12>;
+				mboxes = <&apcs 12>;
 				qcom,smd-edge = <0>;
 
 				label = "modem";
@@ -2213,7 +2213,7 @@ remoteproc_adsp: remoteproc@fe200000 {
 			smd-edge {
 				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
 
-				qcom,ipc = <&apcs 8 8>;
+				mboxes = <&apcs 8>;
 				qcom,smd-edge = <1>;
 				label = "lpass";
 			};

-- 
2.44.0


