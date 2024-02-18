Return-Path: <linux-kernel+bounces-70211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE48594DA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F5A1F21E65
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7EEAFC;
	Sun, 18 Feb 2024 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="ISpBGnAI"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85DDF505
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708235340; cv=none; b=uu+PdzgU10dHCATcXFLZSFDiaP2RdBuEO6HYmq85t+Xdv6ctZGmQ2g5SD1dh8ZsZWL4H2pcAETS1z4zvLwRTt0QQ+L7SVKalEq/HOnA6CduuW8yUFTr959CDnYPCRx3L2aN0BmPuG03tnZ3AGLUhEj2yOCyEm1ssNrEt5U00AJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708235340; c=relaxed/simple;
	bh=wqUin1sjbj77sZxf5CBubb84h2AEImW2QytVCy0e+kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSw1fDSNkKvLLkFA3Q4WQrKU4b7fKPjX14kBAi8CCi1coByz5lrycluFwjFJxcSRA+I3W08QagF8qYPjYwqoMGVcObeG/hod8n71brY6aAzlv8+99nsKJ0B27vqb0YfDxmtcrnqTEc9ltDqjY7tgc3tx2bXywy0tSy5Od7mbEfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=ISpBGnAI; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21e95f4ed73so316167fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708235338; x=1708840138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyLVMnMBS10QM3fLaOhCo7hMew07au7N3ayvJLnFVOw=;
        b=ISpBGnAIDOylGzkmk7yogpp4jo2t0vUn6KfEaNSqikNP5Dhj/Vy/p4R7oCS0Cm5u7+
         gywGuaej0CkWgpAWyRb7riUP+gLG6Gms7SYti3n5WKjELNXb3mTXLZPz9Muua9zYZAbT
         Fot7lsWKCXrPBASdb69D/sI2MW5Mh+e9Oepb3+pWB0TnSP9AJvTylUj2SZlon5s++zol
         +nM+EZiJ6O3yMs0J+MVXZvWEdNAoMR6Cgl6/2YUmX1wSa/V+kX37SAbEp6cGhIa37d6Z
         gJAwX+lQCBnN9IXXLe6hUIc8qhpwDUl0IOOuTK28/5OR0ZFVNmkqgxA1NLyXemmNmJnM
         bU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708235338; x=1708840138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyLVMnMBS10QM3fLaOhCo7hMew07au7N3ayvJLnFVOw=;
        b=koGYIiiT40lJACg8wda6GegYRrOUF8iLKGuIsmXodbI1G7E8W2ACB4e+cbQlZ66xT9
         n9sksZ0IovAi1kx5vjmtoGHJzHhoJmIoi+Y0BHkZDeY7lfRActiXh2w0I83+9fMHCG+0
         FgUDLnfJZx5lBkwrQ1Ze39KT9AbKugVhw6gJxogHO6wMDMq5cOLMluuE5AzsaxUvY2Eo
         q5vT4OW1zodSbEyswwcl15lwwOyRgO5XJjnYnvCVVlkaMymN1TRu8UuaangYN+WI2VnI
         x0gartP09kbzdTMkrVbIq34duO3k72yFxtgE46+yob5UEpLJJk8GAc26bhX9AYvlVXPx
         D6jg==
X-Forwarded-Encrypted: i=1; AJvYcCXdSlgTA6h9tB07Be4R850cxSFBME19DEeslPZqlDFaQDU0Dq4Yx2XSDUEdiEUfSjwxgKkJXCowBICK9BzVKU4ZkmCsEJ+hQ1zj7ylG
X-Gm-Message-State: AOJu0YykBWVLuD7/1RtzhYPimQDavr/H+QEdZm4VHzQERZj10acQSlmB
	CpZSl8bh47I+ZOsvxUdpD8XB0bm32VDet+sN6G2GS9Ir8NMo3Ab8E/YH9afoMD8=
X-Google-Smtp-Source: AGHT+IFtBEXxhgWx4BRtpNVrNjs9r/2pPBzBxQBWky0++68wT9T2I5azFbRLbgCx4HXDinhjeMHIjg==
X-Received: by 2002:a05:6870:724a:b0:219:30ff:ca0a with SMTP id y10-20020a056870724a00b0021930ffca0amr9361287oaf.58.1708235338029;
        Sat, 17 Feb 2024 21:48:58 -0800 (PST)
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id 32-20020a631260000000b005d3bae243bbsm2394808pgs.4.2024.02.17.21.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:48:57 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 3/5] dt-bindings: iio: light: adps9300: Update interrupt definitions
Date: Sun, 18 Feb 2024 16:18:24 +1030
Message-Id: <20240218054826.2881-4-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include irq.h and irq level macro in the example for readability

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v6 -> v7:
 - Removed wrong patch dependency statement
 - Added tag
   https://lore.kernel.org/all/20240210170258.17fd1099@jic23-huawei/
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

v5 -> v6:
 - Separate commit for individual change as per below review:
   Link: https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/
---
 .../devicetree/bindings/iio/light/avago,apds9300.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index a328c8a1daef..e07a074f6acf 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -35,6 +35,8 @@ required:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -43,7 +45,7 @@ examples:
             compatible = "avago,apds9300";
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
             vdd-supply = <&regulator_3v3>;
         };
     };
-- 
2.34.1


