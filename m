Return-Path: <linux-kernel+bounces-163575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21F38B6D49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8624E283EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB870127B7C;
	Tue, 30 Apr 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSHOfsec"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D61272DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466980; cv=none; b=MY5OeGP1kUwMfNKPfCwjGcdiAPAwzmoTZc3jI6dUkk61UaTCj9xdY3KNUB24a4pWRvzfZXNOshXJoLQkcvu0XyG4RKvfXLEs8xZIk4Eq3UmvvgmZ5HMe/9ciLBUMMB6WrwAIdSwXH/wtIk/wOaBBumf1CaXX24lkYAgjz/7kbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466980; c=relaxed/simple;
	bh=cKJKjqwlm1QOrPFB1Ms6ycK6h0ZNc3GUi6oxWl9VtR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3NZwQVTOmPxOxB20nsVxNLMz3Pl2iwhuhskUkzeCe5ECpaxZqNPHHJSRCnnL+drAFX5iVk8za61JUU8QFkna5YwSM77YB5WG5+CB8Xm7FYmv5/fXvDlSzFBQWpqCvnxwueAUMJz+/YEO6gBihP1RzuQmgNETxWH8wENJNED26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GSHOfsec; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so49793065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466977; x=1715071777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PybDsCgKxR+rO4bdush11H6SUy+N1UT2t1snZO1mLjw=;
        b=GSHOfsecZYwxzIR5cRUfwnmSxXz8jlKGQdV0twyObUV8G93zH37S847gUbmyOLasXg
         njnbqGSWnqeVNv/+Zjfvyrgqyb484XFmaMtdWwDBDE5Er2LodWMXMXaRMvoWonDwKkX5
         R+oe02HMH1cTaYbS5TbQVeNIvehERCDmRD7XekrwycsyAfBPwQoDYi3JzyzQEBoN82I4
         sX2RYjAY5BOdL4VR4LZK7kfLA3wuhozlglGDxD796hIp3bWHLSDP5sgoVDzDaEmvPEQl
         deID2vz1ltPi5alAgyvk02IBPFRiPML4VtaqdQPXJaM9GWpuciFdD7pZ98Se8nU+jL8h
         at0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466977; x=1715071777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PybDsCgKxR+rO4bdush11H6SUy+N1UT2t1snZO1mLjw=;
        b=KlYC45rAADZ6tIrTDlnWMYn1ZRCniPo5FDH4TE4qk/EsnIqwftnaTMaRqbuiaRpw03
         Ip63RZcLj+DerRQy3cJ5yR1J9eZ3kg39XrWQKlTK8h/dLDNtUJSPwu6uJyHTnOjLEQSy
         LrmLWEqY1PpX0nks70FI2pS0XT4FnNLkbgfeEOvi4sZ/laVoKs4L4OWquBQ/DC0QViqg
         cYNbJTBNEA6ncIeH5rfKIPd45ZQxWkZt7XWflAmpBJ/fj8+O0YSabaIlSuJEEYoLIJUo
         RavUVmxV3PkOCcu+f09U4k/syQsOgNjotoq9JSfdH4XHNCwBcFdWuQfYFu48+0wmOXEI
         PpbA==
X-Gm-Message-State: AOJu0YwD17wAZ8eceb8v3j1VK8FDDYnKwvsnMuyjh/6mXvzrBNLPzZpA
	KTopjIVUUx21v9IzY45yTRosHZwzHldQFZ5UzPnS2Hugc7nkPEaMmBMbb0TNr/4=
X-Google-Smtp-Source: AGHT+IEcNRhB2dkAC4A9zIEj1/kmePL2wEKf3smOCDYv/FypfupSyp+A+Qtri7v3honyb0SrRIVSCQ==
X-Received: by 2002:a05:600c:3d0a:b0:41b:f48f:9e6f with SMTP id bh10-20020a05600c3d0a00b0041bf48f9e6fmr7448453wmb.3.1714466977687;
        Tue, 30 Apr 2024 01:49:37 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:37 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/11] nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
Date: Tue, 30 Apr 2024 09:49:11 +0100
Message-Id: <20240430084921.33387-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=jUN9PC94pRIr4c0UpzNsu966efw+NnzUhLR4wMvpQLY=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCMnEfOyY398WAeReluqFC7wpRyw2wEngjij 5hK8MtUNgyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjAAKCRB6of1ZxzRV NxppB/oCUkXbxcsnfbUaNXAuAbb+b7SOMEiX2Cw2V5XdYXqD3C3IVCsf+/qL5Sot14TAvloogGl WEd8a+R5WZaUkeE+OQY36EWWXgEFn+QMDTfQEOLTuwv/hEiL4Tk0JDXCQksL3dSNEUKTSdW+Z87 GBl9PcH76OuPe0u6jZrQGO+LA/GUNJd0ddkMCW741cD9KHMsGls3OcoCnfMa4f53yE3qh/K55WA XRG6NXEdy9DO+iq3DlxP82SYnC4gaBjG9bI2p8Z+wQfK9m/HgEdVhbw5LO6aRLYt+bUXAhJmU1U opLSQuIsqeLdHtOAWkftfIkBybZyK0/QzHK7jW0/cSam5o93
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Modules registering driver with nvmem_layout_driver_register() might
forget to set .owner field.  The field is used by some of other kernel
parts for reference counting (try_module_get()), so it is expected that
drivers will set it.

Solve the problem by moving this task away from the drivers to the core
code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1


