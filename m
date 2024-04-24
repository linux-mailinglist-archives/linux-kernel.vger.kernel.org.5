Return-Path: <linux-kernel+bounces-157332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149818B0FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56572815D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05B16D4D9;
	Wed, 24 Apr 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="6kn+VP/v"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD42168B19;
	Wed, 24 Apr 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976464; cv=none; b=dt3dUWTe7pcWWYVz8rxFOAqwMaRjWGTZrE76C13dKXKgWH+pDeMrYF8Kj63St2WL4KyDTjjOLx5Dks3FGr84GLIqWDIYLgd8LaCj2kSF1k44ZwMR2ki7P5RTNUK3dSPOHLp7kz97cE2AqTew9Z8+Q0gitmRtM6lYtEbPpeOwrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976464; c=relaxed/simple;
	bh=p2PUgz4UgDN8BhScJ63ELIredxmJ/DvCqJRgoSHMeDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCDnRNbN7Am+uMqGPa9BzQtOOPRoGWfM/9j6nNlv4HNL6mGBV9wbPulv3AK2KXGB+sBLzqbSCg3hvqRgNWeM/yh7bCvxT1Cgrfmrt3SlWmHERp3QjBkY5OVrPFLsIYj7hQuG+nx657lLAwqj4f0tGJFg1Ku+hD0kMHZE1TpAABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=6kn+VP/v; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975863; bh=p2PUgz4UgDN8BhScJ63ELIredxmJ/DvCqJRgoSHMeDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=6kn+VP/v+dbj4SdAnqsUXx71Y/AU2mCbogNdQBMdFXuKdOrLLBhJqyQuA6EYmznsi
	 YY4BRBsFAhmhyLRzKJT359m3cPTBg7UQFRypLgRiZglB0Wsv7iBEMncxrb+kDjKDdh
	 ETiUn/jV3uE+fSQRfFKqBj/X80xvkwHL1VjizLew=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 18:23:54 +0200
Subject: [PATCH 1/7] rpmsg: qcom_smd: Don't print error during probe
 deferral
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-apcs-mboxes-v1-1-6556c47cb501@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=777; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=p2PUgz4UgDN8BhScJ63ELIredxmJ/DvCqJRgoSHMeDo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTIw9U3i3ifxXoB2YYegdlbUJfpWug3VH2uRt
 LK5g9RZ1wCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyMAAKCRBy2EO4nU3X
 VrieEADJB9pzIZlaDFuRe/vXpra2hrFROLAG5HRcJXybeMt9Nkd8kjzo7PVsEKIhkoINCcS5820
 S5+vccc5lPl2qH2FNdsZLztBU/zGXL3YdtFw3lTypYL3lrkSxlUBM4tuFw39A8xlM1nhjN1+3kS
 kEyreDlbDjxlZa3CUoRqq5r078IgCLeSI70WEPABz3Q6nRqCQjOhKQj4zaeiwM5Xk+B3j7KiInK
 GWLl1Msv+2iAgll72uxiBmjfEWT/i5b6YOYkULrRo2wGI3vmUtc3+aGlJdFMj9rZpZ2J0nKbZF1
 CcgmPw/MLfr0b409kczG3XFvwFMplsnfC8ZecKlqBfgonHZx70RkzSobm6udXaEjrabHPmrEEuG
 ypLdloqUH4i4Rddzj6BHmK595/AQjJJd8Xx4PrdtqyBlMhFh/8zgrT6m4sAIPrDv7unqtkr6C/R
 ye2zvxcFt8icTI7WlxEP6+D9tlXZ/RzyTXZtQnV6fOTKnQku3ykFcXHZw3l+WtGgfp3CLNh/G3g
 KAUtientfBEBq6C8qw+Wukf71M+IQoLs+ZkkuERyMX2lCC5n6aB71IiZnMxdV9MXrL7ekv+dbzv
 BOpQ+u1Rp+hlHmc87CzyX8FPtZ/hk1J8rDmXDyLFhfjqch0n9YkqvXTsFc3BITP7/aGHwFtysoz
 rOYI1xREmOfEoTA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

When the mailbox driver has not probed yet, skip printing the error
message since it's just going to confuse users.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/rpmsg/qcom_smd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 43f601c84b4f..6fc299657adf 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1502,7 +1502,8 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 
 	ret = qcom_smd_parse_edge(&edge->dev, node, edge);
 	if (ret) {
-		dev_err(&edge->dev, "failed to parse smd edge\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(&edge->dev, "failed to parse smd edge\n");
 		goto unregister_dev;
 	}
 

-- 
2.44.0


