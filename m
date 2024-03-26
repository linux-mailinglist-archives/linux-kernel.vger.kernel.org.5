Return-Path: <linux-kernel+bounces-118971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B272188C218
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E428D1C2CF00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB874402;
	Tue, 26 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uPalsqQP"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD271731;
	Tue, 26 Mar 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456060; cv=none; b=bfSMec03sWtazOHETRQqbRN2+88G4p55ub28bO2+3UicLRbhOJLP8k3Nik/1nZDr0WewhT9eNYOCpIzcl3Oa3boQtedUroF6avWZixpDb/QSUu7IUY3E0BcHEtgubhQBr7d3/OggWjkzEZfSK4BhMchSNSyhnCF9LXyhpncZZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456060; c=relaxed/simple;
	bh=z9ytf3yAf9T3nzFrLsq+ilJtFAcJILQyZyZ32llh49E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Du5t9kz6VfX/VHoRssQ5N5Yq6lJt8WQzhBl6gJK8djjlWzPgLZAqMPbKoU9EuWfoh1vdy0dD5hapopI8nei7JUYlv85hxvBpS1lpKmcGPeHZ0fpstESD22sJsF302Wr5SA/1i4QrmbJKwtRBYjDwq/CeHB34w8HZe4G0Wd1wdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uPalsqQP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRV4w080826;
	Tue, 26 Mar 2024 07:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711456051;
	bh=+3pmz0PQmucIleuJBVNX7kROEXn+vQUZWmW93sQBGgg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uPalsqQP7k/Y5XOdHKTSTNgPPYuBGxYcq/B+TKk5Em3E/JrY1FtXuFJ5T+b94DDwb
	 l3OFPBZ8EbKNz9MqUEqnZP5xMvrpC8qgz7pgjql89Jq+dTwKxEcQa940RF7rceF9YC
	 Qg6tRG2da2AiH42m720GbO723R/JNmZwY77S9FpU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCRV2A035195
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 07:27:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:27:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 07:27:31 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRN2c129435;
	Tue, 26 Mar 2024 07:27:28 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
Date: Tue, 26 Mar 2024 17:57:20 +0530
Message-ID: <20240326122723.2329402-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326122723.2329402-1-n-francis@ti.com>
References: <20240326122723.2329402-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the WKUP ESM instance for J721E. It has three instances in total,
one in the MAIN domain (main_esm) and two in the MCU-WKUP domain
(mcu_esm and wkup_esm).

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 4618b697fbc4..b0f41e9829cc 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -689,4 +689,9 @@ mcu_esm: esm@40800000 {
 		ti,esm-pins = <95>;
 		bootph-pre-ram;
 	};
+
+	wkup_esm: esm@42080000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x42080000 0x00 0x1000>;
+	};
 };
-- 
2.34.1


