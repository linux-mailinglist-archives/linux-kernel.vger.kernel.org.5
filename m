Return-Path: <linux-kernel+bounces-76434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD47685F750
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D56D1C23690
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA057310;
	Thu, 22 Feb 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y1j/mfEO"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0756455;
	Thu, 22 Feb 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601639; cv=none; b=JvhVGLaKDVHlbXqJxXZZ4J8jQ27GhUOLpeXcg3Bkayn2Rgb53sY8ZbLCp3xJ65yspZi8iDgkPYJtzr7j8lYD9q2zoONVgDvv/tRH+ccCLkllnkQpDYMV+2Fmn7Racjbj8DHu89SxgkEd16OONIUt143vsQKeZRhaC+1mgtO9Vlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601639; c=relaxed/simple;
	bh=atXyNk7GB+hJTN0fsQot5GwC/uENkkECLZRLShv8k+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lcK4vcQKMv9k2FxAXBIgkGK2xV4QnAZERr9wfBFEOCXyM6ovh4e3LB4FVc3Ke3x/0t2+WEtdEFPfHuNW60AbghsvL10Vox1SCOGoxPL0jBheLBuHt9K0Pir7Zb7hpdwOHq6AmQqQ6nwWAeo4MjbdDtdA5QiPr+CQnR2ic37+n50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y1j/mfEO; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXgtJ059188;
	Thu, 22 Feb 2024 05:33:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601622;
	bh=/i5M1vv4BeDdGkOVkUnx+Hn/FIm8GsBXtMFZcAlL/os=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=Y1j/mfEO+3HvAox0QNPTQ/exhwgRQzS4J8ZxruB2AWbEIfXbrXHyNFXL/1YsCCN6d
	 QxFKWPC4mbLQsoVt0WuQmPSctHRD7R15myyt1NI1XStnvwCwjJCAaYhmKmtDB0HpQM
	 gwy0F4yIsRRZp7w6WBHoGt+Dyww3UpPovnrj/ZBM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXgEV014411
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:42 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:42 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXfFr091559;
	Thu, 22 Feb 2024 05:33:41 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:35 +0530
Subject: [PATCH RFC 19/21] SQUASH: media: ti: j721e-csi2rx: Enable
 per-stream controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-19-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4259; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=atXyNk7GB+hJTN0fsQot5GwC/uENkkECLZRLShv8k+I=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDspQ0qdgETFHF001RaowVVFDW+jd5UTTuLk
 tihlIECxAKJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw7AAKCRBD3pH5JJpx
 RV5GD/9wmuxokjgrkDCLH9qrTkzz1CdmlgTUYvg+3/n7gSkq0Hi/N29wErDzPMvvmj2LUcPU0fQ
 CwL+UOFYxCl2hID0WOFVvkklcoaXK0NC1V9ccT1METHPpK9/impOl5M4JqiJZTl8hoZetU8i1Ii
 7Zq18Fn0IThRVPNHoCajGshkMcmP3twUlNGWRZGGawaVh+dBYfxo9hjgwHPvZhBNvYzQsWVwesm
 bTt2goc3J0UmEc7Yw8g3CbAZzUwHJMswXHKfTRR5RUzJF+Cf/tptSj3G9Mt6PadsrfmhUpTbSDb
 8K8LGf0TJDbeWsnpGIaoRrG3xvKKOlImpIfAmm05/JgTrbgYXujD0bed9t9I7nrlNsCAbBBJH2E
 mfnfZ/r1y/ClFYs0zUVf7NgKTtPXxV9jlXI4XmuXzyUNKak7LufPtFu1urP0tltGIOyoHynB3D2
 fSUzuZ+ux2YNTQByORtWh5UhqhgJ9uI7lpA4gwEZNxJHg8zuo2fTrQf+WamlDpSpMB8vvuVBw2Q
 WNFsBij1VDwJ/f6X4UM3U87119FuAN1dfZlgUAhtLxJ1t6Lhy8SbfGJyET6gfCdb8xJqs0IO1w2
 278RgxZMilq9Ksv0dOlXfPd+Mkt/CY/S7cefYEPRlQuJpAyIK9sjnd8B7iO1ynEihV4mVe0bvy2
 YtF062WkPh6pkNQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the new enable_streams() APIs to start/stop individual streams on
the connected subdev when capture is initiated on the corresponding v4l2
device.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 78 ++++++++++++++--------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index b33681e1e2db..c2d47507b3a7 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -983,7 +983,9 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	dma->state = TI_CSI2RX_DMA_ACTIVE;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
-	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 1);
+	ret = v4l2_subdev_enable_streams(&csi->subdev,
+					 TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
+					 BIT(0));
 	if (ret)
 		goto err_dma;
 
@@ -1011,7 +1013,10 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 
-	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 0);
+	ret = v4l2_subdev_disable_streams(&csi->subdev,
+					  TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
+					  BIT(0));
+
 	if (ret)
 		dev_err(csi->dev, "Failed to stop subdev stream\n");
 
@@ -1126,36 +1131,60 @@ static int ti_csi2rx_sd_init_state(struct v4l2_subdev *sd,
 	return _ti_csi2rx_sd_set_routing(sd, state, &routing);
 }
 
-static int ti_csi2rx_sd_s_stream(struct v4l2_subdev *sd, int enable)
+static int ti_csi2rx_sd_enable_streams(struct v4l2_subdev *sd,
+				       struct v4l2_subdev_state *state,
+				       u32 pad, u64 streams_mask)
 {
 	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
+	struct media_pad *remote_pad;
+	u64 sink_streams;
 	int ret = 0;
 
-	mutex_lock(&csi->mutex);
+	remote_pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
+	if (!remote_pad)
+		return -ENODEV;
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       TI_CSI2RX_PAD_SINK,
+						       &streams_mask);
 
-	if (enable) {
-		if (csi->enable_count > 0) {
-			csi->enable_count++;
-			goto out;
-		}
+	ret = v4l2_subdev_enable_streams(csi->source, remote_pad->index,
+					 sink_streams);
+	if (ret)
+		return ret;
 
-		ret = v4l2_subdev_call(csi->source, video, s_stream, 1);
-		if (ret)
-			goto out;
+	mutex_lock(&csi->mutex);
+	csi->enable_count++;
+	mutex_unlock(&csi->mutex);
 
-		csi->enable_count++;
-	} else {
-		if (csi->enable_count == 0) {
-			ret = -EINVAL;
-			goto out;
-		}
+	return 0;
+}
+
+static int ti_csi2rx_sd_disable_streams(struct v4l2_subdev *sd,
+					struct v4l2_subdev_state *state,
+					u32 pad, u64 streams_mask)
+{
+	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
+	struct media_pad *remote_pad;
+	u64 sink_streams;
+	int ret = 0;
 
-		if (--csi->enable_count > 0)
-			goto out;
+	remote_pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
+	if (!remote_pad)
+		return -ENODEV;
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       TI_CSI2RX_PAD_SINK,
+						       &streams_mask);
 
-		ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
+	mutex_lock(&csi->mutex);
+	if (csi->enable_count == 0) {
+		ret = -EINVAL;
+		goto out;
 	}
 
+	ret = v4l2_subdev_disable_streams(csi->source, remote_pad->index,
+					  sink_streams);
+	if (!ret)
+		--csi->enable_count;
 out:
 	mutex_unlock(&csi->mutex);
 	return ret;
@@ -1165,14 +1194,11 @@ static const struct v4l2_subdev_pad_ops ti_csi2rx_subdev_pad_ops = {
 	.set_routing = ti_csi2rx_sd_set_routing,
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ti_csi2rx_sd_set_fmt,
-};
-
-static const struct v4l2_subdev_video_ops ti_csi2rx_subdev_video_ops = {
-	.s_stream = ti_csi2rx_sd_s_stream,
+	.enable_streams = ti_csi2rx_sd_enable_streams,
+	.disable_streams = ti_csi2rx_sd_disable_streams,
 };
 
 static const struct v4l2_subdev_ops ti_csi2rx_subdev_ops = {
-	.video = &ti_csi2rx_subdev_video_ops,
 	.pad = &ti_csi2rx_subdev_pad_ops,
 };
 

-- 
2.43.0


