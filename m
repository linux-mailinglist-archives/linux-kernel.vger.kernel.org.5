Return-Path: <linux-kernel+bounces-33292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A3836806
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62C31C20C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BC41766;
	Mon, 22 Jan 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgzukqFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3C4174F;
	Mon, 22 Jan 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935668; cv=none; b=n/6JWzRWINCSh5RrKcoZoA5ARQECOT53/sqeCDFtAEEw3k+EP4cRFnyi9nphexyzt0jGrDtAfrai9mdCNVSndscVjwudO6uN0a96PKT1qqpMv1zwPqyQtaF40Xh70etMjgv4E2ln11oa9K5cmLclXDlRC1HTnNG1btjcx4gxZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935668; c=relaxed/simple;
	bh=5WiHhm/3Z4FSDuRuN9E/aZI8EX2lzNesoBNgmQECzkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJB51ivvP+JksZnwivIZq7cpU+hrgUQNwG6wVYiGAcLwspjdZpztpR4B0qHwNlUxQmVrQe9ANCWMEOntcFLXGeAZ9RKMk4MkrwFOwG35a0nQ0uvoxS9Uq31ie8GgKW7hL7cndp72j3ZchyYfxNgAMY1a1wbxU7vfH8aIp9mEDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgzukqFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0249FC43394;
	Mon, 22 Jan 2024 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935668;
	bh=5WiHhm/3Z4FSDuRuN9E/aZI8EX2lzNesoBNgmQECzkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgzukqFbTvU0/Rnl/513hRPQfkemXcibPiFWGDrVCVi2HU0BYWnDah0vRlC/eCwc3
	 GehH4RxayyJRSPmqShH65rDkFNYR5F7IvEOM9GcasEkEGEAogbK365KzuvmxTdOcda
	 /SZkBNVGqDu33DKr44AgZZTx7ioo07Ww6vKBA4ug3HDptNL8DruymlknX9eRS0L0Et
	 qYeSLGEl/N1ULxdOSZh6dGkIUGLWYmeBg7JNvmAGfDHaAMYxPK42PQeDuI9I5vyVQO
	 xhOyRPyj/OPrZ8hz/x2j1B0o4jQtN9bjFf8+h7WTNSLyl66Fd3wwZBGoSpp0DMKwSm
	 sJx+qb/FpcTpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	linux-clk@vger.kernel.org,
	linux-imx@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 70/88] clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()
Date: Mon, 22 Jan 2024 09:51:43 -0500
Message-ID: <20240122145608.990137-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 21c0efbcb45cf94724d17b040ebc03fcd4a81f22 ]

In cases where imx_clk_is_resource_owned() returns false, the code path
does not handle the failure gracefully, potentially leading to a memory
leak. This fix ensures proper cleanup by freeing the allocated memory
for 'clk_node' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/all/20231210171907.3410922-1-visitorckw@gmail.com/
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-scu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index be89180dd19c..e48a904c0013 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -886,8 +886,10 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!imx_clk_is_resource_owned(rsrc_id))
+	if (!imx_clk_is_resource_owned(rsrc_id)) {
+		kfree(clk_node);
 		return NULL;
+	}
 
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk) {
-- 
2.43.0


