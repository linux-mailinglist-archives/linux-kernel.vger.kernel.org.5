Return-Path: <linux-kernel+bounces-131423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C68987AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1705028E001
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D01311B1;
	Thu,  4 Apr 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPAB7fSr"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8A126F2A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233628; cv=none; b=EAAe6efHn+h0XF6MWw2+At+/qAog5t5yDzo+2syIiz+yTW5Am77H6fp72aPfiwCVfVKmIft3ugqpuOFiSCJex3J4Sy1tLsnHVYngSXPjWRPwIKzoIHtUWIcfRdU1R9s6eaAng7GWNvEWe0SlXOJ80dYTHVhIJXNrvPvmuyXPbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233628; c=relaxed/simple;
	bh=j9cqp4SjYW9U7WgZ0V/m18CHVeS7hsHpCyHSSMK1LiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZUXpdEnJn9sTN8SQfS6K9PH+d+eEpoueYQLo/pzH+sg3LOuQvO+FUdxY32EEdV0kWvj04DmX2AVilFV/c4YSipfYhnu2czPaVij1f2zys3GmqoCH1oadKrRrdStPSnzEg74Jzh+qrK70J+xwZhjyys85ksuWC9AwolyxO9TygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YPAB7fSr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ddd1624beso509964f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233624; x=1712838424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8M8yJjJuvMId3GZYZjS1l/TGkga5FhjqBUO4vnkd2U=;
        b=YPAB7fSrUcV0N8QmAbhAt5eNLqlDfqSZ/b+DA/N996tJpdVLQVxbcaksHQ6y/o0YdI
         g33VQUJZoM8JbRwy/I4nzG91j33Z/wxBWrrExjSDMFln2VPnl8WiPWdA86LtPZIQZJ7Z
         KmhYZBN8HN+WSNWoqOSEBoQ/GYh9gSmCHUd11orypQr/VrMwKxpB1G5ZjAPVoLf3L7Ym
         Uhje9iWDultzBVmIKjJLa8ESUfBoeCoyY6ooce1p+uJwgd58s/g1FNG6U9Yr7gfdVm8f
         2TT/ifpq0Vbp/L8cQB4NlKImLP/5aXcH27vsm/CPRjdQQezhxTchIG97YVM1j0pLMQr1
         wf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233624; x=1712838424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8M8yJjJuvMId3GZYZjS1l/TGkga5FhjqBUO4vnkd2U=;
        b=nCdoTgpNyN9oFoaec6Qc6AP5ytPtXI8q4mZA88pC4q12ktfeJ6KYaKIfI0nnYsnP19
         4LkLaIRkNvyLuMLP8OKiDJIjIvg31gTZVYPnrpAl8B90uyyxR67xTnLC3oZ/OoE57pXX
         Onm7yavpHBJlXBFN4cI4gUJPt+NYF+QIg359NyCOzX8Cfn1SHhMIQQatQeTBFr4KLFRE
         22MAAfa0efhXfPsA7ZFF3HnTtnSqDs7AxpEvN7eiM0NcRTkrKw9zzKu3Ru5rcJ+oJHSH
         Juq3hfj1BBnDv5noJFL/KWYCebsP9Q3LMaDijTp+xs/AR0LmBgJad2VdOcnTor9TcJNm
         ymGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSyJEOFJkLqnnGeVeuRvpZJFLfz1GkU7jXK0+M2gz56dqx/cs+D60cVKX3kUNjIV29zlB76AydzVeyBe2AP44cb5x/CYY8M/tELfaS
X-Gm-Message-State: AOJu0YwWDTF7Oth3BP19K0nEMCUB24iepc8SCLsDSC29Kb1QEvaieaCO
	G9OoakiDQSAmyyoXDGyLQZIZSZww9MnnExsmhYdwg7IkgtYh8c2HVhcyXDo/y7s=
X-Google-Smtp-Source: AGHT+IEexjP4B7taUG1Uny4tFgGyVFyyDBsJMVaOWIrgfE/nQ60oagnYHJl04Il3/SGN/3eIZeAILg==
X-Received: by 2002:adf:ee90:0:b0:343:83a8:96e with SMTP id b16-20020adfee90000000b0034383a8096emr2374666wro.8.1712233624515;
        Thu, 04 Apr 2024 05:27:04 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:27:03 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 09/17] phy: samsung-ufs: use exynos_get_pmu_regmap_by_phandle() to obtain PMU regmap
Date: Thu,  4 Apr 2024 13:25:51 +0100
Message-ID: <20240404122559.898930-10-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows us to obtain a PMU regmap that is created by the exynos-pmu
driver. Platforms such as gs101 require exynos-pmu created regmap to
issue SMC calls for PMU register accesses. Existing platforms still get
a MMIO regmap as before.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 183c88e3d1ec..c567efafc30f 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -18,6 +18,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
 #include "phy-samsung-ufs.h"
 
@@ -255,8 +256,8 @@ static int samsung_ufs_phy_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	phy->reg_pmu = syscon_regmap_lookup_by_phandle(
-				dev->of_node, "samsung,pmu-syscon");
+	phy->reg_pmu = exynos_get_pmu_regmap_by_phandle(dev->of_node,
+							"samsung,pmu-syscon");
 	if (IS_ERR(phy->reg_pmu)) {
 		err = PTR_ERR(phy->reg_pmu);
 		dev_err(dev, "failed syscon remap for pmu\n");
-- 
2.44.0.478.gd926399ef9-goog


