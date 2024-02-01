Return-Path: <linux-kernel+bounces-48379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E2845B38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0473FB28E00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40BC15DBD1;
	Thu,  1 Feb 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIxi7+9P"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1615959C;
	Thu,  1 Feb 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800705; cv=none; b=uR1Ka0BKbffrEasLFd0bTAEtW60MX4hJaGjTEv/x+RAJ0KI6VNK3VqSZferO41fXedGOV2zSRqz0iWO+r+6P7jZqPT74kpuHD7aIo+lIsTJhUKpu1q7b1G4etS3VgueEKp2kNbDU4gnHWRlfUV7XWjNdkSi1zZXPOQ8HKpKLGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800705; c=relaxed/simple;
	bh=63BrzW6aMc+JGC7gqe8EkH0cOOlKVNIeDAlN6uqZkNg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i62y2NTFvArO8wgCoJIn6Pvw7ub8PUkrxQlrhBCuHCUCPzVUCWEDN1l9N/4Ir02KY+7tLlAn7o/qxYb9p9niIiRj67OPYDunw+Q2QeapUglsDdH4yf1KmovfD9t05gnmlV2bt5nzco6OdEGgGdGq+gpbv93n1CcdVCG2pbYKahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIxi7+9P; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so14697121fa.1;
        Thu, 01 Feb 2024 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800702; x=1707405502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DWji551HMy8KzAwDabgWpNbrF4QkJwcm+aGRh86PPg=;
        b=IIxi7+9PToIzjCtLM9giMpMMcXjB1jXZqI9E8UEMWZBSYTwUr0yp5IoepP0RMxI43x
         wdyt+bUpWUAeH4pDnaUAMaCacfVCT76Gtr8ZZIcv1xDVj1mgLqgVxnpu73lRgER0/+yd
         y5TmR7fURgAIJB17T+sAHFSMk6dyIFyussARvxtcldx2TumrKCuY9oUGWv8dGDdE/zqv
         RapjDY4oo8FMnp7CToqynQzfpBfybjDXIhPIpXXLrBr9c0y/8RXJJclIvu298wC+17Z5
         /UvJu+Wd7ZXQTB8XgiPItsR7XZAAz0goPNLPHiS5ON9bjsN8wVugjdFwGTh74wQwIrP7
         /jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800702; x=1707405502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DWji551HMy8KzAwDabgWpNbrF4QkJwcm+aGRh86PPg=;
        b=sCmeKFES/xw4EvppvLhNmiBeKde7OMWesUg0T4vtMWKz7y2zKAn09UlIti9wRgENh0
         ygB2gDOyi3RqVVDIhIQW4sDNLerzoL24bMpB+UcfiK0kAjpSqsk8VggxwtoAi/rptFdX
         xdMZt/sHV673144ddISuNktOcD1OyqXQ966przl8YLun4LHOeVK6m18SuS2EfW2bcMK0
         H9Cykbm1yb+ze/Z73tMPbMRpJ9Cdu9Ux1x7OyddzXfShal8iTeNV1wq0P2uGJMosvYls
         /Vif2bfc0cWCmPQoZ051umoaVzkBvYIbCVf4PVYL1uNrvG3UhienB3xcsvCv3xj6YASp
         RysQ==
X-Gm-Message-State: AOJu0Yzkvh5jlJcUx4ZGt7xbrSkGMPGwK4aIauYSsX5HxaaW/MtUbosx
	xOOFx+/uebCWKXJhyEdMcRH1RZDq+bLawVbWRaXXg4F/A5iqay29
X-Google-Smtp-Source: AGHT+IHWTof4W1YBDl1hP/0kcUJJgEOOsfHXmmQTz3TAD2K/Zx96Z9cN6PAgPmvPZvMczZRp2p5zhQ==
X-Received: by 2002:a2e:7c06:0:b0:2d0:51f3:12f8 with SMTP id x6-20020a2e7c06000000b002d051f312f8mr3437380ljc.46.1706800701734;
        Thu, 01 Feb 2024 07:18:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXIcDkke2DduKl4OkgHUOAEE4bpRLQ0wVathyw0r78CplOy9JyCKon14ZSgkfxtazOoK51qOtu3jnjY3wQxORKhdPdqqnfonwYY5dQz89+OhkUTK4dhmKzu89XCJnvAxczWtnKvZVnKXU0s8fHzmlJAuYTjxXXNU48URAnbrpGyOJlPj6vbSLiHB+GnHuL7vVheUcLfFi9sZ7vBLlqbuiBXKY3x23gC/rvyVgd5b+2SdZrXnSZeptpg1deIkLd5DNtsES/LuMsXG+ean7Wdy36TLF0C4BqP+wgqymEXvnghctq4f15/l4acP7j+aNGmbrx2bI5ofmxeuuLdlHllr2hED24uqgRqc3pFYtIkhCesk8u/xIPXy7Hfxh74EEDYOFLQeP1gTl0NGImPnbLoaAF49EtHS7OEu+LUYt4yheLvSRAlwRKAX55YpdrYjp9VxKVnQerEorcdIJXyHW1/dFhwyLIqF9m7/U4afhzsxbvEegaA6xcomAoAat27+HL6GchwXCrMHI3togeibH1urzCiJF5r6fUjhmpp18Oe2gb5DBKy+TTcy+Hpy8FZlBY+flMV755Ei0yjJUGM1mrEoLM1lzvBnffr/nnnnS507DULs9qFWkacnADs
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:21 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 5/9] dt-bindings: net: add QCA807x PHY defines
Date: Thu,  1 Feb 2024 16:17:31 +0100
Message-ID: <20240201151747.7524-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201151747.7524-1-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Robert Marko <robert.marko@sartura.hr>

Add DT bindings defined for Qualcomm QCA807x PHY series related to
calibration and DAC settings.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/net/qcom-qca807x.h | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/net/qcom-qca807x.h

diff --git a/include/dt-bindings/net/qcom-qca807x.h b/include/dt-bindings/net/qcom-qca807x.h
new file mode 100644
index 000000000000..e7d4d09b7dd4
--- /dev/null
+++ b/include/dt-bindings/net/qcom-qca807x.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Device Tree constants for the Qualcomm QCA807X PHYs
+ */
+
+#ifndef _DT_BINDINGS_QCOM_QCA807X_H
+#define _DT_BINDINGS_QCOM_QCA807X_H
+
+/* Full amplitude, full bias current */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_BIAS		0
+/* Amplitude follow DSP (amplitude is adjusted based on cable length), half bias current */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_HALF_BIAS		1
+/* Full amplitude, bias current follow DSP (bias current is adjusted based on cable length) */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_DSP_BIAS		2
+/* Both amplitude and bias current follow DSP */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_BIAS		3
+/* Full amplitude, half bias current */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_HALF_BIAS		4
+/* Amplitude follow DSP setting; 1/4 bias current when cable<10m,
+ * otherwise half bias current
+ */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_QUARTER_BIAS	5
+/* Full amplitude; same bias current setting with “010” and “011”,
+ * but half more bias is reduced when cable <10m
+ */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_HALF_BIAS_SHORT	6
+/* Amplitude follow DSP; same bias current setting with “110”, default value */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_HALF_BIAS_SHORT	7
+
+#endif
-- 
2.43.0


