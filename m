Return-Path: <linux-kernel+bounces-115505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552DD889BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105A328A849
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A08236584;
	Mon, 25 Mar 2024 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtHJftLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222711EC631;
	Sun, 24 Mar 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320945; cv=none; b=JCS/UXgi82HbK1Chtg+KuDK7dvd1U7Ovr8siS79wSXWE4JTskNRyC1FA7OSF3SvkeNOVPX7wVVRBlimxAZALW/uRE+Df5hx5cb3gQIIK+6JnRCvwmR7gl42woJ9idWQj4WoTsiVdPR78cFa17WnG1K0HZT/25a+GeS7EUraorCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320945; c=relaxed/simple;
	bh=7zR0BrWM9FieUe0Q38iXkPk2VIsJeZQPb9NcsHR1SBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDCh3ouXCiVfuoZp1xn8C9gO7spwcNcVGkfwjIpDVxW9T7XDInW4Dv9bEy628nEOhNa0au7deetEQc+1ln9eiXcg/pBxc2aSwwOkBzh9oJHQESCqiSj0ltSBw3hckhJOSwjxr0ejvzLR5RGJIEdCq4FgNzB8yXR5iLdXHntf6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtHJftLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61863C433C7;
	Sun, 24 Mar 2024 22:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320944;
	bh=7zR0BrWM9FieUe0Q38iXkPk2VIsJeZQPb9NcsHR1SBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtHJftLQK1IIyGC5by6zLP5+3F3EyWSXdP8tEw3fDNnmQZmogOBm7xDirotFkGpby
	 Se9799TUAHPf937SJHpvSrlNSetGIkpZhNr2DWZCWCO2FRpsrN9eRahj1siBdQQx76
	 6AacfiTc75ecmW6O+APOPLVPi1E5KKnFtuhxw5zuAMC092kjuJJizMmwhreQKQmqK7
	 yFxzRkeJkjIsop3X29nenvaX15wuxS+zRJeXDR2Dq05xnsSF5dm8SiQxvGEbogOR/r
	 228FWdmUAhIvHWPWapCFFeJtX5hNRI7XoMrBJCq6sZ4GMpA5aPAE3Hlj0h/5Q/mqLl
	 8tdhy79JeWJ5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 507/713] clk: imx: imx8mp: Fix SAI_MCLK_SEL definition
Date: Sun, 24 Mar 2024 18:43:53 -0400
Message-ID: <20240324224720.1345309-508-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 13269dc6c70444528f0093585e3559cd2f38850a ]

There is SAI1, SAI2, SAI3, SAI5, SAI6, SAI7 existing in this block
control, the order is discontinuous. The definition of SAI_MCLK_SEL(n)
is not match with the usage of CLK_SAIn(n).

So define SAI##n##_MCLK_SEL separately to fix the issue.

Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/1708683351-8504-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index e4300df88f1ac..55ed211a5e0b1 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -18,7 +18,12 @@
 
 #define CLKEN0			0x000
 #define CLKEN1			0x004
-#define SAI_MCLK_SEL(n)		(0x300 + 4 * (n))	/* n in 0..5 */
+#define SAI1_MCLK_SEL		0x300
+#define SAI2_MCLK_SEL		0x304
+#define SAI3_MCLK_SEL		0x308
+#define SAI5_MCLK_SEL		0x30C
+#define SAI6_MCLK_SEL		0x310
+#define SAI7_MCLK_SEL		0x314
 #define PDM_SEL			0x318
 #define SAI_PLL_GNRL_CTL	0x400
 
@@ -95,13 +100,13 @@ static const struct clk_parent_data clk_imx8mp_audiomix_pll_bypass_sels[] = {
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK1_SEL, {},		\
 		clk_imx8mp_audiomix_sai##n##_mclk1_parents,		\
 		ARRAY_SIZE(clk_imx8mp_audiomix_sai##n##_mclk1_parents), \
-		SAI_MCLK_SEL(n), 1, 0					\
+		SAI##n##_MCLK_SEL, 1, 0					\
 	}, {								\
 		"sai"__stringify(n)"_mclk2_sel",			\
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK2_SEL, {},		\
 		clk_imx8mp_audiomix_sai_mclk2_parents,			\
 		ARRAY_SIZE(clk_imx8mp_audiomix_sai_mclk2_parents),	\
-		SAI_MCLK_SEL(n), 4, 1					\
+		SAI##n##_MCLK_SEL, 4, 1					\
 	}, {								\
 		"sai"__stringify(n)"_ipg_cg",				\
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_IPG,			\
-- 
2.43.0


