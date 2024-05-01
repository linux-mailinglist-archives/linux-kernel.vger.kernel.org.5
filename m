Return-Path: <linux-kernel+bounces-164902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900438B84B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE931C22076
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8214F8BB;
	Wed,  1 May 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df324JfL"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560B4E1C8;
	Wed,  1 May 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536502; cv=none; b=U1siOP/2UIPei8rJUwVEfXRrU+qzgsMdirDCOt+YQlQQnY/34Xg4kHi7UwvBwsEQmNIowRzctWms+ct3isuo1cHmPRwfbpZWubv/ut+2/goNEkSmUCWkWi44fEmgtEAijqDZXsZiZRzJidjISj17bf4BuIvPmQ8CviggOvsbncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536502; c=relaxed/simple;
	bh=/LW5UP24d3M9gnDJHKsZY3AjzrEnrgPIA21IZxGWV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZG4jisUD3tJjQ+AGx+X1wpCpAoEXQfKXcxXjieR92Lqw2Gg7avqy/3b6AwW8NQoQ6EbItPzKHLV8wah2drkUEDnmzOhPBYEkZwZ6jKvCOfcxhP1eQatAoXHPwi9q6Iy5UPIqtVUB+yfD27KZDLB9dPUxu1Yh98DOj7//jG6mJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df324JfL; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c70d8bb618so2918529b6e.2;
        Tue, 30 Apr 2024 21:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536499; x=1715141299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=df324JfLuQjeVFKrYQ4Ck0c4ts7v9IN+PvwOOVlFeXwu5RMuCsDSjwis/7JYLTnb6R
         9pMwbPdUMDtYoO/DIhlQqTUovHeXOQmABfFm3kjBySwhtKkw+x7kaFiGk6m9K4EVvFS5
         eKtpGt69ySSzkDOOQ500NJyB6fW0ahXGHapJjIBP9Ve5i6MW2sQ/LH+wT59QXoeRLx+L
         OwJhtAtIApBNqPUZd3/6qRCbLs37LpY7c44oZw8p9fIoh5DnzIslESX3y4tFS9FEOHde
         BlnVif8rrR6F2c1LcojbMwM2js1vlI+9FyqXOgvR2Cg83mQiFCpgV3C48E49bOXXh1Hm
         UQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536499; x=1715141299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=Z2kTUmzG1EcPqSXllLKdaPZZ2R/fZMEgfxwhHCRKQ/uUu7eZcm7RukEcdbIVx7gDRp
         GUlCsWPyduEX4xTGSLL0OI1EWRFN4a3p94e78NNJGxFaf4y+wpPubYFOjPFJ4Gc06TWL
         DG70gJ/R0323CdG/V4jUppGBgqI5WDKH/MdDEyHTUQDMNDHaGnCuS4L3pXVzwtFww06U
         f+b4kyD7x2QvRUHQmSnPOj5fY1o1HvP+1EQKVMfegVDH74OdyRjZwDPpWSxIZyNQmviL
         x+oUFlEuZ0XcOFQlK7mT3fBRrg3j9y5HFGTrxVP/RUpFDpEJvRGUVoOkszsQ14EkZYLL
         xdLw==
X-Forwarded-Encrypted: i=1; AJvYcCVNNHnDo3HuRomficQqkopE6h5Zg9+o6LRoQDHodmBKc2lMgIdAz7im/uud2RuWxNEL2x/T9J8aVHx3rwQye0p2w/r9vh8HonRbAf863I7A+1yZ2bs8skcLgp1RGEMIuIU0NoQwVwrhCUnuNsO0Ni1lfif6lH9n59DZzj3+2GFKOsrYU+k=
X-Gm-Message-State: AOJu0YyZtoTc+1xrLx3LOR/OwEdYRwVmDJZKjgx+U59WaNvVKeYUZOAz
	wIpE4hR0SwORG5MSDuhw+3zqyNFH7rcD1ocHMrcj8aS3op4VSI+a
X-Google-Smtp-Source: AGHT+IHC5p/PcKlpuC6jhUfWCQh7T/pMpwh4pou8GiOvWFlIveZW0KCcXaV7pZNPdGh/gFeQLGizKg==
X-Received: by 2002:a05:6808:213:b0:3c8:42d8:d6c3 with SMTP id l19-20020a056808021300b003c842d8d6c3mr1627400oie.48.1714536499248;
        Tue, 30 Apr 2024 21:08:19 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:18 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/8] dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
Date: Tue, 30 Apr 2024 23:07:52 -0500
Message-Id: <20240501040800.1542805-11-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the missing PCIe PIPE clocks.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 08fd3a37acaa..52123c5a09fa 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -216,4 +216,8 @@
 #define GCC_CRYPTO_AHB_CLK				207
 #define GCC_USB0_PIPE_CLK				208
 #define GCC_USB0_SLEEP_CLK				209
+#define GCC_PCIE0_PIPE_CLK				210
+#define GCC_PCIE1_PIPE_CLK				211
+#define GCC_PCIE2_PIPE_CLK				212
+#define GCC_PCIE3_PIPE_CLK				213
 #endif
-- 
2.40.1


