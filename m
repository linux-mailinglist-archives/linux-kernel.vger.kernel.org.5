Return-Path: <linux-kernel+bounces-68378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E36857970
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71ECC1C225D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C81CAAB;
	Fri, 16 Feb 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gANvFRmV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F31C290;
	Fri, 16 Feb 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077108; cv=none; b=UznHXLhlDY1+8fV+Qmp12uCzXx89txX8C7+Vx4iQuuoLKSz0j9KgkNaYMjYAOkkt2Q2zCl3QE+8tLBnOdA45iacrKNcOQK0aJ+cXYyZxEntPhbm953M5j3qAUWZSLnTdyIsTt9/+8i+uXwC/ZOV9P8zXRANzEC5QqDGW6xRRknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077108; c=relaxed/simple;
	bh=tkuaNBMkKydcINY6S71b/9WvjINpnpK8UWPJ1sC4kN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IT5jviDYObivr97xWbn0DIVMnLk3dcdI0E00/gnCt1oGJINgYskeXu+nH8odWzjTe/XBNgjtNF29c6gU/9WUtD9r+Z0r+XYxX1LHQdPSc/opAYAsN1kDtjso2kscx0PPKWUG26uBLGGETSoACSqPt5TtCCTu6EMeM86WeSxv4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gANvFRmV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708077105;
	bh=tkuaNBMkKydcINY6S71b/9WvjINpnpK8UWPJ1sC4kN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gANvFRmVZ4eC1ndXJdBrndZE/qXSLcyVDMVrnGXkk7nbNYTGhPdiHThqBNBARIRyO
	 pACNdAAf7TlNyoGb2sQPx7scMeb1urIqKg6qY/FPEDkEzcm0rIPP3aACVTk5IT2V+S
	 2qi39wzFwU3nDlXdZtGEffKzMDyFTFglSa0+0jTZzIE/j9DuwIFmMjowjX4hC79zV8
	 tg1rTZ3bnGxs5Z56Ir8VYr2epyyRlAeMWg7A+L6NRzXbIpFuQ2MLPC1mnanfzEV2c4
	 lDobBAS/odXA/tm+ZLwscUbvTT9i+LFWrdbu1TNzy/oqOeL/U4A3m9PlowQfFp70yV
	 ucM8cckugY7OA==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B27543781F9C;
	Fri, 16 Feb 2024 09:51:40 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: heiko@sntech.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	dmitry.osipenko@collabora.com,
	sebastian.reichel@collabora.com,
	shawn.wen@rock-chips.com
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-dt@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 1/4] clk: rockchip: rst-rk3588: Add BIU reset
Date: Fri, 16 Feb 2024 15:19:19 +0530
Message-Id: <20240216094922.257674-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216094922.257674-1-shreeya.patel@collabora.com>
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export hdmirx_biu soft reset id which is required by the hdmirx controller.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/clk/rockchip/rst-rk3588.c               | 1 +
 include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/rst-rk3588.c b/drivers/clk/rockchip/rst-rk3588.c
index e855bb8d5413..c4ebc01f1c9c 100644
--- a/drivers/clk/rockchip/rst-rk3588.c
+++ b/drivers/clk/rockchip/rst-rk3588.c
@@ -577,6 +577,7 @@ static const int rk3588_register_offset[] = {
 
 	/* SOFTRST_CON59 */
 	RK3588_CRU_RESET_OFFSET(SRST_A_HDCP1_BIU, 59, 6),
+	RK3588_CRU_RESET_OFFSET(SRST_A_HDMIRX_BIU, 59, 7),
 	RK3588_CRU_RESET_OFFSET(SRST_A_VO1_BIU, 59, 8),
 	RK3588_CRU_RESET_OFFSET(SRST_H_VOP1_BIU, 59, 9),
 	RK3588_CRU_RESET_OFFSET(SRST_H_VOP1_S_BIU, 59, 10),
diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
index d4264db2a07f..e2fe4bd5f7f0 100644
--- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
@@ -751,4 +751,6 @@
 #define SRST_P_TRNG_CHK			658
 #define SRST_TRNG_S			659
 
+#define SRST_A_HDMIRX_BIU		660
+
 #endif
-- 
2.39.2


