Return-Path: <linux-kernel+bounces-92384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7157871F55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FE9B23852
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17985945;
	Tue,  5 Mar 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4Hwq/G1P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6284FAE;
	Tue,  5 Mar 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642289; cv=none; b=ZGZ0BAB/BN3vrn20ayoCmP0c+ZHA5XlF4EXZC0l8MBjjUI7E3JFPAg9qAJ6/GHw1XexF8K1mazNZVcBHHuj1jalCMO4Q08cD0ctDyEi1NXmw75DJnDkN49F18/3LNtbFK1zdD9GzisFIjliB8HjXYsKk7sRuy4x7JRxLp30Rw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642289; c=relaxed/simple;
	bh=h6HP2ARr+i3JkH4OP3lQ3xIj3IkGQJMVh2tIqY/xCXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBlTjECUFhX7RHzMxgn53Zv1JaTYFs0+k/84VDEprWYU7OvqJNuqxmo6zcIBHD7SyYPdjNS98xTl8X9tmXFHsWwe2/iWVwk/NXb3xBJr3C4T+NdDwrPa8Z4MmBekxh2QyjtSDKoHzoLxtDhSrAJOK6Jq14X5UToHf5bmYxHme+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4Hwq/G1P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709642286;
	bh=h6HP2ARr+i3JkH4OP3lQ3xIj3IkGQJMVh2tIqY/xCXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4Hwq/G1PTBG0Wj0bUoNTFmaz0pb9k5TJEt+zmmHkLZ08fXx3Y8haCHSdzwaWpk9BV
	 cBch06aBxaKhSCMyzZlyIP8Yp4Mi9BajrYma5QSmFix3DWVSr0OT0PnmbSWhxzfXsU
	 Cyb2RcypXfdtrJ0r5FGM70+Q4dWlgqc0eH9uP+KWq9o8Mq19+HeGcbR4VTJbFEHR4j
	 BJyPEskZqpS5V96SnEiKGYgV+mNx2PrkWJuRdVfC86mqqbHtRwCwBKkT4PLVnZ3PmJ
	 Nd5eL2vWGPpbkNxNn0GJQRkgL442AXsnO+3Da6QQjokf5qBGaSIFOMfniT8Tu1Xe+i
	 jhVnRQu8SDzuA==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 230BE37820EF;
	Tue,  5 Mar 2024 12:37:57 +0000 (UTC)
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
	shawn.wen@rock-chips.com,
	nicolas.dufresne@collabora.com,
	hverkuil@xs4all.nl,
	hverkuil-cisco@xs4all.nl
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 2/6] clk: rockchip: rst-rk3588: Add reset line for HDMI Receiver
Date: Tue,  5 Mar 2024 18:06:44 +0530
Message-Id: <20240305123648.8847-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305123648.8847-1-shreeya.patel@collabora.com>
References: <20240305123648.8847-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export hdmirx_biu reset line required by the Synopsys
DesignWare HDMIRX Controller.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v2 :-
  - Improve the subject line and commit message description.

 drivers/clk/rockchip/rst-rk3588.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.39.2


