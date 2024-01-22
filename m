Return-Path: <linux-kernel+bounces-32720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21EF835F60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5804B242B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC423A8C0;
	Mon, 22 Jan 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDZH8hZc"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F73A1BE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918768; cv=none; b=IrczU1Q57EMtscqDahI5gQpJDSQBeahQgTeKQq50gGw0ZLjyiCtXYYCRIffRCxBtLpU/Q6ltXDrLsGCWndG+Pfb6Yefzi5NwG1BUFBdViVJcI7DqKjPJ42Vrjq5wuCTjMw8Figsg7SQXVWzwqq/kaoaVpY+VI8IzC2nHH6ngvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918768; c=relaxed/simple;
	bh=7ew0NAPyibZscHi7tUqReuVpp5Uimj/jNK4i5Okdy1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cZPVo0M9x/AIGJE+PpzJoXLwx/FJZMWNcW1Uw524Jq2qQZtzHFc3Ze8SG+4cLBbFxUX6iAagba2Ps8emLuuFfMoHohrQti+CbT7KNUuOHbnifm5fowk0THi1za3b+NqKx7Hgyp0WEhspuEbriXPmGaazllmZ+OFmD2Za2mQ9R7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDZH8hZc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1431187f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705918764; x=1706523564; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5KCrRWR4ilF4vEoSC5VCKhwGShhqdS0j9kXD/3Vfb0=;
        b=hDZH8hZcO4dZAxhic1vdeqfNr8S8aJcyAGDvYNDgS5OfiM4SWe4AptdH6PQqSjhGss
         p9PhIu+yTEv/Vk26G79MrrH0Xm57PrxHGnZp6DMvTCTeOFTJRN0Oca+aLiWWiwtvda9e
         fP2ShisCO3cTTgoHnvctJQGG/BKldTb29QeA+HE29ncgMs35egGlw8kqwTl1dXbyVv2V
         1UbxlkgxGpjp7+gbbSOZzUtyoWT8oWXOxke4SJCmGnm0e3CjVryfWejlM3Mxy71Xl339
         eZDq6pi0O4fUsvPZJ700tXPUYwIF3wbD7K213+E5sPAlgZLmL7AYu17VRaaPE19L6Biw
         6mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918764; x=1706523564;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5KCrRWR4ilF4vEoSC5VCKhwGShhqdS0j9kXD/3Vfb0=;
        b=enQbNURbq/czm1Lqy7cZNwgxcDwCzsLKTEfJE7ThCfOCKvx0S04Sul/QnaTwHFUIzp
         U1vD6xt8irG8qN6Mni8DmOH8N1vw/1G7zRriexk7e3rEk4lk5HOwRfDNcjgXOXa2o7sb
         2OPKyn1alsofWiF6Imt6YTCa2Ip5vYNsyaaW/ogEC9+Vjh3z6u2doDmHSsZCMu0h+5hg
         fUSD5+Zq0c5JEYpQYHfC6qN1ZqW1a88lMD/kWbbW0379DwxYB4qaRbaH0nn5eMJJOnbT
         ZkNix6XUSoHZEZVJU2rMKn+sOKJpifZnMFa0NnLdoQscS442kNyChkfdsOZOHNEFImWb
         YVHQ==
X-Gm-Message-State: AOJu0YydzdZsdFK/GoE+yuWuetMjopfR21hNfU1CwN6ihRa6HWEeS5CC
	/UejvgrwQoBwzUFt8GdnbyGuMSji8+RfqS59Bvz1saPVH8K8Qrr9b3sjcFWAK7w=
X-Google-Smtp-Source: AGHT+IHe4wXlSjtTn4jr/HiF9w2fGiO/kyyLg3woFILZwp1HItkxcNAd9zaJLjBSjvhxzWb8dh4bXQ==
X-Received: by 2002:adf:ec05:0:b0:337:39c6:a48d with SMTP id x5-20020adfec05000000b0033739c6a48dmr2495036wrn.25.1705918764139;
        Mon, 22 Jan 2024 02:19:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q4-20020adfab04000000b00337d603fd01sm10396114wrc.66.2024.01.22.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:19:23 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: qcom: sm8550: add support for the SM8550-HDK
 board
Date: Mon, 22 Jan 2024 11:19:18 +0100
Message-Id: <20240122-topic-sm8550-upstream-hdk8550-v1-0-bff7eb3a17eb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZBrmUC/x3M3QpAQBBA4VfRXJva8RPrVeRCdjAJ2w5S8u42l
 9+5OA8oB2GFJnkg8CUq+xZBaQLD3G8To7hoyExWGCKLx+5lQF3rsjR4ej0C9yvObvlDbS1byit
 2hiA+fOBR7v/fdu/7Ae+DACpvAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7ew0NAPyibZscHi7tUqReuVpp5Uimj/jNK4i5Okdy1w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlrkEqDU5S9hf5alNl6YJGm698DwtFMj622jrhx2DZ
 Y1B2aZOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa5BKgAKCRB33NvayMhJ0cgcEA
 CeKDZ4/c4Zvu1/gfShtQOBt1m5KjG8d4zIU6ZNlzng52CjCCpFwXln9vvfiWoOsxpMx+YmtRh0MNEk
 aaM7roJywNTPN6EkYqjoyx1dF7Sd0P0dngKVcvEixK3QtYnHM7z2sz55UMwaMgzYKbEwkcX3zRES8d
 FoV7htavkUzRx8F8siLvRTCCK+BydTM/OdVLVJcfJ6gvuDpgBg/JIaO5Cka6ISln/oh449HwxaX2Zv
 FEuSlebcgqyQXfVQTMRrklvgJtC3I2JVHgRgs26scWEPiqb//qC4ZGmaSIKYwYsAbraqsbNbZaIddF
 rRXUi5cNbhCvVrAIWRJm4/3lV8ASs+dW/ppCpWOe+uukOTEXrUipCf9kPSXlvxaX2lkNtYqoc0MNYa
 V1nAGdz1LhYz7iB6LhTkdbqH7psPDFCeCWGlmh131ZD7Jk/TTLm8k1cHiFBKKlIDWbWcta8XPxe0ld
 HsvXQnGxJ21NEyDU7vwKwbEKP1z9KpgMJmIqzKIKSAnLXWB2S4GkH14uDSf9xwmJfYlXZIoJpxXtdP
 B4kRKWpio/7F4AI0SErwYxRN2zjRvPgMK5QO9A/v3Tjb5dUasemKcpSeKbG6aW31XjeYtv3WZcbN+L
 +u9/fQdTyFjJYYjWt9rlwnq3kjGDeRveTN+/8j5XTmojG4mLX3Qf678eErJw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The SM8550-HDK is an embedded development platforms for the
Snapdragon 8 Gen 2 SoC aka SM8550, with the followwing features:
- Qualcomm SM8550 SoC
- 16GiB On-board LPDDR5
- On-board WiFi 7 + Bluetooth 5.3/BLE
- On-board UFS4.0
- M.2 Key B+M Gen3x2 PCIe Slot
- HDMI Output
- USB-C Connector with DP Almode & Audio Accessory mode
- Micro-SDCard Slot
- Audio Jack with Playback and Microphone
- 2 On-board Analog microphones
- 2 On-board Speakers
- 96Boards Compatible Low-Speed and High-Speed connectors [1]
- For Camera, Sensors and external Display cards
- Compatible with the Linaro Debug board [2]
- SIM Slot for Modem
- Debug connectors
- 6x On-Board LEDs

On-Board PMICs:
- PMK8550 2.1
- PM8550 2.0
- PM8550VS 2.0 x4
- PM8550VE 2.0
- PM8550B 2.0
- PMR735D 2.0
- PM8010 1.1 x2

Product Page: [3]

Dependencies: None

[1] https://www.96boards.org/specifications/
[2] https://git.codelinaro.org/linaro/qcomlt/debugboard
[3] https://www.lantronix.com/products/snapdragon-8-gen-2-mobile-hardware-development-kit/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      dt-bindings: arm: qcom: Document the HDK8550 board
      arm64: dts: qcom: sm8550: add support for the SM8550-HDK board

 Documentation/devicetree/bindings/arm/qcom.yaml |    1 +
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts         | 1291 +++++++++++++++++++++++
 3 files changed, 1293 insertions(+)
---
base-commit: 29a509493dd4da77c9109aa54cc4c145ca64ec23
change-id: 20240119-topic-sm8550-upstream-hdk8550-899e9137ed01

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


