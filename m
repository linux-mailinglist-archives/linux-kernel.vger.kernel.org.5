Return-Path: <linux-kernel+bounces-153430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A38ACE07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1099281821
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D714F13C;
	Mon, 22 Apr 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r57bAFbA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9E3399F;
	Mon, 22 Apr 2024 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791944; cv=none; b=KtzljrsLL0AG5gHodKPa9/n8RSTIyb2ZYCXKYxY4i6BRwskM45Jjs40BuoCj0C5hxTyZIOFkNR8HKmqYCzuyHHWwTaqVWRAko3txlXXhfct9tlttTQ8eraT8ZcsGFb6SU0Z0Uwk3bH8j+IaFX6gy7qcfQ58EL1TQ6U0XMV1WfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791944; c=relaxed/simple;
	bh=nEIImInbgCdKAwG1S5PDkhkW78nGxj3mhR5gm/NG8rc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QWGuiKZ+zgeGD4ywilnH0FnWLMzB6X03HvYIi73mktcCn9MTu+PH20go2j5erXVV8R04u/3V3tgmto4DYDdb67Ok8Dct7NjO9JxyWVebSUIN9ngTtl8KtHCNCYAytOhog6Ojpy3ELwdjnIk2Z13tDJ0ZrhJ6H+noGeP8abCWEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r57bAFbA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MDIhLm026330;
	Mon, 22 Apr 2024 08:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713791923;
	bh=qbn10NRmBdiC8cpl9UdEzAERTYd1gkIgankGkqfzrRE=;
	h=From:To:CC:Subject:Date;
	b=r57bAFbABQPhFOPr4tEUysnw8+14302h0+Bdj0Sez3Zod7Ti3qoQyPpdJALLad+Gc
	 pUiKxfpjZFnm3dsBrwxO8CUStzEGVWbgMxJz1hFm+T7E4D8VbVCs+hV0eNMl5C1hwR
	 0hdocmohGlUfdqHeHpAHvoXvVujSeJi1yo2+rWPc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MDIhDb078973
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 08:18:43 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 08:18:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 08:18:42 -0500
Received: from localhost ([10.250.148.22])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MDIfwc080761;
	Mon, 22 Apr 2024 08:18:42 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <b-kapoor@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable UHS support for MMCSD
Date: Mon, 22 Apr 2024 18:48:40 +0530
Message-ID: <20240422131840.34642-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable the UHS modes for MMCSD in J722S by removing the
no-1-8-v property.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 78032caeb5fc..bf3c246d13d1 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -381,7 +381,6 @@ &sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
-	no-1-8-v;
 	status = "okay";
 	bootph-all;
 };
-- 
2.40.1


