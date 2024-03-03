Return-Path: <linux-kernel+bounces-89784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8754A86F5A6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB08B1C20E4A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8967E99;
	Sun,  3 Mar 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="urwBMzJM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92167C53
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478090; cv=none; b=tAO7mk0P8kW5c0Ebmr+LK9ryMU6CcTelDjxz9kjfcizjeDbCQwGKS9ewVoA7gQdro4tOK4e6pQTLH1+dWkZ7A5Hr67+/Gz15UiY6NfFhCwK3KVw03nrqUJjn6oJOw5LH8BQGpk63W+70oa4iTHmp5Xy13XHHxrsmZqhXWs+MgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478090; c=relaxed/simple;
	bh=nvJK9T5GO6zsqKvJQk5I8mIr+ZutUY0oMGz3rgd//xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVFVi4n71fyQ14XJheLpiWodfIMS7oS+Rl0W3mXZP5fcPG0JRnegP8FR3Psv+N7aj3q8d26xgufnNPFWLlkVS8E8PiFuQwViKd1SmF3GNkz5AMlakm+hZEK7Bt2iAJSojidjBJJ6qOFm4C0ClYlITgm9srnSjBfcS2klJdff7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=urwBMzJM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565a2c4cc1aso5195161a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478087; x=1710082887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzSTJ0rdnj8Y8S9Xc/5yNamLOwhLIILlmWUgX3JwXEY=;
        b=urwBMzJM6cRTeC4YT/NXsx4fMHmC+WRvnsflEwqVr0GiCvy9tlXXVcrTbPm2PAEbZA
         MiqvcMiu38ItUSDXpxEwDQAItxUY+XQGAmE0xbSBsLVGmRA7Q6OkaXZ5+oNEoKDPJD80
         YTOBr3b+AqGYa2Cp//ocR6CJQJsX6Ba2uF3UKzOByamsbY3sY3o2Y5p3LlUd2H3I0LbG
         si6L4dvqhA/qbY9fB2A/+LvLCwJLdh2jDu5N9CvObavY4vH3U9wwzxhbcSlStpFH9P5R
         181EuSdGN4GXB1k70RtX5cx7vXfoha4NMrpUo66Gynm7ENfS87JW7nfnQLjr8R98KWiW
         KQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478087; x=1710082887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzSTJ0rdnj8Y8S9Xc/5yNamLOwhLIILlmWUgX3JwXEY=;
        b=UNyi8zVlqrNSivG04nG27X+fqArfRp/FcHSaqDuBVKOhYrr9cohSfOdyX82qK0hWGi
         LQT1W3v2iWhWEjc0jYMvqWzDh+70GPeP4HsSdqw3qi5YdTBb3ri2uWKx8/AiOxJmGjya
         MZWImN3nS6Tg8tmgd0ykkwWp0ExGYQzVL7pCDPeIS6w6hl5I7H5JsEnRjucgMt6A1k4c
         eZIL8y0UFegVv3CV/yd3x4+iVitTfOvRHh/RxiAkYHKTxE0lL/neHRnU7ObtZMrZztB2
         OesPrI335YEVBld2VpMn5fga0GXGFHtowsBsa30glbDE1W+lIk4NEWLoAw0Oob5FNbTM
         RQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV7FZ9OVLuPOdQgOv5AObcJKjN2+61gq0ZkKPmJyStNhxLoPQ8+MWo1dfO2uJJMLczmB/qYkcX1V2ZMPh4HHTvLV80N6YZW0gRKV3X
X-Gm-Message-State: AOJu0YzywTNHcmXlSns0NNAR4evZqzzHCmBR8ruKCgLzgdlULC2DerVZ
	vUELo3zfG+Fhtb6wU/rOCI5K/OtRsy2v4mZ+d2+QliYSBHWHBMUaK+Fq+Vvrxtw=
X-Google-Smtp-Source: AGHT+IELTVpJwgFZ6SW6fstDB0Y1lIR0GrHp4KSOgdjkJcUeO5vl1ra+4gBL3VDeUw40ofJY2F9+og==
X-Received: by 2002:a17:906:3846:b0:a3d:ed30:11c8 with SMTP id w6-20020a170906384600b00a3ded3011c8mr5033827ejc.15.1709478087088;
        Sun, 03 Mar 2024 07:01:27 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:26 -0800 (PST)
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
Subject: [PATCH v8 04/12] firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
Date: Sun,  3 Mar 2024 16:01:07 +0100
Message-Id: <20240303150115.133633-5-brgl@bgdev.pl>
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
 drivers/firmware/qcom/qcom_scm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index c1c4809b154c..054b538828d5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -998,14 +999,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	struct qcom_scm_mem_map_info *mem_to_map;
 	phys_addr_t mem_to_map_phys;
 	phys_addr_t dest_phys;
-	dma_addr_t ptr_phys;
+	phys_addr_t ptr_phys;
 	size_t mem_to_map_sz;
 	size_t dest_sz;
 	size_t src_sz;
 	size_t ptr_sz;
 	int next_vm;
 	__le32 *src;
-	void *ptr;
 	int ret, i, b;
 	u64 srcvm_bits = *srcvm;
 
@@ -1015,10 +1015,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
 			ALIGN(dest_sz, SZ_64);
 
-	ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
+	void *ptr __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							ptr_sz, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 
+	ptr_phys = qcom_tzmem_to_phys(ptr);
+
 	/* Fill source vmid detail */
 	src = ptr;
 	i = 0;
@@ -1047,7 +1050,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 
 	ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
 				    ptr_phys, src_sz, dest_phys, dest_sz);
-	dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
 	if (ret) {
 		dev_err(__scm->dev,
 			"Assign memory protection call failed %d\n", ret);
-- 
2.40.1


