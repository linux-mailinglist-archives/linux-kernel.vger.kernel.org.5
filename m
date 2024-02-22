Return-Path: <linux-kernel+bounces-76431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049A85F744
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E26D282A64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54D55E68;
	Thu, 22 Feb 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GGY8q2v0"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB655C06;
	Thu, 22 Feb 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601633; cv=none; b=jZ9mUwUjj6KEhHHzNbfeLv+g3L2gAQIqqopm+AJU4pge2Q+1kfZ5LrgQGEWOIcl7OTw2JKr80MaywUSXoNK8rTFnKw6Wve/3vkaIom1HUk2MZoFYVeItCBK5jEmvRRcFX7WeCroHeyeqHTP4wMA3lE/xwo7k5Ks0JbAVlpZ2j6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601633; c=relaxed/simple;
	bh=H/EkA7/3egmQtAVJ8kpXMhqh9m1rOR7HNqmR3Y2RSMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d8YmUMwbfaKKKeVLjjbG7sQyofVmC3vZAlqgh7noZln12yH+mJuMmGNEOGiDJhJ4MB30/Bxf1FfTKGIUp9Ef6Ffc1YOL9x/UUwo2aESi6lEdMBvR637vijrtyo6tJC7Q98i0RCegf/Pm6SXAPKWJgcyw5Weq5X1b9gnodYBsmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GGY8q2v0; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXcBr112384;
	Thu, 22 Feb 2024 05:33:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601618;
	bh=07yIeWWliUpA8c0qdo5yfrxhS/SYHwPJZKzuICs0MDk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=GGY8q2v0GGG2TdAxW9e0rG32J/zPqicZB+4+qFFiW9SkrEoFIJgEHqBC3PU8Mnt2Q
	 n1/oXVGZ3ud1xPKG0/96j8ZgI2vjf04AG/BPCzgS6Gm+OBHSWFK7BxRB3S/gasVW9I
	 GDkdFcxBC3Urit6919wnDIexCd2B/OzziyowjJBw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXcca057410
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:38 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:38 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXbdV128904;
	Thu, 22 Feb 2024 05:33:37 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:33 +0530
Subject: [PATCH RFC 17/21] SQUASH: media: cadence: csi2rx: Filter streams
 in get_frame_desc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-17-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2358; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=H/EkA7/3egmQtAVJ8kpXMhqh9m1rOR7HNqmR3Y2RSMQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDqTSsc0XQfJv7yVhejPfmWz4ruBmlilBj4D
 RflUnBmTN2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw6gAKCRBD3pH5JJpx
 RfMOD/wNoVMPKXlSXaKalMd1CChxqUuP4eilv37zylz9WI4RyefaWDUee+qinGlvXiedd013HV8
 1LJs0krP7tOoB+X9XMG7znBKcgfxQUru3h2FM+AZ/DMHs9dWRKAP6Zsv1IouC71qSh4TwmorwJd
 nFMhXjHWq6YWIVInl8fsKNtl8/SSDth1AhoEkjQSZ1u53jFxyX56og38chxG1j4c3RWqkgN2MAn
 4YfskgTHc03KdYjbRsB3bijc8yoGsUT5GNtg2du4FnsGdRR8RGFX4g20dHCgfspy6s50Qnh/m1w
 ajUbnTf/uvjEfmEB6ad0uyPfup5oGRAKF4WDJQp1KSkRW43kpcOU0qahPPXztZ+hcuGjnV5H1Qt
 1nFNjwgePaITBeDcHDcIrkhvo5dlOWDys5B4i1ui/TyRBmHFUy1bryK6znl/22XHn1hZrS8bPYS
 gMIvgRTYJcnn9VkTg0YgEGCKpV8ZOdnPou/ncDArYGtst18cZ1Yr9B+hxnVyqNFF1JpnJeewT/Z
 oOM9JeOzJQKMoOHzzzH+VAcycOJhezpVB2B2ZD0TDGKNgRNb9oSCuuhTDBTMPqyNtsOrXOQoAg9
 AUWUn9jSvYOQrMFDK5wp3cKTx0+PHk5dcN/emMeXont7Ogu1ySS3LSup5NHhlM72EfzPB8tC06U
 v/3T11rpsxwTkzQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

With routing and stream-aware APIs support in place, make sure to
propagate frame descriptor information for only the subset of streams
that are routed to the particular source pad.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 50 +++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index f96638b9f252..a0ccdf72a3b2 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -670,8 +670,56 @@ static int csi2rx_get_frame_desc(struct v4l2_subdev *subdev, unsigned int pad,
 				 struct v4l2_mbus_frame_desc *fd)
 {
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	struct v4l2_mbus_frame_desc source_fd = {0};
+	struct v4l2_subdev_route *route;
+	struct v4l2_subdev_state *state;
+	int ret;
+
+	ret = csi2rx_get_frame_desc_from_source(csi2rx, &source_fd);
+	if (ret)
+		return ret;
+
+	fd->type = V4L2_MBUS_FRAME_DESC_TYPE_CSI2;
+
+	state = v4l2_subdev_lock_and_get_active_state(subdev);
+
+	for_each_active_route(&state->routing, route) {
+		struct v4l2_mbus_frame_desc_entry *source_entry = NULL;
+		unsigned int i;
+
+		if (route->source_pad != pad)
+			continue;
+
+		for (i = 0; i < source_fd.num_entries; i++) {
+			if (source_fd.entry[i].stream == route->sink_stream) {
+				source_entry = &source_fd.entry[i];
+				break;
+			}
+		}
+
+		if (!source_entry) {
+			dev_err(csi2rx->dev,
+				"Failed to find stream from source frame desc\n");
+			ret = -EPIPE;
+			goto err_missing_stream;
+		}
 
-	return csi2rx_get_frame_desc_from_source(csi2rx, fd);
+		fd->entry[fd->num_entries].stream = route->source_stream;
+		fd->entry[fd->num_entries].flags = source_entry->flags;
+		fd->entry[fd->num_entries].length = source_entry->length;
+		fd->entry[fd->num_entries].pixelcode = source_entry->pixelcode;
+		fd->entry[fd->num_entries].bus.csi2.vc =
+			source_entry->bus.csi2.vc;
+		fd->entry[fd->num_entries].bus.csi2.dt =
+			source_entry->bus.csi2.dt;
+
+		fd->num_entries++;
+	}
+
+err_missing_stream:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
 }
 
 static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {

-- 
2.43.0


