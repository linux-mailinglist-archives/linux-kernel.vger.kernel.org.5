Return-Path: <linux-kernel+bounces-116788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4788A3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA502E3647
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA649182776;
	Mon, 25 Mar 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JvLtRK0D"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA4196691
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361052; cv=none; b=NaPSHWL7L/acmGU8dhtkje0VMYIeafaxhuY1ObC5JrnVQRHaa2kgRJx/p7XqZfF8AzrdbrkTxDBeag7GzT3PHQyPT8L1J44bCqYbt3eEfsqI1Qxm86yHhT6G2TCbZJnhTKBCdj+eoI7q+sIsEJelfTNH5FsmmV02uJwRPveKmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361052; c=relaxed/simple;
	bh=EH51HCSeo8d+4t44xNDlJL+YzfigfLghhDUCkzVJpmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nh3v94NSRo+ocAKEHGfY5w6iiFsIGfet9PcU5zETcouZWlIdDTGUsWtKbygl94OatvrMgct24aDml6Dbqv/iJE6uZ6l8MBBX44xR5uEkIF8IG2DyysO6iCYzSnXY0N4WFRaOPLNFpHzQ1Epu7/+FliiR5+rL7rCM0QKQXILvsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JvLtRK0D; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so2899463f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361049; x=1711965849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xM9SBn4JRwG0bOMb0/BB9XkHkn86JKvqpbMlH4QUNA=;
        b=JvLtRK0DidNr8+iKGuHu+h1Q4yqcPXaQBId3DHhltOCh8rgmh5jJQ/8I4eZ28emnIo
         AlLRh5XEWoe6LYkDcCgp4BinLmQJ4issZoI8ZSeiOpeKPqwaoJNyIwHDCOOlacVizeB0
         uT4KIr0pryKlKryWB8tHZqUo6xCTafQVABFQ2xKcbG82okhH5Ob6V85kKUvTyGp8YQNO
         g2TZWlLEC5QdslZrnQ0z9YgoURzaWSvHU/wSci7E1xelI76OuSSruLXVquPd4vZ0A0pQ
         1Ppb9TQm+GQeh7QWqMICP0Pq67n4WsuA/oJ/tL40qrFhJZ2pNwRp2c2T/TCXW7prHLcV
         USCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361049; x=1711965849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xM9SBn4JRwG0bOMb0/BB9XkHkn86JKvqpbMlH4QUNA=;
        b=fa2zaYzQmJluUVuTb0I0ovKGGoWfzkUW93nFoZxW6r1E7R5kcCNJ2ywu5slyGkPDJd
         yxyu07/clmC/ch1t9ayIu98Ya56OzS2bH3XdQoJ3rOcVJlZLFlRIBEBNUdcKVrGQQF0+
         bTucMDb8NeXxENGd+W1jRg6lGyZzl/kElaS3/Ey9x+Qx2prKxLcZIF3VipVSew2SJtv8
         Jc8eZlpNhSAT7HfV8zHrjxA5T7oSEQZQu/2zqbVJKaUUZF+DbYRjnlOLNB9v9sZ4P43L
         HBaJRGUpgRHQlT3AuqtmiqKYYKDpZD3api7dshBf5Nrt/JZPXBpOhzWp0Oo7783fLQDw
         lXMw==
X-Forwarded-Encrypted: i=1; AJvYcCXQslu65KriiCqJ8KLd4MUAuqlBTyAM84tm9oFNLLf0fBw2Vlmd2ZdHl8GEjImtger+Prj8YFOEMNFEUY63XusOvv9UH4/9aeJFFm2B
X-Gm-Message-State: AOJu0YylRTF24Ewc4/pJY/np1RdfSZwP929Qb5cW1O7fYqm1DnXUsj1R
	3IvYxjIBnG3MU2ZOXeCac9Liw+0IVjQCi0zzDL8v7bF4yx+t6lz+4U0pA7nvjKo=
X-Google-Smtp-Source: AGHT+IEydXAKs/QNU0eg4C+NDFq7UNSX+j1Jp2smkQIoaNT+FPHMVEGEtr5Miuvb08MTKW4WyYZpsg==
X-Received: by 2002:a05:6000:1ace:b0:341:cf9b:c8e with SMTP id i14-20020a0560001ace00b00341cf9b0c8emr1303987wry.50.1711361048974;
        Mon, 25 Mar 2024 03:04:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:08 -0700 (PDT)
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
Subject: [PATCH v9 04/13] firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
Date: Mon, 25 Mar 2024 11:03:50 +0100
Message-Id: <20240325100359.17001-5-brgl@bgdev.pl>
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
index 21c22d306aac..cd47389ac80c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -1001,14 +1002,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
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
 
@@ -1018,10 +1018,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
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
@@ -1050,7 +1053,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 
 	ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
 				    ptr_phys, src_sz, dest_phys, dest_sz);
-	dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
 	if (ret) {
 		dev_err(__scm->dev,
 			"Assign memory protection call failed %d\n", ret);
-- 
2.40.1


