Return-Path: <linux-kernel+bounces-89310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED4986EE22
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721DE1F23B21
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B779F9;
	Sat,  2 Mar 2024 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFh612UP"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812979D0
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709346176; cv=none; b=DJsDGUOdGKfMpNWGX5zwMtJfQzCYMiGgICTtczl8WFtfwZ7b3ZYp9+g1g2fn+mBCdrhX0q7uxE0HGInMMFTaO65uSJLKAOV1yp1FeRQ/dgZWnPeNEd53cwjwRyeGF9In2VPbzbED2cRNAuGMaX2Nq/bAsPbq4FNGZKJdkestAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709346176; c=relaxed/simple;
	bh=+TPfVjFogzNReOpfUhnNpXtp/FYtnnphNfnHE/uHRDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dn9sPvnhkTyoxy/Srj6h2XbbxARJJTR1wRRfKuqq6c/HajUNne6LlEfQrTCWobvherE59ymMvpAXUzn5Bnb+gdpWjtm2yfEPTfud3+y8v7F3pxpb7VoXq2kNbSz9onvgmRuViOPZT6o0U9M5IwQQiKShwz/Ueyt+5F5KCrdruTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OFh612UP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so497258966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 18:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709346172; x=1709950972; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZvUgYXHOYOKAIGSRrva5Qq5ru4WipUXtpvetm5o08c=;
        b=OFh612UPFVbhfc70mA8B4JrgSpPnCqkLmCvHZKsDI22v4/peb+AWYHagr0qVHaYC3N
         l6/tK/nop0OMBJVc8UeO//rKM1iq3wtpF6WeOAOiQGzbLBgp9rNNgsTyhR3rKtTg+l4i
         43O0FroKrGPLiT6J+1V6M9xNiOgHhPnxBgjT2UxaCZCHKcPQexS3RmseWTDBbnu4YOZ7
         w9gfNmtFqPsh6AFQg630y+VdA5KSQeU/CYn+HVdxqMSAjuBwuTdmx1m4bq0IJpECuNUw
         Wps9Pa2VSKcjWqAVV3HdUGrIb+BLFjczOJLxGNcR/lkEakRhm4zFAoxMHxC6mPFevNZI
         sdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709346172; x=1709950972;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZvUgYXHOYOKAIGSRrva5Qq5ru4WipUXtpvetm5o08c=;
        b=ZWa7L27Jd6DoksVjBrCfrs9DzehzWqzpEw21ezSVi7SPeC4AQFIOxC8Kltre/jR/pd
         +TXOwvUpXPEph7dMB4r3HF8rNb+XTLWc8+KkUbAXbpy2ywi/IE7NmgnnNfPAbORWxkvV
         b3wN1EdYtJxP+OHbgdy3tim31HmD83TzwOwjQjP+GrPg9UN+0eO27wkR6y27Fe4CGeZW
         ajl9F3e8s0jYSCnfQXkLCzWhRNpI/dc1Nv5AYS7SntmySf1egJ4ct5kicUrhcvvXc2IQ
         q9h7WJBn7Q+k9MkLbtOdmK76TE1uwE6XjMwdCHIGfEEUeyC6U+5eiV+YZNfLmRmKgvvy
         gEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAg0ia6vm/aPqUeKpwtyJ3PtoaFm+synSgr817XmVoWKQwezGs6yhXqkADm2Kd2SU8wnqTiTOJvfJb6+tNuu3rB0St40nR6nNp9K/h
X-Gm-Message-State: AOJu0Yy8pcxpO4ArADQYctZzZxEozk9pANhqBPArdhFl+IoUbke5O8VR
	kSl8dCs9yJYOyTNFoSDJO0hT1FOZXODQKDdEIq5Y7R0aKz7/qKBiEiInLUjqtoA=
X-Google-Smtp-Source: AGHT+IE8RbV+EyI/CHCqqMAK9d77rj4AJodP1gAIw2tErl1logb+yYZchP2Vjyv75hb2/UtdXJoplw==
X-Received: by 2002:a17:906:ce29:b0:a44:2218:4817 with SMTP id sd9-20020a170906ce2900b00a4422184817mr2245935ejb.39.1709346172136;
        Fri, 01 Mar 2024 18:22:52 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm2224924ejb.130.2024.03.01.18.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 18:22:51 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 02 Mar 2024 03:22:49 +0100
Subject: [PATCH] interconnect: qcom: x1e80100: Remove inexistent ACV_PERF
 BCM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-topic-faux_bcm_x1e-v1-1-c40fab7c4bc5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHiN4mUC/x2N0QqDMAwAf0XyvEBax5j7lTEkbdMZcFVaHQXx3
 1f2eAfHHVAkqxR4dAdk+WrRJTUwlw78xOktqKExWLJX6snitqzqMfJeR+c/YzWC91s/cIhDIEP
 QQsdF0GVOfmpp2ue5yTVL1Po/PV/n+QNBPlC0eQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mike Tipton <quic_mdtipton@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709346170; l=2702;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+TPfVjFogzNReOpfUhnNpXtp/FYtnnphNfnHE/uHRDQ=;
 b=zi58sy0kKdm53JaXN9XU5z5Im/i8Hz47TaQYkUIUzQ776WqFvixIrJG/ndQNhJQ+C/iFrLi6k
 dYYIlRSZPCjAv69OnpP8fBJm0f9nOkO1xF77QFxDa7TuY1yjEi1akVJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Booting the kernel on X1E results in a message like:

[    2.561524] qnoc-x1e80100 interconnect-0: ACV_PERF could not find RPMh address

And indeed, taking a look at cmd-db, no such BCM exists. Remove it.

Fixes: 9f196772841e ("interconnect: qcom: Add X1E80100 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/x1e80100.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 99824675ee3f..654abb9ce08e 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -116,15 +116,6 @@ static struct qcom_icc_node xm_sdc2 = {
 	.links = { X1E80100_SLAVE_A2NOC_SNOC },
 };
 
-static struct qcom_icc_node ddr_perf_mode_master = {
-	.name = "ddr_perf_mode_master",
-	.id = X1E80100_MASTER_DDR_PERF_MODE,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_DDR_PERF_MODE },
-};
-
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
 	.id = X1E80100_MASTER_QUP_CORE_0,
@@ -688,14 +679,6 @@ static struct qcom_icc_node qns_a2noc_snoc = {
 	.links = { X1E80100_MASTER_A2NOC_SNOC },
 };
 
-static struct qcom_icc_node ddr_perf_mode_slave = {
-	.name = "ddr_perf_mode_slave",
-	.id = X1E80100_SLAVE_DDR_PERF_MODE,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
 	.id = X1E80100_SLAVE_QUP_CORE_0,
@@ -1377,12 +1360,6 @@ static struct qcom_icc_bcm bcm_acv = {
 	.nodes = { &ebi },
 };
 
-static struct qcom_icc_bcm bcm_acv_perf = {
-	.name = "ACV_PERF",
-	.num_nodes = 1,
-	.nodes = { &ddr_perf_mode_slave },
-};
-
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.num_nodes = 1,
@@ -1583,18 +1560,15 @@ static const struct qcom_icc_desc x1e80100_aggre2_noc = {
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
-	&bcm_acv_perf,
 	&bcm_qup0,
 	&bcm_qup1,
 	&bcm_qup2,
 };
 
 static struct qcom_icc_node * const clk_virt_nodes[] = {
-	[MASTER_DDR_PERF_MODE] = &ddr_perf_mode_master,
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
 	[MASTER_QUP_CORE_1] = &qup1_core_master,
 	[MASTER_QUP_CORE_2] = &qup2_core_master,
-	[SLAVE_DDR_PERF_MODE] = &ddr_perf_mode_slave,
 	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
 	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
 	[SLAVE_QUP_CORE_2] = &qup2_core_slave,

---
base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
change-id: 20240302-topic-faux_bcm_x1e-8639adf9d010

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


