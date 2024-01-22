Return-Path: <linux-kernel+bounces-32735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBAA835F83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBD928A570
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5233CF47;
	Mon, 22 Jan 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yCQhd5eJ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A13B78B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918936; cv=none; b=fbD3vYKLWIDcUuzdrDYpz4V/EnBsC4xKFCCIg/V1Kg5A5E2vAt+eSrzxlOU0RCBx40XhERzCAivjwsjMCIN7w+Tf4Mq63eR/dXuSl1nXISsLwrDGPEutCsjZjsTCkMYnX5xB62Ps2kofobM5q/LpRYr+OA3iPNRKZ2FN+6QsgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918936; c=relaxed/simple;
	bh=WIOe11Ytzyo9Yq0ljywUwZYIxYsyWX7ldWgffEttovw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPxEQ9tY9s4sUxC9o55WAg6y/EL5EB9ROrOr7ipl4I2ol+POPgi1eGVEIRIBLmXJMY5hx2Zwp5HFXeBHbILMFnJPlB707qEknKQUeT70DxVWMUGeIgEbSKcaOLrJbr6vWAJdI6XT8Yfz6hr2wdpJclwXU96AqDU296DnF4fv1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yCQhd5eJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336c5b5c163so1745950f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705918932; x=1706523732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0oEOKGcE5RDVKHJLOO6pZt7g+TRP+w7zOsv5ctScyA=;
        b=yCQhd5eJ3Bt9R6Spqy/D5t5v8+cuTAcyX0oL9PJAoDwpqxgRay3VD3Nady6xbviIZd
         o9b10XOKwiWjxvbRQEYqwLRoeiizoWGrQh+6sIyZhfxFIt698MxYrMy6rud9jJDkdcHb
         iHnMqxAMyIN9ebWE6AniM+qyPgRTD7bFBfa0uidIEJib9LKCf01Ub5DDQQ3spI9+ZrIu
         /pRXcXjyjYq3uVH7F6ljjwkVNU6wzRqX+Dry6CmBZZB5p86lpqsqjRa6Z9NBzbluYpJg
         3NdXzTq1CSeUNkhZA6grbXn1YX3Q1LrXd6b57ilgS3g56qjNxiF7DUi7SfBa3ov31kx8
         yrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918932; x=1706523732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0oEOKGcE5RDVKHJLOO6pZt7g+TRP+w7zOsv5ctScyA=;
        b=e74oN3Ly11eLSDqV6FTUiVR8mTT1GDgf+xZY/PKzwV7oedlZj82gLQGlaxHrnRzW5l
         Kl+gWQhI/ws41o1f6kbgLf+xbyvBEJdjvHuPtmtoXNHoNJkI8cTMcQF0j7Zk9i8v+iYU
         oQ1cfxULHCUg1BpsUcaOP6VlpPeB3+MhSuEpCVxbmOS4VrXDVJaOj47MiFjWFO7vTGrQ
         ZaYNuTwZ2GVvqvmNTkX7lE3SJIwMlA2Ms/7khD7kcV8uyoDn5/kRvUEckyKQ4m5SErcy
         RWydh0PjEGZlZ8ijlLwT3WYMGgRWRrb7EBfxy3RNk4JthNm2Iy+skHq3xmX5TFnX8MBA
         84fw==
X-Gm-Message-State: AOJu0YwHMGBvPidvg2R9U5PZkksqDchnikMfAPSrOzhDy6ZpLCm2zwng
	n37/i79tvW12LayB6cWs+gj1Q8T4hVv+Py6eHItKMk8inbbvErd6fVNNbf2g7Qg=
X-Google-Smtp-Source: AGHT+IFToqlcKaxkiS5LUPEGDrIetlUm4/CPOggDUt+GZFmVFqwX/xwX44NKNvyf8GINsBA/qvKbHg==
X-Received: by 2002:a05:6000:100b:b0:337:d8a5:32d6 with SMTP id a11-20020a056000100b00b00337d8a532d6mr1954803wrx.9.1705918932721;
        Mon, 22 Jan 2024 02:22:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0033926505eafsm6377904wrs.32.2024.01.22.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:22:12 -0800 (PST)
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [RESEND PATCH v6 07/12] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ allocator
Date: Mon, 22 Jan 2024 11:21:52 +0100
Message-Id: <20240122102157.22761-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122102157.22761-1-brgl@bgdev.pl>
References: <20240122102157.22761-1-brgl@bgdev.pl>
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
index 11638daa2fe5..3a6cefb4eb2e 100644
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


