Return-Path: <linux-kernel+bounces-16876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ECD82454A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F375DB21169
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF03249EB;
	Thu,  4 Jan 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MdBhR7cS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568E23762;
	Thu,  4 Jan 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404Fjrmm105829;
	Thu, 4 Jan 2024 09:45:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704383153;
	bh=SS4qp3FbuwSqV8rxN86fLN4iZLCeCkhuyatEDQHR1cc=;
	h=From:To:CC:Subject:Date;
	b=MdBhR7cSqxkMrjuQdnmh/n+7M2JbB/mhh51pbpt1J4QJLWRy6hBFU64466rBMISF7
	 nSQTRZJEvbpRtqL55lfOlNGX16A+QQf/GnOMuYvSqg7wAlpp0XtptdOxmTex90lCzT
	 fQ0wnVTg88Hj2rqhmRjDmlxjjlSahhXfNKLyEX5g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404Fjrhu077332
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 09:45:53 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 09:45:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 09:45:53 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.40.136])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404FjqGQ040462;
	Thu, 4 Jan 2024 09:45:53 -0600
From: Andrew Davis <afd@ti.com>
To: Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v6] mux: mmio: use reg property when parent device is not a syscon
Date: Thu, 4 Jan 2024 09:45:52 -0600
Message-ID: <20240104154552.17852-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The DT binding for the reg-mux compatible states it can be used when the
"parent device of mux controller is not syscon device". It also allows
for a reg property. When the reg property is provided, use that to
identify the address space for this mux. If not provided fallback to
using the parent device as a regmap provider.

While here use dev_err_probe() in the error path to prevent printing
a message on probe defer which now can happen in extra ways.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Acked-by: Peter Rosin <peda@axentia.se>
---

Changes from v5:
 - Rebased on next-20240104

Changes from v4:
 - Shorten comment and code lines
 - Remove extra ret assignment

Changes from v3:
 - Check for probe defer

Changes from v2:
 - Rebased on v6.6-rc1

Changes from v1:
 - Flip logic as suggested in v1[0]

[0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/

 drivers/mux/mmio.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index fd1d121a584ba..30a952c34365f 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -44,15 +44,20 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	if (of_device_is_compatible(np, "mmio-mux"))
+	if (of_device_is_compatible(np, "mmio-mux")) {
 		regmap = syscon_node_to_regmap(np->parent);
-	else
-		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		dev_err(dev, "failed to get regmap: %d\n", ret);
-		return ret;
+	} else {
+		regmap = device_node_to_regmap(np);
+		/* Fallback to checking the parent node on "real" errors. */
+		if (IS_ERR(regmap) && regmap != ERR_PTR(-EPROBE_DEFER)) {
+			regmap = dev_get_regmap(dev->parent, NULL);
+			if (!regmap)
+				regmap = ERR_PTR(-ENODEV);
+		}
 	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "failed to get regmap\n");
 
 	ret = of_property_count_u32_elems(np, "mux-reg-masks");
 	if (ret == 0 || ret % 2)
-- 
2.39.2


