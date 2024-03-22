Return-Path: <linux-kernel+bounces-111992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30638873DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEFB2846E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3267A129;
	Fri, 22 Mar 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abXUh3P2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58E79DB2;
	Fri, 22 Mar 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135492; cv=none; b=fdYAZ9fcaSd7lm8YRnnzemZSxG37IE++KIV0t+Yc7AMttjioXrS7gr7BaBAfh8Etz/MjH1k2w/t1F4orkB4ervbD0RyeYlsEzYK2/QddiaCLWyCub7+8sEi0pT2WxX2BOUjHnRclgp8mqYSZHhIyqKBRh8cNkCSNFWBiQ4Rjwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135492; c=relaxed/simple;
	bh=ZcfJW77o+avPTeg2tdUvNFQMCBaJDocyWKaLWxFMj3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyooqmvduGAnDKOcklubqs0ZV4aJ6v83/3k4H/z1Qz8y4NVzy87FYYXkXjI0tFQKnGaKGbqWjWjR5L3GaG5926LkCALPTSoLHUxYzLLKu11KYdj6PTpMpyoX52HU3QYt839wkk1JENA6jOk2lkUhPWzBq3ZtQKCVQYRY056ONOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abXUh3P2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4707502aafso429443266b.0;
        Fri, 22 Mar 2024 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711135489; x=1711740289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0ZcSySu+KpK49bvvLZjoVLSgT/8Vz6AsAvPYvNMC5c=;
        b=abXUh3P2mQiFeYAw2zH3/3mIfZiF1lH5J2MVew8uMwE08ETbuT66hMR/F0b97itbi0
         I46T34A7gidqcN4TOrth/i640QUZ2rsBJsloT4EzgCiZ3Xgkp4T2BxnuINbH3sCp8pPB
         Gbz2rpXoC5weH5i1xKsRcV86mRrxUpQbvk7GBknqQ0UaXq9mL+ROfwk6rEmiUhbLQFIo
         RaERuLSCy6C5i40r3+DsjvHNWbaQUqpdTB72q3QaE54/PPmtrLOa7RJK+VFEXWRCx8fX
         SFfKoy8UF17IzMzHnBnEpfDueUpJLXlEEPE65nX1XKs1+E9P+RO39vF1y4j0cV8rXzx8
         R96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135489; x=1711740289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ZcSySu+KpK49bvvLZjoVLSgT/8Vz6AsAvPYvNMC5c=;
        b=BFbvVjcvlqhw72AIWYcx9K3MGMXMLCqJkMs5U0YASf89pOfdlZnAHkZTe3SUVg8J27
         PzWLCEEhejuSrrTzA6Ydx5XTQIDUhelqOhSgq6WEK+htsprI4SPZ8kvnxBY2jO9POpHZ
         NVIrCItjusPan7MMObnMmk9kCbdtCqbiBCf9Jf6B+AGPA+tnYQswHhjeowUSBRha1bnT
         8j8sxmoMpkt0sBMWlE9g22HCKo/eTvmwyyJzinv0X0wGm4UYCR/062TbV/u3TEEQ1gxI
         7tm+uDILT5W6FDb+3Dleg5q5KPSIBIKr6PT0kqdElP9j2bMK5gx1u0/T2H0XwA+C85Na
         0OCw==
X-Forwarded-Encrypted: i=1; AJvYcCVUGBrpZ3whM3gKBP5JQ5p4sqJD2VcC3Xc8R2RDScM/HDAZvcpZ141c7P1jXxAIjQGLGjeQe17EdYZI3oQLmfx3Dfyfj3UIFpzXOgw/GMwuZwkzQ7hVsHJGdkuvKqoKOBPIVvpFIJ/Lmw==
X-Gm-Message-State: AOJu0YyhWDHgXEM5bl+LQ/O66EEVaT58NFDUAGcq2lpfUz7KRuHs8i5v
	4h93MctAiVOjxOADIZVERog+DwTRH2rsdooyR9G3gR5SZXBwEWEw
X-Google-Smtp-Source: AGHT+IH2yEbV6zpZDo0LYkd3n2fFTzdL0Im5jXNMEzApVu9s22IYYAjdujzEhfw0+DAGNdM8vqJYDw==
X-Received: by 2002:a17:907:940d:b0:a47:35df:3d40 with SMTP id dk13-20020a170907940d00b00a4735df3d40mr578759ejc.4.1711135488705;
        Fri, 22 Mar 2024 12:24:48 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7fa-7d92-6b28-0504.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7fa:7d92:6b28:504])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b00a46b87c32besm138572ejc.39.2024.03.22.12.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:24:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 20:24:37 +0100
Subject: [PATCH v3 3/5] dt-bindings: hwmon: pwm-fan: drop text file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v3-3-6697de2a8228@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711135482; l=582;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ZcfJW77o+avPTeg2tdUvNFQMCBaJDocyWKaLWxFMj3M=;
 b=L/sFLNsHGNhO/rLBb+tChETQJOlxvloAo8fJxkna9N5FfqHJDz7Pb+FiDVWGj0Ns0klwArXB/
 pp35gYqwpowB0zH8wqWdg25xMJ5RkM6jU4rix8DnDfF8Q7bQK00/nsM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This binding was converted to dtschema a year ago.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
deleted file mode 100644
index 48886f0ce415..000000000000
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to pwm-fan.yaml.

-- 
2.40.1


