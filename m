Return-Path: <linux-kernel+bounces-44494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A508422CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821DB29724D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DED67746;
	Tue, 30 Jan 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gN5nViwy"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7666B3F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613522; cv=none; b=IA8jgroIXi7U365RAn0Xn/8lnqGt6zGEST2ujath/IBf54jFD6X6r58gTM5EkPkbVcGpsKxaKAINvHO+fC5LQitFWndFxFad8wNj3ijFF24oHkNsXJ5TTEId0/AO4N++f6bVzas1yi3+PXCtm8J1Q+i6z2DAsHgxt0a7+t0ztoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613522; c=relaxed/simple;
	bh=kGS2YlYpwkaMeLuYA2ZJo9VryN5LNnd/3OS8jgCksRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3V9QBh9xslfaZ1GC76YNZsEihy5cGf1G9BFVfYiBgqQXRw1hC6nQtGPHgLX1owc2DZgL3mhmEruWH6ajvxmKbDxxUAFW4fMqPolliAIwwDku4aZ67vjpH0mUZMpPBvPrJRwH4z+MPQWE7cPNgpsiB0SJQ5yQPYhHVXT0NfrWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gN5nViwy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a363961b96aso34780666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706613519; x=1707218319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOtNl4cKe7GBawJQPo+KdaP0XIGpVVB++fTiPzkFZX0=;
        b=gN5nViwyIq+mAad0AUgZIWiljRPN7K0k1UbDJ9u8WH6WZjj6luj3ynXhHB5CdB2Pgz
         +7qeAFesteomf5lysPqhVXl6Qk4hUyVUUBUPQINMso0AsWlVxO/koPk6dBvCFQ+1D7Pw
         nMlKJrq4ogmajAi0yynsCeMe6Zv58+4pKzT26BHMYGZ2XHRAQZsffftTGrlvEIVOVdBM
         NTxmb/eiTa/Bc9tx9mo02bdEFPlyAOk38jfErBl2ayqn8w2GxMZaMR1kx3fBBy54e6z8
         BYpm78YD5dIYTg/XCSR88aU4O+2gZQb7vj1ILZl5ZQ2WuGXoOT8CZ1ZTzisfTDYWRVPo
         oWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613519; x=1707218319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOtNl4cKe7GBawJQPo+KdaP0XIGpVVB++fTiPzkFZX0=;
        b=dC0S2/P4sri3iLMj0wYlbhreY/tqehEOruGzwSiWVzd5Gs50dS1EnF+1DoSNv0afEp
         IlYCIlIdLAfV8flYxV8cLfWvQ1179Copc35wUAmfUtPyaMQKu/IDOm1X30KzvZ8tcp8i
         lCKsgBFQpMvARYb/p/2of1Mxh+V9qxU2RwaD5v389NUb6307OQxF3CfHOgJ33nmMVN+1
         ZNie3qG6HLwCHQ9+J9RNwnEkfE6mH8PqdIOmOVGpdBd5p47Hc7lfZ+lkOQx3Cr1XgXhj
         bRnHJzJ+a6i+T20lA/Qq9ez0/y/dZAZNO6MI2Dz3ClVZDa2UZclAkEjehvJxgvsMT/hr
         nsoQ==
X-Gm-Message-State: AOJu0YwZdVnh7z0SAcAp7l1py7YLdeL8hzkp9mYEUpUtQrVLLywyo2If
	/sVhShzITAc4U/9ukY8n2HuljM/VEZ4ECmNJJW0gRtY+4zTX1fvL3FiNrCHpVMA=
X-Google-Smtp-Source: AGHT+IH/ny2CqOMsS25PWFkZVT2GcF7qm5uWsJ1Y+uwbTDUyS9YsNWk+xyeJG3SSE0spkJqW8yAFog==
X-Received: by 2002:a17:906:6882:b0:a36:3d9d:59e4 with SMTP id n2-20020a170906688200b00a363d9d59e4mr392530ejr.64.1706613518942;
        Tue, 30 Jan 2024 03:18:38 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090634ce00b00a35a11fd795sm2559079ejb.129.2024.01.30.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:18:38 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
Date: Tue, 30 Jan 2024 16:48:29 +0530
Message-ID: <20240130111830.4016002-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

voltage-divider is always an iio consumer at the same time it is
optionally an iio provider.
Hence add #io-channel-cells
Also update example.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
index dddf97b50549..09f10d7c4e02 100644
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
@@ -39,6 +39,13 @@ properties:
     description: |
       Channel node of a voltage io-channel.
 
+  '#io-channel-cells':
+    description:
+      In addition to consuming the measurement services of an ADC,
+      the voltage divider can act as an provider of measurement
+      services to other devices.
+    const: 1
+
   output-ohms:
     description:
       Resistance Rout over which the output voltage is measured. See full-ohms.
@@ -75,12 +82,17 @@ examples:
             spi-max-frequency = <1000000>;
         };
     };
-    sysv {
+    p12v_vd: sysv {
         compatible = "voltage-divider";
         io-channels = <&maxadc 1>;
+        #io-channel-cells = <1>;
 
         /* Scale the system voltage by 22/222 to fit the ADC range. */
         output-ohms = <22>;
         full-ohms = <222>; /* 200 + 22 */
     };
+    iio-hwmon {
+        compatible = "iio-hwmon";
+        io-channels = <&p12v_vd 0>;
+    };
 ...

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.42.0


