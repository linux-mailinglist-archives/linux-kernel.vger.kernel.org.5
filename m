Return-Path: <linux-kernel+bounces-142305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938748A29FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEEB28E12F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C7F12FF8F;
	Fri, 12 Apr 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="WbiNxpKg"
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567C12C544
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911481; cv=none; b=kISmZKOCGWTdqBh8FIPQazboGMAn1sb6knyXfJt55ah20q6OmjzqMrS2EgHNekvnbfPxEds+WCAIicpv3977q6uD4g7PsNshVs6Gbhy04MrRCTflkjmwQqaQEPkTfJsR4mtmbS6YlqUhMapvILxlE30Of2wB5llmUMivG6eW7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911481; c=relaxed/simple;
	bh=mCAvB0rO9lm/U91o/sD34CmBBvyvw1MORHao+rAUw9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5hejFII1Uu9Z2HrwJQnv+mk1Qs/QNqr/ickkUpxkl2hkfOAocdVmw27agjZS2ze25sWPHXIkrOhhX6TGCX2N/8Abhujq3ZjvguCMXXcoucqLte9DekOiYFpsg87pYwcFYz4JIFDtqsGXZIE4WfXVz/BfrvBmmVmXAEfTgFbG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=WbiNxpKg; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.11.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id vCWKrIsVvwWj2vCWLr0hxG; Fri, 12 Apr 2024 10:44:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712911469; bh=mCAvB0rO9lm/U91o/sD34CmBBvyvw1MORHao+rAUw9E=;
	h=From:To:Subject:Date:MIME-Version;
	b=WbiNxpKgvikedTT6O3tvR4TQ2cxLMbT8Vto6PyJRht7WGd9f3Ubo9Qf8bVczhTBOE
	 JxIpO2ch1RgHVShgoW7XZr/obqEHWDYX0wECpcLyPBb7dW4AIdTlp/kGcJoD5R9ELI
	 QmNgzYNw2g+WrG2grcJhDilaUOdE7X5jxuoiim2ljgFp3i6LolBf/f943vqy+cF0Ue
	 1gP9DnS5hdtx1F7ar0Bw4R6DiiCZuRXFkjGRju6zsETZnMko/t0ylcKAHY+cXiMMgo
	 ZfWmTfiPCHFlGikX54cjgVOdLAnwXaoA0av+GFv4S6I/5c442rh4hffQvOswb6M6Gh
	 hbuGntfZRAX4w==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v4 1/2] regulator: dt-bindings: pca9450: add PMIC_RST_B warm reset property
Date: Fri, 12 Apr 2024 10:44:27 +0200
Message-Id: <20240412084428.400607-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412084428.400607-1-fabio.aiuto@engicam.com>
References: <20240412084428.400607-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK4oHPsPdScFzaYXVXev1tdi4Txm6ETsUGH2jspVbqAutHrXEIWcUrjnGZ9ffT8sz70SQGyAJhqLj1JpS2icoNVbYd+jE0GQMAhMTewqK0tdlAFaWc4P
 aSAA1Ufl4kz6ZD/yL1YyM+036tU2Adfcwmkb5y4mc1jDPKWQ5yPbDxqvn++pMVD65qNC+z+QDEMxboIHFcv1U1v9V6sr9ckSm1tadAs16zt1ogILT7M4HI84
 eBXxgiTKjCBfmPXIDUgpYVNGs08tIKr0C/7Eb7+lEeeqfEdqPbzjt1pZEV0qQV0PAXQZb9yejU6C7YJ63h2aedMe6ejlYBpJUXfPkqE8vd56g6+DI01K2UUF
 hZZ3tODALy3azWzjLCJBhKZ14Rq3AYuNIetp0he5MWieKgp8Ux6kcB88CsLtXNogBtsFgUBLjatCdXiZbKeGZDZKtd8+cb5tCRDqXw2+HHSI4pnSWUY=

The default configuration of the PMIC behavior makes the PMIC
power cycle most regulators on PMIC_RST_B assertion. This power
cycling causes the memory contents of OCRAM to be lost.
Some systems needs some memory that survives reset and
reboot, therefore add a property to mark the regulator as
performing warm resets on PMIC_RST_B assertion.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 849bfa50bdba..865b259dac37 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -93,6 +93,12 @@ properties:
       When WDOG_B signal is asserted a warm reset will be done instead of cold
       reset.
 
+  nxp,pmic-rst-b-warm-reset:
+    type: boolean
+    description:
+      When PMIC_RST_B signal is asserted a warm reset will be done instead of cold
+      reset.
+
 required:
   - compatible
   - reg
-- 
2.34.1


