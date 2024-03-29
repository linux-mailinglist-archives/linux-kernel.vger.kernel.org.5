Return-Path: <linux-kernel+bounces-125161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2489215B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7B9287FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A104985C46;
	Fri, 29 Mar 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfzgP/S/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153750A72
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728829; cv=none; b=qATwKJ0hMVAA8x+TUFjYDMAcKzuNffyzsbIgvLt98XUUTAwCx10xXfpkg7DwF8Qqx+jd8Gv5sKH/KC5pfHPY/dwYlvFsJro+KtE9fMXu4gcr7lA+3K9lMR6ySBx2CdfiJV120BdulbAiyGd+AevMSW2LqsU7R7jfjtwFwwlOGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728829; c=relaxed/simple;
	bh=xKnlZub8/eLYJI2vzunTToUncXuCG4OEL1Cd4/mpZFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9ruDd2PhzDtFtEqMFDrl6wx04p1H/a7T9du0cwcfQ/fOtevnDUIrLFC+NFzsPl2yYGSfMSwwm8hsNwf04M2Jgywb1EwOrFgtTQk8jVUblbhWjgvEZhTwO3N/8AKVf3g5x6yTVlQFl7DPdBBk1aNFJ7w8v9uVM/UzzLmXY1AV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfzgP/S/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c5de23fso14577335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711728826; x=1712333626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CflbPnJBfIFWRetJNdeSOg0H8c9h0tnwdQ9Sgj5VAjk=;
        b=QfzgP/S/gK/K/ofJ00+3A+4CC5IlNtbw+RLVJD467isi+ioy/gRPIm7NUGM2uO7F/n
         jjTTUdQNoZAVwTotliTk+jYslbHtJZ7Dizvzjbc10ijkeTKs3ooDFax/d5sWFfMp2N49
         kzSnDIlcnlOCvD+aeWTqK6REdKFEyrNj6j4TFYIoQs/hSXxISS8XET8rbS1HrvOgg72Y
         vc+AHWuO4Ic9WjBn09TTdQgiqqHv00fJQwb6RRV5fkbOQI+vUptAeopAlpGIV6dapRwE
         bw2Ci/weqLy6ouLZzZD4yeSYQ4/Reld3IENaYNxgF/8rGqBmdjucp9KmX7O+3a14n+Jo
         dazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728826; x=1712333626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CflbPnJBfIFWRetJNdeSOg0H8c9h0tnwdQ9Sgj5VAjk=;
        b=Ym1WyE+eq12Apj5tqBIwh3EStMGSGheuN6QvcrM2VOYmWuckL5e1YiXtzPra8hOdhs
         6FFr6YqRr/IA2aHIyBeKjCe65bFyKjLeAuo7bnnzzHbzstHhez3MUaLxj5T9TzXo256E
         3a8H9fGZc0Yfjw2660+3/J5jxx7YlZG2ajvYk7CaBAXOPKR/wRn88VxKGPuKQZqlAXhp
         osWFyXUQvMQNFe0V2ftz5fGLZSj8Ahskjwkh6NgXj3NuacpkoXpgjDxG9kcLM/eO4jU0
         CfSf+tlSjF+J56KWhGCVW90cs/AFG2ENgjqfaqrZU3WpNW3ukqW2l0UPtngz44CfpBgy
         vf9w==
X-Gm-Message-State: AOJu0YxwNt09uEYmxMprhJWhbxfNHaRNDzI9jRv7TX79ZOeOuo8Cv1Q4
	xA4BKRf60GgbsXjt+idUa4U6KoNVK1dpBied1PpZPFBKk9s3QNKL7W4lkG32gus=
X-Google-Smtp-Source: AGHT+IFnagdAH2ofucKH6gCveAbM6xu0YsqiloWKrp+NA8eW73wn8lfVBsSRweH1HZ+wLzaVc9u3ig==
X-Received: by 2002:a05:600c:4509:b0:414:7e73:1f5b with SMTP id t9-20020a05600c450900b004147e731f5bmr2026077wmo.4.1711728826426;
        Fri, 29 Mar 2024 09:13:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b004155568fa99sm214878wmo.36.2024.03.29.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:13:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 17:13:35 +0100
Subject: [PATCH 1/3] nvmem: layouts: store owner from modules with
 nvmem_layout_driver_register()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-nvmem-v1-1-d700685f08e1@linaro.org>
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
In-Reply-To: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xKnlZub8/eLYJI2vzunTToUncXuCG4OEL1Cd4/mpZFc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBui0RCykLRErGn5WDY86JIhegIPR2tSNkBn3Y
 yAgWZlPpFGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgbotAAKCRDBN2bmhouD
 172AD/0cCsqNwX+hhrx4LDT25yG4uTR0GlXIz10l7jqz9FdR7f+ZeLkrIVzTaKgLkLgNcqKcEiO
 U/i078oicU+jsCsR2ffVhsjrLcn7J7x+eistZkTp4grA5CPoipuY1tuZvop6pswYGGogDumhJuZ
 NnOs8Cg22tRxpdxMR3Ju7NJ20SmB09jD7rXEQaXhKFo/tREmfGHROvfJZbeCbfqElU2wjaT6lW2
 4Fstx11254+7C93EDRkYxunV3OUjOQ7fA8B/7mvAg70X6UIIzc7zA/ZemS5ssshRXScw3gSEicW
 EuHnx2buU8aK2wMfcmvTrkShpaxYxvijgzxOa1ZZahYwgrbPBGNTXaSmw5J8FiQfkTqvzA50Q2Z
 D9oAjfVWKVNB9ea7vtUgTGvhKM19vU6Wom93adYlxneWWKYD5M4ImkcWd7BYKj5WvL3sxMn3om0
 Kuk9k8eR0heTdhzpj3hzkTrctt0Ege9LIJr2R2mGQh9El5FINktR4vZa/8DraeVQdjPH7twsUo0
 g+yNJVmgrJ4+3JmkW0FyaIrIGxvOnFUHfs1oAyjbeL7EsKRXcf1AYnQYFCc3oX9jSa8v70dDC+0
 eZ5B++G9AlaLXWgFuo+RdkUDCdYn6RpCbVkiGxQXb+gP4rOPkkYK776xoqghRYV02dfdAHhqscU
 HEehWZEnhWbOmog==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with nvmem_layout_driver_register() might
forget to set .owner field.  The field is used by some of other kernel
parts for reference counting (try_module_get()), so it is expected that
drivers will set it.

Solve the problem by moving this task away from the drivers to the core
code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nvmem/layouts.c        | 6 ++++--
 include/linux/nvmem-provider.h | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index 8b5e2de138eb..64dc7013a098 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -52,13 +52,15 @@ static const struct bus_type nvmem_layout_bus_type = {
 	.remove		= nvmem_layout_bus_remove,
 };
 
-int nvmem_layout_driver_register(struct nvmem_layout_driver *drv)
+int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
+				   struct module *owner)
 {
 	drv->driver.bus = &nvmem_layout_bus_type;
+	drv->driver.owner = owner;
 
 	return driver_register(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(nvmem_layout_driver_register);
+EXPORT_SYMBOL_GPL(__nvmem_layout_driver_register);
 
 void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv)
 {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index f0ba0e03218f..3ebeaa0ded00 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -199,7 +199,10 @@ int nvmem_add_one_cell(struct nvmem_device *nvmem,
 int nvmem_layout_register(struct nvmem_layout *layout);
 void nvmem_layout_unregister(struct nvmem_layout *layout);
 
-int nvmem_layout_driver_register(struct nvmem_layout_driver *drv);
+#define nvmem_layout_driver_register(drv) \
+	__nvmem_layout_driver_register(drv, THIS_MODULE)
+int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
+				   struct module *owner);
 void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv);
 #define module_nvmem_layout_driver(__nvmem_layout_driver)		\
 	module_driver(__nvmem_layout_driver, nvmem_layout_driver_register, \

-- 
2.34.1


