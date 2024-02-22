Return-Path: <linux-kernel+bounces-76426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA385F736
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C937D1F276C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746035102E;
	Thu, 22 Feb 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BmrmLF48"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8E4F211;
	Thu, 22 Feb 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601624; cv=none; b=si0rI4W/YO5l2MInnY++S2j5FTmVZktCZ6bOW6+9gG4BI66KMKdtg91+VKrK6psaHG0muJCJi/xYRNccmSXWYI5KmPwB+BCsqTP/u+eOqeO6jNFuU3iOzRDd5p+6AEIEpXHKbQpztx+lVK1gkD09513TgMvIkLywtzFfAq2pwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601624; c=relaxed/simple;
	bh=Na3FxDoFmJwKP2/Z+thurEhYoJ1q8QJrM9yU72Ifm1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D62ht26OeX17n7Unh3tsWurhQZ9HfCqiDzD4OnZgHfrIWNlcJOXNqTcXI5j7Q6q2neL2t8PG/PKgZSsW62sTM+GZVg7+/JQK9ma1LWVAu3xlx4qd4VdImnaPmyJ8UkdOR4u7IODWFndvCE7EK8kkTbaEunf7UOxH5GSosATHNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BmrmLF48; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXUlt018090;
	Thu, 22 Feb 2024 05:33:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601610;
	bh=IIFOD7uZml1cZMulax2MAWAdhtL2PDteL/pS7c8c1vg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=BmrmLF48vcqVdT/ofpJwNIkxU+/ZO2A9IQIBp/tyiyidCR8PIPoeQ32ThbUtZKc40
	 QnLjJ3rYGNGcDsdYByOMZeL7L1jlj/pCF/RXP+8e8VSUNzz6LYYysqzorkjPoBU/0j
	 SHJ3FYLBRL6X4Ef4ec28CMGn4r8G7YTvv5pXxqnU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXUYo007860
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:30 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:30 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXTYO128794;
	Thu, 22 Feb 2024 05:33:29 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:29 +0530
Subject: [PATCH RFC 13/21] media: cadence: csi2rx: Use new enable stream
 APIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-13-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Na3FxDoFmJwKP2/Z+thurEhYoJ1q8QJrM9yU72Ifm1A=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDm2nXX6+ZXmetmJ7ki72+WsjqiulUvHkFgP
 7xWNQ1geB2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw5gAKCRBD3pH5JJpx
 RcT2D/4rgzQuq3zQkIoE4qSuyAw/GfQ5cFCro98zAa2VhMJO/n0wTwFbWUo/VPzWURWzKXhjpzp
 5xD0K2Qqbos8K2JkTF03EiQopJQqmW9wc90Nm2tLAS3YV5ew6dQZEzozANRhAwno18bgLsEPLwU
 rsUJiTq5QXoPXsr1P69BaQTb4eK3WrQxZ2XUrX0oSkKu3TUjSRIPDgzz0wt/UqI75waW1dE43mK
 Z1ieDwTK5LsoAk+zx5/zP4ci7mz1sz+uDkKPF+DidedAvnExGYEL/W+La5118U0FZASGrWpn2WA
 ttIyVbXuBzwVnZVlfTp1p1vEPZtrZKdRAaeMUGMlukh7TY++9dy8KsYQZtvAAXzPj7Vf3BXollu
 YdzGgDiKLi+CFkmEyi5SpBMvVv1NQM0ofoPcRDXBE/47iJXSCETF2ZlDx3VGMOOOkt70paChXCO
 wyZQWr8Y+9i0d90C0rEuXc8G6Sizeib/kf/qlgbYH6/E9m+9+vzCrAueicMQ78peTk6iQaSy8vj
 6aKF6WZUcm5Kt4STi1kItSQkFWGGe4h5BumBZhIDGpEcyAU4evBkWFB0/K5ORhRI+9luCOKvI15
 f1m0fFtFMC3UzXHjYfUDBNRNKSi2XMDuxqzAsQniShysnw4bnANlpoZtGlBjUm4mc3cWmxJjTdP
 8Oa6AczAV9QRhiQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The enable_streams() API in v4l2 supports passing a bitmask to enable
each pad/stream combination individually on any media subdev instead of
doing s_stream(1) to start all streams on the subdev at once.

This API is implemented by ds90ub960 driver (FPDLink deser) and thus the
caller (cdns-csi2x) is required to use it. For now we only enable
stream0.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 989924dba9a9..bac341881e41 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -226,10 +226,18 @@ static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
 static int csi2rx_start(struct csi2rx_priv *csi2rx)
 {
 	unsigned int i;
+	struct media_pad *remote_pad;
 	unsigned long lanes_used = 0;
 	u32 reg;
 	int ret;
 
+	remote_pad = media_pad_remote_pad_first(&csi2rx->pads[CSI2RX_PAD_SINK]);
+	if (!remote_pad) {
+		dev_err(csi2rx->dev,
+			"Failed to find connected source\n");
+		return -ENODEV;
+	}
+
 	ret = clk_prepare_enable(csi2rx->p_clk);
 	if (ret)
 		return ret;
@@ -313,7 +321,8 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	reset_control_deassert(csi2rx->sys_rst);
 
-	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
+	ret = v4l2_subdev_enable_streams(csi2rx->source_subdev,
+					 remote_pad->index, BIT(0));
 	if (ret)
 		goto err_disable_sysclk;
 
@@ -341,6 +350,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 {
+	struct media_pad *remote_pad;
 	unsigned int i;
 	u32 val;
 	int ret;
@@ -369,8 +379,12 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	reset_control_assert(csi2rx->p_rst);
 	clk_disable_unprepare(csi2rx->p_clk);
 
-	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
+	remote_pad = media_pad_remote_pad_first(&csi2rx->pads[CSI2RX_PAD_SINK]);
+	if (!remote_pad ||
+	    v4l2_subdev_disable_streams(csi2rx->source_subdev,
+					remote_pad->index, BIT(0))) {
 		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
+	}
 
 	if (csi2rx->dphy) {
 		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);

-- 
2.43.0


