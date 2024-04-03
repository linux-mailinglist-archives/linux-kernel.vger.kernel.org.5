Return-Path: <linux-kernel+bounces-129033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3E896385
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5FB285F25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E218EB8;
	Wed,  3 Apr 2024 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgmCnxnV"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71796AD7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118870; cv=none; b=PP7VO/hefEZBfK2xJhgrH5JT5ezPIgmOkS15ASih/w25K4KtDh2Z/sdyk6mBXIJF9aZ0FegcSjBj3m5hkXLk5RUz6F30oKF/+O9zEreSrd+Psp//2dKIr6hqU5zqQF4cqJfXWeZsj48QVC0E/si4DCukDVMWjZZQ9ZPpbqiiuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118870; c=relaxed/simple;
	bh=QQOwsJIqbn/sH6QWOe5NAW476GND/Y4m9LnS8t8IvAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzoJmNlwKwuRY3LZfaJgBwKGhcnhu6Go3+oEkVJLqaPQKeUGYF+X1qIQ3/FEp2VMbjYBzhGJcWT4gttGppjN/z34MEo8DwB2MLHaRiEEgqGNzYAKxeSFFvx7mo5/HuYRSGF778hSKfaWGmVsnt3y5Tbb670R+U6yV4igStNf5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgmCnxnV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e28be94d32so4975535ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 21:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712118868; x=1712723668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8PahdsTaxrvJsdtCNtln2KbqBTimvNp7eghq2QDJGQ=;
        b=GgmCnxnVoxb7hLrs2lO6JMnCUHvkSfnAB2ia0eoJRLLcv1baiWIk/UbHJLctXDthpa
         eeJBLGAp+o4zLBdEaIXrAGxjgdcosV7WDUwrl5spQApCvJVSrjol2mB/IPjFnlIjHW9a
         oNrvfJ3G6O8HdlQcztPYhH8/KpGGOplhNEL3VAK4y77OnbU/4rrf9MubOXQjXDAPmuyc
         zMN8HNqZWNRrGYxCPuh5xj5a+KhKPAYolQnw8aM/1z/Ps3l4fMGzQfY3flWc8gN1AiIv
         9JNv67al/zJbqlGtKLgsodKrpH6bQKVdy56kLP6KE9lEVy1w8FltCbGGUBoDUPUmlaI9
         FYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712118868; x=1712723668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8PahdsTaxrvJsdtCNtln2KbqBTimvNp7eghq2QDJGQ=;
        b=Up01sXMmiwEuHrWIm073jB94bPnbSUxFBZhZlQ4ZmsSRingjoENwDdt/NwFatTvlX4
         TacO+YNnBRoAKe5/PAeHdaDj6whFb/MUCDWe6K/FGP2JYcd/owcY/qbTSDCWjnLc0hMf
         N6Zg83nWQBBazyzTzoJYov57b7gKFNC0xlFQtkJpK5flgcq92q0mi8jRKn1yLC/NZoih
         zyRa6eTEncLu6yRndOadGPBd8Jprs7P0xw7FyCNNFQH+DIQQ/0biQ9eIX/eNn78qm+BE
         zMs+OJGYSqTCoCPGbOoCwzWo9HVU2sXuVWIlJ7xtTWtsLrQ08YWKErY43U4E7jEHZmtn
         B6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLe3cDD7pdOY2n+TJHEgnlO1Pwm6XFkqDrBLvPx79yiGmPVAvvkfdkGLoH1Bg7ntC/fx6TsdlmMZnENzBbBVd+4OEJULFtgjt4Hja
X-Gm-Message-State: AOJu0YwtWJnhUXzxh5g+bHiAM+bmtDH0OAQnYJoMUeb69Zone4IyJDWY
	FMzGYfUp/6F0YPGSWH1cHTEjmX+31S87CyZcQwmPbWF3mlQmSlz+7ftqI9GxWic=
X-Google-Smtp-Source: AGHT+IE57hrKWhru0eMdU7jCJ9P/I0eCL8aw23kcrnxVUEU40D8ove2/9CFeHxy1kPDYTiXVaUWLXA==
X-Received: by 2002:a17:902:d4d0:b0:1e0:d579:91fd with SMTP id o16-20020a170902d4d000b001e0d57991fdmr19430037plg.7.1712118867872;
        Tue, 02 Apr 2024 21:34:27 -0700 (PDT)
Received: from sumit-X1.. ([223.178.212.199])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e2059a6386sm12074634plb.12.2024.04.02.21.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 21:34:27 -0700 (PDT)
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
Subject: [PATCH v5 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS
Date: Wed,  3 Apr 2024 10:04:13 +0530
Message-Id: <20240403043416.3800259-1-sumit.garg@linaro.org>
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

Changes in v5:
- Addressed another nitpick from Stephen.
- Collected Stephen's review tag.
- Warnings reported by Rob's DT check bot aren't related to HMIBSC
  board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
  still not converted to YAML format.

Changes in v4:
- Dropped IRQ_TYPE_EDGE_FALLING for pm8916_resin given the expectations
  of Linux kernel driver. Instead depend on systemd workaround suggested
  by Caleb to get expected HMIBSC reset behaviour.
- Incorporated further DT coding style comments from Stephen.
- Warnings reported by Rob's DT check bot aren't related to HMIBSC
  board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
  still not converted to YAML format.

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
 .../dts/qcom/apq8016-schneider-hmibsc.dts     | 491 ++++++++++++++++++
 4 files changed, 495 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts

-- 
2.34.1


