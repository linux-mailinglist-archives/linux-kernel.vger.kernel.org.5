Return-Path: <linux-kernel+bounces-54720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8454284B2DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B15284E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0912DDB3;
	Tue,  6 Feb 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="TqyPjeFP"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1034487A1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216915; cv=none; b=ETR6TaF0UM8EZ4mfJAAceifdwrHH2ePSXddSDIDFNmHIirJQKf09cBT5JXcGxboJHQz5e9/EKE7OvAiqpvcPjBlUm33qDxeI1YD38SZd2Gf5SPSrFh+1lD/lmz3ow7E3ZVsdHDB/1oalkWRWKWHjvEb50QlaxbisntTv7dzRF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216915; c=relaxed/simple;
	bh=aU3cUFcF/+qA6c/U4GCnJpmTtXdJ/4c+yLFoO5y/rN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmGS/9Yo9nxVQicgg/SssvA0hisL1FsGpPOa+fF+h/LEu0MLm53KqgvIf180W8NX9gPYYpfQRLEUPu1CaysJtxPox7gyB7Js0Gm/kVVdQ9UrYk3PLHet6fHlIAgjEaKx8LH6I0+n5CK06Ah9Vd3vUcApFzhGPjR9LizCMkkr8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=TqyPjeFP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3832a61a79so40655566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707216911; x=1707821711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug0YsfnX3VGECMAmiImMvOD5o629AgP4WulAYnK+czY=;
        b=TqyPjeFPyjiJgrgot2/qkkLFNMdlnE76uHPT0KybbI8IhdWtk+Px+0hXZ5X01csVV2
         rscahdAa9VZmeWoPmWXx0i3KTXcmYJfUubxXgjkDWiZ2k9KMh1Vo6EokU0G7GLBvYy5X
         +vpglFZQsaM5hvo+5x0MM1h+wzU4lLlm6bAJRq/mbvn/rQjRODgDyrABZpvSLpU7JmUM
         hX6jtOSoJOgaWRlFyhMQyvqC3kGc1v6aPFh3FKB4po2t8sl71QQ2FkL8FqKhyBVM356u
         gK+btpk7JIxu7RRmr2hafGeFge9L0qc4jUu9RxTPvVjGQK8OCBzSs7XVdNZGetYd0qBt
         IVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707216911; x=1707821711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug0YsfnX3VGECMAmiImMvOD5o629AgP4WulAYnK+czY=;
        b=GPU7xG2xuSUqRY+EAd7N13x28H1PP9NVhtyZavx3GZlFlqO/KxY4yLJ4gmNNum84Ob
         bx7Vd4sheYnPZppzIjcMgd0Lpxny3aHpSaoXvwy1miy59MPizINgFMu2fDBeox9PPcNO
         RxaGn7ps2cJqmwMDEh5HYVMrEXwcY+hbpJUeJ8X5x/LtS2llKJ8xcp0VnlgBhSugze5w
         UxgPquDkkoQiJNNwZ2sf7FyJ2ePxrcyU60EjkQufvsp0/hJsCFeazBFaIymuX/wD46sa
         V/8+NLx3Rs8pN5s9YLl57bUGjGALsho2+1a4RP67+RKZe8wWwqMsPmz8Lxp++Qp50TtR
         NGVw==
X-Gm-Message-State: AOJu0Yz/GQMGqWZzbY9BiD9h1o1E50i4s4Hl9M56UnsU0iEb7ItYxg2H
	eiBF5JrTFlsVNL9lu9nizsJNuts3E4oQH/jBDAK8BCMZAq8aXhVNT+ZJItoPA24=
X-Google-Smtp-Source: AGHT+IFjAK6xGybwYfWgmNQTCA1Ip56LWjbj6wr4mOaUdW+/3YHGkzhQ1x0ynFDGZRJfEJqJRZZcBA==
X-Received: by 2002:a17:906:5651:b0:a37:e3ea:634a with SMTP id v17-20020a170906565100b00a37e3ea634amr1768503ejr.40.1707216910887;
        Tue, 06 Feb 2024 02:55:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWErRgo/bZa592qqqOQWx3DByL19PW/1WplR9Kb6WY/ShnP7PQtWeobq4ljTtn1zYNA9F8Xx1wzOX8yvF9afGtqb9GmOwv9UsMbaKxO9DqObd+zVgNcJBAqaHRhu97I5ez56/7Z9j+YrrUN+THTfYIyh5UpQ4rwIufEnezplXsEeIbiVB8rASb+2szZDkUCSOFcqzKDATRNloDRhA+TQyqZ3dYxHrA5ccvKifft2+WOV/1FXheds/hE1orzKaWdifAz1Z6X76gTAQA6NDDMuLjQFupRjNbB63rhOJjNRv8aUPeK5wMv/rb/+sqHTyopwIWB5K1MSzBMGHlFoDUGoj9k5QTq/mzVqTI2yGb+nNR78w==
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id un2-20020a170907cb8200b00a30cd599285sm993438ejc.223.2024.02.06.02.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:55:10 -0800 (PST)
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
Subject: [PATCH v4] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
Date: Tue,  6 Feb 2024 16:25:01 +0530
Message-ID: <20240206105502.648255-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the voltage divider to both receive and provide measurement
services by adding #io-channel-cells.

This is especially valuable in scenarios where an ADC has an analog
frontend, like a voltage divider, and obtaining its raw value isn't
interesting. It is desired to get the real voltage before the voltage
divider.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../devicetree/bindings/iio/afe/voltage-divider.yaml  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
index dddf97b50549..fd3c511e1beb 100644
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
@@ -39,6 +39,17 @@ properties:
     description: |
       Channel node of a voltage io-channel.
 
+  '#io-channel-cells':
+    description:
+      In addition to consuming the measurement services of a voltage
+      output channel, the voltage divider can act as a provider of
+      measurement services to other devices. This is particularly
+      useful in scenarios wherein an ADC has an analog frontend,
+      such as a voltage divider, and then consuming its raw value
+      isn't interesting. It is desired to get the real voltage
+      before the voltage divider.
+    const: 1
+
   output-ohms:
     description:
       Resistance Rout over which the output voltage is measured. See full-ohms.

base-commit: 99bd3cb0d12e85d5114425353552121ec8f93adc
-- 
2.42.0


