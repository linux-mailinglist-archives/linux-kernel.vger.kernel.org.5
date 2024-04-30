Return-Path: <linux-kernel+bounces-163588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321CB8B6D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BEC1F24094
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74219DF4F;
	Tue, 30 Apr 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z14H+Gug"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10921128382
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467016; cv=none; b=EmVD8WbgvNoVjcm2s1MShMePWzQxODy2QYJuc1XrwyGVABAMnTILMcQGkYC0Fs6FvMcBWb6ctgyIRqmoHDIUxrLh9Z7pS7OtT2oZ2Pi2BapgdfcaI1FOLTYsneA/lDNKbQD5i4v29MHPIcLVHajO8TA98pyXZm5R1cwpucFKJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467016; c=relaxed/simple;
	bh=kbui8HAPtLFHoAihV2ljcEUIS+VOYj9eDPfH+oMl4OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKwHx2ztDtKzpbwPzuiHgV8Bn38DI7jCTuxW/9URtF/nmXfFB1CWxRg+rWQceyllGUfQdSPdsXsPmot6umWQxLikYtbb45fFKTpp7p2ktpjKE8vqb91Z28EIOpFJNNc+sAZ2BdQSb9HPzv5jbKG544iOO4Kb0bXJ7pg4ZN+eUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z14H+Gug; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b2119da94so43506205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714467013; x=1715071813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6uTqfKoynlVxjI21T7uYyBdXiDNj2CtWTfpf3yueTA=;
        b=Z14H+Gug3SjA8O9bSVcw8qU1ZiGMAN5z5t/7onkBGb1uIla89qRmxKFURXXI63pg7q
         3DJ/l0DgzVf77Pa+35LJAUV/AEkzdHhDCeIGT0xeBsjdp0mue4sfvyJF//K8/Tmdlz3H
         Y88MvoPPGjawtCzMzhi61aKKGfJo1KT/Wayb+DaA8YS20aT3ywvmkTYc6ZHGxKBFlBLs
         CnPv020iyR3EJ5R+qd3aoXy1BE8dXZbOwJAB8TFUx5RQI94wYhbJfIR52BaVAipChAQ/
         ih0O95dCxjihAj8DY9qXUQsbaV8VE3bTLPgBEUP4pUhGWvDO3saTO/HDWLvM1PcUQXS2
         l4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467013; x=1715071813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6uTqfKoynlVxjI21T7uYyBdXiDNj2CtWTfpf3yueTA=;
        b=JbJSAQ1800slHBsnw9MahtioHdbtuTXQW84xoMd4AIfNnvazXG4QUgpUBEuJBq+vb8
         sWlGLDyL+WPGccp4t1B79IxaF3R9AMhqdxkUapzKxE9qkr+KH54DMpqO/ASJtHbKcwRU
         OmNwE/7gYZ9J9pWxs4/CJkn7aKhBj9TPLmA9SwdJ4DaGY6bpXKrIWPSGU3RGutiaqPs5
         lS+qSYOFvciJkMEMhuIuk0jun3qkQso6U3Yx8Dwwh+js5NEy2wzT5NsVyiCp2c+gOIwI
         /HA98GopRyw6Eb5vV7fk57sRM6zCdJdmzC2Okq7OJOofz2a74t/WR0eJ8gEIlWLDKWQN
         QTRg==
X-Gm-Message-State: AOJu0Yy7xQcjJnsyKQlJu3CCuXCr9Oc/D58R8FCIFl0PaBkxbsIZBMF6
	1FQD6KqPYtnTLcKIwK0Scz4OWA1Vh7XyFTlLCZkEitK4vfaukIYkxldzO309QbU=
X-Google-Smtp-Source: AGHT+IFqvFfPU/bksTwoGs921EUcdtwmr8d6biVghNHbSXvEpY0oGctoOJ95eP/lNSsikiT2jb+whg==
X-Received: by 2002:a05:600c:a05:b0:41b:e406:5ae6 with SMTP id z5-20020a05600c0a0500b0041be4065ae6mr1722711wmp.9.1714467013510;
        Tue, 30 Apr 2024 01:50:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c1d9200b0041bab13cd60sm14590670wms.3.2024.04.30.01.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:50:12 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
Date: Tue, 30 Apr 2024 09:50:05 +0100
Message-Id: <20240430085007.33607-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
References: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=RFguBTYvrqxK+fOEwZrYRQmoHKkXcXeO9yaMOm+ScGw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLC8DiccHI2mEf0fLCFWeIjJ/nOeJGEyIe6SJ 3Hw8oYeu+GJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwvAAKCRB6of1ZxzRV N2iuB/9cHmUeup36IAovs9Qp0L4Ij8VpokiFeHpRielS9+SokQp0aHgHaEuFlvt1AaVdrW6D9Gt p0mH8A4yKPhwe0lWyaqqACVIj8hNOtyYrwx+09Xvc8zdDqzonb60NB2MNpop62vaZp8K6ZgZDvW AG3qMKgbfzCconj9PnXUqfGyD4vY/GmBRMO/wYWFha18GJWyluBmhzLkeowm3CJbpGyBhNR9bHZ YGJ4Lp2OtQg84sJe4GXQxS39aGdF2q08+H8XkQ4nLfR5UaWa/B7GHghoeR/NVPxQ88WGiSBwR+/ shf9WFhwHKlcky79l87Gr38eP4sxsp/HG+xP5LL3Rst4L4Kl
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <quic_vdadhani@quicinc.com>

Currently we have auto suspend delay of 1s which is
very high and it takes long time to driver for runtime
suspend after use case is done.

Hence to optimize runtime PM ops, reduce auto suspend
delay to 100ms.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index a09a26bf4988..ce28ac35b2b6 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -81,7 +81,6 @@
 #define SLIM_USR_MC_DISCONNECT_PORT	0x2E
 #define SLIM_USR_MC_REPEAT_CHANGE_VALUE	0x0
 
-#define QCOM_SLIM_NGD_AUTOSUSPEND	MSEC_PER_SEC
 #define SLIM_RX_MSGQ_TIMEOUT_VAL	0x10000
 
 #define SLIM_LA_MGR	0xFF
@@ -1575,7 +1574,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctrl);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
+	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
-- 
2.25.1


