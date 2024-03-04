Return-Path: <linux-kernel+bounces-90625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6D1870269
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F04B1C20D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2243D564;
	Mon,  4 Mar 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+OEh+t4"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115643D3B4;
	Mon,  4 Mar 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558101; cv=none; b=rZwvNlqaBogXGS+B16dcp2E515uD/BpXW+WQBjTPdxuYm1dnvcV+E/lNSq2ypj8CpzLULhLx2Ni1hFuzv/Uklg8+tTT1nueIS+xeXzGeRyzfEg0Oeye4jgiv3Xa7ZyWXr8BTKqDHmlkqjowG6LPrzUmsvHwsM3V5GZp7fWQ/3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558101; c=relaxed/simple;
	bh=my4sJhUKSsXBtRhKes0rW4/YTKXdCpClyjKDr1rq0YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GaBXAXmtbODLCG1Pjwzdn4yHvxLLitwyGd4SIWs0tVqR4EQLZSMXKpw/MLTFiGMmoo8BjdJpNWTcLfKvbCqx3pjuhO20lOCNAbfCiKPpdsfHadJD3CMSvk3ZmMTbzjbAHp/rsH8dvGiAGw7TiIxNv5qeLuyVCmLn5xPAHbDdx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+OEh+t4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so5776632a12.3;
        Mon, 04 Mar 2024 05:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709558098; x=1710162898; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSY+0FJnRKGhhIo9ghINQ55bg6BnVBP3EupnZ+W3FO8=;
        b=i+OEh+t4Dv14E31IrPnlpAbVMWnn/5lTuwCojMO9IGAYcA+XbFqpV5CZV/gnWS0L0O
         IO54jTP+kXhuAMix+UfdwmThXIRdq3bzWDm/YyZfIfDkgjW1a44fUALQdUI1cjFAXA/O
         Y3aCT2d0KFSBopyfPxFUoKwA+AsCeJE40Y8/DX2WxXSHzydAnYaptD6ehyDY1B38PTnO
         XNs/twi2WTT89NhoqVXuNLgq03XgJNujE9JGT+xAn+PdK7s3urS1e2r2BFe7ErUfHpIA
         Acfp/UlG2YLrOYDZEKHa9jPVa7jIXL2rdSiFhfOovUurK5UZUjTDvUS9N8coLjJoQ5RZ
         s3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558098; x=1710162898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSY+0FJnRKGhhIo9ghINQ55bg6BnVBP3EupnZ+W3FO8=;
        b=kdElYyX6zGBEbxjIaKfS830CF3wAk6dD1q+N3duV2dIPcK6eHHqmkfIrLvfXHh/aHo
         PE9zwitEWucX/Q2GStIj/ryh7sPkQbRHTEKXtkx6PvX/zd5rtEq+TYzN/RWmFixun5hb
         fGuPF0qevvqWSRg48vNQukVrkVbVkxKAI5NTUVm/bTGV2XJIghN/bUPq62TxYsSeAeZG
         m/Dg7tNvLowQ0/8TMtnLFiHBUG/xIUZt7atBTy0o5ATrh5aYwe6786OGQUH4BPWpt8QH
         RyQ42Du++tKlV6LT2663ccYS1v19XWrzP81Va9q8BgOQn7p5YGZ8y236eP2fNFVEGDMU
         zKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf2vXIHWVR0UrVp+NlWeKzwhQEdJucy/0fDSqbjm9huBH0RLCpn044TSbkufqBkOKUVK2poQ3Sk68BEF6fUQg5YIUSwEdnOxRV2O9hAgTMZ15pMEjo5LNwWSZYqHH2wIyJOVwX
X-Gm-Message-State: AOJu0YyYxQeixB/qnKGAhPyJGFYreHTougq13Vg3YUKLzGqhQlYJ6FpX
	uOYpdMwSjQHUOVXIF859T8jUQtv+vUpFHIs7K3Hu10rIoKYL1/id
X-Google-Smtp-Source: AGHT+IG/dHnH6tSConVbuE0bqMVDVg8iYE+f1uNWUntd0gl7R8U1AZk7sAWSJA91AKlGmuEixDIp1g==
X-Received: by 2002:a05:6402:2152:b0:566:ef8:a81a with SMTP id bq18-20020a056402215200b005660ef8a81amr6732285edb.7.1709558098243;
        Mon, 04 Mar 2024 05:14:58 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id fj10-20020a0564022b8a00b00563f8233ba8sm4595285edb.7.2024.03.04.05.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:14:57 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 04 Mar 2024 14:14:53 +0100
Subject: [PATCH] firmware: qcom_scm: disable clocks if qcom_scm_bw_enable()
 fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEzJ5WUC/x3MSwqAMAwA0atI1gaqVRSvIi5qm2rw34AIxbtbX
 L7FTAShwCTQZREC3Sx87AlFnoGdzT4RskuGUpWV0qrCyx4bit3QsZhxJbTrgqqlxri21t4UkNI
 zkOfn3/bD+344dc1UZgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

There are several functions which are calling qcom_scm_bw_enable()
then returns immediately if the call fails and leaves the clocks
enabled.

Change the code of these functions to disable clocks when the
qcom_scm_bw_enable() call fails. This also fixes a possible dma
buffer leak in the qcom_scm_pas_init_image() function.

Compile tested only due to lack of hardware with interconnect
support.

Cc: stable@vger.kernel.org
Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Based on v6.8-rc7.

Note: Removing the two empty lines from qcom_scm_pas_init_image()
and fomr qcom_scm_pas_shutdown() functions is intentional to make
those consistent with the other two functions.
---
 drivers/firmware/qcom/qcom_scm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633ab..e8460626fb0c4 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -569,13 +569,14 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	desc.args[1] = mdata_phys;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
-
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 out:
@@ -637,10 +638,12 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -672,10 +675,12 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -706,11 +711,12 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
-
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240304-qcom-scm-disable-clk-08e7ad853fa1

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


