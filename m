Return-Path: <linux-kernel+bounces-125160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7B892159
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE21F25C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEAA85620;
	Fri, 29 Mar 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJYDXYDq"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E417E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728828; cv=none; b=JGMQIplzXtzHN7tmJTmPsiTP9owwxseTiq9G5OrHgjZBEm2kmZEvQPGoSCauKB2EtYHpb4K40BcJACNGTF26oCHLD3s+JrCM07WgPqN6tWj0J2z1WTp2eLr3ESqppANkSqH5UpeoZ4CsKQEOeaTlQ7qTDnWPhJNyrL+pfRG9oCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728828; c=relaxed/simple;
	bh=6sSD76TNLvgq+okx//hYnG7lHu+6GFWKO41IVzMhE44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mgxZFupw7QDuL1G9TauXdoVVqKwitXTXeOijDmETLzi6NTTmReMm2q1BGKkpHDTzaqp9Y8LW+o/xIhH1WHmF2NITtA9JMfYdERCE4mJ6oxVBIS5f9raW8D6GBwJyWfqelcxq5dfOoxF1yMA1VH0p8ZNYdZmfA+rA3n7rljW/vNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DJYDXYDq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41553b10600so2131995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711728825; x=1712333625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gh4OPHFge1SpQRgcQeMYXBAOtsZdIF7ML/uhMhowM38=;
        b=DJYDXYDqntbw/yyQrALJoNsv8JjexVMe7seAeXIpYbWFD1FFW8THXsqe5Jqz8xWP4l
         uYg+KW5PP21VoEdyG5P84btfzpciLdib0CdYkEtJbu/obSqvpGxVO19Cga6/UW/KLreO
         z1sjZIB/7j8Vaat0yXdAxpKMkmCWj4WrOOa2gHMvackjZyMl8EVlZ2y782Mims/zsx5y
         4tdNMGa4WjJcu4ieA3zqfzl/1IiZcGZY2xKMcCay564Ej4hnQHPBwJmKnukQ29n90dJD
         88mgsno0I/aCrrmG+ygNA4CkqThoBWHGhJTK3iy0sWAXtfhU6ZtQ8TfG4NgscM7Cz8Rs
         O9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728825; x=1712333625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gh4OPHFge1SpQRgcQeMYXBAOtsZdIF7ML/uhMhowM38=;
        b=Ts4UBqtQxasYkMCslocxSJmuRUuYozlDkoXg6P1M0IiRp5KMUDL5/q+k4GLeb59C/Y
         IUvXWP2u0+3i++gk7skKcooPASNWOf8FceOahNe8unx6brfQjqs1UCobEyrnc800Q+Wg
         bvkJyk/cODcPN650IfhbpiI044t7crzzqiIgnH/EPunvCau1azojl8Y8vvz5UMKdV1n7
         AHhuWTbRcnEKa2XSDFSwgVhvhylnmRDwSjEVg2gowc8GTNrmPHWHAMKtLmEryzcFOvUA
         t+icuUlS25xScXasF+BMWXRj0kwURSVquXwtH+V8bEszhROJTNKJ840sTLodSuhiTj5v
         y4Yg==
X-Gm-Message-State: AOJu0Yzifp2shzYbPce3E5owPxey6yqwIMVHMjYEcHp9ECg8fGyzqaPx
	nE7qzYtKbwzIiY0XZ4GdVLR7xyIANN8n0D7kfbj5qhWcfsAe4alaHgv4V7fWvAU=
X-Google-Smtp-Source: AGHT+IG0CoAHJub2fy9DIoWV7x2/rt0aL7ySMWI/Gbhp6LH26UxWI1WkFFZt7hQn9W7mKV0quDz9Hw==
X-Received: by 2002:a05:600c:3b17:b0:414:1325:e8a8 with SMTP id m23-20020a05600c3b1700b004141325e8a8mr1987737wms.39.1711728825037;
        Fri, 29 Mar 2024 09:13:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b004155568fa99sm214878wmo.36.2024.03.29.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:13:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] nvmem: layouts: store owner from modules with
 nvmem_layout_driver_register()
Date: Fri, 29 Mar 2024 17:13:34 +0100
Message-Id: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK7oBmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyNL3dz8lNKcVN388rzUIt28stzUXF0LM8PEVPNEg7RkIxMloMaCotS
 0zAqwodGxtbUAnc+pwmQAAAA=
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6sSD76TNLvgq+okx//hYnG7lHu+6GFWKO41IVzMhE44=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBuixJAyTn7p1VtxvctfpDbGYhS30XhhpWPDER
 MqyfvGSfPGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgbosQAKCRDBN2bmhouD
 13ghD/wPJfgPhlKZF02Wc3Lm8/apEk2joR6acaoaRlf9Ye1eUj72/KHNtUMmMmihaY6CXSV/Ddg
 LTLU75QPRTKNKxiSgKN0/S7eLxR1zQfv1Zs6B8OB+7cRJOtwNe2Ko2d5OdiQeCvNCRHeQEx79/9
 CyLs4eAiAShE1x6WXxqwKSlerDEpWhxHYAqE9o7rrVeNlL0i81E1c94B9+4RQbQaKw+/D+YUQPx
 b7LAEyAxwP1yEthlJ7Ts4Pmg/ipaTCOTmnyQI6er4BWLh1hfHliBEylLnVmLfo005yZspko0zOS
 G25q3XH+rWxnCiTBk4Qr5mT0U7Dex2c+UYEz79/B0kV6PBvBnZEU65UTnl42hrqnXlUCiFl2y9J
 rGRVHzeXSSwSEPVFtmacoks8Wf9910EJqVDAug7Z7R4PaSazdRsBisuJ+zsXJZxT2p9Rrab7gxx
 FptwxxJwZKXpTCQPSCJTDO4DKncxnMM9r0jvq4XNUdYY3b0suFJ7ybO3f53/R28ylDdsOJ0FXeS
 7qn58QaYDUHyIA4T+inkKfUbWrPRvRTu7mmDyh97dr3kdD1hZ+DthJk8KD+qcKoJr/2hnw+6Fzt
 ODcmzXXdR8v5L8ano3Rh55LPr/Q3rJI0ymYB5DhGQPVu1WgrnR5irjpSWiPIeb+z9vHpiBV+GAH
 DUXDLJDNTC8p7UA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first patch.

Description
===========
Modules registering driver with nvmem_layout_driver_register() might
forget to set .owner field.

Solve the problem by moving this task away from the drivers to the core
code, just like we did for platform_driver in commit 9447057eaff8
("platform_device: use a macro instead of platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
      nvmem: layouts: onie-tlv: drop driver owner initialization
      nvmem: layouts: sl28vpd: drop driver owner initialization

 drivers/nvmem/layouts.c          | 6 ++++--
 drivers/nvmem/layouts/onie-tlv.c | 1 -
 drivers/nvmem/layouts/sl28vpd.c  | 1 -
 include/linux/nvmem-provider.h   | 5 ++++-
 4 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240329-module-owner-nvmem-861ae7a0fc24

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


