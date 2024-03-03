Return-Path: <linux-kernel+bounces-89786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E259686F5A9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9801F1F227AD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23D69DF8;
	Sun,  3 Mar 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TpO8HbMc"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5967E82
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478092; cv=none; b=hQ8L3UOxb7NcSzHcHhrE+wiy9QNHd+KmBSoETb0565t2TjN+BgIJ/W9lz9W4qKA96H7xg4t3I+gagV8/ljM7G7qrsXjaiu5mVOrFn76EnOH68P3k6xfw0dNzo6l2zjvhJOvvUgPcsWBY9w2M4J/cwaHqg3Lyy2a5AcP+/LdQl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478092; c=relaxed/simple;
	bh=W62wClgcYa0PKLUh0EyUOEk3cSRlXh6BgLiU1tYJFYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4ET9jDjA2YP0Mxlz7Tj8rVTp3vAZBwk5sfTaeK98YsX8VhvgMmbTj3coF5bbSRKPcEbRvHwLvIQU1LOUnp0zh3WwJHe3w9+IreeHS0g3ZKl9FMklt+FC2S7pCB/f7t9wXbfwuZPP4cIScVJEsS+QIFojJRqcJXvyjzpo9Y1/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TpO8HbMc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51321e71673so4095438e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478089; x=1710082889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwOsyagATLxiLLSOZuWrrte+FT3urOwesDO7wStwSyU=;
        b=TpO8HbMcU/yz6W1heY4uOaJbXNOhanlA2XBDXuz+yAZEhgVnXXzz7LdiGNDwmLVf3y
         lILHopD4iR47j4JXXf/DYDkH8VHAJ46dic+c/MFWNkZCvaKtovGy03ExXIAEfYiQwhhb
         CTtM9mztquL8jz4JEC6gGc8LdBv5EfntYy/i9j7HIb7C7LcwhFfhJ5VMZ8EVuCrb6ef7
         9jl48yxUE9/WTiKGHox7+PFiVYYGrq5rYTaHYZISozqe7s6Qhq4ECzMZNfgul2TO7VRE
         ilmI0IGaGpM2si8usHqlpgDI5QEuNE2fToA/SDiernr2hNX9t0DK8uAlK27HmohlHafz
         0gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478089; x=1710082889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwOsyagATLxiLLSOZuWrrte+FT3urOwesDO7wStwSyU=;
        b=UTHk3g8YPr4l15tZZXRXifEWZ6bCsK/Au36Kz7lk9b6zpPcdTu8D5rKh3Cjtu4D9HU
         iakpej8TX/O3LugfF79g46JzQXc67sujl61Fe6onybVFZClYY79q/dKMnxORJqcMtIoC
         rJTL1XU/mtNDdkRC6SY/bnwwvoS1pPHUCGys+6c2kaRS29vMiOf/i4gnOapiPSS0tvnN
         /WwwWc5XyP6RLi2iRF+7iCxF9n9nvdbUmEFZpMiLxcjSHPyLO7bQ3Jh2Lxu+WS+ra6G2
         MbDh6FpcErFB/UYQ+1up5EQ/fV/qGXLnOgMM4i9QKOln3xNKI1CTNXXSeBbwGfsunW48
         Wsng==
X-Forwarded-Encrypted: i=1; AJvYcCW2VmyC4Ju9yFkU/Xdngzv0TXR63qIZwYI+3EudqgR2xkzPqgUJw2LFbKtYcj/uGINvfUe/cIYwxFO2BHnq4S9hiiNjYJw0pQQvx0iB
X-Gm-Message-State: AOJu0YyvJ6ZVDAtr/4CYI/f3A2TW4KlUCeAo5fOhFVcdri+WNNqxG1KN
	2VUUe1NAaFv0xtqx55kcxzC6z9lW7IalnyfxvOdHAwGWo9QKwxnCFKcqCz3bLhc=
X-Google-Smtp-Source: AGHT+IHGQCA1nHfqiZlNwIm3ejWFnOM2lHkM5W3Q89+JQgso6u9tVFPfbbwJCf9MV7KbXIbcr0DDXA==
X-Received: by 2002:a05:6512:3493:b0:512:d89e:946 with SMTP id v19-20020a056512349300b00512d89e0946mr3969996lfr.44.1709478089065;
        Sun, 03 Mar 2024 07:01:29 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:28 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v8 06/12] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date: Sun,  3 Mar 2024 16:01:09 +0100
Message-Id: <20240303150115.133633-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303150115.133633-1-brgl@bgdev.pl>
References: <20240303150115.133633-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 50c574fef3ac..ed2600bbd4eb 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1340,8 +1340,6 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
 int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		       u64 limit_node, u32 node_id, u64 version)
 {
-	dma_addr_t payload_phys;
-	u32 *payload_buf;
 	int ret, payload_size = 5 * sizeof(u32);
 
 	struct qcom_scm_desc desc = {
@@ -1356,7 +1354,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
+	u32 *payload_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       payload_size,
+							       GFP_KERNEL);
 	if (!payload_buf)
 		return -ENOMEM;
 
@@ -1366,11 +1366,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	payload_buf[3] = 1;
 	payload_buf[4] = payload_val;
 
-	desc.args[0] = payload_phys;
+	desc.args[0] = qcom_tzmem_to_phys(payload_buf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
-	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
-- 
2.40.1


