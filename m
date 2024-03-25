Return-Path: <linux-kernel+bounces-116794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F97F88A5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38826BE4673
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033701836FB;
	Mon, 25 Mar 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m5yH7W7E"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51EE18181A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361056; cv=none; b=tYTEPYAtV8mJP4Caj4sPlbG8onZVTGktvUqnsfx82Ppci3GJOMhMxfXn9t4iz61AuNachIujkzHNHg/AhZVp7WXNyQk7ZVdeJq9+JNWLG1R+i5WWPNP8cRGNO7bVf5xOVS2ccksCQ29dUGwOOEK3WNTYg0RjmTD70I/9aDGifxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361056; c=relaxed/simple;
	bh=IUqejzqcyuNGIBnKywmHdqb016FeW5Y+vRvwo1J5vYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+cYUto4qQAMFa2q1f8aEjfWfd8M8CkwliYiURPzfewPjoxC5xscr+b1gfZAICIWG80XhrfrjS/U4kYYnCEMNKBLzL6JQNHl97v8Ru8z3TBWjcXhqkQBYZLskwKmhJftMonA3MCmwNe/M5rrM8jSjw7TpD5NrVHvKuZWq6f+geM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m5yH7W7E; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513da1c1f26so5208734e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361053; x=1711965853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xufcXpqu9meZgvOhjobiZ3mAJVgm6XQHol02lU9mgVE=;
        b=m5yH7W7E7M8VY9S30xP3BZ+wCgmEbGBMN8UTskyUd1M/Re/arN94yKa2eEk1J974x8
         Knk96Zrd6zkgZLPKslfcsuBUY8eVjlx0cNOpj/EC+4+Dz5dG9UeSSu9As25aeKQ8t15M
         /ZGiBZhxWQ04AjS24CT7J0JAuhIf3Alc8YFw0+NtOPWiFy0n6bH+/eroD6SmKOWxPltF
         ArBKEQUw4maVc1bD6E95MoxYL/jF2Cke6xXvTWkL3iIGtLaVqll4qqwrFDbmihj3fKw+
         RdIR6/YrHokFZNY+l+zhzGOeAhUfAtreoOSwFHgLGm8e0tOZIHMwSyzPGx+dnysBFyhz
         uMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361053; x=1711965853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xufcXpqu9meZgvOhjobiZ3mAJVgm6XQHol02lU9mgVE=;
        b=Kip3WGIJXyKa9sS+7MGNrJNxsP7XBGzvXbu4P6nd02+LNI4F5lgqvRNGcoRBkd/7KP
         OktagOPY3EbOfXn0u/6iP3kLyMgLoYDDL5japtHLD7RyADks+NH5A+V74eMtYPnHmeol
         sa+05Stwk1WGb+HewrDyYXEbw7r8q/MyaXN6KeennZFxvZmtKjiUGGdVLZIL9YTazZtI
         oEEjnZcIg/3GtAh44sxmnuc4M2lsPFWTPtUVIQwjK3NX9zFasaea62qmxFhCKb9nNNl+
         Jzfjq0eqRJVs3im+izOjqybCztbcNGh0j1Qdkx8K0DBnlbbT4pwSbUrzgTENlA+xc3jQ
         rJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXsE+dyxMCmtxcodiqZWXVg8r1g+n6pmbnB08BaUwR3f3MbnCXA89FDj/V59F6WD5rQPL9sbGvz39WjO+DaB7DzruLRw5J0HsaGUZtx
X-Gm-Message-State: AOJu0YyqPJXYXlKaTNwgp1JjMrW4dzg7lyo4fGnbOHiaXaySSdx1gFEn
	ImaZhQQ6p6ucmrk/acCqIHxX70SrjBZ8BDIpc7GO4Z3YP4a4S0FfofMPLi8qJ6o=
X-Google-Smtp-Source: AGHT+IHgBg0LWLPO99YeuP7Xyyt0H7oIgeUw1/SglAJPFnHodW8TAuxRmmG2jkvBpFOO8T2o3jhO6w==
X-Received: by 2002:a05:6512:3282:b0:515:a8c9:6ec0 with SMTP id p2-20020a056512328200b00515a8c96ec0mr2202428lfe.36.1711361052810;
        Mon, 25 Mar 2024 03:04:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:12 -0700 (PDT)
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
Subject: [PATCH v9 07/13] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ allocator
Date: Mon, 25 Mar 2024 11:03:53 +0100
Message-Id: <20240325100359.17001-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325100359.17001-1-brgl@bgdev.pl>
References: <20240325100359.17001-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of manually kmalloc()ing it and then mapping to physical space.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index feb44cc03d2c..d9b189632e61 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1528,37 +1528,27 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
 	unsigned long app_name_len = strlen(app_name);
 	struct qcom_scm_desc desc = {};
 	struct qcom_scm_qseecom_resp res = {};
-	dma_addr_t name_buf_phys;
-	char *name_buf;
 	int status;
 
 	if (app_name_len >= name_buf_size)
 		return -EINVAL;
 
-	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	char *name_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							     name_buf_size,
+							     GFP_KERNEL);
 	if (!name_buf)
 		return -ENOMEM;
 
 	memcpy(name_buf, app_name, app_name_len);
 
-	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
-	status = dma_mapping_error(__scm->dev, name_buf_phys);
-	if (status) {
-		kfree(name_buf);
-		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
-		return status;
-	}
-
 	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
 	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
 	desc.cmd = QSEECOM_TZ_CMD_APP_LOOKUP;
 	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
-	desc.args[0] = name_buf_phys;
+	desc.args[0] = qcom_tzmem_to_phys(name_buf);
 	desc.args[1] = app_name_len;
 
 	status = qcom_scm_qseecom_call(&desc, &res);
-	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
-	kfree(name_buf);
 
 	if (status)
 		return status;
-- 
2.40.1


