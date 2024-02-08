Return-Path: <linux-kernel+bounces-58144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734984E1DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BC5B26580
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB27994A;
	Thu,  8 Feb 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsvUCmr3"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFB79942
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398358; cv=none; b=eVJUI0sypEKevAMKinDLmbCkTrPX246d9QjLnto3tanL8g7LMeCSeJyX6mdSEPb4Pcdqdnd2EbxB0g6gfHkGcIE7DS2NLXPvyG3ncWuz3CTgGjbcohGScsktXdxYzVz+Sdh+RjIsFkGZ18XfQqvRamwi+3qnNaUiFoMb4oJOBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398358; c=relaxed/simple;
	bh=sIPGsvhd2TtbFsqAJ9mYSFI45ZdoGvLsIFDOkHIlirk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VzCWX5VFVGyrzL/f7PT7i3K+ohEdy2PvV9j9ONDsjtW+sWLjsaj2qo8gCuA+mpsv9T2Ks2F9uaURq/CpIX0Bvifh/20f6Hr0+U1h70vd5VpWlmF2Mv7fG6/A1xd2pjLS899d9d1J7SlzZcxmjOSVgzDEilIw2smCpp02SUVb3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tsvUCmr3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so2060882a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707398354; x=1708003154; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v68PZCp8DaDB0hniw0EzBktgIOKF0gHNVLVOyA5QvOs=;
        b=tsvUCmr3QxnflSiJ6D4YyrhBqO58SYZeisUGs9AQscPXJ4wR5GRbeprup0RoVhcgzN
         GrKtH32SHu3mpFpAWmDHdikFyuNhGA6AWq/VXbuKhKGFUts2j0e+ea/nLDzkbKPd0PnI
         yp6Byqpzd1FFT+kV9TLv8e+YLtwn8vIGjfcquML0cB7NMN66Ehhg39okjNELLPKiReed
         pDp+PfGyGaXk276JAknb5Yx+T6nONEhk1ZU1XZW4ZWuKpdWPTX1K6Se98Kk+hs2XKatk
         BYW61P/cDcNjiqQMIggsefoIJamZvZzcLqLJTwP7g6OnYz0Y3YWoAFxeEQrogy1TcchL
         MP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707398354; x=1708003154;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v68PZCp8DaDB0hniw0EzBktgIOKF0gHNVLVOyA5QvOs=;
        b=qrsg6bSJEikIKSgap3F9TQD0Aixtot5HuIxKsyNv0Q5eD3OtdX0B2Tka55ORLf435Z
         cDGwJNtHGZ1fmwX5sQrLdyZb0TjePQ5UOhjUf96D3Yldn7uOnk2kESwtJ7tGxyqBieoK
         o3Q51BPqx/p3C1EkX+KeMOd5IswNyx4q+hwG1tka0Z0+PWXn5C3JQkW0GYLiaElweBqC
         o2VaKdgYAmZoxfe6e15IQ58EuKKLLzAcPuAhvxE+g3S6C+DhmCa/AfUQsxApTAre5s+A
         iPmJCKpDbo7gmNJYsKhiC8BatruaY4X9k2Ryhjmh0ynRLCEGoe/9F1EyRLSOuq655l3k
         rX5g==
X-Forwarded-Encrypted: i=1; AJvYcCUgVRMLQ4KZNMh2mO0ow22cIdzm9UgtnOUPkj98ltK5lZbGbwZbpv0J9IOxq4Yk3FzzZ/S5op2a6Da/8A/RKnFqLrEyRksCDSQXns+F
X-Gm-Message-State: AOJu0YzqU27qMNIBaBQ/j+iU1qEmOW89yuEtqzl/tcsSs5fVHaDqMMQP
	DMfDbSLCdPzAkQdVUeUc7EJvzAz1nR4rAZg4Le0WzCd34NfWyyupPB09FN/hB18=
X-Google-Smtp-Source: AGHT+IEPcJU57x0q0lQK6QuoSHTUoDEnFxbfYEHK7CLWVfxVxrnbrTPMUYyHi+C7GvGeTQnNZxqDKA==
X-Received: by 2002:aa7:ca5a:0:b0:55f:cca3:e89e with SMTP id j26-20020aa7ca5a000000b0055fcca3e89emr6308984edt.21.1707398353765;
        Thu, 08 Feb 2024 05:19:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDzJNR05Js1uILClJym/TFreZGmW64f7ze6W9uFnz3xx3mxpQ9aD2sMdf8sn3oQT3ZLy4soEejFCWoA5zdkm8fIX4gy5Bc+vTp9LehJW6IkE0DBiWd2OYu1pUaQWACZ4pOrPEXEOX9fMo1Pj1uwrbbTzCUEfnR08YrHe8UD57ZmM3XhuDSVo64C/IkVGAdgI5oGb9DzvirZ59r4Lc9GVG1IJgoyvMsP7tDHfgLBwUMsRz8jHs8FLNPdfeAKAy45zc1/Rn6/ZjY/aE=
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id n9-20020a056402434900b0055f0b3ec5d8sm793059edc.36.2024.02.08.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:19:13 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 08 Feb 2024 15:19:00 +0200
Subject: [PATCH] arm64: defconfig: Enable X1E80100 multimedia clock
 controllers configs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-x1e80100-configs-v1-1-9e027bee5209@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMPUxGUC/x2NQQqDQAwAvyI5N5CsSku/UnqI26wGJJYNLYL49
 y49zsAwB4RW04B7d0DVr4Vt3oAvHeRFfFa0V2NIlHpOxLiz3oiJMG9ebA4UKsNI1yypF2jZJKE
 4VfG8tNA/69rku2qx/f95PM/zB80x4QZ3AAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=sIPGsvhd2TtbFsqAJ9mYSFI45ZdoGvLsIFDOkHIlirk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlxNTJCLFVTGi3QsawTLc/XMbUeuf3HeFDJPTIv
 hgUkuWr8eqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZcTUyQAKCRAbX0TJAJUV
 VnwJEACse3LhWNh+AXLY43en5GgBVTTUOOYvDOtiAAWYsZeGTNn+LCmENfgi0POx2ycsJoRuiPQ
 R02gvIlJ+PC8/EmEWfSXDhWnyvYxCPu+kBkq8qykc/no1agfKgy7p1mjGXXgccCmJwxoS1Yxsce
 TVVaxX7xcxAaKZqOCX5Vf3vOrbay5X1+TAfIVQbIMx+reSxOeclVghMu5j8HeeT10khWqh++Q9C
 FUlCe4bvAKqTMvc0VBwAQB42iYLROPLpYUE2oTAeJZVxBdXtXOFqh8FAlJO2Dm9B75j+dD+bNV2
 b7MyNJpOdiy9Ge00Ab7oh/Xg5cPRJ98YenG2nUoWPo67mgtjQ0ALdACyhHhCfmWyg2w0nPJoQf8
 gvOaoiVklzvm7iGgwpiOcw4MtRAr2YlnL6d8M9qmDCXe9YH4kKXVPA8oejTdnR09YO0oUe5KsDk
 R1aBEoZvLikZIEL7qC9LKfxHk8wH1VaCYyukG6mj9WeiRKpn5aK7zCziARaMIcqBFrMQ3ipg0Bv
 ZgHbPOE6Y9Tlem5yiCETYa9+b+c7N6SkGBXsC+J87F05OpGYmXnM3DNYAZMkbQwZLgEkMQiDJZX
 6z2VQszO3okaFAiNP+A5+bCEoOoj/N0Cywk+tu0WH4z8cYMY3BHFR3EjYShSYxr3rfJPnZ7aRDV
 5lMBl+Gzg8YnAyw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Enable as modules the CAM, GPU, DISP and TCSR clock controllers for
Qualcomm X1E80100 platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f44b3abf3cef..c9c1b1aa4625 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1253,7 +1253,11 @@ CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
 CONFIG_COMMON_CLK_MT8192_VDECSYS=y
 CONFIG_COMMON_CLK_MT8192_VENCSYS=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_CLK_X1E80100_CAMCC=m
+CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y
+CONFIG_CLK_X1E80100_GPUCC=m
+CONFIG_CLK_X1E80100_TCSRCC=y
 CONFIG_QCOM_A53PLL=y
 CONFIG_QCOM_CLK_APCS_MSM8916=y
 CONFIG_QCOM_CLK_APCC_MSM8996=y

---
base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
change-id: 20231201-x1e80100-configs-a0f4507ca23a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


