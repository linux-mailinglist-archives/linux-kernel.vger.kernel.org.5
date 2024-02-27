Return-Path: <linux-kernel+bounces-83397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B994F86982B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB206B2E7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98448145B27;
	Tue, 27 Feb 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pevypelx"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D814534D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044054; cv=none; b=NvwatIlRqeezf4Y4Y3U4yIi8ARIDh72C4bTlH/vx9Pg+yPnGmPwoqzU3qhvjCRGJN4KYP5H1QnQ/CzYQp04ChD4BDpXSl50654OpgSt5AexKUUBPhyJKOan992AW7/5/eaAHfiXP7P8v9DWsj0aJyALVHtrVtdcA2NaeC2caYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044054; c=relaxed/simple;
	bh=ab6q27R3QlFLFfpy8puelAUfdFCANtrxW82g4p7AAaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LfTJmbkbsUU+e56hGNPLHPou+Q8K6CaEsGBZeaKpMnrIEl3ZJUpsXkX85PIneC3wJ+Q48fg6nfe8vwUKQIZWMtm+Y6hreXIMFmEuQHisGa7APWt9zGV70OD2wHTp7oie4zMv5QwUDsuYpJ9E8Dqy0ZFEtISNY8Et+cp75Thn/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pevypelx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so4568993a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709044051; x=1709648851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsr/AiI0N0LjdjI2GsJqDjqyT+l1PI1B8gFeuYj95io=;
        b=pevypelxVUn9u8BZ9ayxMCkHazDRu/0KV1ltZNr6QC6TF+DKYXYNbiNCdWz0CV7Ytk
         pDNKsZbWYo1T9qlU3kLhHy3OhocuuEYZHWYr5V6wZX1rJnNbAZLK7sZXbBtGCpe17mdI
         n8GAnZeS1dSXTPRiuKfC0Zb1895kjxDIEOT4bWhdHouH4iLjNYSLXVshaeg5El7M8/1f
         qeodq3OJUYRPgfX7ZDx1isbsZzrY+obvujDE2PGPWfq0kv8GHcop32XibVs6YWxpw595
         INzVjT0xNoAI2v1TJ1aejGpNQc1jrJlgb/LaBSWRhrXEzEAs9cZ8EIK5kt2AMH/gUeQ1
         TdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709044051; x=1709648851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsr/AiI0N0LjdjI2GsJqDjqyT+l1PI1B8gFeuYj95io=;
        b=IQjpqRlw0VPZPL2wWbqGh1PO+CcOoTUgljtiWh2dd/vNRbduTO7Iy6NFC+EHWDeHuj
         iiJN0qujwPGiKouRZHq2OuXn5lbfhk8BJncbK6iFG9IYIKVYbj5XBhvmlaDGr3OWLOwA
         tcVBrg0YpkgTaC5JaydZYq+FvmZCG8CV2Jbe+obXsu1PNw4WXfJcBxiHx8YwY36h0fni
         6YM4TgnfbRs/7rBn1lLRVklchE5P/vUZzS1gmv3jt64mJayBOqm6a7OUJQIpJJV3LymQ
         warmHpQVuXesO/eNK7KGSuua4YFDmdamtjME7IBcPR4rgGt6vGV7lbeQcspo15c7ICpS
         tYOw==
X-Forwarded-Encrypted: i=1; AJvYcCWLXRvDm+vOsse0NN34Z4Cwq4i/Gc1TfR0l7rZvUkwY5wRZPTDQjFv00qB7rFwO2P2rCVMZBQ52T08HArZO7IvtaJQH0KV18ULayvTl
X-Gm-Message-State: AOJu0YxOkryDxguW2KH3Xn0YotJAI0LF1LcKpir3EyDPxqEfZkTY4a7R
	PM76dTNBG9U0QG2DLH+xHlM5lsAw6hadjg0dV+7Hi895Frxevfd848Uh1z5HPLs=
X-Google-Smtp-Source: AGHT+IFusTJZzlMLAmX1/SlunCdlq9zrBA5BARec3/3Z2lzwXCSXw2wRXASMrtR7vVo7sQdCMlx+Mg==
X-Received: by 2002:aa7:ccd4:0:b0:565:f077:d872 with SMTP id y20-20020aa7ccd4000000b00565f077d872mr4712627edt.15.1709044051484;
        Tue, 27 Feb 2024 06:27:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7d550000000b00564c7454bf3sm813689edr.8.2024.02.27.06.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:27:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: defconfig: enable reset-gpio driver as module
Date: Tue, 27 Feb 2024 15:27:25 +0100
Message-Id: <20240227142725.625561-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
References: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm X1E80100-CRD board uses shared reset GPIOs for speakers: each
pair out of four speakers share the GPIO.  Enable the reset-gpio driver
which handles such case seamlessly.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3f44aebafda8..746ea4499e72 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1473,6 +1473,7 @@ CONFIG_PWM_VISCONTI=m
 CONFIG_SL28CPLD_INTC=y
 CONFIG_QCOM_PDC=y
 CONFIG_QCOM_MPM=y
+CONFIG_RESET_GPIO=m
 CONFIG_RESET_IMX7=y
 CONFIG_RESET_QCOM_AOSS=y
 CONFIG_RESET_QCOM_PDC=m
-- 
2.34.1


