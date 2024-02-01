Return-Path: <linux-kernel+bounces-48190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BB84586F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E981C2360A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1D2134F;
	Thu,  1 Feb 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lcrz2ZsU"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B553362;
	Thu,  1 Feb 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792836; cv=none; b=l5gI2RfYifyV8YNKfJFIQWQMyw8doLIDhfXN/tLnny7US3bs1UOWIo2mQ44LjfST+onopqb0A2MPWvaQzSPlGPh8gekcpyfx4zh38N6UlcdUAbzxTyZkVRGJ1PCKZ5XQ2ngWXCBewLm98DMSqoEnkxxvQLGIVuaYPi7YHjABhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792836; c=relaxed/simple;
	bh=6f4Ef9/GqiTKpvvaeCgnLywnZPv2ZhZoDoytSU7PwmA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LXaFA4AIT6nUv83yZOQN45obyHDpPYbiSpg1SN83KHlIsPQ+o68tpyGzXu/K2n0U+4rSnVQnGqgNI6ao5q8aRBMSyznucQXqfoQHkGCSYY1+TZSrnh5CuCqJTVJB6AL7INLsKZ7Lg1j2K/USN18VPxhzsSQ7j89rkjzuMKQv3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lcrz2ZsU; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411D78LZ111369;
	Thu, 1 Feb 2024 07:07:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792828;
	bh=a4dwWi7L1ejGump8F9su1AeeKeLJHybmWk4K+nGMnxE=;
	h=From:Subject:Date:To:CC;
	b=lcrz2ZsUrvC9rB5IGNlUcST+QH0DhwDeKGBfDasHJr20z8yLXPdmkxaTqnDsZzpyK
	 HzDrhlxO6lLBDxDhmNCHEIbtc2AqQNVN5it7St65a/aeaUhywlE24I/wxquITOa2R9
	 Q4W3I9IBfQi87OKKkzAFHn57gJxZlgc7+bxliGrg=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411D78ij067804
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 07:07:08 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 07:07:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 07:07:08 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411D77gf082914;
	Thu, 1 Feb 2024 07:07:07 -0600
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: Enable camera for SK-AM62P
Date: Thu, 1 Feb 2024 18:36:59 +0530
Message-ID: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHSXu2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwND3cRcM6OC+OTiTN0kM8sUQ3OgsFlyohJQfUFRalpmBdis6NjaWgA
 ZtD6TWwAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=6f4Ef9/GqiTKpvvaeCgnLywnZPv2ZhZoDoytSU7PwmA=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlu5d2TeizF9nQk/It4ohVfSZw+IXeP/ikOijKb
 BcZc/x1Zy6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZbuXdgAKCRBD3pH5JJpx
 RZ+dEAC2Y5VykRkS+inD5WGnHLA16IhhYq5HVgiOh5tWpa8z1or/Frv+NqCWrMNuqMLK2PBJ67T
 ZBvDsmLI98sMzA9fkX+0lwsn4JbPPQwq3Vv8GerFqnkJFC9VTRCxGl8a6h6zvwfmDNAdvLLD5V9
 zjyZBDbsJ6dPvWI9ncP8H1dAqRp5ss7HemuAKVdoXLoMsPd9n/1xuECzE4oA0NqlqeWBKpBTX0r
 F/ILU1OCECETrvzMFYNQwqhK+S4+QrvgF3kCcoB74FN+j93BYwZGIXi9dPLIi7361L5pT2OIrso
 sn1B4pV5AdaHrPTx+QsQbWb6NRIf1QwnSj6uLBlEGvCLFoKp24YLkib0EmUs8/OYUZLm5nWVxls
 5npL/73fJnxo4bRsaUqRjNRu5UdpDHNkT6FZn/u2GDcNQYJan54TB2XKREzv7beIbT+lNrPW+YH
 Q/3RU8hXAjK/DiZf6kjUtWg5pP1d26j3K3z68fU6Aad87wLK3fguORNvENY+EqA0o8geOP3uNvo
 6ky94Rcfh2fb5OtrH1ER+Xgy1UajxzfFU6Jrgjt+VVGw1olPrWXTvuEz/YgKWgiqcsjyCVrl4QA
 NBfUyb1w+KgUjc3f/GD/xrum8OxwP4O85mntBrAKUh9W4rkxNXIIkH0fCGSpXv5Mo/8+M9d9Lsw
 8gVk0o/YRhLcT3Q==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series enables support for camera sensors using CSI-RX ports on
AM62P family of SoCs.

Particularly, it enables OV5640 and IMX219 sensors via the 22-pin FFC
CSI-RX connector on SK-AM62P [1] using the existing common overlays for
SK-AM62* family of boards.

Capture test:
https://gist.github.com/jailuthra/11f3383ccc0902b9db90d806222597a3

[1]: https://www.ti.com/tool/SK-AM62P-LP

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Jai Luthra (4):
      arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
      arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
      arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
      arm64: dts: ti: Enable overlays for SK-AM62P

 arch/arm64/boot/dts/ti/Makefile           | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 98 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi      |  2 +-
 3 files changed, 109 insertions(+), 1 deletion(-)
---
base-commit: ef7bf0ae92cdee584950f74f364338c28f549cc7
change-id: 20240201-am62p_csi-b69d172406ca

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


