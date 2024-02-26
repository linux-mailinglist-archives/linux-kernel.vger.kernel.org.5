Return-Path: <linux-kernel+bounces-82032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95076867DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EE21C2C1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC50132485;
	Mon, 26 Feb 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAMLG4mC"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C64132474;
	Mon, 26 Feb 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967577; cv=none; b=BFLx+dYLKS7crzs97oq1DnOswMzXSwQ8JdAt88IWj6AKcZD/fEnJwullDWREE7uRNajyL1HTVYt7nEVwC5d7JpHyLkogDi0PzDFag7WoDOBrnQHT6r4KNb4emek/lGWgdpclqy9Fdj0/hHVqdwR8lD3piejdYqqFEzADQeElhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967577; c=relaxed/simple;
	bh=qfs9npxew4QZJ2PWJjpG7NN0CXdtBE3vktHY5s5LCmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dXkkHZmj4k/Wew4saBrih3JsOjS4YLZxsUTps0W0RysDTF2DxCr84kb4Ms9cXa+QXlevFvAnhL9Ta2TmvfDsDtpyEDr+aRwnOc423ujCmKw3JxQARHX16SrE+C+XMW8jIwIezBy2zdKi2Q6QNiLNSLNzHBLj3rIcbggvu8MyfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAMLG4mC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so4371070a12.1;
        Mon, 26 Feb 2024 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708967574; x=1709572374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHsvO2ojw3wAaSXT20nex1iPrH3WjQEzc6x+r/FAtBs=;
        b=UAMLG4mCy7Emc1QlJQxXFY7FYiSNAwxODcROdyPXF/n4LE41sgkX8DeiX3hBOP4i+B
         NsXZv7o3/2uxr2SeEogJay2d6j1KuQRiBohJ7JLB8/sMQ/TA+c/ThjWxyGFA+I+cgUMv
         lWO19AVGAdz1GIO59Z6OS+gUiX8O4vUBU+YMPEWV5yxkKiWDU4r6JjVuWhMmxMAHWStu
         joSYuuDN5et5Nwl6WGX06vDROT2ylLEjW0RagNZ8FLv6otSgafbuwKevzICzDZuqvDK0
         OBu4GucoJdWfVLpYoflFhSJFPZ2pSW7HqcHRlBOLJ5FD/4STwvvxXBso+i/B4vVuz4QS
         kp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967574; x=1709572374;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHsvO2ojw3wAaSXT20nex1iPrH3WjQEzc6x+r/FAtBs=;
        b=erSRFz9Iz1YjL/wSAbkYgKJx+O8+bQwKZnW3yIRKHPelimzggd/OKatcFKH5CdNBVA
         tDV8g34/erShfsTooZYae3kBniDkB6unoJ5ZLwh5MNRZHmZ4vPwJxVqXz3vMUAN7Qsq8
         5xV6gCPQtqMuYGKV/yAhP1iTe7wa1bSOvOz6ZDk9xn2p4kv1jfbAl47+p5x9+3aFY4WL
         LOSUyxtR7IqYW4t7VyLiZepCxejiERDfktYanHouivKo3E/IcXU2z14Mn5jXV7s/dm1a
         YVAs2LgKJWjhHFHVkXhSEayKzrdONpRgAhr4CUTbAREBKgeZrGIaZaxAIpP55p+U23kh
         zm5w==
X-Forwarded-Encrypted: i=1; AJvYcCUGhA1CSPl80BdbnTU0ulyyr+X1h8v9tf0gua1aE9rrUt4Rz5M6vhdEbF2QINyJe8UmXAzRkZqC4We9aKdDHSndmpqTm5+dmx+mFheIOAr4yy0+S4zLLV/UeYIiMatCUOYLsV6H/mR27g==
X-Gm-Message-State: AOJu0Yx2/tdOiRvH4hEL2csbIydEGBxIywG783ZV41B/rW9zZwZXx9gQ
	gdt5lOeA+vflcYO91i2Q23NhkIkKAC5USUqDwA63XGQV9tunRMk0
X-Google-Smtp-Source: AGHT+IH5frrm0IXBGW0E8O+sVSV0Pc15SBSqYT7kfDX8vi7iJPKdrue3XGDQNR9RWKKAlFGQL8P+Uw==
X-Received: by 2002:a17:906:b115:b0:a3f:5b9b:a17b with SMTP id u21-20020a170906b11500b00a3f5b9ba17bmr4675959ejy.53.1708967574495;
        Mon, 26 Feb 2024 09:12:54 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id ss3-20020a170907c00300b00a4396e930bdsm98989ejc.79.2024.02.26.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:12:54 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v2 0/2] arm64: add minimal boot support for TP-Link Archer
 AX55 v1
Date: Mon, 26 Feb 2024 18:12:38 +0100
Message-Id: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbG3GUC/13MTQrCMBCG4auUWRvJj7GNK+8hXYR00g7YpiQSK
 iV3NxbcCLN5B75nh4SRMMGt2SFipkRhqSFPDbjJLiMyGmqD5PLCpRTMRjdhZHbTmmXBWoWDEda
 07opQR2tET9sBPvraE6VXiO/Dz+L7/VHqn6rHmTG+81Y61enuPs6WnmcXZuhLKR8FA57YrAAAA
 A==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3

The purpose of this series to add minimal boot support for the
TP-Link Archer AX55 v1 dual-band wireless router.

There are two patches:
  - the first one adds the compatible for the board into the dt-bindings
    documentation,
  - the second patch introduces a minimal device tree source which can be
    used for booting initramfs images

---
Changes in v2:
  - reorder pin configuration properties in patch 2/2
  - add 'Acked-by' tag to patch 1/2
  - Link to v1: https://lore.kernel.org/r/20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com

---
Gabor Juhos (2):
      dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
      arm64: dts: qcom: add TP-Link Archer AX55 v1

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 133 +++++++++++++++++++++
 3 files changed, 135 insertions(+)
---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240221-archer-ax55-v1-73ed91a97c6e

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


