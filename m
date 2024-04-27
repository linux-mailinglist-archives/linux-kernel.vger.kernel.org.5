Return-Path: <linux-kernel+bounces-160895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022638B443C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5654D282349
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787033FB1D;
	Sat, 27 Apr 2024 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DES1xUTD"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CD39ACD;
	Sat, 27 Apr 2024 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714194708; cv=none; b=f5pIXnax6u5JRePSijhxo6gytyndGlhvo7GB28GLIzOf/quwgYi5XgWKJ0yegNrzGu0t3jJ70sYeu0xkg8w4bUaj1EFiqX6R3twZwGi0iB7niFQ3tztqHM+sycdx96cKVO9+uLc1bmAkDuWgow2i5ooOSFmOSqpnAAuymi/hFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714194708; c=relaxed/simple;
	bh=8VRM2VkcgoEktDYSv+F1ch8yrYyKhYb70NjkmOM2jwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nIGjZFXvKi1rPiNS65ojL+2OjyuSmVvniVSxMsCkwlZ+YRKW5i3S/IMXiGEPNTbPvEQrihwn+DwHiAacNpk/jxbPQGtsh8up/KooUWT+OMe/A9lczJ411gMRzJHg6jcBsp/uJB4L4nNeO7MhG3L0kE1gbr6dEGQ4uM/6WUetZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DES1xUTD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso2693777b3a.1;
        Fri, 26 Apr 2024 22:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714194706; x=1714799506; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfvio6Ar9p6N39vgdGylkBAH6kePM0TVQXG+0k++jXQ=;
        b=DES1xUTDojazXeD9BwWuyUF4ciAtdxiEfzqRpoK4bGbR2hWj86wMrJKb/KE4R3Fje4
         KiKL8Qd5i+py/A/dQtnw9jhZ1rn+bmjwJ63j7GQj7edxUrXq+tw6k1dWa7XRzZDx0YAw
         oh2GjvkQzjA5dsGgDHJ9SJyxLaGLIn4VfgA5C6u4py0xfmij21c6sNFRN7qKMAFnbRv4
         XEFkDNApyyydsgG7EYxebQsoKU0UOISshBcnG4Dh3tZ8ge4Kh+7aJL6W4wsWqBVvQSHh
         h4rl5XBb7+REYAFCIbG7iZeS+12rFDcTNP8CIqcBhKZPYQjSBlLGJIuh0g/Xxvyxt2Le
         iBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714194706; x=1714799506;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfvio6Ar9p6N39vgdGylkBAH6kePM0TVQXG+0k++jXQ=;
        b=sUh9k+qeOZneeFAZIKrhvftFaCnFhn8ZsYVfu4N5+uvmk4ujaZyRZywsiR50Ugwal/
         /rRP2t4ZcS4pbnimTx4wklrM7K1NtroJW3bwVy3T8O3NFoz90UMX2A6otbPP257nITli
         LbkcK1O/rIrJjumqj3YUT8KEWOL7awHfbosvXvsy63UqwT791j/BW6EsZRiEQ0r+c6g1
         2YWoaHiuN1+FLV6J3zoFur93dSyPpD4kMTDbtrg2kmmJ2o8kN/gAbHHojuTnzWg4kuSH
         P3Nq65nvMcf5Xzc6P37Zw59qdZSNve0a/9Jjf7CuONY3nnhjhoBnlinsS5NopWOVeqdQ
         D+CA==
X-Forwarded-Encrypted: i=1; AJvYcCVVRlmH+15WINKnIwF9ptFUDz9xtQnZKhThI3+v0ZttPby1u3bRahXoXACtMNfBQvP3IpG6Az5jxD6UY0633O0dYh1mmS7sxyt7zhXxWG74lcna1L9HXXCSvUqVHwB1yWD/ECjg2zgDGg==
X-Gm-Message-State: AOJu0YxdxOfcjMYVqq+99JO7yVWwQ9rrf/QNSLRrqM1bTaOrtLG9TwbE
	v6V5CF5LnB4RXt7Y/e8Rj3NuVn+3JgMqIV1z9uQ7SWAF45ENI6+mgdq2MbHb
X-Google-Smtp-Source: AGHT+IHYcnpjBYzCXvO1wqBPivcKX+9ihfCD+irSi2I8DsGpMsRGKN7ZvL+YULYlKfLouvxF7pVRxw==
X-Received: by 2002:a05:6a20:2454:b0:1a9:509c:eba6 with SMTP id t20-20020a056a20245400b001a9509ceba6mr7691260pzc.25.1714194706049;
        Fri, 26 Apr 2024 22:11:46 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.34.32.15])
        by smtp.gmail.com with ESMTPSA id cb17-20020a056a02071100b0060063c4be3bsm8108513pgb.14.2024.04.26.22.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 22:11:45 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v2 0/3] net: dsa: realtek: fix LED support for
 rtl8366
Date: Sat, 27 Apr 2024 02:11:27 -0300
Message-Id: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP+ILGYC/1WNywqDMBBFf0Vm3Sl5qJiu+h/FRYhTHapRkiAW8
 d8bsuvycLjnnhApMEV4VCcE2jny6jOoWwVusn4k5CEzKKFqoaTCQHZO9MGZBrRt21jSxhrXQF5
 sgd58lNoLPCX0dCTos5k4pjV8y80uiy9FLcVfcZcosB5MJ7Ujozt6jovl+e7WBfrrun5FeXh0s
 AAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=8VRM2VkcgoEktDYSv+F1ch8yrYyKhYb70NjkmOM2jwU=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBmLIkLRZl7C6eLd85C8sxKCLjP9x7Q7mevpFWvg
 jJP2zsAuUWJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZiyJCwAKCRC7Edu60Qc7
 VjHBB/9YDCM7GrUKLRJ9q71ktMXB0J+Thn8JAINSB2kccom0rDeuNcbxNLd7K7hXu2VBsBS3F7l
 OnCl7eNZSeQj0YvUo4bYh/AoGs+3cucX+yMgo9B2cVPLxg1gvXtZcvg5eOIeWjHDQHmgg3HvBa3
 XqybY0lvU9gLWaC3zIoeH9gLJud80ZoSCNUilxGXgbm7J6jS82e24R1YovmipA1mM4EQ1I8kA6T
 sYuwryPIhRgEYD5Z5rLuEmzVxE9MOSs/hdG5yKVf3Wh6nxK4xAzzeZYVE+o8l4EQOqafbjzBauk
 s+IJj7Rr6dYw83Ybz9XEBMcURFXYsOzJqwJZSgK3fpggHzJl
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

This series fixes the LED support for rtl8366. The existing code was not
tested in a device with switch LEDs and it was using a flawed logic.

The driver now keeps the default LED configuration if nothing requests a
different behavior. This may be enough for most devices. This can be
achieved either by omitting the LED from the device-tree or configuring
all LEDs in a group with the default state set to "keep".

The hardware trigger for LEDs in Realtek switches is shared among all
LEDs in a group. This behavior doesn't align well with the Linux LED
API, which controls LEDs individually. Once the OS changes the
brightness of a LED in a group still triggered by the hardware, the
entire group switches to software-controlled LEDs, even for those not
metioned in the device-tree. This shared behavior also prevents
offloading the trigger to the hardware as it would require an
orchestration between LEDs in a group, not currently present in the LED
API.

The assertion of device hardware reset during driver removal was removed
because it was causing an issue with the LED release code. Devres
devices are released after the driver's removal is executed. Asserting
the reset at that point was causing timeout errors during LED release
when it attempted to turn off the LED.
 

To: Linus Walleij <linus.walleij@linaro.org>
To: Alvin Šipraga <alsi@bang-olufsen.dk>
To: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Changes in v2:
- Fixed commit message formatting
- Added GROUP to LED group enum values. With that, moved the code that
  disables LED into a new function to keep 80-collumn limit. 
- Dropped unused enable argument in rb8366rb_get_port_led()
- Fixed variable order in rtl8366rb_setup_led()
- Removed redundant led group test in rb8366rb_{g,s}et_port_led()
- Initialize ret as 0 in rtl8366rb_setup_leds()
- Updated comments related to LED blinking and setup
- Link to v1: https://lore.kernel.org/r/20240310-realtek-led-v1-0-4d9813ce938e@gmail.com

Changes in v1:
- Rebased on new relatek DSA drivers
- Improved commit messages
- Added commit to remove the reset assert during .remove
- Link to RFC: https://lore.kernel.org/r/20240106184651.3665-1-luizluca@gmail.com

---
Luiz Angelo Daros de Luca (3):
      net: dsa: realtek: keep default LED state in rtl8366rb
      net: dsa: realtek: do not assert reset on remove
      net: dsa: realtek: add LED drivers for rtl8366rb

 drivers/net/dsa/realtek/rtl8366rb.c | 363 +++++++++++++++++++++++++++---------
 drivers/net/dsa/realtek/rtl83xx.c   |   7 +-
 2 files changed, 273 insertions(+), 97 deletions(-)
---
base-commit: 5c4c0edca68a5841a8d53ccd49596fe199c8334c
change-id: 20240212-realtek-led-a665ae39a9c5

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


