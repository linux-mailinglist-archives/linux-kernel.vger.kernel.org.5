Return-Path: <linux-kernel+bounces-76425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F485F731
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52911F26979
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09614F1EB;
	Thu, 22 Feb 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CYmtYY5x"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B44D5A5;
	Thu, 22 Feb 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601621; cv=none; b=DFD40M4O3gjBAibccWAEf0oHkyObO4X4hRNWSUtcDg5xDx+KCSznxXD1j+1aIVxeTSDS7+Yo5opMV2MC/WBw3wrY9C/5pcio/tKBttbesaN+IPIH2gYaQufFb3EKbm0DxvUScLmMVWU2R7kICG8E2WTTJSgRb5HfrAAh6r3ZR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601621; c=relaxed/simple;
	bh=OAFyGIfI4QNtZqZsii8PfuhldKXwI8qlEf3a30bhc4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cgbydQEWtel6lBNiwY6asafaVIngrXiUM8buFSVePh3Xfsdb8tX8xOzdBWjhK+KQnsX0HgzXX/SwzGyNStS5F4VyVtE00OzWLnaDPO4mkt0M1IgVNu7g+KlWk2Wp6ni3ferRqZW0+HUEZKMm/mvt9UyNy47E6YaJtIp3DV48cSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CYmtYY5x; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXRN6018078;
	Thu, 22 Feb 2024 05:33:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601607;
	bh=D1JcLO4nEUWK7guThesjK1pDOn36eFgs8+2V3wttK6k=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=CYmtYY5xhJEpgeHqjK8iEU5EeODd4qC7hDav5rv5m2zpcEUtCBC4xwy24wkEEoI6Q
	 Id3pkVxl3WM3kj7uVm4DxDKMe7OmRrgtWj7C4IMO1hTABE6FLjLuRFRle4ITsJRUTV
	 Ffi3ysN0biuDFLy4FY2YIzjlm8v//r1bBBE05qZ8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXQG3059446
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:27 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:26 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXPTo128738;
	Thu, 22 Feb 2024 05:33:26 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:27 +0530
Subject: [PATCH RFC 11/21] media: cadence: csi2rx: add get_frame_desc
 wrapper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-11-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=UVjvXFZDdMcwPLK95L3EAt34fnv5iTWXgWYHYS6GVzQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDkR+ssg4gl30zSyVASKScmFXRmSLcX+zSte
 ZSKKYCvG+GJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw5AAKCRBD3pH5JJpx
 Rd1/EADDcvgw+Hz3E/hhe2SkvFpelMMmoxA0L9R4N5mHIxG4qikx7Nyt+T3bYcs3EK49nj1kD2r
 xfvbGT465MFEjXz3P6Uc/nRHQhuqGB8VpaEtQrlsmCw8jVr/VkDuKeN81CxhizFb/ZFzFuN6yfL
 UzvTYYKVae8EhsYYNVOUO0qat20bpviP6nbRYa9czF7ikD7Lzr3q3RWU4vGd6bqu///pLBub5Jz
 r5Aud8Xv4gbY+V75rJoQS6Eyo2y2rfvzpb7YfK/PvCE5djeM5f2h0WIRAq7Y/PGTYnTdXIfaWAp
 a4XmXNCnAM3r3oIySGHBTd4qS1ossYBgYyjh3/2w5lRa1b3rkxL6/KG6sjpHfyJLRjXkqDV4QO1
 WJ2r9HMdXGXU8Y4UToBrKL/pM8qopVs5vhHgiLP1NVh96UQ9T376ogJue/p+gfJbsyPcqd++AfH
 9LllgBiJPuwkU0I34FhF6OAPdyuuLzJEMppadUvFhVMALWeOok0icDKKoAdVYUBCPmfV+9srtZF
 X1CzfinQEnk5E9CaK1fjTqc4k7XJD0z4N+Ow8jwrB61SRsUChMTIpX7+qQBrWJW7xYKlRNhAXM8
 SeEFfDCy9qDjCIF7MIBD+JmTVFqyxlN0DURi27wBL91GOW7uSK7ly/OJOA4hRaK2FjoysNDt435
 LD8ObJXdme665Rw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Pratyush Yadav <p.yadav@ti.com>

J721E wrapper CSI2RX driver needs to get the frame descriptor from the
source to find out info about virtual channel. This driver itself does
not touch the routing or virtual channels in any way. So simply pass the
descriptor through from the source.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index e19993ed351c..989924dba9a9 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -139,6 +139,21 @@ static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
 	return NULL;
 }
 
+static int csi2rx_get_frame_desc_from_source(struct csi2rx_priv *csi2rx,
+					     struct v4l2_mbus_frame_desc *fd)
+{
+	struct media_pad *remote_pad;
+
+	remote_pad = media_entity_remote_source_pad_unique(&csi2rx->subdev.entity);
+	if (!remote_pad) {
+		dev_err(csi2rx->dev, "No remote pad found for sink\n");
+		return -ENODEV;
+	}
+
+	return v4l2_subdev_call(csi2rx->source_subdev, pad, get_frame_desc,
+				remote_pad->index, fd);
+}
+
 static inline
 struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 {
@@ -470,10 +485,19 @@ static int csi2rx_init_state(struct v4l2_subdev *subdev,
 	return csi2rx_set_fmt(subdev, state, &format);
 }
 
+static int csi2rx_get_frame_desc(struct v4l2_subdev *subdev, unsigned int pad,
+				 struct v4l2_mbus_frame_desc *fd)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return csi2rx_get_frame_desc_from_source(csi2rx, fd);
+}
+
 static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
 	.enum_mbus_code	= csi2rx_enum_mbus_code,
 	.get_fmt	= v4l2_subdev_get_fmt,
 	.set_fmt	= csi2rx_set_fmt,
+	.get_frame_desc = csi2rx_get_frame_desc,
 };
 
 static const struct v4l2_subdev_video_ops csi2rx_video_ops = {

-- 
2.43.0


