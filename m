Return-Path: <linux-kernel+bounces-76428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D885F73B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4FA1C22229
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361235337C;
	Thu, 22 Feb 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xvc2EISI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599F4F8AB;
	Thu, 22 Feb 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601626; cv=none; b=o/uWHpbomxqb9MDkg16vXjj1dJnJ0wAq8Ib/Rt4TAkXeQ6WXqVTi9LgtJd4EbdnIM7nKeg6/SdjPChvi9ghzeb73ErlYefj0ilDxhZuN6FnrQ1+c7LYteufVm43oGt4uIQbo2GKEIz+i8GSwQOdFyqXL1d3o8FpV47jdegocvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601626; c=relaxed/simple;
	bh=zIYkGYnREr2zzxvatff2YEHLJNp39GM3nN7mI+RemYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FsQY6msa5zsP2T30SW/Ejh5tuqtBL6OSUdiL/K/1iJ1YeCuyIMpxqTnz+XkBT8obpx1DEQMg5mvyP8pluu1Oe+23UEGw9HLwq5Oqcg92JWVKpOY5xv+QGG9me+desdAPkrmv6xqXuyuJsPnQn8TnW9/0Ly7c0o6Sd/DH0ah76p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xvc2EISI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXTGS112348;
	Thu, 22 Feb 2024 05:33:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601609;
	bh=a6u0dz7gnMTNjGZgYfZ5DagZDymNpTJ3M4uXSorQvAI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xvc2EISI80L264m4N2znCp3A/oYtzuBcqiipOacZWRpcpsIN7rpFOx1GVtOtjeC/u
	 h18f9gCpd1smoAbX7q9HVhfNRoyHbDkDvezkMj4/Mvwcd9j6NbNl/cbJXahUianto9
	 0VgdGgjxjqB7Qcl5XAuY5Bpw0fwPZSK1J7ZfQYpU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXScO007723
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:29 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:28 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXR4H091345;
	Thu, 22 Feb 2024 05:33:27 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:28 +0530
Subject: [PATCH RFC 12/21] media: ti: j721e-csi2rx: add support for
 processing virtual channels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-12-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=zIYkGYnREr2zzxvatff2YEHLJNp39GM3nN7mI+RemYU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDlbvmJ1PmuUHzer1GkCJIG2CYbiEmT4z5Td
 O1M2a8KaMaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw5QAKCRBD3pH5JJpx
 Rer/D/49xcRPEH/+G2XwYPjXH3qi31OHduruGlQu7oDxKSUZjUEaTUuQlLaVYEThPnpT+XXrrrm
 W0dbsgL/8AmeAHD4C7shTgoGbBwPmpUJaY+6Xq/dSWKXLKC6zymSjWsSUennxEbCc8aaHuOcSQP
 v/g8mmR8RZu8LTOsqQVC1BSMuRJLhmihG6b4ijRhPV+ovMYgwMBsAxHEEBfNaTWl0YAjPTB+FJl
 qEaxjoSnXQ0e/gyh77ywfi+WogcX7DojMjEaT9VKuiVYqnSbwMprmd2HneO93Ib+24hR+omqRnW
 T71QFFQC3TIoewJp9AoE36mq6Lmhes7oj/LZ597cxD57R8fs4WSo3DvPbx9wWbEdm6tETpFc4Ly
 iBxJTrbkTdwctXlEkjTsclaG87/VomivJbtJDVeMe5rggId+cvYZPeCqd6wv4us1F6HwDsDyJHM
 KhuESWYbcZeipK8y1Twh9zCcgtwgJvRdfMf3kOp6oHUsON1W5Iss0RvCoU9aNyTG0uVHwh48Gcv
 rDsw9FKZPRgY8IuNPrmt3EDNFnqhM790peE2PZ7sEQaBoYMBJkJfeCs7CLRTJyeOG+ySUI8fyxe
 1mfwCNqQt1za8F8nbHKPWshx/7/cVmHcHg+R+iSIl06+HBiF4lSKYIg3O+bGedOA8NVZReRao9X
 YtAbIl1jxAWmWOQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use get_frame_desc() to get the frame desc from the connected source,
and use the provided virtual channel instead of hardcoded one.

get_frame_desc() works per stream, but as we don't support multiple
streams yet, we will just always use stream 0. If the source doesn't
support get_frame_desc(), fall back to the previous method of always
capturing virtual channel 0.

Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index f6045888eed0..4be8a306ac1f 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -29,6 +29,7 @@
 #define SHIM_DMACNTX_EN			BIT(31)
 #define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
 #define SHIM_DMACNTX_SIZE		GENMASK(21, 20)
+#define SHIM_DMACNTX_VC			GENMASK(9, 6)
 #define SHIM_DMACNTX_FMT		GENMASK(5, 0)
 #define SHIM_DMACNTX_YUV422_MODE_11	3
 #define SHIM_DMACNTX_SIZE_8		0
@@ -105,6 +106,8 @@ struct ti_csi2rx_ctx {
 	struct media_pad		pad;
 	u32				sequence;
 	u32				idx;
+	u32				vc;
+	u32				stream;
 };
 
 struct ti_csi2rx_dev {
@@ -595,6 +598,7 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 	}
 
 	reg |= FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
+	reg |= FIELD_PREP(SHIM_DMACNTX_VC, ctx->vc);
 
 	writel(reg, csi->shim + SHIM_DMACNTX(ctx->idx));
 
@@ -868,6 +872,33 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 	}
 }
 
+static int ti_csi2rx_get_vc(struct ti_csi2rx_ctx *ctx)
+{
+	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct v4l2_mbus_frame_desc fd;
+	struct media_pad *pad;
+	int ret, i;
+
+	pad = media_entity_remote_pad_unique(&csi->subdev.entity, MEDIA_PAD_FL_SOURCE);
+	if (!pad)
+		return -ENODEV;
+
+	ret = v4l2_subdev_call(csi->source, pad, get_frame_desc, pad->index,
+			       &fd);
+	if (ret)
+		return ret;
+
+	if (fd.type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2)
+		return -EINVAL;
+
+	for (i = 0; i < fd.num_entries; i++) {
+		if (ctx->stream == fd.entry[i].stream)
+			return fd.entry[i].bus.csi2.vc;
+	}
+
+	return -ENODEV;
+}
+
 static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vq);
@@ -888,6 +919,14 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret)
 		goto err;
 
+	ret = ti_csi2rx_get_vc(ctx);
+	if (ret == -ENOIOCTLCMD)
+		ctx->vc = 0;
+	else if (ret < 0)
+		goto err;
+	else
+		ctx->vc = ret;
+
 	ti_csi2rx_setup_shim(ctx);
 
 	ctx->sequence = 0;

-- 
2.43.0


