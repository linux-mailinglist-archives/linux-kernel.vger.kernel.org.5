Return-Path: <linux-kernel+bounces-55129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC7384B818
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A8528E4F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D1A13341D;
	Tue,  6 Feb 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pIO21g6D"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2245132C39
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230284; cv=none; b=rcR9qKx7qbtVtXk8P7W6DjLXNMggrqtK++xT6r6sNLz27TVf4c9ZRMNhKpAfi0uEmElJsbSW9JE4jUcqFpb7OpaGadMFaME+GEONNeHTLv6KF2F+7g5yX5Y0J4BEHn4Je1/IrEVuGwMySwQ+8L7xzaCgwJwOiYpikhQezIaAjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230284; c=relaxed/simple;
	bh=JSA+JTxZwyy4vGSW5/N+RDxQNtaOg/Fg9ZTWoKkSIvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+ar8OTcENLCKvEgj4wWaOzGWbaHNlyIoroiZw6ShCtqTTZ+0+IXfERX9VJ33PZY2FyoEgMqGsO+eH7aZJlvuYpoCrV6+FeqKcFkKPENZikngjXULmDvLrHYgn5OBIHeWFkdTpjqI9I6fSi68K90c3mOwMg3m1ERKxqHOYDHS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pIO21g6D; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51025cafb51so8430704e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707230281; x=1707835081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W+bhvv0j8yck+8GT/uP++ViHHwBweYBoHrSumeE15A=;
        b=pIO21g6DwTfnp6YimaXLBSBWFgadK8O8cYB0d+aV717JRS0dMUkeLY2zox8sO4Gikd
         a3gaHeV1QQTrGP2AcfTR8B9IU4geZoY/Lac0et8y0FhojuOxTqY2U5gCGsIZaJc/XQU2
         wlIRmZ7hj6riSBhLSNaC3NN0MWYk/UuYC9u0lp64r2+cU0lMKBobusfCy9NVUYR6I1qa
         vbeZJGsd4Zd4RgRArCfWuo5JKhLqx/kxYUVHDkiGGO/y1zclvEkYmiHAqnVch2YQxrLX
         V1fSEbwI6zxztIb4obKvK8mtDBKPP3NreSCrrGL19ZOlNE5lsOXIeGUwvPKvuPNM+JuQ
         Kd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230281; x=1707835081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W+bhvv0j8yck+8GT/uP++ViHHwBweYBoHrSumeE15A=;
        b=A3KUqDh0UUFLDwk4T87JTibf8eMV1o9lkAk0NSXGiIETyvqROXKiLsP9l+g2o9qKQl
         4RiNRRPTLyIATbKvUn2huyU4hd1WsEAQ8VrurQ71NQBPMrf3Pvr6ITCp195d1ttCJhri
         fR1bVERHKQPj9NFM70fehufJsDPgEKF5ojZHaqfHcSb+leVd4gLYEaYuhNs7jmsw8swc
         yXOpQXbGUlyuE7lEV6bc7OyKpyUzIeeylxaN48spnlGkXCU5YsUatoPB4WN+Qj/Keb4l
         HESmijJq0qT3B7rhQdJmEd+q+i91kYsw8iFDOLT9FoXOa4LrBXcj/HVdLMsYdTjxpcPB
         Z9Jg==
X-Gm-Message-State: AOJu0YzBET5DDOj1qFD7Bbh5xqhhuSRchp82H5PdDy5QOHRTO/KfNtxf
	ZX9kQhyYEjsV8PMdH08+w6srDB5Ak7j9XPMAFUBqMvR/hYVmouMw4u8Y63CtQNw=
X-Google-Smtp-Source: AGHT+IFq40p5PGRZgK2PDID88ekIhXGdOYju/iR3pvUeF7F3dzHYw/J6u+QgBb2DegU7Af/HkHjnCw==
X-Received: by 2002:a05:6512:31c7:b0:511:54e8:b82e with SMTP id j7-20020a05651231c700b0051154e8b82emr2165876lfe.47.1707230280818;
        Tue, 06 Feb 2024 06:38:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWA4bduWkPXsrwXkvP0AHmjMJ9kVUsar3ZVfJ6PAFzztWBt2XGLA/HzTQ6kKQA2T2M0Vz3Tvtm9r4I1EInMLHaOwmsXzoXCHER82pTbiprCITW7TUc/O+baBK0j3xcC7EgLztJSgxkqxbKHFq42s2O8XnO9xWIfiJws9S1IRFCGb4LeYD+TNSOpTtuEihJAiPrWAGEWgcn7PhGGQdOKheWHIJGGHxMkc5hLlbr/3X0TWkGLbIlFkJrSu6f+vWYZ1sbX/ZWiJB1grXNb2xwWroT1eR2lN0WY5o3Wd/fPj2NOePxj572MJUiNU6PI1Gf/ASEYH14JsZRfsyHelKP/KFfKkT0QHAlPKTK3xJBcwbsWiRFeN0UVsm7riXT/P8shLWjTVmssYHVIJJIObse8UfoeZyNuMXBQCLHsQxUbkTXlUB4jjQb8
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709062c1600b00a37585d5dcesm1224418ejh.51.2024.02.06.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:38:00 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 3/4] soc: ti: k3-socinfo: Add support for nvmem cells
Date: Tue,  6 Feb 2024 15:37:10 +0100
Message-ID: <20240206143711.2410135-4-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206143711.2410135-1-msp@baylibre.com>
References: <20240206143711.2410135-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support nvmem cells to retrieve chip variant, part number and
manufacturer. As multiple different devices depend on these information
it is cleaner to abstract efuse fields with nvmem cells.

If chipvariant nvmem cell is found, the driver assumes nvmem cells are
being used and tries to find the other fields as well. If it can't find
'chipvariant' it will try to create a regmap.

Some prints had to be updated as I don't read the full jtagid anymore.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Andrew Davis <afd@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 67 +++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 59101bf7cf23..99794aeb6206 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mfd/syscon.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/regmap.h>
@@ -114,45 +115,68 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	u32 partno_id;
 	u32 variant;
-	u32 jtag_id;
 	u32 mfg;
 	int ret;
 
-	regmap = device_node_to_regmap(node);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
-	ret = regmap_read(regmap, CTRLMMR_WKUP_JTAGID_REG, &jtag_id);
-	if (ret < 0)
-		return ret;
-
-	mfg = (jtag_id & CTRLMMR_WKUP_JTAGID_MFG_MASK) >>
-	       CTRLMMR_WKUP_JTAGID_MFG_SHIFT;
+	ret = nvmem_cell_read_u32(dev, "chipvariant", &variant);
+	if (ret && ret != -ENOENT)
+		return dev_err_probe(dev, ret,
+				     "Failed to read nvmem cell 'chipvariant': %pe",
+				     ERR_PTR(ret));
+
+	if (ret != -ENOENT) {
+		ret = nvmem_cell_read_u32(dev, "chippartno", &partno_id);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read nvmem cell 'chippartno': %pe",
+					     ERR_PTR(ret));
+
+		ret = nvmem_cell_read_u32(dev, "chipmanufacturer", &mfg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read nvmem cell 'chipmanufacturer': %pe",
+					     ERR_PTR(ret));
+	} else {
+		u32 jtag_id;
+
+		regmap = device_node_to_regmap(node);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+
+		ret = regmap_read(regmap, CTRLMMR_WKUP_JTAGID_REG, &jtag_id);
+		if (ret < 0)
+			return ret;
+
+		mfg = (jtag_id & CTRLMMR_WKUP_JTAGID_MFG_MASK) >>
+		       CTRLMMR_WKUP_JTAGID_MFG_SHIFT;
+
+		variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
+			  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
+
+		partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
+			 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
+	}
 
 	if (mfg != CTRLMMR_WKUP_JTAGID_MFG_TI) {
 		dev_err(dev, "Invalid MFG SoC\n");
 		return -ENODEV;
 	}
 
-	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
-		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
-
-	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
-		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
-
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
 	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
 	if (ret) {
-		dev_err(dev, "Unknown SoC JTAGID[0x%08X]: %d\n", jtag_id, ret);
+		dev_err(dev, "Unknown SoC JTAGID[variant=0x%X, partno=0x%X]: %d\n",
+			variant, partno_id, ret);
 		goto err;
 	}
 
 	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
 	if (ret) {
-		dev_err(dev, "Unknown SoC SR[0x%08X]: %d\n", jtag_id, ret);
+		dev_err(dev, "Unknown SoC SR[variant=0x%X, partno=0x%X]: %d\n",
+			variant, partno_id, ret);
 		goto err;
 	}
 
@@ -166,9 +190,10 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 		goto err_free_rev;
 	}
 
-	dev_info(dev, "Family:%s rev:%s JTAGID[0x%08x] Detected\n",
+	dev_info(dev, "Family:%s rev:%s JTAGID[variant=0x%X, partno=0x%X] Detected\n",
 		 soc_dev_attr->family,
-		 soc_dev_attr->revision, jtag_id);
+		 soc_dev_attr->revision,
+		 variant, partno_id);
 
 	return 0;
 
-- 
2.43.0


