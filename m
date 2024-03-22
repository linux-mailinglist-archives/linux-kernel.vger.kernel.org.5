Return-Path: <linux-kernel+bounces-111994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6108873E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459351C22B94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D57A70A;
	Fri, 22 Mar 2024 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOYSpRjY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE817A13B;
	Fri, 22 Mar 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135495; cv=none; b=CHbJsXY1fcaNAQa6winXv0Is/uQlKC02OSly+K3HOIM2yh9A8uOsMChjPT1Xh6QPR5EpDzxaBKUEU6S9KGCKk8JPw/Lsg9VWWvsWSQhn48xRcbGrYpf03ImctyfqCsTrokxVbpPVqqxT76vk85AocBMgleysTE0bKDgy482+lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135495; c=relaxed/simple;
	bh=4rUBSyPV6ao55dHemnHVuLdadgQFFoAi54Gb6HBKVTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ve5WvXhEOpI7UNa3pE5g84lku0GsbEnY14e5QfTqoS7i+zeab2qolyLLRV6Uk6Xiq7SUrTRyOJxDidugkzLULUghpeMGvCRcsEReUUaDWjoG0ILXMjr8AdFdyQob3edXAhQYbmOgjM23D1EzwS+63vDTjwRgsgNZNzGEZTSARUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOYSpRjY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46f97b8a1bso330250466b.0;
        Fri, 22 Mar 2024 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711135492; x=1711740292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0ZX0mSNtR84zaDW6QrVcacYADFhCeQmdayKmvm0d6c=;
        b=mOYSpRjYH4EV+KEI/ebzvFSQsIEf9Y1VNiRWUcn+JW/QDdKMf05Qnf1l8Bt67Gc+60
         nGvSq+eg9ya1BVX6VJ8PHN9MoJ2vOjgoQfmJ+9X0pqHHOhLeTE8uS8wuZEec7hZKtSoG
         +HpMN2Xi/RWeB9RT3sed8KnCQ8Clw+lkqCSene6lejdQJU0a/OwxPJdCuc0rWVs6/Ott
         MGbuKCB/L/TbNHoWk2DI5AfOognySJCrZY207zhcyXGkRHvVcbgOuH3XLcDqIxwfLr2K
         OAqrXDd6EhQahR5Ti0Sb7HGw5qa8dS5PSW/JPK1TXfvN3uLpPRGOkB3fjb9+YNBYnx+z
         NHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135492; x=1711740292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0ZX0mSNtR84zaDW6QrVcacYADFhCeQmdayKmvm0d6c=;
        b=Qucw2QLnwwEe9ERvK0d5/cA6WPQxMpZEt7N9UPkqPz6LCsliZsL9LT1I8PqBHbd2rD
         5OMlAn71TTskxtFfhTdB0gb277WHU6Frsz+n0Eru7F0NYKlXMPPOFsyrmN+QdzSYqf8U
         /KWQ/ZT7w+60j/dRPpoDxfq2E25uzt7aSQ6HF/I9q2nT03s1LrRd30Xy2HKProsmLc55
         7WFof9/PuTz6YRMwm0ANkPo5R1W+pmTZ8PWhAzenVMro45pxzlGHJZruX9gtBufh8VYn
         2VvdhkfDoXXLNEplOHm2JN+6nhiVtxBviO3mPCiYbGfSBTknNWgaRKltkijebWWgU4w3
         K1Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU849NQ0kWJK5Ms03ob8Ti215zbOXam/MPDbCI8OmG2meVfu99+1RY4Mo1Wc3nQx8qA4OkJVf9fUug+tN3cxlLefribokH6BXEkDNYnWxr0OcgvkEnW9vzDrObe7+/EaQfav6Ek0c3LHw==
X-Gm-Message-State: AOJu0YzpHLtZCp7Z75I+8zDsMf/j4ZURDyR7wlJal01o1fXS/UKA+CvT
	ogDdukk8gx/feCFgpI9i5sLoHhA/2JRktDtiJgqqbrnfnuglJLG6
X-Google-Smtp-Source: AGHT+IELHgSsJUpsN7yw8plhcYvSHv3xoFGdy2OWmwfX2zWELl6zDgevNE+MyEEhH8Jiec/NFjsrXQ==
X-Received: by 2002:a17:906:3e19:b0:a46:c0dd:88f7 with SMTP id k25-20020a1709063e1900b00a46c0dd88f7mr483888eji.17.1711135492177;
        Fri, 22 Mar 2024 12:24:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7fa-7d92-6b28-0504.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7fa:7d92:6b28:504])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b00a46b87c32besm138572ejc.39.2024.03.22.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:24:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 20:24:39 +0100
Subject: [PATCH v3 5/5] dt-bindings: hwmon: ibm,p8-occ-hwmon: move to
 trivial devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v3-5-6697de2a8228@gmail.com>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711135482; l=2051;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=4rUBSyPV6ao55dHemnHVuLdadgQFFoAi54Gb6HBKVTY=;
 b=zWmOM6kGKZqUQ+f1L0py3IV+XS117E9ltKUW8/tcaqs7l9b5mKAT/Kh5w3bCFk7xCLyks7s5q
 vIrcv2/ZrWaA8uTw6J+NgLLb4IsEFsI7ut1VFEDUJXGbiYLtBxiUPms
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This binding meets the requirements to be converted to dtschema
via trivial-devices.yaml.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 ----------------------
 .../devicetree/bindings/trivial-devices.yaml       |  2 ++
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt b/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt
deleted file mode 100644
index 5dc5d2e2573d..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Device-tree bindings for I2C-based On-Chip Controller hwmon device
-------------------------------------------------------------------
-
-Required properties:
- - compatible = "ibm,p8-occ-hwmon";
- - reg = <I2C address>;			: I2C bus address
-
-Examples:
-
-    i2c-bus@100 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        clock-frequency = <100000>;
-        < more properties >
-
-        occ-hwmon@1 {
-            compatible = "ibm,p8-occ-hwmon";
-            reg = <0x50>;
-        };
-
-        occ-hwmon@2 {
-            compatible = "ibm,p8-occ-hwmon";
-            reg = <0x51>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e07be7bf8395..87b0dd9b0734 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -126,6 +126,8 @@ properties:
           - ibm,cffps1
             # IBM Common Form Factor Power Supply Versions 2
           - ibm,cffps2
+            # IBM On-Chip Controller hwmon device
+          - ibm,p8-occ-hwmon
             # Infineon barometric pressure and temperature sensor
           - infineon,dps310
             # Infineon IR36021 digital POL buck controller

-- 
2.40.1


