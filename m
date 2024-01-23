Return-Path: <linux-kernel+bounces-34952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002F68389B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966B81F260BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C28C57870;
	Tue, 23 Jan 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IueBtP7b"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2A56B90
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000133; cv=none; b=pKfNxafxgmgQ0C95JyLKnExouzFt7Z3cXjsC5JV+4gElEzIbLDzW1qTymclTNOHdmL2z/TEFdnU+WWCMcf/OwIuXlWAqRXYI2xvosOd63B+UqAq0tO0dO3W+X+zK3WBfy9sWBrjXIGj68R8x0H/Wwy03SqhRzNXWvLzlQk+phFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000133; c=relaxed/simple;
	bh=ebvh8s265QxFni49wnU2y2UvCQnFwiVaxlPKftDp3qE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R1m270CdpJ7qOzkW+V+YHXD/JhfEmwN/W4OkCrdcd7H9f8S2CxLC6WOD+Vb+VJZOq2CQFhJDqk2L66x90kWxh6ncazY9bSWAvbSa+6EoiOY5Eqvr8YxvkCPAYo2SinuQ/0mqGnYjkyeZDECJj2Oeh4pKDNvrBx6ij9tKu7Ww1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IueBtP7b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ebf37314fso2038015e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706000130; x=1706604930; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4excpL0Q1d2CGhcGSiYdaikpifaiouLwH0VoTG61D4=;
        b=IueBtP7bGbUp7Jl4SmH9qWbFfl5dBp7iybluWsGCskqysebX0lYphyxxqt+myaAjNq
         o+DLiST4nv4Q2ns/MSAalyXSXlg3YrryiU/tx9T1eoA8Ek2vzr0rOwH6P8yY4Z/xudD2
         Hj6V8y+viqCQhz6sbLkdX86VaoECS1muwmPcgQo5RA04JDwA0mga1M3sxCbg6texP1xh
         /vgkoNvx6SxvPzTnQhvoihjWITGriTqU4bEZ1A27nu3cTbjyEdqp9Z7ARKFwKRGwkX3M
         2Ziov5T9qKM11SBeMynjRJyzOLVrxOrjGIF8UTD4G0V1+JiL6AP4eW8gCuk+6BtE5wHD
         TpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706000130; x=1706604930;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4excpL0Q1d2CGhcGSiYdaikpifaiouLwH0VoTG61D4=;
        b=kT8gaBCl7PxGcYfj4CM7Cnmwrxok8LlpNDZqVVCmQf8PYG32BRhhh6r4sP59reKhMO
         Ny/I1WoakAcCw5wpJbmJonKAZVxSIkBvkBOOFyU+OyRfDzm8p01tIxCCtoxwzJuXtlP4
         FquvZnMHY9Yhel6O6OdJdPYPRZf6mPXPWJmnYJ0YFgiT6oQ7uEjkIOsRPhhqM8Fa70EO
         S+HD1rONZAx8Tm+Hut6n5PcZ3Yj6FwR5acNHQXjJJr/gKNg+0by5fuVcUKn1URXmkp3C
         7K9OuqVco0rzVJtc6LhNpTEB/Tpq69e/JRLjhqEII30k0e+0R8q1GWa9x1agY71ACY2s
         Y6/A==
X-Gm-Message-State: AOJu0Yxpo/flj7FoUnxaIV93fHHfhxSbGX7pdgAaQgwlI4rGYWsndIZn
	OMqgk7NTZKaoe86bNiKRkne9Jw9NKp8LbbBS4JVAH1bUlJDoubgJfRpiRVloDlE=
X-Google-Smtp-Source: AGHT+IEShWgk5uHMDQ9acuZK2lt7tJucFS8smBzTFa6umBi5cv4vEE6ruG+NYLq5+EbxiwTM3Y9A1w==
X-Received: by 2002:a05:600c:1d27:b0:40e:ac2d:aa8e with SMTP id l39-20020a05600c1d2700b0040eac2daa8emr287005wms.51.1706000130049;
        Tue, 23 Jan 2024 00:55:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d5042000000b00337d941604bsm11553765wrt.98.2024.01.23.00.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:55:29 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] arm64: qcom: sm8550: add support for the SM8550-HDK
 board
Date: Tue, 23 Jan 2024 09:55:25 +0100
Message-Id: <20240123-topic-sm8550-upstream-hdk8550-v2-0-99fba09fbfda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1+r2UC/4WNQQ6CMBBFr0K6dkynSKCuuIdhUWCAiULJFImGc
 Hcrce/mJ+8t3t9UIGEK6ppsSmjlwH6KYE6JagY39QTcRlZGm4tGtLD4mRsIY5FlGp5zWITcCEN
 7P0RhLVlMc2o1qtiYhTp+Hf1bFXngsHh5H3crfu2vbMyf8oqgoe66nOrUYdzywZMTf/bSq2rf9
 w9rMVlKywAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ebvh8s265QxFni49wnU2y2UvCQnFwiVaxlPKftDp3qE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlr37/5S/udDRWGTL/xCwARccixW/K9qjZS5UE0pRN
 1XKahTSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa9+/wAKCRB33NvayMhJ0eZ3D/
 44ss6nIKCp8J1dfJHKhUx669JJLwrwlHBSi/lxaaBLdQICGahpQpOyWnupO9icgdH+Qu4hzzS3bFo2
 uOSl8wzSCQAEtdXJNSWXFstqLXfYje1qraC/0DjCQwpJYg/9shSBq/9XVyKJXLFA10DtMNnPEMCCvZ
 jYuCFuFbLPdaU73+RrvjIvotUQmSNDirPG8kbJHgYQ4A1a68b8B9PhN8vFJvsfk77FIZuQBQII59cn
 t3nU8oUyw9Z6uXvHdBxGtjTjie09qUPmm3dz87IsI8k6YM0iHyrIUSzBWIzP0FAYZlQ8zyoXUktv4Y
 auX4lYPRO498BVKo3wpn7blLcSSf/RxNeNgDMT42Diq1JoZ0FgmAIZDfKA9eaZk+G0mrgiVVuRVLSQ
 iJsjN8UFIqPh9dwQzdlcdXmXQlB3qcsTmZyaFJxyL5YkLg6P2Q9AdUIDnHZartOi4wUzIcs+hih+kv
 IJ0nAaqKhD6rwtRhFMD1En6lFg4C1mYNj9m1Orf5LMjzNbXomE8VxVcTrAaCextH0knn7v0ukX1tlt
 cmSqu11fG49zyVvxXD/mw3hFgLerDFW82RU62QjoYFEuPEmBX7DhAa+iP9KCO02kBFP3JEZXLRhLaa
 0xfxsghTEHJAGI5eLwMMGNSA3GGtej0f7YPwknC104vkVIKxzWO7JqzGR+xg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The SM8550-HDK is an embedded development platforms for the
Snapdragon 8 Gen 2 SoC aka SM8550, with the following features:
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
Changes in v2:
- Fixed ordering in bindings
- fixed typo and spurious blank line in patch 2
- Collected Reviewed-by
- Link to v1: https://lore.kernel.org/r/20240122-topic-sm8550-upstream-hdk8550-v1-0-bff7eb3a17eb@linaro.org

---
Neil Armstrong (2):
      dt-bindings: arm: qcom: Document the HDK8550 board
      arm64: dts: qcom: sm8550: add support for the SM8550-HDK board

 Documentation/devicetree/bindings/arm/qcom.yaml |    1 +
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts         | 1290 +++++++++++++++++++++++
 3 files changed, 1292 insertions(+)
---
base-commit: 29a509493dd4da77c9109aa54cc4c145ca64ec23
change-id: 20240119-topic-sm8550-upstream-hdk8550-899e9137ed01

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


