Return-Path: <linux-kernel+bounces-32731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33831835F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CAA2895E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BFB3B293;
	Mon, 22 Jan 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m9upLF7N"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0063A8EC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918933; cv=none; b=hlCuCmb74H2Ta9X+ic06gnFVxZpWfgrwxHdM0WdIq+VLQeOODspVbkqQIaH1jAJ3Ie9vL1KygXxQhyPYuvxhwvqmNurWZ9HBHf2Wd31Efz13CypWajYvTTFtUvaIY+q5A64Me0zE+7ISqThs3jV32WsHXUO7l4mMlqUNteDa07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918933; c=relaxed/simple;
	bh=hMzsleAxBtBbguc8gCAikfvgC+u6v027CTjRT8cZCJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gBlk7rwmIb3GVuNc6rkPkPgnt2fmynn+Ye14oSl07Oexcl01FjIqAmf8wXV/YIVWu4XdBLLfoNgdh01yegD1TLDgX5iCDhK8aSjligvWNOHUPS8ER8t8J5dlEOQ53j0p7cQW7beFrmQX/ACciREs6qRfvxZ3Da1jzobR9kiq98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m9upLF7N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-338aca547d9so2333958f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705918930; x=1706523730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky7A6Q6k7ixaopUQaNLMQkcUAky1WorEIskukk+Y5Zs=;
        b=m9upLF7NOvs2FdXIv/IF/ktuhfw1UDY2POZT5aQPWrMF0F4pIXRQtD6zJHWi8x5Nt8
         4j0Yad73SqtSus68dUIGrptxNmDk74L1tB0L8p/8yI1z787277lgjD3el2HTciqD4xVf
         sDpi7giNShDk6yfn5wng3cd8Tts+o01rSL66OdVvXN/Aga3iD7e7uvox71df9zDJQC1X
         h7ZCVOf2R5ZzqUA4OkO3ismN3KTWs0G+1kw6CjKpAJXUc9ApnVU+BpRlsC7TSxdLLlAm
         QMmgB9SJJZrhBVqXtP4Ze04xlp5ayr5qSdd0dGEs72d/+/XvoRjnb0b8DWlJsInK8AL8
         XNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918930; x=1706523730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky7A6Q6k7ixaopUQaNLMQkcUAky1WorEIskukk+Y5Zs=;
        b=kvm8hOARugf2f/cQ6DPzBwL0/KP9PgFS2SEnv9vJZU4ZtkLG71aCFsQ2BiG988syKy
         Jsk80NJqeCMxuEhlYe3K4Yl3TkN5Hrhu+tGowDPMrrUTKIaH7gGLlKIlnZY3tqAUzyq2
         /qygRBL4xbUUbc+BYEr0bXCHZ40quyUcTsLaFIVR2ePfYtoNVT3aBkt6B036dflEcpHx
         yyHCs3ixp/F1fFE2x+KADNRqaFfu7PuT+Wsx5RZx3ojmqFNeljznv1DEZjF+oCMddllC
         NAey0vNgEY9JrqlVXkER3xuxzXR+WbvrdWEcSmunKaRIFLGWmVTynnfjB3vh2DImA/h5
         hGXg==
X-Gm-Message-State: AOJu0Yzb2wNSOhonPQmVWYBYy/2s/Y9nqcO2Y2CyhplEYjYlqjJQF1P8
	FRfgO7xvVf20rr9T4EbePSyFg34JLCo3FDpIVmlZx+tpZhCQVkI9mRnZV6KrDCE=
X-Google-Smtp-Source: AGHT+IGDLuCffdMW9Lj9tUJzf7vxOv7j1BC9cFUwhDhb7FRKBxSwFxj76m+ZfTa9+Lav7Ez4vfQTJw==
X-Received: by 2002:adf:a381:0:b0:337:c030:aac1 with SMTP id l1-20020adfa381000000b00337c030aac1mr1124936wrb.153.1705918929832;
        Mon, 22 Jan 2024 02:22:09 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0033926505eafsm6377904wrs.32.2024.01.22.02.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:22:09 -0800 (PST)
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
Subject: [RESEND PATCH v6 04/12] firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
Date: Mon, 22 Jan 2024 11:21:49 +0100
Message-Id: <20240122102157.22761-5-brgl@bgdev.pl>
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


