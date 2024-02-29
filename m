Return-Path: <linux-kernel+bounces-87076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D186CF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38FF1C22AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AA7827A;
	Thu, 29 Feb 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d4UIcvL+"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015575814
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223984; cv=none; b=DnIDLWlvmyPrXlBdKJImgW7Uf7XF29JXfnHKx+T9kF/bwzEetxFuFwdkD6ri+Rs2FSlYOx3w2v91fbjh+d/s4NLXfxtjQfGjDSydnCNl5VmDUhoNHx0QG7hXg6/XNEcQ3iTaRjUQ1YwNe0em1wDQqxGMZaR5hofx2Ho1RcirdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223984; c=relaxed/simple;
	bh=v+uT1av2sl88VR1dO/eLr+o2H3H+rOGNPQ5vM4PEMvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FjqGOUiRlukwf3JminKXRqiQnLqiRRPzkXZox+wdiZA6cUzfP11r3WLSa2muWyMj5mXE2fqDePE3Fm1tpRuFdbR62ueSAFvBxoIJwzMBzcyBJzWuhG+FS5OgXd5oes/IgpN4SIKjXHbFOLwRo+HNzh54ezkiRhK3T2tt3oGB04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d4UIcvL+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e49872f576so564548a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709223981; x=1709828781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isdRJ2LkpZPWbdYtwV073amQlPEG6TrmA4+SClB0Ykk=;
        b=d4UIcvL+8oq/Tw3dG0BEwbObiuJbBaCnXQQ4lu9ZSJkAu1plu/dv2m5AeTTt7OTIb9
         niv3abFuOW2Fxa9qqTaRhUNpsLtfka9rYHkfGkBm6a+6z3u7FHyIRpG9wIdCrogDIkV5
         QtSiLzFmiQ9KQHSdiJpGxBrFbFy5owzMB2F2TBAhb/+JprMr1lJ3nkPoUXEriABqakYm
         S6YHuAMU7Y7bircD1yOlglctlhnS7kzsCAW2u9QFONEz5lpTvTsSBpiskyLpN2bKGmDy
         lNXV9YdHTYcFrDsdUQFXZt33/DBrbqqXe5zVaE+rEfJZoq+bmVhuNXAO4JbSjsqXdOmK
         JtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223981; x=1709828781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isdRJ2LkpZPWbdYtwV073amQlPEG6TrmA4+SClB0Ykk=;
        b=TczhrHRcX+3ws+KjQjrWj0n1TV4aTbiyeA/8eJF9HMq0KZa4O+yg39UP6hulbTkTdr
         c/mvBMsudSynNgcl2I0jZWTKesWDKUKrTcuJUHPWi5YLV1+cYyCgv3/EoaXPx4nnK1Sv
         0KSWEgreamLpEblZa9JmeDd9oJvMU0s3quFtT2ceQKYDXiTmiFN8f1QJOCrMDnRm+tOc
         RSL/dT0bkDhxTwAXb2XerCpnblO2LZORypUrgBmapXRo/uVTGqRT48onuHwaxsTDqJ1+
         dqphAK6AAXqFiDCVqHPgw9O8UX4svMxptZWvLlnRIfPqo0RiyR8wbf7ufve7OiemhG6f
         hDRA==
X-Forwarded-Encrypted: i=1; AJvYcCUl/CfJMCijrbV7llUqyXz7OdBZgt1BjbLB28R2mNeNid5ty463/m2mANDgUdhM1RWbqjIETCEnHJOZJMqw0v95AsAR3Syq6ojssAFq
X-Gm-Message-State: AOJu0YyJvnDu/GHEju2717/iZJfk59QPhisOBjxJ4fySPiq0CwWvrZ1x
	Z1kxNq93fHr+bZLFum+cn+Jq56cr1VoiTqzUUxDKcth3NGiy5UIvXbTr+So3IIM=
X-Google-Smtp-Source: AGHT+IEcMQZwAjFh0kFWEBihkV0hd95rT42OUpOFtVanJEFzOw2Zeq05gkLXsiC2d+xonwkOBzAEdg==
X-Received: by 2002:a9d:62d4:0:b0:6e4:a1a1:8d78 with SMTP id z20-20020a9d62d4000000b006e4a1a18d78mr2543228otk.2.1709223981289;
        Thu, 29 Feb 2024 08:26:21 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b7-20020a9d4787000000b006e4ab46ede1sm325141otf.2.2024.02.29.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:26:20 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iio: adc: ad7944: new driver
Date: Thu, 29 Feb 2024 10:25:49 -0600
Message-ID: <20240229-ad7944-mainline-v4-0-f88b5ec4baed@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This is a new driver for the Analog Devices AD7944/AD7985/AD7986 family
of ADCs. These are fairly simple chips (e.g. no configuration registers)
but do have some unusual SPI configurations. The initial driver is only
supporting the normal (4-wire) SPI mode.

This work is done on behalf of Analog Devices, Inc., hence the
MAINTAINERS are @analog.com folks.

---
Changes in v4:
- Fixed broken DT patch due to misplaced changelog
- Link to v3: https://lore.kernel.org/r/20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com

Changes in v3:
- Removed 'multi' value from adi,spi-mode property in DT bindings
- Modified driver for above change
- Fixed spelling of 'conventional'
- Added '#daisy-chained-devices' to DT bindings
- Added comments explaining that '3-wire' mode is not related to
  spi-3wire/SPI_3WIRE
- Replaced _sign with _diff in chip info struct to properly handle
  pseudo-differential vs. true differential chips
- Link to v2: https://lore.kernel.org/r/20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com

Changes in v2:
- Added limit to spi-max-frequency for chain mode in DT bindings
- Added spi-cpol property to DT bindings
- Renamed '3-wire' mode to 'single' mode (to avoid confusion with spi-3wire)
- Renamed '4-wire' mode to 'multi' mode
- Dropped adi,reference property - now using only ref-supply and 
  refin-supply to determine the reference voltage source
- Fixed spelling of TURBO
- Renamed t_cnv to t_conv to match datasheet name and fixed comment
- Fixed wrong timestamp pushed to buffer
- Fixed scaling for chips with signed data
- Make use of sysfs_match_string() function
- Link to v1: https://lore.kernel.org/r/20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com

---
David Lechner (2):
      dt-bindings: iio: adc: add ad7944 ADCs
      iio: adc: ad7944: add driver for AD7944/AD7985/AD7986

 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7944.c                           | 413 +++++++++++++++++++++
 5 files changed, 646 insertions(+)
---
base-commit: 205bbf0d2dd2e0fcd6bf2a15b7df6fc570967e3b
change-id: 20240206-ad7944-mainline-17c968aa0967

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


