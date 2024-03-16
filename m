Return-Path: <linux-kernel+bounces-105299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C833787DB95
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0265D1C20A80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD41C698;
	Sat, 16 Mar 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8WU4BdR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD263A9;
	Sat, 16 Mar 2024 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710629828; cv=none; b=fde4QW3NyrEUmbWbxIrYztYwUh3Ez8ItEEYXKthdp5K6Mo3/XEIEwzhFEtQ57mNvH0YA8M9qDQZe5NrRKkXHKOCffdjIWNs59zi9bIcHf7jqbjMnrraU3yniE6It3xjTz/PqxN4e151Ky9KQ68Q5niEXEBgFuS4HNkajtDiJwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710629828; c=relaxed/simple;
	bh=61sBZHPE/9BePG2PUWCTUsaPTqr17Q1rMWOTxVkWVJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L9BIJgYYGav5GqoGjwIlo2oCXTXpvk4hdYWWvBhaNnQOxBqb9nYXgIv1F4C3lFKBsqlVKpZtjwDlw7tD4gj9iMZI7Xjue2LHs7kfXiB34IFzLF8Chnh63WeTmTQ32PALmyK6cxc89LCxe6VOHnRcrm1nocQghsu5fnxxkaALg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8WU4BdR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4140c25d024so575735e9.1;
        Sat, 16 Mar 2024 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710629825; x=1711234625; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yJM8cNsiPI9LOGCSabYPlR2nGXuPJ4NIkS+qqwBQO0=;
        b=b8WU4BdR8PfLJvjFs1yks4cqV9ApgyH3bmE4/YLdsXBs6VZzme93VklfDY+amhodEM
         i6LuYV4BdsOvaFkvMKTIpHWSzVbrRABF7cBtLiai0cEpR17rodSNZBBDbgDIzSw+gbKA
         iuKMgVwvK1AaehG+8eB7i7DVZBhHiGqiUb4GAcQgFw9KxfBP9dn6XzIJJmcqKANooYyq
         9ZD3BxH3bmQwwnDof9OZ6RCx7mConPQR1uImf+YbLLJe4m+QPgajBVWlUAAOgyMWAy+V
         Wj0IZ2X+gNaSBmjL2nMAOhAXHa1gBp4iHwZXayMqWSZ4DVQhfL+gUdQA+FAfG3jQhuK4
         1R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710629825; x=1711234625;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yJM8cNsiPI9LOGCSabYPlR2nGXuPJ4NIkS+qqwBQO0=;
        b=vqqnDrH3cKdBa31Q0zuRyukWW0J6n3n0AuHUWcyb4O+eiLwR5gb+ToeE1TSWR67Ue7
         WR92Z951j+HMWf/kALmlwDJymywrSitUVgWbKkaQCo66fG/kTOcLfZcCBBDmTS59G4xP
         snSkCN0XtwFG9lG4zDuhmS60tuVFDYLYPDhJECxO9AE2nxFrV8fdf0+c5JGf6xqY/tkq
         k3J3Ag53lpUxS0c9gPE7GO16Ce/dt63q5+F4qx7B8xkiKO5IXagLm1xI0ZYyLUh34VnJ
         h4vIYZquJGvajPf+v34+qGeSzD92p/iqHL7rvFIclpLzOZ8DbbeZ9S8wovu9Y8LPEcbN
         3kSw==
X-Forwarded-Encrypted: i=1; AJvYcCVCKzN8nPR+Z8coD2CsXHKOQLTAwcUdUEIhzy3ejnM9EgKpi0P4bHP3EkWKKuptGYR0Pvg6HikZlOkTqAzFE3tUoqwY0kSqrwZihb0Uf5zV9BB173jZlz8XujQhcrRMShf6G/9zeNa3i4v0gIV7BjXq3u2bpsOHNNvrZ5gnt1R+vlVwUQ==
X-Gm-Message-State: AOJu0YwJBqauZeDjiYwO3CEkSIUx7cDR4k1W0fYUVzo2RIo5OePuQj9q
	QigvShlCJC0UAJy7rQfYUX7ZXQNwDSvb3W4grFvn5d3DSymSu+/7
X-Google-Smtp-Source: AGHT+IG0QUdB6h84Dgv+n+wirrAon8mGJ0rABZ369JBdHJfs0WsgW4wi4Zg93NSZ2MXQV/erD40sCw==
X-Received: by 2002:a05:600c:4f82:b0:414:860:bda6 with SMTP id n2-20020a05600c4f8200b004140860bda6mr1659473wmq.9.1710629824672;
        Sat, 16 Mar 2024 15:57:04 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e9ae-4993-d02f-11ee.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e9ae:4993:d02f:11ee])
        by smtp.gmail.com with ESMTPSA id d6-20020a05600c3ac600b004140b96dd4dsm611096wms.21.2024.03.16.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 15:57:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 16 Mar 2024 23:56:57 +0100
Subject: [PATCH] dt-bindings: iio: health: maxim,max30102: fix compatible
 check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-max30102_binding_fix-v1-1-e8e58f69ef8a@gmail.com>
X-B4-Tracking: v=1; b=H4sIALgj9mUC/x2MWwqAIBAArxL7neCLyq4SIaVb7UcWCiFId0/6n
 IGZAgkjYYKxKRDxoURXqCDaBtyxhB0Z+cogudRciY6dS1ZccGlXCp7CbjfKbDAD9s5o59BATe+
 IVf/baX7fD7DbwIhmAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710629823; l=1404;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=61sBZHPE/9BePG2PUWCTUsaPTqr17Q1rMWOTxVkWVJg=;
 b=HvVjjT9vZbNjRgyeR4k3PhCzQNXYNqvPI93IuO01gBZSgB5D7BahQW5KVmrmdnvLlg1kbHRDu
 D2f2T0Hmz8EC1jz01PCR6Wr10W0wf5k3V4TBvkTqifnwu00S4aTmgyf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The "maxim,green-led-current-microamp" property is only available for
the max30105 part (it provides an extra green LED), and must be set to
false for the max30102 part.

Instead, the max30100 part has been used for that, which is not
supported by this binding (it has its own binding).

This error was introduced during the txt to yaml conversion.

Fixes: 5a6a65b11e3a ("dt-bindings:iio:health:maxim,max30102: txt to yaml conversion")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
index c13c10c8d65d..eed0df9d3a23 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
@@ -42,7 +42,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: maxim,max30100
+            const: maxim,max30102
     then:
       properties:
         maxim,green-led-current-microamp: false

---
base-commit: c1f10ac840caced7a9f717d4170dcc14b3fac076
change-id: 20240316-max30102_binding_fix-898e7c94cce9

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


