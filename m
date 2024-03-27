Return-Path: <linux-kernel+bounces-120509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32588D88A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915A21C26581
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA462C842;
	Wed, 27 Mar 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKa6fjnv"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D62C6AD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527281; cv=none; b=HsdOlAeaHrxwBl3e17JNjfkYx4doC8ZVKKmlSER9ClxhQUamuEOpowggcVlG2vC/SUIQkhjFY1vJXhYCf2s/AgikrwLeYt9bc8GHO8vs3WezGOndO91SCKeIHRX2gs7uiq5R/5f5G/95fIS+w73puY1bUVg9RWsJQT1xdkJWbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527281; c=relaxed/simple;
	bh=J+RN3hJRTTGLVUedvZwunXC+U3v2nB/A62NUBTLgzc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NjPzjfnOzXAmTRM3wMNzpQymaoS7Odl2LiWjW85241gmBHXtwmA7r/kDqwJF0KIC9cvDEiTP+Ghaa+s1YiOaVQH43PEYtjOVOSgRph6t0DRYMnDcumv5T2L9A9Sp9ErcRRSntIIj4m8l7CziKA5+0/q/tOWofJdO6ih0u6hMnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKa6fjnv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bc8cfc19fso7107491a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711527278; x=1712132078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGgUTwKlHME2QDnguByWBsbbg6zeHGMGTyqt6xg/ofo=;
        b=aKa6fjnvhABIv4eBDExxQ3VKmne7fLBmf53KFQcyd7lsjqvYXYrgQDVfePiVOJUP4O
         F0fTdORMqLkYzT8EHq+efyR2KVpXre/TpS04wc3fZA291/1b9+Ai/VgZhtZuvsnZ/sKt
         gcqN1zE61qywFBSIzs9q75l6pRBbbl4At87CxLB9wCX78mkMp1NyC0kxl7j8Y7v6WN7O
         hXAzzOUsrTP/mvYjI1utAxhSHz1FDjX7wieicq0+Kv3lfUSPOjR7gz/RzHwea8P6Tb8J
         S2NHIyKqictXYDXJHme8S950R74xdp38G3CrKcjEVvmC0mtofkzLoDI1q4ixL02HKktC
         zDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527278; x=1712132078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGgUTwKlHME2QDnguByWBsbbg6zeHGMGTyqt6xg/ofo=;
        b=kFuCKZD1NQ0b7E4P1+uBXX39nwc3zinKdsqUHTfvL2ND/A8NPaw/aJSuPcJowGH6YJ
         0JpV5TgOX5JlAWLReo+HcBmLUkF6aWoY64eDQ1NFDNybcsMQATqUs08sEjPITYMRB8iL
         M7V/EyRTzU73NfUxg6YqijDXuLaZedUWVoh8I3QaoURBtgaQ/uFGrU0ywSODkJhA+jwE
         p/SyalN7ARd0mS8TdfaQg/PEt7LVHRpYD7klfYrN92EDmy4cMAJMm/Fn9ymAUVDv30Fb
         rvEeoLblXhFTs8lHGRJGFxnwKU15g0/NXLr258o+RZp8YTDWNKYCE4wEqYeaafWYFocK
         3gIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpTBn+RE7GKlip7daGM09dJeTThrYdARXRuIxDSXvF3mhFzUSPUyUKsuAEoP2x4EiBRdpWraBFWN9W7RrZ8JFkBo5WWUOfZViOhJD+
X-Gm-Message-State: AOJu0YxHkVh6mHE9eN6V1ZiJSsLVoSTuxMp35Ha0xrmNMZGOa+Q9Z6rR
	QCmxV3VIrvgu9xszfvG3rMzMyLabXAL5OcbjlTzyqbigUgto7PDHcRSMeJPKARA=
X-Google-Smtp-Source: AGHT+IF2WYb63mDp3YYRsu55oQqYhgUaP/nqOCYF9KAD2K6IRNfSBG5mnyYgPX2fUXSl5J4iimH1Rg==
X-Received: by 2002:a50:ccd6:0:b0:567:3ed0:47ec with SMTP id b22-20020a50ccd6000000b005673ed047ecmr2379022edj.23.1711527278609;
        Wed, 27 Mar 2024 01:14:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id ck5-20020a0564021c0500b0056c1bf78a3asm2386723edb.28.2024.03.27.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:14:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] platform/x86: MAINTAINERS: drop Daniel Oliveira Nascimento
Date: Wed, 27 Mar 2024 09:14:34 +0100
Message-Id: <20240327081434.306106-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to Daniel Oliveira Nascimento bounce:

  "550 5.1.1 The email account that you tried to reach does not exist."

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51d5a64a5a36..de17c0950d83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5207,7 +5207,6 @@ F:	lib/closure.c
 
 CMPC ACPI DRIVER
 M:	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
-M:	Daniel Oliveira Nascimento <don@syst.com.br>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/x86/classmate-laptop.c
-- 
2.34.1


