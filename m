Return-Path: <linux-kernel+bounces-32734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC0835F81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114081F265F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87D3BB47;
	Mon, 22 Jan 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pud8Qino"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB873B1A4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918934; cv=none; b=dXQ+7SS37gU0jsrTte3xF7DMvpsCep7q7a92w836PQxT36ZL7joVkL0BpWWKdveWoMTogGSyAP2DDh6+gZZ1zYD3OjoritmkiEv4H/m75zyaZv4is/wa3pghOdi1KmRGPWep0NH1AVMNxig3Qe6WsVXH4UVO3d4mmdSE0y9NhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918934; c=relaxed/simple;
	bh=5OOWzBxeb7BtobnU9iNj/y8p2LAmrftIcVh9GRDhdDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzWxZk7dGsedSc3MbjWlB4n33/unP8bs3KACwgcr+Nd0DpZmTTTnPR16jJnnKIWpylx+mMfStsfiSqI7mL4HngIPqamd1kwdKlZIOyk0D0cNycKlfbS7AP9xo7+xrykuxPdCinRjB2dBL7oKVUfqtVfgH3VTck/y19cE1i4iQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pud8Qino; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so3609795e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705918931; x=1706523731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0tdf3eyAnzGsNLeuGvazlCndWizgRVXM7rJoHxIMZA=;
        b=pud8QinoedIIJkLXDE7JqnjdRfXJimIu5k8LQm7ZVRPZWOMqIpGY8rXaiCUdCFqf1k
         nJJDs9b3JEvs90SGacsikkCHFALlf9Ny1HiDWU7qoPGcwFrEuDuvkW6V+FeO0sxp5LOz
         OMi3zHBx567qO5ui5E4GOrlQXFmngYfKzlAnwrHyNfoUYE8ypqCV0sd95d1o1pAFoPn+
         4+o2ITzSu+pRayHqq3HKbFWt7zWrcHVaAsoJwPz7xf0NuyhWnJMg16bmr3CIzFer+/nW
         6H2HKOmUKcexXqgImskohkqow8pR8vkKcmvO0jpJbG82STpT9xK6f9ROSU6lifqhQJ9m
         iG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918931; x=1706523731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0tdf3eyAnzGsNLeuGvazlCndWizgRVXM7rJoHxIMZA=;
        b=awQd+dvVbz14kt8KoVQV/iIrz7M1+DgjjC3qsJCHOZV2nrvhZlAB2dU3Tcwlh5q/tq
         APmC8EsAVPa7e4jIuQE/tT31ELAw99WeaBFBJdA4VAI3386xtzqWUy2eKpmUW9ULjWSx
         JdzUKu6oqs73Y0VTBRJlOC6Qy1q+1pqA4Yyu3KvNEqZsqlxHE6C7nbLFTtWXJcqa6pft
         DY2SIseT33GW7FFGdKUIyyoDeLIRj+PDMYEjpEMwznswQ5M6fXbkjnV8vGyhEmTb6rhZ
         WqV4MoOG4DFzUH9/w5Q5FRIps077kCLQXjTma7h5Vf3+8WY1KXYYccTghSEvMtD24a+8
         2qZg==
X-Gm-Message-State: AOJu0Yy7l57+IY8/m6bl+1KSZalfHc7GNi7a7FAPpiw+6Q82tJBOmHBu
	It6ZRnFRudZIqTDVWSQy/BoPnw0P3cmRiy/Bfya5PkFe9WyJ+rbmO6bGmYeYkfY=
X-Google-Smtp-Source: AGHT+IH+B9VN5ZNnUgonoCwpyLkf6Q3Qt2MIRkE7DG5TIqy+hV7NtfjVLOWQzZ7VrxUQpy3bxMFZdQ==
X-Received: by 2002:a7b:c38f:0:b0:40e:6617:fc33 with SMTP id s15-20020a7bc38f000000b0040e6617fc33mr2146170wmj.146.1705918931763;
        Mon, 22 Jan 2024 02:22:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0033926505eafsm6377904wrs.32.2024.01.22.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:22:11 -0800 (PST)
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
Subject: [RESEND PATCH v6 06/12] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date: Mon, 22 Jan 2024 11:21:51 +0100
Message-Id: <20240122102157.22761-7-brgl@bgdev.pl>
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
 drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 31071a714cf1..11638daa2fe5 100644
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


