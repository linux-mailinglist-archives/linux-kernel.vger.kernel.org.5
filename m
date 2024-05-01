Return-Path: <linux-kernel+bounces-165715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452868B901F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FF12820E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF85161925;
	Wed,  1 May 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eeKMprLL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE81474B9;
	Wed,  1 May 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592532; cv=none; b=k+cT6GHwSnKbMUPerU8cjwYJRkdACMpVsrdXT6PRaBZ1184hMSCIvdC9ajwC50xEacapc0Eyi/kQ/znSG8NRwKz6RvZM41PoFld+U5eAVUJfZTrhLUNjMc1Rmfd1gUK4ljLPouHXNCL4VADttXInQhnCtdYoFYG6KDvYbHBQQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592532; c=relaxed/simple;
	bh=hWE+HRqsYOkbNGE7QZUoRuH7leej+iqZ6A+V++OTDvg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uh+CgRB7ZdkZSjLTYL6xIZ1giceD/bSx/nm+77otk2pRIBNsHySZ+wFIZ7cfxKSZkY4XPxSUgm5RsVuHLBvK7vmUwGCb0BUOzjSYlOTVLn/oacbKbSFNwzt0aJ9eWB8j+6w6vK5oa9wJHhQsTQtSCKfQtBZMTQXW09na7OZRboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eeKMprLL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 441JfvUr047309;
	Wed, 1 May 2024 14:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714592517;
	bh=jWXU0JkDOU9HuQkamimPRjSRXflu3jQKPWewfH4wu58=;
	h=From:To:CC:Subject:Date;
	b=eeKMprLLjcW3/nwt5jTRlzEKvZVRPf64DeNS2uUx0fH4L1deIcOufM6oKpVrY1KAO
	 rq5Ch+YoUKGMJy80vnRxFRnWat3fZ8paGSVjIuqKJYuAGT5rqZuPUwHy9Nj7sKY3pY
	 SbvP305HRvj5XVGDHP9UIXqVC+1gjwm3pq7zlVk8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 441Jfv8Y016738
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 May 2024 14:41:57 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 May 2024 14:41:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 May 2024 14:41:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 441JfvvC107762;
	Wed, 1 May 2024 14:41:57 -0500
From: Judith Mendez <jm@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren
	<tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: am335x: Add PRU system events for virtio
Date: Wed, 1 May 2024 14:41:57 -0500
Message-ID: <20240501194157.2727136-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Nick Saulnier <nsaulnier@ti.com>

A PRU system event "vring" has been added to each of the PRU nodes in
the PRU-ICSS remote processor subsystem to enable the virtio/rpmsg
communication between MPU and that PRU core. The additions are done
in the base am33xx-l4.dtsi, and so are inherited by all the AM335x
boards. Do note that PRUSS is available only on all AM3356+ SoCs.

The PRU system events is the preferred approach over using OMAP
mailboxes, as it eliminates an external peripheral access from
the PRU-side, and keeps the interrupt generation internal to the
PRUSS. The difference from MPU would be minimal in using one
versus the other.

Mailboxes can still be used if desired, but currently there is no
support on firmware-side for the SoC to use mailboxes. Either approach
would require that an appropriate firmware image is loaded/booted on
the PRU.

Signed-off-by: Nick Saulnier <nsaulnier@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index d6a143abae5f6..d763ed4a15b58 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -915,6 +915,9 @@ pru0: pru@34000 {
 					      <0x22400 0x100>;
 					reg-names = "iram", "control", "debug";
 					firmware-name = "am335x-pru0-fw";
+					interrupt-parent = <&pruss_intc>;
+					interrupts = <16 2 2>;
+					interrupt-names = "vring";
 				};
 
 				pru1: pru@38000 {
@@ -924,6 +927,9 @@ pru1: pru@38000 {
 					      <0x24400 0x100>;
 					reg-names = "iram", "control", "debug";
 					firmware-name = "am335x-pru1-fw";
+					interrupt-parent = <&pruss_intc>;
+					interrupts = <18 3 3>;
+					interrupt-names = "vring";
 				};
 
 				pruss_mdio: mdio@32400 {

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.2


