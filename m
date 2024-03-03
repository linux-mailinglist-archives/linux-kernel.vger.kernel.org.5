Return-Path: <linux-kernel+bounces-89787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B886F5AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7294286C6D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009E6A8C9;
	Sun,  3 Mar 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PV1L2Sxa"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B30692EB
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478093; cv=none; b=FRVnrLRkFk/VgICZjX4SSpO+1YkWQk0iEj41FhexvPKWgKREGveccqnNLo7NBY4Gt5cjFF1eVhNmZuc5hGLbp4n9p04AdN84p3bWCZdXbFUEOYOdPjG7n2FIOYnqWO3DK8f86NP5AL53secwodVsF8K2KxroIFEz0xkwvaUylus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478093; c=relaxed/simple;
	bh=yG+TshWtjJCiqqxLLFxJZ8WZUu8dYiNTiWAwfrTaYNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkRLAJ6w7LwUim/QW/PTHk0tQdcladKBbLHPw0oh3av5fTwKUAPN0lHPYuteIhYv/5ZI9fLz29YoDj4e1VNqGQn5U0mTAydBSmzbY/OUM5Eb5Lc2j6HR7m5PJjPdj7nUe/ER7J4IyPjKgPjOqcH23JlGNQwXkab5mdYIi8sXJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PV1L2Sxa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44ad785a44so233439966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478090; x=1710082890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=objFWYLJTsCFID4bxkiF8sYIttYlyjZ7w2ytPsMa/co=;
        b=PV1L2SxaGWMjzKvuMU/ATUwTE6U90rh2YWO5O8AlPCkVrhggKuaERoWyGDLSHsjQZx
         TctV+Od8GHTI8U8kyQxsnD3bg/z6sGDFDd00Zq9DMaRDTw7731zEADItsS8Qtj2LiS1O
         b9bLxK4nkCjrV8sNlUhFs2XnL+b8yRj8HN1X1Ar85a//kYJMk/1RvnUipZkkrdLsEW15
         S/k63qFN+De4f4a1D4WRzDLsorwgLpPlqIa66uwB5RnniHFvyXPvjwZt/Mhlz1umnGIx
         OfwbFnzjnZN5cQ/Yu9E42vUAiXxQ/gPqetQH58NRYL3yuUFeDbsKpVWwmbOGtKpC8PAS
         sK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478090; x=1710082890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=objFWYLJTsCFID4bxkiF8sYIttYlyjZ7w2ytPsMa/co=;
        b=oT6dywlTOwtPJn1G/kf5f2HnysY69Ljhnjp9PaLQr9VFVyRfCS//rmehD8avbZqxAm
         AbFNjUatMKj+xWYlCjuVKRQRYUPWOIEBZD8vc/z/IPMrNKedgQ8Ww+bM1FRza3LYLEzl
         7Z34wb6KzK4mhOUoWV5iDo1L7zqMsoIQjoR6bGn6tZizESfyeDbx0sS9R86hJ7R8fvVU
         xTHhKJ3AC+JStZc08kS0Qv8IAga4ErnAvUahhLfCB0c+st1Qm8pKD/VDNMP/sOUnJQMG
         YtzaaSl2mQh/kzyVg9WT9Vy6X3ii4xClW4T8vfmDtDbskcx3mTQi+HnfII7SHQ0DlprX
         Oelw==
X-Forwarded-Encrypted: i=1; AJvYcCVnqNPhMaVQOqjK+ZX1PIa2hB4L9X943pWgWXxiVaiuWsZON2NI2Ji3RDWvd6p0ROdE9zxrZeLJ9p8C/sip61iXzbbzXSftfhtGLvKV
X-Gm-Message-State: AOJu0YzLmzpT4Nv4X0qu8tGlj+PBgRjNudiKOfIkTb95WvLdw89qBsgz
	pOnjZW6LiNTAZrS1IvZHW+lAbmdY3VgX7mYtliZePYTPB4I/6NFmHcBtOtA9fGA=
X-Google-Smtp-Source: AGHT+IEgUKslhbCFFA9X8FIivCaFHvZzj0Mw+hoRLlezgDrkKgO3aZB7DIdSuQrBqwbWWHQQ4Gcy0w==
X-Received: by 2002:a17:906:f355:b0:a3f:da1c:ae4c with SMTP id hg21-20020a170906f35500b00a3fda1cae4cmr5201250ejb.54.1709478090047;
        Sun, 03 Mar 2024 07:01:30 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:29 -0800 (PST)
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
Subject: [PATCH v8 07/12] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ allocator
Date: Sun,  3 Mar 2024 16:01:10 +0100
Message-Id: <20240303150115.133633-8-brgl@bgdev.pl>
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
index ed2600bbd4eb..b0fc0727d090 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1525,37 +1525,27 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
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


