Return-Path: <linux-kernel+bounces-79602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851478624A4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250BE1F225E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ED03CF42;
	Sat, 24 Feb 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJsmIfSs"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7152941B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775052; cv=none; b=BtOcEpUstqNSvDw5iBxY8RRsao4N8rLlDpU8nf0FP7q2tWDZ05XdbnffVV1VAt7flM9Vy33qm5j7O3dca66U1/k8u9pxcoL16eiNH/YZgTXaQy4RTK1RjgFSMa7FRFDSi1d7pNDR5mL9hgPrWfWuyqhTvLJr5yPS4gKSsAtG5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775052; c=relaxed/simple;
	bh=z63TB4+Z27D+t/m2JEWvedrUJxpwVqty8LoTRrbcYEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qoqtsMmSPoyYfOD0Es39/g71/uuyeaGGxBLUXfdr28vZwK7/AcKrSj/WRx8SLPSfiX24A99zmvfoWwjC84VMoWX6UaxpGf/EDkWG3Vp19VuC9Tt/Z9xOEyZIx1y2TjpRKaKlIg7Jw4iIn30eGddQoByHS7vPH9tp+ZOr1ofWEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJsmIfSs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so198749466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775049; x=1709379849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m710Yr54pAqk+KA2CTzSDFkc4Ow3kHnnG8+DYf4F/A=;
        b=vJsmIfSscncJt5rwTLZ4Yb4Qr73VACk9q02CUJtov7BM64FbeyUmLx4ExaI4aXbVEk
         oFO0vOVNkAZOxhM7+RA+yu8A+XJVXF/ZNzWenzOpNIzhzr7s7fj5jKWYoc15P0Z25foz
         Bb90VyoVeTmMjPoTcsNYXNM2hyowoPtpdnmbhoBEGijXnOupuDFpAjOqvdHh5IHoWFem
         3XUZBpxWM+RdAHchjvXrPf9C7XdlnNGBNLNkc7ztaghJE/cl0etUSZoTSKdWGa4SDY5G
         6g/Ex+oUbWk3+c0nYAu39qWu+aYoWbyBSpXo/lpG12tTcHoC8boXPFmP+euErF+ZdlzS
         Kchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775049; x=1709379849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m710Yr54pAqk+KA2CTzSDFkc4Ow3kHnnG8+DYf4F/A=;
        b=mzPmz1s8P9Lec+IRWeTGftrYH0gmt+62nq/GIwCBokn+hHQa1oUcI/70TYYNeTk/Wa
         /sgsYIH3CUbzgztpixfTPSUgwCk3sgDVvXebRvgq8tu5WFTyZedlS1EZQj3ikegwaFa9
         6OG2iNBsIbuiazPTlOmcX3jECn3w3E9lMZh7sWmi8yYhFYQ6FfWOrOSC9bSNcYIGvVNc
         S4NsRopuPts4/Jvg3yShYUsOwQMANU/TVMjQrqG+0jejUxFNo12BUR88riD9FJvuQ2en
         ZiQYP6quE2HU5eTCe5R3ubyOSCGY1Eho3ivj4gogyJ5VYjyWvbMKuYnJmATVGOrDHMF1
         0/og==
X-Gm-Message-State: AOJu0YxHmQ3gbSgQLtYWPaNOohphrzPUfKYf1jzJHHbtNQxwTE9IhsVG
	s/s4MgSrh9grE64OPLgF6QTc/XgY6M/W2eUwu6byXo9xhQ5Cm2lb7YhrD07MOKa9pHDwN5xJ9xn
	8
X-Google-Smtp-Source: AGHT+IFUAAFXk5dHXQt8vmNLhgaPI41rqwHX/1B2RpBtzh0g68/n8AitYWpoAJZiu51cH24x/nNdvg==
X-Received: by 2002:a17:906:bc4d:b0:a40:189d:c5be with SMTP id s13-20020a170906bc4d00b00a40189dc5bemr1499486ejv.11.1708775049332;
        Sat, 24 Feb 2024 03:44:09 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709060a9000b00a3fc12516aasm510734ejf.217.2024.02.24.03.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:44:08 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] slimbus: core: make slimbus_bus const
Date: Sat, 24 Feb 2024 11:44:03 +0000
Message-Id: <20240224114403.86230-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114403.86230-1-srinivas.kandagatla@linaro.org>
References: <20240224114403.86230-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=1Kud+WzkaKmhAQRDjL8WCrIP5bxl7s1/NrswjM1Ntw4=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2daDhlACMiKpQ8tIqDTZeX+odeTzg8aiKD1Va Z7sNOnu8sqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWgwAKCRB6of1ZxzRV N4SpB/0Vn0m+XeMiSOlNFhDWWZYw/95ycjo6uH+1C4m+zLGCzOITacrxODClqRVrdeVducvYDdZ 3HhdBu+GhykONF+9DZWWDqaOs5QcoB12Oc+ywK5E+1Su2MNsNJjI4t1nxXJkfxxpvRRBQImNpdF TWHY7uI3QsgDshWyQrg1U1kY9hKcvBTmH8FUog2DAgqeGlQuJqrOfrarLer4T7UtWquvTZpwAMh n2iU7MtSCkxA+3Xqm1MqUuGTGaDny10SIBSHkasHsLTE1IjehgVpwqMhTlOhqs00+WeZY3s+W8V YE2AXI61kG9h2BF9SYtF9Nfe8/jlRIPP1OEwolVXX+aHSCfZ
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the slimbus_bus variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c  | 2 +-
 include/linux/slimbus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index d43873bb5fe6..375218e02e28 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -100,7 +100,7 @@ static int slim_device_uevent(const struct device *dev, struct kobj_uevent_env *
 	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
 }
 
-struct bus_type slimbus_bus = {
+const struct bus_type slimbus_bus = {
 	.name		= "slimbus",
 	.match		= slim_device_match,
 	.probe		= slim_device_probe,
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index 12c9719b2a55..3042385b7b40 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/mod_devicetable.h>
 
-extern struct bus_type slimbus_bus;
+extern const struct bus_type slimbus_bus;
 
 /**
  * struct slim_eaddr - Enumeration address for a SLIMbus device
-- 
2.25.1


