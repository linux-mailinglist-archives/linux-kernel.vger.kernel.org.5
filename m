Return-Path: <linux-kernel+bounces-57891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F784DEB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD97B272CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C26EB55;
	Thu,  8 Feb 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFbA4NPF"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2E6F533
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389471; cv=none; b=SDYayNAS/ojCz6KrU5kAwxOOVZx/puwYZpktCMG1XOcqpVpxoMFSq6fIIeWZxyq926G6uYmFlteGpcoy921bGjm4FRN0QgjUiVMuDp1o/H614URcQhzwMAXeFeg4GhVuUJnBz/0SuN0qt1AYCSOgdkaJQFe64DbSJQU+XBsN2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389471; c=relaxed/simple;
	bh=OiRouAt14h5JaF6DwcF4zzmoZj3l9r6ZHZBAp9AGyoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXsTYzdfhYPoh7YDEckqs73XCWbkkANI2fHWHUu2hGLYuy+E+PqNdFFDTpDtL+M93eFMaHb4Z9ARTf8+OfMkCqTszeKqwR15SzP4fnHpXzFRWKaOphGVNFnAcSuJgHFNhO+p6/w455Ot3FVHn2FdUKp29fu3CkN6sIa0tnO2AzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MFbA4NPF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b5978de44so183122f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389468; x=1707994268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXwFqlt6c1ZOza+7pQsKS9ATwwru7pOVTdZ7KdBmCto=;
        b=MFbA4NPF40Rsgsrvg1SQBYnzDlVO/Zz5y0P00MLAB1SwXZcnys/ahuxEmT1JvpRCjs
         eFJwfW0qV3pK//trikquJmdMxj7lPcDYzLgDI7SiC4vJgwXb8M3XtS597d22dbMvxzKX
         FiYhXB/AAa0vkwqQxIsEwL0dqqqc+a/e4efkoJcR3X5Ib7iKfvZgQNb+dRUCPwp/H1GG
         KPM/v2i/QzzHLOduZM66c3W5APopxhUGjYzgXq8BRqXcEZINvE37up2iA8cTULHUgKxN
         B6b9nZLTU5eWwodYVqmqK02JcnNb5Te39Y4WPInbck0TX48Av2ihYQDR0AeWeqQ+/q8e
         7zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389468; x=1707994268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXwFqlt6c1ZOza+7pQsKS9ATwwru7pOVTdZ7KdBmCto=;
        b=Lg8FbqOMu+TnEOhUe7mWUHQqC7aa13oHBrOOcCw/bw2AzMfbTpDcXO5zB6vnnd/mTe
         lq2dCi5Rkolq48bu6yeyfQ2gyGbo1RypNKsFT9dstz620uAEpqHO6hgs+nePZ9+kJieo
         9pIViMxP2vhhaOYDjSKnGdtTrO8tJDRxFduQpt0y/YuM4Vcn0XnpkUfSlzdynwzS8JlP
         gIDTwcns160aC1aUyrKtfk4e97SIrvxNm7bc+z5SXgPaloo99rmV8yl0WloGUI6ZbaKr
         chI8BPXGkoDWt18PslxHicHvSV5G2vR2prr8b1Wr7jiDwvCQd6nMflX4NJcA03QrJQVl
         SiPg==
X-Forwarded-Encrypted: i=1; AJvYcCXeLS2pUkuhZkGnXqNs+8oFMf6N3PEKpEmLtaInGa8FRi8Wy3vCiGWPBfDDwQakqdN8JCyik2WAzXUUWDzON3gDqAJ9jC0CN1M0EUJR
X-Gm-Message-State: AOJu0Yyg9o9IqJrfThwpHF4CW55wcZq2cq2wnA5IAgiL84ZJPa9lsTCv
	dnCyGd1PYf6uQJ/zI3C4uad9dPTZZ7j9cw0pQ/KQMXgc2JS+aa7zBCHqgcbd1FM=
X-Google-Smtp-Source: AGHT+IE78tgjEnAwBI/DGo2QckcRnc3g3LtQlOE4opD1ymrrICz+q9b59uveIlmlBnStr2YTMgVI2w==
X-Received: by 2002:a5d:5344:0:b0:33b:464c:b11b with SMTP id t4-20020a5d5344000000b0033b464cb11bmr5006113wrv.52.1707389467987;
        Thu, 08 Feb 2024 02:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJy27b6BhCOFkKGxE/Bmj163DNWoZK2fPkgzVhZlJc8ImZhW6wyy2ASu5RUrnsPLWavnCLAXg6Bz8FOYJORdEg3IDOp6Ypk2NoAiAP4noNeGc3odnaA/aOSkzjsUr6Po6xPqwhN2ZY+VG96xHaLVIxRGXxrSGcxW4gJQ14MIe89ns+rZZWkdL9rUvF4E1T+NZAgQOVWJmwcEPKEax2oImsEYlMKCJGn6xu7DgS8C4TaDHZ
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d69c1000000b0033b4719eb6esm3308283wrw.27.2024.02.08.02.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] interconnect: qcom: sa8775p: constify pointer to qcom_icc_bcm
Date: Thu,  8 Feb 2024 11:50:55 +0100
Message-Id: <20240208105056.128448-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
References: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointers to struct qcom_icc_bcm are const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sa8775p.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index fe1b11041e6a..a729775c2aa4 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -2092,7 +2092,7 @@ static struct qcom_icc_bcm bcm_sn10 = {
 	.nodes = { &xs_qdss_stm },
 };
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn3,
 };
 
@@ -2115,7 +2115,7 @@ static const struct qcom_icc_desc sa8775p_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 	&bcm_sn4,
 };
@@ -2142,7 +2142,7 @@ static const struct qcom_icc_desc sa8775p_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *clk_virt_bcms[] = {
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
 	&bcm_qup0,
 	&bcm_qup1,
 	&bcm_qup2,
@@ -2166,7 +2166,7 @@ static const struct qcom_icc_desc sa8775p_clk_virt = {
 	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 	&bcm_cn1,
 	&bcm_cn2,
@@ -2271,7 +2271,7 @@ static const struct qcom_icc_desc sa8775p_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm *dc_noc_bcms[] = {
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const dc_noc_nodes[] = {
@@ -2287,7 +2287,7 @@ static const struct qcom_icc_desc sa8775p_dc_noc = {
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 };
@@ -2323,7 +2323,7 @@ static const struct qcom_icc_desc sa8775p_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gpdsp_anoc_bcms[] = {
+static struct qcom_icc_bcm * const gpdsp_anoc_bcms[] = {
 	&bcm_gna0,
 	&bcm_gnb0,
 };
@@ -2341,7 +2341,7 @@ static const struct qcom_icc_desc sa8775p_gpdsp_anoc = {
 	.num_bcms = ARRAY_SIZE(gpdsp_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
 	&bcm_sn9,
 };
 
@@ -2364,7 +2364,7 @@ static const struct qcom_icc_desc sa8775p_lpass_ag_noc = {
 	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
@@ -2381,7 +2381,7 @@ static const struct qcom_icc_desc sa8775p_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 };
@@ -2413,7 +2413,7 @@ static const struct qcom_icc_desc sa8775p_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *nspa_noc_bcms[] = {
+static struct qcom_icc_bcm * const nspa_noc_bcms[] = {
 	&bcm_nsa0,
 	&bcm_nsa1,
 };
@@ -2433,7 +2433,7 @@ static const struct qcom_icc_desc sa8775p_nspa_noc = {
 	.num_bcms = ARRAY_SIZE(nspa_noc_bcms),
 };
 
-static struct qcom_icc_bcm *nspb_noc_bcms[] = {
+static struct qcom_icc_bcm * const nspb_noc_bcms[] = {
 	&bcm_nsb0,
 	&bcm_nsb1,
 };
@@ -2453,7 +2453,7 @@ static const struct qcom_icc_desc sa8775p_nspb_noc = {
 	.num_bcms = ARRAY_SIZE(nspb_noc_bcms),
 };
 
-static struct qcom_icc_bcm *pcie_anoc_bcms[] = {
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
 	&bcm_pci0,
 };
 
@@ -2470,7 +2470,7 @@ static const struct qcom_icc_desc sa8775p_pcie_anoc = {
 	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn3,
-- 
2.34.1


