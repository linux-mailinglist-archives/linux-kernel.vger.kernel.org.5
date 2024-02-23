Return-Path: <linux-kernel+bounces-79200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B7861ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D0CB20AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305014DFE6;
	Fri, 23 Feb 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjoY4Gq7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400614CADF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723320; cv=none; b=P+Mk+YtvOj7Bcay64J01o2avxriEYUi/f1AbcwTeiJbxwyrU3ZjHbTGi+oEhDtLfo+17PPBRmzFBGnidDJuT2cZNSnGyc9+WRUM5P6pJGRN27FISJ+QI/Hwze/3rZEDn9HM6RvOAr07zjbRnNU2u8O5LU3Qk95ucplLTO3nv+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723320; c=relaxed/simple;
	bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/Lipj2gu/Oat+8T40hrieKQpFcMFE2Yd9PRlEMrm95N7c7DQeEK6zy9cnuy7dOuXjLRn2UbhB7ITQ4LvT/XRg+N6IJcFAsbJotzBQcGTVRmc9YG7AS9uT6UC+IynEGj9smWBvwC8TZ63mn58akBj1zeyZVPTBQjItJeB6WcGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NjoY4Gq7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564d9b0e96dso1052848a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723316; x=1709328116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=NjoY4Gq7tD09lIHOstdTRf+CWwtCYyM+GpTatqDGB73cnLflAt1JVMWF8YroEs1Zcf
         jrXS1jPbggHQhdq7pPWCFnIQRbaVbrccubaYZpaB4LikBOARVTY7t6JCgNg+utZPnsXj
         YEvVz+vkmxaIBhfOG4FB3Z1gkr4UG01eXYU7a1miz1TAC0dWfNSHkD6r+uH602Ddp9cM
         QK7IfQANmMry5ysODReKKcREk/ZM/LsmXhC5rMWsdZ5lHy9rgIBqwGej3WHyX2f9HAub
         ErhveSSCwEV9S/K1oRKMfWAMdsAVS5jcGloEwLfgGWfdrzvS9aSnJTHc++siv2+eY3TP
         52Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723316; x=1709328116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=wKcejmEjrBbJ5TsLjFgF/aojQgu8BUSSmzXR3PHGlIS9sImzFpWqHBiyMtZMCKPCVY
         TFMGsXd6tPBci4sddi5u6kizVzffEfFSEkr8wZPmQ6mAr/c1M4unH01c6kED1013aX7w
         ENuw7MryFdocfpkqLHA/id6TmTViBEVQ0dLC04daiLP10E3wfHC60KyTojsXEyMXQWah
         NN7kmxP70idpatfdHAY/l0D2QgtcWm+kqk+Zou7l/i8QKqmKCyFGAHcfNyAYOLZy08fM
         eym53E1WGZt1URf0rUhdb/zddY4KGpmlTBKYZCjyLE4SGV1Pdpi3oIbbe2hACo1X66IV
         BChQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK6/FNOyTzc84SEYa2RX2a/G296JYpfpdLRrHaKkCr/Wu3HL3hJr7S8fkk1cq7wl7k1QlCkKfH6IcdMon9rL38GozRcZtzI3svlnlL
X-Gm-Message-State: AOJu0YyRuWbFwxifM3J3yNEse8pCDn97Nb9Fsj2yEwMA0auk62vHZ3Vd
	mjQtdStR4F8HVKqJkEVadgx8IqLcLftRSmlcOgGh2aEhwyjSQSDqRC6Ppbwzaw8=
X-Google-Smtp-Source: AGHT+IElLGA1VQIlXAlt56rTNEpM3OmiudTre3s73PFHTGooTnhMqgF/0YDNxtDTUSbwvvaMjDFiOA==
X-Received: by 2002:a17:906:a38b:b0:a3f:721f:a7ac with SMTP id k11-20020a170906a38b00b00a3f721fa7acmr600921ejz.45.1708723315809;
        Fri, 23 Feb 2024 13:21:55 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id mj8-20020a170906af8800b00a3ee9305b02sm4091226ejb.20.2024.02.23.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:21:55 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 23 Feb 2024 22:21:40 +0100
Subject: [PATCH v2 4/7] drm/msm/adreno: Add missing defines for A702
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v2-4-2d3d6a0db040@linaro.org>
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708723303; l=1379;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
 b=NXYDavFJ3TC/4KiU+OLYy06EnXZgFmyjLCFX7iZKoUTbin8UI3o1WKHxiAxISRJ/Lpa8whlgL
 OmvgcvRyQ93Bgd7cMUYUQkgAXoezpOmzuvOSNtRIQf2InPOAkx5rZ92
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add some defines required for A702. Can be substituted with a header
sync after merging mesa!27665 [1].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27665
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx.xml.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
index 863b5e3b0e67..1ec4dbc0e746 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
@@ -1945,6 +1945,24 @@ static inline uint32_t REG_A6XX_RBBM_PERFCTR_RBBM_SEL(uint32_t i0) { return 0x00
 
 #define REG_A6XX_RBBM_CLOCK_HYST_TEX_FCHE			0x00000122
 
+#define REG_A6XX_RBBM_CLOCK_CNTL_FCHE				0x00000123
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_FCHE				0x00000124
+
+#define REG_A6XX_RBBM_CLOCK_HYST_FCHE				0x00000125
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_MHUB				0x00000126
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_MHUB				0x00000127
+
+#define REG_A6XX_RBBM_CLOCK_HYST_MHUB				0x00000128
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_GLC				0x00000129
+
+#define REG_A6XX_RBBM_CLOCK_HYST_GLC				0x0000012a
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_GLC				0x0000012b
+
 #define REG_A7XX_RBBM_CLOCK_HYST2_VFD				0x0000012f
 
 #define REG_A6XX_RBBM_LPAC_GBIF_CLIENT_QOS_CNTL			0x000005ff

-- 
2.43.2


