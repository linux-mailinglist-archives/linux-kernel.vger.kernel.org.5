Return-Path: <linux-kernel+bounces-36054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C2839AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DB0B22D63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555739AE5;
	Tue, 23 Jan 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="tMappZn9"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBD13ACC;
	Tue, 23 Jan 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043876; cv=none; b=hPbQKwGGX/DbkVR/0aHpU2M0XCcqVIPFYVIjiEP9SBx7BCb3bqJ832wtMLaFI0+J1172pkFkDz1XAhyg/LuuL5nejgTA0aYKlxdV9Fl+JhuP1afyKPmmzYoTe5QHZSBTB7ticc7USKOb+Qr08SU/pi7b1FQCnixmgUG/L+SJ5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043876; c=relaxed/simple;
	bh=6Tt6eRYCiLryDbZmMcrKQu7hSAO30Hir5TyQMBYLc2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFUYl4Qmv0Ftc6Hz8W7+6jH+ZBwfE1EsJuyHwkGcdgL71Z28IBxWIzhJEfEqusi8XlClWPM7O9mKxoYfi3aMnB1hwA/Wmff/UB/cwKSM3Psj4wDtoW3TmtbGHSjKitxGTuzkZMIizFjsrSvpDsyFW5wAwyhSkkYfweUKoPrJ8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=tMappZn9; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706043867; bh=6Tt6eRYCiLryDbZmMcrKQu7hSAO30Hir5TyQMBYLc2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=tMappZn94EZDvk53WXGyAWQjeOxqtwTvDv42zG18rEuu1uegC0BhYJ1DbxkZB0ZFZ
	 Q0FlkgGTUNDV5/QCXog3OwikuARSDiFMdjR6nCnBsswpBbbYAL60MA9+q6YCiTI6JI
	 pNtmu99dYk5zkyw7jpByT7ZuAcj3VxPj/zZWzrTU=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 23 Jan 2024 22:03:56 +0100
Subject: [PATCH 2/3] clk: qcom: gcc-msm8953: add MDSS_BCR reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-msm8953-mdss-reset-v1-2-bb8c6d3ce897@z3ntu.xyz>
References: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
In-Reply-To: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>, Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=812; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=8RJwt2p5+9bT6QQ/3hPOmBGTH0lkJfO7XYCtLnTgeIM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlsCnXA+2mEUNEOks1QZlI/1ceT4VUxjVTjAH78
 B8CNE5k++uJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbAp1wAKCRBy2EO4nU3X
 VrhSD/0WGCK03oMpHb2EbL2RqQS/Ywq3b7sbBoW8HjGlfmhZyNN03GchQqM43BSpXDOGpDPv2b6
 mb4nvGd4fG000UsPOctR1SgCRll82pC30krHtuzuXE0TxKsIaifKwLMfItBz2r6FS/9n01XOoS1
 a9boyPpp6pWLydI2EPn3AbMAP+CDejOWxnn5yYB8O7O46xPI40fhLir61rJLbhM4wWreP65hi+P
 F/OVc94cTXB69aO/bwqGu+ri1WtDXnaoJKto2HmNjbC9B6hD5sa2Z0YC7gKhNTPAP01ivY2GNa0
 v9JOnqHjNex12zSdicTUd1tYiud8crfzGz+9Y1W9m0XkIGcq646eEXFvqbadN2XlTfjpY1Nogd9
 Oef2Bz4dWDa8TY/fJ6Nheeu/M4AvSViBCLv+1S/+f0KA0fOSUwLd5s7Q/k+88BXhYqTmvj8C2A7
 IdJakQnCqtXOfa0/ppIzrbxlZjyYX8nMS+8yH+kZfjqYl1KnbZFgVDARfQ4XM1yvX1NAI/MdZ4c
 MXkLqAvrmBW9DA7ZJ++TxdPJdmXdGfXqlfv9/XT4auG5M2Q+nrkUOlKLCF005baXIgYM1/LinOl
 +JmC2x30d28UPk/07XBLUEePxVy+Gqy79hHNYvGXPWnOpsdbzOOKsuqhyqqeJoW3C7Zz77yjjF4
 5Jl8a/0cKfc3FIg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add an entry in the gcc driver for the MDSS_BCR reset found on MSM8953.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
[luca: expand commit message, move entry]
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/gcc-msm8953.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 3e5a8cb14d4d..5725857faae6 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -4171,6 +4171,7 @@ static const struct qcom_reset_map gcc_msm8953_resets[] = {
 	[GCC_USB3PHY_PHY_BCR]	= { 0x3f03c },
 	[GCC_USB3_PHY_BCR]	= { 0x3f034 },
 	[GCC_USB_30_BCR]	= { 0x3f070 },
+	[GCC_MDSS_BCR]		= { 0x4d074 },
 };
 
 static const struct regmap_config gcc_msm8953_regmap_config = {

-- 
2.43.0


