Return-Path: <linux-kernel+bounces-58176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B0784E257
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855FD1F21D15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9458078B6A;
	Thu,  8 Feb 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoVlE0sO"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79476C63
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400257; cv=none; b=MhL5Kfqql6U6+GPEI9+D6azLHH1peb0sy4Dl7I0Yq8lynyRLvdCO/JH7JVAC2qgstkBpTMsNt27UWF5/d6YA/ZLLFXzBljPkJLsYRMHjCK6cpVQER70+YRAfKV0cTZ3URoc0vFEJb+b0o1icIoGIFq+MT3nfYX2fpU8qmGPbkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400257; c=relaxed/simple;
	bh=p2usWgPysTo/9X224ZyHEY+TGT4J7QxxP4dWqWMr0XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+kiUPT7Ic5p0kwqV5i/RA1pvJESV9Dyrd6Jv+BEF19EYiZOVG5tVlIh9nINmbfmak2r7ZM2ZTZzdLGjM/W8vpkICeP0tkS3d6aOcDxx3LCsaIwCnYbjQr0dsMDgRrotWSLuXHd0RTMpUHI0pRAD8kYMnslHbQI4hcqQXjfTO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AoVlE0sO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b58ca0b95so368699f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400253; x=1708005053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjENHLcLIAVWZiAZ2HXcUWfnK57wdK8wfcg4H3+qzmM=;
        b=AoVlE0sOiLAEnTCHm4OGJBe0gKJ7eNEeKclZqC9ZQuYla3RMkNoFF3jt81+GyYrQKJ
         btOBnbavW+LavtkdLKdb6ltdQd56NG/JSLdly0y0w/Fa/8MhcV6rZj7JZ+J7olNuu1vf
         I6yexrc9G/Cx7dQmdLG5c3I+JtEQmPlt/a32m1fs/zfDkqCRg68ZpvLFhhpvo4+Nf13r
         Ba4Em1LlxWJURfHrg7RUNVouPOnXHA5538lpA7+v8DJj6J2xc7Nu3QDtVEALoclbysG7
         niOwuJhjYkZ7Ux3DGgn+LHgAyO/7gRIrgBbhhlChAg9PO1R7rJmb3V13uHQRWUkHdlGp
         j8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400253; x=1708005053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjENHLcLIAVWZiAZ2HXcUWfnK57wdK8wfcg4H3+qzmM=;
        b=ruEiJxLA5xQncQu/Q147BzXOnpLPOqjjwIEj8jTdy5VsmuAqtpkPNrUSttW+5iDMdq
         9aqa5AgXQsxdly9yLkoM7wS1plQqEHptAx3k3FWch6RzCkXrf4TmthJZNkPx4BSPazHE
         f5m7w3NdXdx0I9netW1JZwXxv5OdJT2bDg6RLHC57qPQJvYdxUZENFPPhi6MQPsZuDVs
         r93qOYlmFD1wyziT5nNu8KVstZiwF9yVU1hlz7conXR6o+wMIc4vb4BjgQwIyp881koj
         496yQhIWma40ol3Q5kxxcEI0AK6rMYh/ALhnnfnFhMO6nqi7lBQSmEf7Cyv/nlLDVXzU
         2uxQ==
X-Gm-Message-State: AOJu0YzJHVaSmjOrjfDC1Mbxi8XzUT30ltEXvU2xk/PlUI4iRIScFyKC
	n/pfd4R31q6/wvvaLs8f9B+M1Z/JQhr+y2BBVE6S8D0lT81p38pADyCZ9euEQyw=
X-Google-Smtp-Source: AGHT+IFTzzez+1+BjUzZhqbA4z1KJveyYp9cLpDPWcvVsrOfjjaaWuyzUn2pNT6GoKgQyYhXLuBEYw==
X-Received: by 2002:adf:f34f:0:b0:33b:295d:19b6 with SMTP id e15-20020adff34f000000b0033b295d19b6mr6293505wrp.69.1707400253564;
        Thu, 08 Feb 2024 05:50:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi6mIo+LskNjMyaaVLjIy6CST18FnOprx16kaQQ3OihpdMbQUNWNaYUGAGHR93OtO6K92p6mEtJnar2aOye3GKZ7S34SIxXYa+NqaxXYQo7K4Ivxg24z1FFeT4A9ctzPYwr9CmtVcR1DlJ1DV0hIjNjdzb/HZH5//1D89Tg7hXr7m7iT0ouvMzj4MT4kNjxbZfPO/wFZZlRiHkOD3AOiraCwZoUF5ZtjLwvqaUGCN0zh8xwoWx4JbnUHZu5fG+rWITuh6NDPZ2Fxk0dy22n64L6of90Y1YfLEdNX6U0knQT6hLUFxUjzM11umvZo1e5T3n9a8Xukm7pSFizaVq1rqG4ixTdfA74DMnekHEVDFCUZDiV5jhyi0FmDlVpVkbkVafpoBJWblDTQhXbaIft4ZeRKdgXTvDZYizOv9lGifXCb2RI/9EWHU8c1Z1F9nfWaSho2vrgPbQOO7prFhiFARfNnY/SWpbFq5gSKeqqhIYlESgaEt4kOZRhUZxkrTQYhJoXc263scl/YdNAZR3vwDhs4pXP7TGQvp+1vlyCf8U3f4K8b71k45qm0fLeIhjhndFbOt0Sh+5Kezk2X5q6Cd3H0Htj6huuB9EEbrBWw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0033b43a5f53csm3618820wrh.103.2024.02.08.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:50:53 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth`` property
Date: Thu,  8 Feb 2024 13:50:34 +0000
Message-ID: <20240208135045.3728927-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are instances of the same IP that are configured by the integrator
with different FIFO depths. Introduce the fifo-depth property to allow
such nodes to specify their FIFO depth.

We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
introduce a single property.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 524f6fe8c27b..99272e6f115e 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -69,6 +69,11 @@ properties:
          Should be generally avoided and be replaced by
          spi-cs-high + ACTIVE_HIGH.
 
+  fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the data FIFO in bytes.
+
   num-cs:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.43.0.687.g38aa6559b0-goog


