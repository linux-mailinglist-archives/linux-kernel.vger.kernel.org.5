Return-Path: <linux-kernel+bounces-87239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA786D187
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD12B1F25F36
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D1E13C9C8;
	Thu, 29 Feb 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVm7/hCX"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6F134430;
	Thu, 29 Feb 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230113; cv=none; b=B8wZxz2tsApCutqoRMejM56iytH3I+7+DmB34S5Cl3NOXSbobBsYJbfaDG24RHdlNPJtq5Ms0CK5XQhgnDAD2LWm/KF+JCChadLBRO1uTNfNL/TNr/JZebDJ7ZclrxE6Jd17QLNcchYJ2sgkxJMn1HIykN3SmbSvNvwLfAYTOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230113; c=relaxed/simple;
	bh=RzhBA7EI+AvZLHUDZAghc882r6aBdz/AAQ9BqIdQzMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTQ0iPH7G5RQfoyBipQpZY8u7sPNu/krjQdGAblL63ska+yFcWA/LPTANkJvmCJkHjurfWjTH3s9abkSh7a4zLDB6pyoy2zSubPnS6sQUxLk4v+EwhbnnFjeWyyjxLnXSANyL69/kD6d2s4q9quINg9Cs/lrr57wunkNLKqseTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVm7/hCX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso719926f8f.0;
        Thu, 29 Feb 2024 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230110; x=1709834910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKW+JTh7ZVcxWjWl6fkeHkCopDJAnEXK1oMhXl+IbeY=;
        b=eVm7/hCXCSB2xqYU24KKJEQOssd694VA3X72iGEIXMHM3BafPCTfEzt53CyfA0XwW5
         0lW/uq0Z7XmNGfGTuzIfiCpA9ERkAruWQD++g2+Ku2CDVM8yHECWzOoM6I1hgEUfSUMf
         MZ+yDuIT54ZynxlbYO/CZPUjm1q/9LCFeJiM8E2jrB5n6zBzXCtqxMgPuJs1qgXsqdcZ
         +csNQc6DZI7dlNNroKpM2cJ3ApQO3d93ujie6ucDGOXkBb2VsgfIdJ+C8291Ov5B5uIW
         frr+zZJD7Z0qi0e0ZhS6WMO05igQWaEBwv/S3fDiN9flWAePW59DO9timTStS+r8zPpm
         aTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230110; x=1709834910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKW+JTh7ZVcxWjWl6fkeHkCopDJAnEXK1oMhXl+IbeY=;
        b=D7lQYu5XXruEyiW8Kdx3qIroeJvOYJEJlpb2MMPu7JwsMlqDySU8TA2jHVaUIAnWnb
         7aXcuBl4i23iS91tU5aHATUAvc1nvDObbulXTS4FHgtRs22s9lh0uy5y6TfzdInhYlsC
         eqhTBbAK9O0eizQ2ivv+cIz+UtIwMDGQJk+cZmIH6p+lFG3FTBngbUk5G7lrye1C4CeQ
         VXZl2K0RRzPdivbGww1VkkiUThm/HR4ungkQOufMD6hywq9FlF87uA7wcgZaq19xax9z
         x+/Rf8CWuqhX5MsvsU+IbREOA92rk4L0G8gSiGzdm2hXG7vmL7MImrTsncBSStKqJCcP
         8gmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxgNgivSHTzykLHOIwgCsr2kxjL+flqUC/g9oERp8a0IAjGX+T8i7LPhDvZLxvjB3sMXEXuojoE6lmXGlW72BuqybN48pny/JavZex0YjYjgYQ3n6w6p6CLTuKalhuOkNb1+rLl2lN
X-Gm-Message-State: AOJu0Yy6kzwRXmkKA7QYcqgbJy3diYOwJmhXd66EHu/wBRbOsylmoWu2
	RRUROuvKF3BjNQT5eRhZoapzQ2yRG6JIBP/J1R2Hzyaaa8odaX9q
X-Google-Smtp-Source: AGHT+IFUxNMPTM1Ga7zfS168Xb0IV1PNWM/z8HXaluNXepo4buu4oO06cDiHid6vaB41t9A7fb6YVQ==
X-Received: by 2002:adf:c5c3:0:b0:33e:12a4:8619 with SMTP id v3-20020adfc5c3000000b0033e12a48619mr2547610wrg.24.1709230110057;
        Thu, 29 Feb 2024 10:08:30 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:29 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 Feb 2024 19:07:52 +0100
Subject: [PATCH 7/7] clk: qcom: mmcc-msm8974: fix terminating of frequency
 table arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-freq-table-terminator-v1-7-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
In-Reply-To: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Only compile tested.

Fixes: d8b212014e69 ("clk: qcom: Add support for MSM8974's multimedia clock controller (MMCC)")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/mmcc-msm8974.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index a31f6cf0c4e0c..36f460b78be2c 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -290,6 +290,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -314,6 +315,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {

-- 
2.44.0


