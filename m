Return-Path: <linux-kernel+bounces-110346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349F1885D83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F691F21529
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DCDB66F;
	Thu, 21 Mar 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIq357YG"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9579D2;
	Thu, 21 Mar 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038805; cv=none; b=JkJ3TF+k6tdSySxEU82pLH0/at56tQY0ckM7SzSid8rUGcXswuk5NlGvHkjzFdFHv/o189/FyAtgBmkVv6AnG+AkRlvD2pIswgWcY/uGCcpY0f/g3lug4gTJILXzhLWpoUk5cRJxHEQgJDyQFupDXDq8a9CCRep19khPm6vFTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038805; c=relaxed/simple;
	bh=qcEcrD27GhTPL4Tby9xhBQdegYW9lZV+AHeuR3cTfSA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ndECovm5+/wo90eNRLD6T9Wg4/7xfz8gsI06nw3PlI1Zuqbw507MI/dXg9YgSzCu1V2zdMU6EuYjVi3lQIHZlAWNNudOuD6mOjAPc1eVKQAw/ogfczagJQQznDRgoDAyGzC1ZErxj8bfTAuhvaQls9k4XfjvPoigDvC2joUyURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIq357YG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a466a1f9ea0so73706066b.1;
        Thu, 21 Mar 2024 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711038802; x=1711643602; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/h/OC6XXnIFGw6jiS4Rplee9xUvxXvhUXxw1/DP+Ew=;
        b=XIq357YGlScruSTRzR4e7qGItUjSffNrXXvB72SbaAkMWKcJOMYsX1cg1caI9e6GWh
         tRTPqUyi/V68j/bLqUhmGgMu1Ce4jQ+VGZwg0+6Y/3qbSyfK4MynP6ADKh3P1odBHQbx
         H+/8TjaEyJZdJ38qXejHRneTRNfcvxSo2STPJbnMgC/JwupSHT7AGCLe5LEslZJnHMn6
         4u0h29Kjwu4PG1zeeRp5nNNuSZqfAJHXbvaUfbQSS5ow04mOH6K6K96d8pnf/5ca4/vb
         KBtPWa47tFpQxioQAnZ4SSMpHss5z7PGaKlSmTStC0qLWyRKn0DKOK6batLIfbIHeFYw
         852A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711038802; x=1711643602;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/h/OC6XXnIFGw6jiS4Rplee9xUvxXvhUXxw1/DP+Ew=;
        b=V5UkUXXfkE0RE5l3EA8QvLCjXRxn4dAOsyeMeEt9MWPzO7NcDzN7zBl1dcLJfMC/72
         k2ggv1CYFg3Rwnh4JocZbWR7hFD9SXta0uBbWycHGjMwNTevlhesKzvy+E6w2Xrva1Uf
         TCgVHXWhyuxh1/zacEjaBaTaDspzviZ4FEP3wqEKw24IQ4AQBz6zs4CTjpuv/gIBAxVa
         kCcUqLg/qepQ2dFx0+cw8Ri39yIOr+aqAtYlRz+oN0u+38hoB4K4jsQekZI8aK1XWeqo
         IcuKhgk2onzxfn7SzebptCMfeyP+BSG9LfE/QBPC4KasIrNyhg4+bnW7IAliKLcjjuG3
         g28A==
X-Forwarded-Encrypted: i=1; AJvYcCVMzzaGy4Tb1gAmfcnPPRwizWvahWWaXHh75LZsKIHmPCt5bCH3jYIyItLuzxCxOf58EJIHlbeZVknNqwuhu0zze2BaGuqCKhJLy0GID+du+Aaf4GrWGZeNbuTuBg0vWGmjlEUpVfKdBg==
X-Gm-Message-State: AOJu0YwwzenENITdX9vGyEoHgDZZceZCurbD4dRW57h1JsaqiMmt6kdt
	X3VSxeMgcYAsEYNNdCJoSlq1Z2sEat1f55utMF1yEwkLXzz+zgJ2
X-Google-Smtp-Source: AGHT+IENMSdv8xlE0iuedgIy9cKlPI5SrVN77feHC6WTieRSG8Omrgj/3aKwrxDhKFd5xReLG1EWCw==
X-Received: by 2002:a50:bae3:0:b0:56b:986b:b4e7 with SMTP id x90-20020a50bae3000000b0056b986bb4e7mr2472630ede.27.1711038802015;
        Thu, 21 Mar 2024 09:33:22 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id v11-20020a056402184b00b00568e3d3337bsm50509edy.18.2024.03.21.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:33:21 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] dt-bindings: hwmon: convert lm87 and max6650 to
 dtschema
Date: Thu, 21 Mar 2024 17:33:16 +0100
Message-Id: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExh/GUC/23M0QrCIBTG8VcZ5zpDj0Krq94jRjhn88DU0LDG8
 N2zXXf5/+D7bZBtIpvh0m2QbKFMMbTAQwfG6TBbRlNrQI6KS+TMvX0M91X7hanpJHsrRzQ9Qjs
 8k33QZ8duQ2tH+RXTuttF/Na/TBGMMy3V2WgUxujxOntNy9FED0Ot9QvPeJZOpAAAAA==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711038801; l=1406;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qcEcrD27GhTPL4Tby9xhBQdegYW9lZV+AHeuR3cTfSA=;
 b=EtXSHwezkxvj2eEAxycT7GjXEUHqtENYKfUoFe0+mGm/+PnzrgR/x6uYXcXZRxxoTJ6FYJV+7
 g/k3vBjATwdCu3jVAUDCKrbE3RxbSuZje4AHB7v1HJVEgydrQZcG7pJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the existing lm87.txt and max6650.txt bindings to
dtschema. Both are direct conversions with no additional properties.

There has been an attempt to convert the bindings of the lm87 before
[1], but the author (added to recipients) has confirmed that no further
versions will be submitted, and no acknowledgment is desired.

Link: https://lore.kernel.org/linux-hwmon/20231030125221.12974-1-579lpy@gmail.com [1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- max6650: add property constraints and commit message indentation.
- lm87: No changes, already applied to hwmon-next.
- Link to v1: https://lore.kernel.org/r/20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com

---
Javier Carrasco (2):
      dt-bindings: hwmon: lm87: convert to dtschema
      dt-bindings: hwmon: max6650: convert to dtschema

 Documentation/devicetree/bindings/hwmon/lm87.txt   | 30 ----------
 .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
 .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 70 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/ti,lm87.yaml         | 69 +++++++++++++++++++++
 4 files changed, 139 insertions(+), 58 deletions(-)
---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-hwmon_yaml-4d738e3b2c82

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


