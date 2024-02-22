Return-Path: <linux-kernel+bounces-76418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE085F71B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB51F24D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E44CB23;
	Thu, 22 Feb 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hxSQijN+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B381383BD;
	Thu, 22 Feb 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601617; cv=none; b=D0a+xoaYkfRC1ETgr78/4hsxpPqpe7X/ODHYDz0Tur1IztlJrS5KsTNo+sOp/bFk9Yx1SNvpReMdogrvBPN6hiB95Ho5R41izTBi+kwPty85e9bpTgfGVhOChPlNOj98NGjjS3h24XZx3F7K1HsRPh1Q0cH3doR7u/aF7z8tujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601617; c=relaxed/simple;
	bh=7KGerdWec5IZppJCBmGQMaaFwKJSklzBgiHvlZ/BodU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nmNIo4+lDb0l/T9zDV+Pj9cnkwv6QSbDwXddqvVQWz41+WpkxP8OnKTDjzIulR7MENhEZfoY2O0Al9PwK7wUjPhQdNOc/PLIuz42ixM98SH8m5Nd0FAPUzjxWvW9d6nGpGzs1fc+pjiivgV/uct6iq5VQxmiIlEvqpF9lFsatoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hxSQijN+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXNbu027801;
	Thu, 22 Feb 2024 05:33:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601603;
	bh=KDTKo8nwJfEk5uEFOup5d3eAQRKj8Rt0pJw7LKWz+J8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=hxSQijN+yyQZ0aq66v/lrtYrCZZ0intct2jQnfoyEe0DNKdTjZDb+qhrk45Wmh2CY
	 sV7sLNf/mzJeGvdsjyQgTSPsZ2hfWVe02bGAH3G3+H1RxerMj3sKWUTeR5O0/STEwE
	 ZwKOA5s9BGILO15sIZYOUCTNzcMk1d/6tEVO6gq8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXNHw059398
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:23 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:22 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXLtH091250;
	Thu, 22 Feb 2024 05:33:22 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:25 +0530
Subject: [PATCH RFC 09/21] SQUASH: media: ti: j721e-csi2rx: Fix link
 validation for multi-stream
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-9-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=7KGerdWec5IZppJCBmGQMaaFwKJSklzBgiHvlZ/BodU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDiLD3CQvkO0R/IE0W3GZS7SvhrPN95twVTF
 ELYQ1rJmbCJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw4gAKCRBD3pH5JJpx
 RSgGD/9CcjtzPAxV9SLZb9MZEOMzgldhbZeZ6bV5XagvDm8qHJl0lCNWTaq9JdFpeeDAfXnPg6H
 ONS/0o4OmOT85zdImrz0kMDUyN4PRLj3WfB1BXS2QM+Z9islSGiQgUdQplrg4G8l6qFvi7pvIp+
 k1RwObyEg/jOo2jQWVqSxGBsxSB7EYttPtuGZBRmhZNgbRfStt4WNFhPzDTyQJilBZOxo50aDwy
 phZW9nNz71WvGcItWvBfKvilD/5zGKhkFSu8iNuOoBXlKXjOTkIwxkmQFPiC9EYV3j4x+ofkQ7x
 CG1MgXPC/px+J6kgDkZNoCVHJp5jHh8hcQhjIwuvrYTtYt6GrzX/KCDbELtpYRZME/UxdyCtOWn
 jPV8qtbIQSSl21jVZMZnPBEx8KquzoKlDyoZzvWOhZmkDdDkJqq+ZoX5wgiBo2wISYUV/bQwF9a
 GTwfe5YPD66r23cnWh7dXLtbAyb//MIgPId4hMOnDhdQZJYUBj4AJa0OzGAZnNu0jjEKDKr3IDF
 h04MCdpcwCThplbHMPJkRVCMaVHdV05XBNHlW6IgK1K/wxfWDpT0FMsd6Cyw2OTUvTwidHzoVvN
 ezxVvYjWD9JWJgjVkZz6gYWC6lAI+HnKuBGkI9im8AzvYFvLKHBUo30/FH2bSwLsEX41yvv9op3
 2nEQLT5lm4H9Jtg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

With the new architecture, multiple video nodes are connected to output
pads of the ticsi2rx subdev. Fix the link validation for such scenarios.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 31 ++++++++++++++--------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 42eb1bff21e2..1443338f4134 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -1133,45 +1133,54 @@ static int ti_csi2rx_link_validate(struct media_link *link)
 	struct v4l2_subdev_format source_fmt = {
 		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
 		.pad	= link->source->index,
+		.stream = 0,
 	};
+	struct v4l2_subdev_state *state;
 	const struct ti_csi2rx_fmt *ti_fmt;
 	int ret;
 
-	ret = v4l2_subdev_call_state_active(&csi->subdev, pad,
-					    get_fmt, &source_fmt);
-	if (ret)
-		return ret;
+	state = v4l2_subdev_lock_and_get_active_state(&csi->subdev);
+	ret = v4l2_subdev_call(&csi->subdev, pad, get_fmt, state, &source_fmt);
+	v4l2_subdev_unlock_state(state);
+
+	if (ret) {
+		dev_dbg(csi->dev,
+			"Skipping validation as no format present on \"%s\":%u:0\n",
+			link->source->entity->name, link->source->index);
+		return 0;
+	}
 
 	if (source_fmt.format.width != csi_fmt->width) {
-		dev_dbg(csi->dev, "Width does not match (source %u, sink %u)\n",
+		dev_err(csi->dev, "Width does not match (source %u, sink %u)\n",
 			source_fmt.format.width, csi_fmt->width);
 		return -EPIPE;
 	}
 
 	if (source_fmt.format.height != csi_fmt->height) {
-		dev_dbg(csi->dev, "Height does not match (source %u, sink %u)\n",
+		dev_err(csi->dev, "Height does not match (source %u, sink %u)\n",
 			source_fmt.format.height, csi_fmt->height);
 		return -EPIPE;
 	}
 
 	if (source_fmt.format.field != csi_fmt->field &&
 	    csi_fmt->field != V4L2_FIELD_NONE) {
-		dev_dbg(csi->dev, "Field does not match (source %u, sink %u)\n",
+		dev_err(csi->dev, "Field does not match (source %u, sink %u)\n",
 			source_fmt.format.field, csi_fmt->field);
 		return -EPIPE;
 	}
 
 	ti_fmt = find_format_by_code(source_fmt.format.code);
 	if (!ti_fmt) {
-		dev_dbg(csi->dev, "Media bus format 0x%x not supported\n",
+		dev_err(csi->dev, "Media bus format 0x%x not supported\n",
 			source_fmt.format.code);
 		return -EPIPE;
 	}
 
 	if (ti_fmt->fourcc != csi_fmt->pixelformat) {
-		dev_dbg(csi->dev,
-			"Cannot transform source fmt 0x%x to sink fmt 0x%x\n",
-			ti_fmt->fourcc, csi_fmt->pixelformat);
+		dev_err(csi->dev,
+			"Cannot transform \"%s\":%u format %p4cc to %p4cc\n",
+			link->source->entity->name, link->source->index,
+			&ti_fmt->fourcc, &csi_fmt->pixelformat);
 		return -EPIPE;
 	}
 

-- 
2.43.0


