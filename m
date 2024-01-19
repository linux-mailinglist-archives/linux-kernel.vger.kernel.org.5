Return-Path: <linux-kernel+bounces-31071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094583285F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFBA28370C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3794CB2C;
	Fri, 19 Jan 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sBbtETSC"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC04C632
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662530; cv=none; b=OP7RYBlHrnw5O+4sr7VFEJHtdQ67ehCab1Nnf0tqUXYyOtaO5rT6rk4yQEuMuR1eznR3Keg7YkoyI3uQppiamsiJE97IpEI3twDhchBMUiVtqtTC7zwj8GQS3wzWqOLO2g87Zi4bybH1WXJIdsApJXtHE1siBjl+SAZU8tAanbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662530; c=relaxed/simple;
	bh=M/khVo5w/QaYGS2KbY7GMVMAto7oj95Xs/13fc8sOY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZsxLtnCUeWgqmnrUdkzeiOcBsGSOZDxJ98hwuFrjsc+SHbUcyM/FOHbHjB+tWIWIDGDbQceTqT7ZMkAFpHCiYX+39Aw3QxbIU544xMav1UCS5UxJkymBvrdZM+NilyvUvDib6ivQ3JFgU6nWN0XhZtMhYe0AmJzYolC0qqA32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sBbtETSC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2c67be31edso70773666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705662526; x=1706267326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkX7t6l4nQ/vCuey8Au/m+51v8pi/S+y8K9YAi1mcOo=;
        b=sBbtETSCA9TEQml4IBa4FeUc3Xjox6F7SbRHlbteJh1DEDoqzIZv643gZcCvcj+Yzj
         LLCkoutZt/jJRKFxG8/C0CyOE1ln1AX1WuATccrJcMEI1qe2BEUbx7uAe1tpX4eBx/UB
         c+mLWt2yMycQ/Fy8ZyCwrpb8cOeOuWAsDNhQK5GA7gZ1mYw3Z+98oCn/NeZASelg7jxl
         Ib3Bfnt20fne+diFtxY9fmnzLohEMEtlbS+iPOKjhsv2nQIdjbvhzsbjeT1zmdN/Rov8
         6G4OhZ+QzPYl9Ncy37eW1aHoW59Xfutypx7nBzzv4Yv9hj/0/QhwiMa+dxNVewwqg+BA
         LCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662526; x=1706267326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkX7t6l4nQ/vCuey8Au/m+51v8pi/S+y8K9YAi1mcOo=;
        b=KgCv3JlHdnW80pvisxV8f5xbWOyG5UY5D4TTVbeHpPBPBHKsYaSIA2jOphzHjQumED
         x/G6p0ZcUStsXcGZYycdY1qHnwInkZYYx4Mulnxzee1KV3FXqFJXXqI/L7KAX/3xalan
         kHNyi7Ii8nsqxg86kmVtmU3Kos6GGPgGjkmdpyqzRkFWvrQW/V92X6ju9eohjJefYghV
         H+97dEXvF7/0mRjptTTSn30PyVLVx6nOm7NszajB1B3Bo2b+Gd8XULVxro9cP6LmnpAU
         m0OLuKdirC2Cr5mT1ijM1GAWIF75HctxnhvEA7Z/XgD+QR5fsOpv15E3IkT3/6PvcE0z
         HTOQ==
X-Gm-Message-State: AOJu0YyLTPJlJa77A6Y/kUS5f9X4RVXkglZCKphY5jxtRkAwvm+heVwS
	gYBAdBkmbJ0gfYOeG7WbrrnNePwZoJCzNcNFsihjWqonlps+AzGxS1NwXQLWU4Mxvoy7X4ABwX7
	9
X-Google-Smtp-Source: AGHT+IEvKUBsNi++IWYFwDCr/xbC/i0gr1neZ+xh2X5zRMqR6tKq5tdCp7hVArBGP391ED1MdvZVbg==
X-Received: by 2002:a17:906:6dcc:b0:a2f:d59:d9cb with SMTP id j12-20020a1709066dcc00b00a2f0d59d9cbmr617650ejt.177.1705662526094;
        Fri, 19 Jan 2024 03:08:46 -0800 (PST)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906261400b00a28d438a1b0sm10091661ejc.83.2024.01.19.03.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:08:45 -0800 (PST)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 0/3] thermal: Add support of multiple sensors
Date: Fri, 19 Jan 2024 12:08:39 +0100
Message-ID: <20240119110842.772606-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following this comment [1], this updates thermal_of to support multiple
sensors.

This has some limitations:
- A sensor must have its own termal zone, even if it is also registered
  inside a thermal zone supporting multiple sensors.
- Only support weighted average

Changes in v2:
- Rebased on 6.7
- Seperated generic multi sensor and dt specfic code
- Simplified the code
- Drop min / max and only do weighted average (seems more adequate for IPA)

[1]: https://patchwork.kernel.org/comment/24723927/

Alexandre Bailon (3):
  dt-bindings: thermal: Restore the thermal-sensors property
  thermal: Add support of multi sensors to thermal_core
  thermal: Add support of multi sensors to thermal_of

 .../bindings/thermal/thermal-zones.yaml       |   5 +-
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/thermal_core.h                |   7 +
 drivers/thermal/thermal_multi.c               | 178 ++++++++++++++++++
 drivers/thermal/thermal_of.c                  | 139 ++++++++++++++
 5 files changed, 327 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/thermal_multi.c

-- 
2.41.0


