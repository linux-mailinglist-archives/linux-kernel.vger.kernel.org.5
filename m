Return-Path: <linux-kernel+bounces-79608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85C8624AD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0E91F2202D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9B40BFE;
	Sat, 24 Feb 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMvyNwe6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC53E480
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775150; cv=none; b=dNC4yj914iL5WV61NcIZwGize39GEB34ogIuOZP2RcrlJw4uWLkv2K/VGcUe8LDq32R5blKJklRdZyqSrWmwnLVSnVGYkgSNhsGleGHSbaMF+aNNni37gjtiT7zhBR002tOdNnrtsF+x2LJSUxJ9N9QqdNgRvjQxL1yGPy3SbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775150; c=relaxed/simple;
	bh=TbDZm2pwUw8Ya9qzVKpSjCAgn7dP8FU3JF75JugC5nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWkkoNZUJ5C4wtsvpyPSvtLpM2HxeNI3W9MC75awugB6Ql+IXqxRHJ/JJzc08AJFA8LsnOKlwIeYBeiVdvQleSNA2sPQxjQAH2tZVfW6IDHGDMIZKUgzegBJA/S0V+ZJDrEC2RJ9d9Qao/VIw+hz/nxL8S3bGVZvZoWkq1o2oSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MMvyNwe6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565b86c9943so157072a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775147; x=1709379947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS7rA/j/L/KU0dU/sRV2PuU9yP8zgIZOoE7Q38qopHQ=;
        b=MMvyNwe6GUpxO6s0RoNG3cbLH9ak5cfjT3ha1dIGTZU2KtTPQxA5n56vXx11pImZ52
         ACqty84BQUfr1c/58aHzOGwNWVCVnOJD7yvk7Do1VbhXaI3RnvYqw3M0PogBYeIMam4C
         HegkGq+LN+ZRMMxDMH1MW64s1nGmczT3j38V1he4qB1gSH/vQJ4FmwpPWLuedJz/7tT4
         uuG7gwoRaiYnBMMB5vrjgwdkuLS2qVh/p1ZTCFhjRyFL6NH2Z0WgtyJLYaKrfHpomh9H
         AHxu+IVnMWMGEezij8iCgxJNP7r0IblJqL+TM5ihOsFM0dJDLrRGwd2+zmoYSUj178AU
         9X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775147; x=1709379947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS7rA/j/L/KU0dU/sRV2PuU9yP8zgIZOoE7Q38qopHQ=;
        b=vuAtTplW2I4KkuN6XzA0w4Tr4uOJcRa8M4uxlZu+sKvVYVJOISCQWkCr3piFlUiHhX
         VFgUgRqmYzbpyLVu11TUJuUzizohU6pZi691NtYDkrMn/RgY7dfqvkY6nfE7NHLwN/hW
         3fsEKr63EcB/hwoeVTyQP2BNKZe6IZ9zdpSJCZSCl5mJy5EUbbUhrE9zYtziyoO6NAI7
         2IqII6/YYyV+ON0EUMAWrLlOPqK7+J36WMYbngQ/fvxPsXKVyXGiIb+1XNSJCQ5/kTkV
         SooJtbhk5bg0AF9/zCxyEBVgG8ULmtptLudAYLgjZNvoQ0t54/oLpUf4fjQ/RM6eyoCe
         DoDA==
X-Gm-Message-State: AOJu0YzuvPNjvazUgZ5FK0n4oYtsniRPJNX0KZ+bdUIxwRH7DhcgiAHG
	42SGuJZDz1KhKFgg0C+vcMmXxCF5l5PVxnmFne5N+8aVnYiokAzX0LSMQFeb6r7U7DvsbUMNYUk
	E
X-Google-Smtp-Source: AGHT+IGGXp7l/I31C/VlsYaCuo5sbMZaFSqsucSFLKG3ppQpFIuibVZOVuOe1ukRwXSBIUYD7QtGnw==
X-Received: by 2002:a17:907:208f:b0:a3f:421:26a5 with SMTP id pv15-20020a170907208f00b00a3f042126a5mr2049003ejb.12.1708775147368;
        Sat, 24 Feb 2024 03:45:47 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:46 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/11] firmware: xilinx: Add ZynqMP efuse access API
Date: Sat, 24 Feb 2024 11:45:10 +0000
Message-Id: <20240224114516.86365-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3247; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ztYMB5wlPQ7riX2muOA67ef80NdW44Fd2iBr8KYguME=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLlGDOcJPROfJzSEXMs0DTxp5duuzEnVdNw 2oaDOxR3vmJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N6JzCAC3GZfAyTzAGLMBlClY2F68xTQYaHOEYMk2pdwdLlXg4VySFjldXzkgZ8BGVNtpSOePFAu C9UJx+VSfM2w89AvpgywCzWhdC7hBipyZ3g6OKEsxWOgfJaC3gYc9LqqIH+LBgE/zRkS0ITfdUr FrZzBzyO/zY5rbopj25K4lNhn20QBalmqZF8QSVLyrNGI0tb3xJLMEcV2YdN/qD6woC6WSbjPAA yrX3EBy6/QLd95BCMva9HBTxh1DYyyb9saHTJ4nlmHdXnyeWvy5Gaowf21ugUA5R93/ySJ5Dz6W gFrLTJDRD4r0wq+IJvND3MaqeH0px4JoDhW/PmQIjIgNinwc
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>

Add zynqmp_pm_efuse_access API in the ZynqMP
firmware for read/write access of efuse memory.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/firmware/xilinx/zynqmp.c     | 25 +++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 79789f0563f6..9bc45357e1a8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2022 Xilinx, Inc.
+ *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -1384,6 +1385,30 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
+/**
+ * zynqmp_pm_efuse_access - Provides access to efuse memory.
+ * @address:	Address of the efuse params structure
+ * @out:		Returned output value
+ *
+ * Return:	Returns status, either success or error code.
+ */
+int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!out)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_EFUSE_ACCESS, ret_payload, 2,
+				  upper_32_bits(address),
+				  lower_32_bits(address));
+	*out = ret_payload[1];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_efuse_access);
+
 /**
  * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
  * @address:	Address of the data/ Address of output buffer where
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9a7e52739251..1a069a56c961 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2021 Xilinx
+ *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -171,6 +172,7 @@ enum pm_api_id {
 	PM_CLOCK_GETPARENT = 44,
 	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
+	PM_EFUSE_ACCESS = 53,
 	PM_FEATURE_CHECK = 63,
 };
 
@@ -562,6 +564,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
+int zynqmp_pm_efuse_access(const u64 address, u32 *out);
 int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
@@ -749,6 +752,11 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
 				     const u32 flags)
 {
-- 
2.25.1


