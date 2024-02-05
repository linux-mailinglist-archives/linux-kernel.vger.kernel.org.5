Return-Path: <linux-kernel+bounces-53223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50284A254
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F43C1C232E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68950A62;
	Mon,  5 Feb 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k2BEKQ3/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3104F210
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157707; cv=none; b=EcMbEFq3JDJC3VRxdanEPVFzbuwWa4zxQCpUzCTI4g4kM/IFXyHFTnoI7/1sOUHvD+o9iWG2kLRFJ5CoaEuscaoaGYokqEd5PhdTouNYC8OckYw07z5JJ1wq0ETsPUygk2cKNu27Gg1sFU5JSQ4S70RRqQyMv6hPhPkwisNlu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157707; c=relaxed/simple;
	bh=hMzsleAxBtBbguc8gCAikfvgC+u6v027CTjRT8cZCJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwVZb84j2LJzmz+TBPCd2gDrGQ7sMuq+bDMCc5F7KK2bnowQdrxr6hpP8+WTHYjM0Sir5crPmbzO4808LGvW/cOedZKOmuLEYCYNdLxkVhdfJmZqcR1XWpQazHQEtez3iDJ8IydutbgHM+OHSpMD7SHLdwUxr892jCGhxjzxovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k2BEKQ3/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso30538785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707157704; x=1707762504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky7A6Q6k7ixaopUQaNLMQkcUAky1WorEIskukk+Y5Zs=;
        b=k2BEKQ3/Pt7DCniPFNC3bk1ZHAzfuGl58FGzII0QS9IFXoZeE3vw1Ek9J/pF4Gmgie
         rN5rOgUFTdIfrGMUWi1+S6sSbQuuaWVsVLdPC/kd33sRCEcFsFGf3Kn+yPYKj0oYJGZu
         UF1QyXvtbrA8/UipVFUIlbneTU7wGajLRNE9UtpYnHpDbsU3PveE3P04p5rqC1D/rQDP
         Kd7KgDk7IDsjM7mfCMH2joWCkxPGbar+9EepGCePHGEdYu9zj9yULQ77OrYV/D0cIDi2
         9jzpVu4beWr7BGXTDohFApASFbSe13vpFb46K9dh3pv/HrnqyQJbwxXeYDYVi94Y8sC8
         B2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157704; x=1707762504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky7A6Q6k7ixaopUQaNLMQkcUAky1WorEIskukk+Y5Zs=;
        b=oMTmg0oTH153MSRYRNhOsxSW9uNiWCHnhag0EVgXV/0rcf1dCg1+3TfvTdZs/AdsRN
         BLqNxdUoPaouaTcrYydDXpiOYWQNrQITtgzIgE+Wk0rS1GyGPLI+eQVhD7qk4VR2JC51
         l5ulYpj00S7UEiCwSEECm4kq7gP19+7lxQy4U9nZKVNdNrI+0ELbigePUUHhzs/rX+Bf
         K6rSqoIFGGyy7yZwH5onKVtid0eTCqVAaavO0cZ2f/KyovJ08xHXKCcCtOk/yIz7NQc1
         Ai2ZGi2jmQXhI27pQ0ga8cl9hHMLnMnyf9RTTqVau2vLJCZytiVZKNBAQp/aTGT/fLOM
         oxlw==
X-Forwarded-Encrypted: i=1; AJvYcCVm9jeAL8wVnPEIjCTmpeFekueTWbvFSC26OB3pRBj4IQ7gskx07JCEeUWQf2GNIRwlT7oIjFahtugjzJYPUFWtMfsCckPf0DOnuFr2
X-Gm-Message-State: AOJu0YxwbKNblPiZm7XZ7uSBMS/HwdERuWGIxBR5bm1434rGmq7aryz3
	Gl46PoQqw2b7ZFO5hoOPYI7/khfk5PddCx2SlgSS4V6xCkplUHCQelVrapzyEcE=
X-Google-Smtp-Source: AGHT+IHD765uexuf9D1x8wbid5+wPG/IxGvcXWflosUmyncm2IQaH5q+GGQQo9+ALGv8/8VJY9iD7Q==
X-Received: by 2002:adf:b35a:0:b0:33b:28ee:645d with SMTP id k26-20020adfb35a000000b0033b28ee645dmr226903wrd.68.1707157703922;
        Mon, 05 Feb 2024 10:28:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUdIiXSS/gpH931MfkdO0Sc5wlorS96kz6Tl+QjssTR3Qn14dYYj0MZDMg7QnloL0AiYaif6ZjjXPYRinmZ0GzAeXTEHKRNySKsblDiF+cPy2n+h6HoymfrcbFzXb1mPsiIlP+0kDmbqPbV3UYXpNKEmqqxLjoTrn2zN0a5go0tfPysE/vdgz0NZXqa6oMS9Bk96BpSPT37LC6FEB+zNmD9H0dxC5SaoODhdTZaeOXyT3o5ReqJGGbe3KVd78R1sfzt3aW7jOR3wlRWtOr89ttoWMe5M/4Y4g3zuj5C94rPv5ba1MccmdpGME5vGh0p2oy5LgcPNcVh9S/VAAsQFc753V1KWNEt51YvoqABivktphkj8v9I4RJq0X6qA6tHvCcDJKFnYQGCupXTBXfLYLZzMULI9zXIZ/0Mbbvf2KYStDUYTn4Sn7sPeNV3mDxHNE23ecKYflh/JHcS0W5OReZkwxtlXIo9XSzcs+5sL9+Ea7RH6XoPeO/+t4Yia6Hr5XCnKndftiFvABgBK50wUiYJjvoMf75DyHIdGIw5NrKskt0nT2K6KjuFYJcFYMXSUZU=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0033b17e18df8sm203229wru.12.2024.02.05.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:28:23 -0800 (PST)
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
Subject: [PATCH v7 04/12] firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
Date: Mon,  5 Feb 2024 19:28:02 +0100
Message-Id: <20240205182810.58382-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205182810.58382-1-brgl@bgdev.pl>
References: <20240205182810.58382-1-brgl@bgdev.pl>
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
index 71e98b666391..754f6056b99f 100644
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


