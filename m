Return-Path: <linux-kernel+bounces-33741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C269836E02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2D71C23C64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02184481DB;
	Mon, 22 Jan 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="NzcAb2+U"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E44655B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943090; cv=none; b=Yu9GCSItQeS9wEcLJE99JhKE2bYiNAMprFVhoxVlJbxx6WahtelouegNoxDpBMdD2OY3ZXjY0qaNEZOeVpmizi53rbnpOxm/d1iG7V8Rh9U7xtU7FFEb2al0j0c9oFxMxuAiZd3YstoMSMxuQYYkfKQPnczqsCmIDOd7egJlCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943090; c=relaxed/simple;
	bh=+YlbBFs1br67U/+bf1Vk+lMHJ6zJydlsiLkLL/RlxLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCpkmmLLk7GHO6+JpLmlPP++D4yFHxUNSx3lFYK6RTh1yG3wZgHoa5cm9DGQFEH6yDjxPEqn8rJkNSbDXArbo4CwvmFkDPV87Cy6putifdhjlo7AgbMhFyybz4AiGuNWkfDNMJfK9mV+GUMht7+5TmQQ4xbbfUPa0Oqp8YhzluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=NzcAb2+U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eb2f3935eso1247645e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1705943085; x=1706547885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTJ/sgvQ4GGqRw4oAEwmS5hEHtXyaauT5zfJynWMNFI=;
        b=NzcAb2+UIC35jL1KTsNaANpX0gBzwPjKzUgAIMmdFoQUbix7Zrs5LNyG36fDmSVz19
         88MlJLJYhvpmEEjFXcXllscZ+Lo7YJkeXySSYwEqfWliuVChVFkeL4I9gBduBr6gn02E
         EE9rLNOUFSzPRyBhSqTZSEge8+uiDhf4eUQ2qbx0NoRycRklzl5kKp7t+1YAPhFoSbZC
         fbZGZcuNgpXKU121aqwqJ+ZtxEo1x+pV631xXSyCnEkVBP6V/HfN73tt2J2KpW5trcZZ
         SJrKMKJOE+hWKTYjGCnjuLHIl1gzpV/fNWinpFipk622ImL1Ps7HBRPXeVCStiwPj2gK
         EBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705943085; x=1706547885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTJ/sgvQ4GGqRw4oAEwmS5hEHtXyaauT5zfJynWMNFI=;
        b=CWvUk5Jwswu9i9aQKh7MAxEZlTkynEb+0xdNWR+1zM4vLYChuaYC0kmwHVReeo3CKo
         pWFrb5jhHzoPnBrM3QmEeeQCKYZGQgcZspK4k07dDcF1k7bUWs207gPKtBbQuoy5w+vd
         CqmDznIQGpPwMCTzlJ/GYO5DWQNIBf2L6VoxZTUgTXSeTlZjgu0msvB4LTZD96o/SS1J
         KGUYtijquAXPVNFqUT3Bf4h86NEperNr8TSUuaQYrB9M++VGhr8ORqPYzhNvGC4EEE2O
         xASqPc5ugt7OcRyPxPhFbbXKXIuOgMqd3VSWHYBqNoJ8xYS1DOMhNHzCBHVmiYwLxkme
         1Dcw==
X-Gm-Message-State: AOJu0Yz68jgs1HcaHHR+fMzrK97+6QChn2aFhdSbi/+KkMj/YbSD7SD2
	GyUZVVs6UDoy6T9Li3BhFaXcAOK7xJcZlCoQ8Nqb+3rZhbmtmZkK9MscgxPM3mRO9eckWtFkgdc
	v
X-Google-Smtp-Source: AGHT+IEWHtWGN+HG2GwkAT+N/pNrgFVI1Fg45sia7VJ8ReIR2/0nYKU/MzKRNc9GLUYaqYIxOdAQdg==
X-Received: by 2002:a05:600c:ad7:b0:40d:8f2d:199b with SMTP id c23-20020a05600c0ad700b0040d8f2d199bmr2105509wmr.84.1705943085590;
        Mon, 22 Jan 2024 09:04:45 -0800 (PST)
Received: from P-NTS-Evian.home (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr. [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm39346047wmq.12.2024.01.22.09.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:04:45 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: tony@atomide.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	Romain Naour <romain.naour@skf.com>
Subject: [PATCH] regulator: ti-abb: don't use devm_platform_ioremap_resource_byname for shared interrupt register
Date: Mon, 22 Jan 2024 18:04:42 +0100
Message-ID: <20240122170442.729374-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Romain Naour <romain.naour@skf.com>

We can't use devm_platform_ioremap_resource_byname() to remap the
interrupt register that can be shared between
regulator-abb-{ivahd,dspeve,gpu} drivers instance.

From arm/boot/dts/dra7.dtsi:

The abb_mpu is the only instance using its own interrupt register:
  (0x4ae06014) PRM_IRQSTATUS_MPU_2, ABB_MPU_DONE_ST (bit 7)

The other tree instance (abb_ivahd, abb_dspeve, abb_gpu) share
PRM_IRQSTATUS_MPU register (0x4ae06010) but uses different bit
ABB_IVA_DONE_ST (bit 30), ABB_DSPEVE_DONE_ST( bit 29) and
ABB_GPU_DONE_ST (but 28).

The commit b36c6b1887ff (regulator: ti-abb: Make use of the helper
function devm_ioremap related) overlooked the following comment
explaining why devm_ioremap() is used in this case:

/*
 * We may have shared interrupt register offsets which are
 * write-1-to-clear between domains ensuring exclusivity.
 */

Fixes:
  [    1.326660] ti_abb 4ae07e30.regulator-abb-dspeve: can't request region for resource [mem 0x4ae06010-0x4ae06013]
  [    1.326660] ti_abb: probe of 4ae07e30.regulator-abb-dspeve failed with error -16
  [    1.327239] ti_abb 4ae07de4.regulator-abb-gpu: can't request region for resource [mem 0x4ae06010-0x4ae06013]
  [    1.327270] ti_abb: probe of 4ae07de4.regulator-abb-gpu failed with error -16

This partially reverts commit b36c6b1887ffc6b58b556120bfbd511880515247.

Signed-off-by: Romain Naour <romain.naour@skf.com>
---
 drivers/regulator/ti-abb-regulator.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index f48214e2c3b4..21392b9261f4 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -726,9 +726,22 @@ static int ti_abb_probe(struct platform_device *pdev)
 			return PTR_ERR(abb->setup_reg);
 	}
 
-	abb->int_base = devm_platform_ioremap_resource_byname(pdev, "int-address");
-	if (IS_ERR(abb->int_base))
-		return PTR_ERR(abb->int_base);
+	pname = "int-address";
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, pname);
+	if (!res) {
+		dev_err(dev, "Missing '%s' IO resource\n", pname);
+		return -ENODEV;
+	}
+	/*
+	 * We may have shared interrupt register offsets which are
+	 * write-1-to-clear between domains ensuring exclusivity.
+	 */
+	abb->int_base = devm_ioremap(dev, res->start,
+					     resource_size(res));
+	if (!abb->int_base) {
+		dev_err(dev, "Unable to map '%s'\n", pname);
+		return -ENOMEM;
+	}
 
 	/* Map Optional resources */
 	pname = "efuse-address";
-- 
2.43.0


