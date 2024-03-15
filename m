Return-Path: <linux-kernel+bounces-104080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B98C87C8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D81F22C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE87134BE;
	Fri, 15 Mar 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAa8P53t"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E38BFB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482841; cv=none; b=DZYSyS3YAyGhUNqHI9thHHbE/isKUQcjGiEnbCRczt0/N5u8wv5W91pNDMD1ld5xMj4l7iDBiFB2NAQm3LU5N2DsFXoAiPI1jn5InH+IXg+ZgWik6fJRbMLqwMwetHq72wwR/Xys/UKgSHce892omak83jbGaS+n175Hk7LODaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482841; c=relaxed/simple;
	bh=HVXTNW9WfrKPtY5fK0crOs82roJk78uiZSNA4Bpj5tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRI34T14p2kZL/plYR/CEZSBx5VxLMyC/9oP2gpFIKLw2JJz+TTFCuUfVRtm10+FZRtJcgjW+hTycSiBE11fMlw6qJR5Xb3Ia5Za4yviTxUO0MrfXWiUToZtcBccjCOE1ZQJnhvepibiCGhN1HueLfjUlT66a030VLE6TzdGMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WAa8P53t; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1379835a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710482839; x=1711087639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxvxJAdPrUFHn3gHyj5TaXqFg1E/jrdJuUEbi6T9i/I=;
        b=WAa8P53tdPONPW4OqIgKzKQ3WHZFpu+75Lrx9FQ8P4XtRKx3sW6FJvP969+GnaHt8K
         9CbPe35sbsdhjcX3M7bS8hEzFSpSEmj/n2eCNjhJ1LcisFZznK5YHC+tTvJ4m63lhBKF
         dURZgBX+ZXdbWzA2XJsT5rBiVxAPmf8e9zFPTfFBQOHEDi6d9IZ1ptnpNEaekQg1sm61
         TY0A/xEV4dwqVmaC7yfXl271ZWkx0g8J9W+GnQv4EJ4cKGRCJY++FvDSMBEXBAr+qfQw
         EtcvL9PfWTBWsbS7fCEjgzks2Ib+obpPjxH5XS6UjRj7yeNs2wmTb4TZB139UBLuBZz6
         ScSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710482839; x=1711087639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxvxJAdPrUFHn3gHyj5TaXqFg1E/jrdJuUEbi6T9i/I=;
        b=DQ9k3jbVxOVVLtuNWux341cXug4SeEdqhCE7O6MqJLY8xQHxUajDF6uFXFgWNKAmw/
         85ft88N3F7JQymppqKrcmo4q9b1aHv98J7c37mfJGW4GMC30GHJQvb0AWuYr5ou+vx1i
         Eb/DT4PrgpFcx9jlWkDCUGHgzUyaGJtRdxtQEHWc6g9gc2XZAH3Xknv+AJjGDenxukxt
         ohjmse1OjUdWDFI5Uqoc3zwy7xtXgIGoAaMYbPZ9+EigwfIDPAJlMe1iRvzKSmPp5Unp
         h10FIGbCZaofu/qrsJ/f7nvjJ8jqIGHSgE0aLIsUc34CrajnrY0EPruhaeiKH/B2/MyH
         m0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVV1jn+CBwAk2kSL5VrzCgl9nzN7Y+jlJXAHOd+j8CJ4M+M865apoS8T2CZB55SyTuJ/mCyyBtNPkssTpNkWhBgZfEk2tfyb6JbcOIj
X-Gm-Message-State: AOJu0Yy1VuSj12IHwZYly0IzG8gCLTL0M4gVzdIXByaz1zWo2rfOU9Lc
	1gSubDY852xvuyWcN03MYaLLQ0gr03WzUrc4VaBhZChuFlz7gPogiDQzTz9zKH4=
X-Google-Smtp-Source: AGHT+IFLqeSVg/GGkWBFLXbMR3PVm6GB4LJGElcVrUUbrFmFNe904DbaRZ9ayxCFBsx906C2f8WoEw==
X-Received: by 2002:a17:90a:d686:b0:29a:46d2:e877 with SMTP id x6-20020a17090ad68600b0029a46d2e877mr3747233pju.48.1710482838778;
        Thu, 14 Mar 2024 23:07:18 -0700 (PDT)
Received: from sumit-X1.. ([223.178.212.73])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170902fb4b00b001dccaafe249sm2852024plb.220.2024.03.14.23.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:07:18 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS
Date: Fri, 15 Mar 2024 11:37:04 +0530
Message-Id: <20240315060707.471248-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
Box Core board based on the Qualcomm APQ8016E SoC. For more information
refer to the product page [1].

One of the major difference from db410c is serial port where HMIBSC board
uses UART1 as the debug console with a default RS232 mode (UART1 mode mux
configured via gpio99 and gpio100).

Support for Schneider Electric HMIBSC. Features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 1GiB RAM
- 8GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI
- USB ethernet adaptors (soldered)

This series is a v2 since v1 of this DTS file has been reviewed on the
U-Boot mailing list [2].

Changes in v3:
- Picked up tags.
- Fixed further DT schema warnings.
- Configure resin/power button interrupt as falling edge.
- Incorporate DTS coding style comments from Krzysztof and Konrad.

Changes in v2:
- Fix DT schema warnings.
- Incorporate suggestions from Stephan.
- Document UART1 mode GPIOs based mux.

[1] https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20240311111027.44577-6-sumit.garg@linaro.org/

Sumit Garg (3):
  dt-bindings: vendor-prefixes: Add Schneider Electric
  dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
  arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
 4 files changed, 514 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts

-- 
2.34.1


