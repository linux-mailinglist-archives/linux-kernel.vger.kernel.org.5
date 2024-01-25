Return-Path: <linux-kernel+bounces-37859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15883B6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A16DB218EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5FCD287;
	Thu, 25 Jan 2024 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DB2ayWhs"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08157DDB1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146546; cv=none; b=eSrdP/haEHiGWD/1du72IWbZ3V5bVM5kJpvc16njq+TOEDmF9PJt+ZXWGpG7BW+w1GP9CWPyq2m5+EZoyyGR4C7V4oIZtbILRNf/sKhJIHYHIf5jtYiN/MIHAleVdZQaG4N5yEBie89TdEOBUDG6qq93CnB9g7OBEjrYyOeFeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146546; c=relaxed/simple;
	bh=ImPV6ylvDLNKhmYcU5bvYmZGFnnlYjliM2xywtcdAl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjidhgET+98/TMauRlbaKyJPiaZLiRzbXkFet1fVhhjnNBoQIXYulK1Cm2lIu/O0dYMqUhHHxYHcKzTQ1hDWayr6Fx4Z8bozMAq/qTgUIi5fm4eMjSv0S6JrOCuC/gtoTLvqDBtIzMYOaaMzlmg4CmzcpMSWsvkXzi+frCBVpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DB2ayWhs; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5961a2726aaso3144442eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706146544; x=1706751344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5NL15WLk6NkJypOkLe+mhvC699JlR9mZPB9t6UM0NU=;
        b=DB2ayWhsszzj86YWy8nzDWV1nuMWf/jFivvx4iGPKNxiwWG9zLUeQ3L7FFyfIsIh9I
         WN0YELLjoWX4VzvoAW6YVzJIlhRA57nfFRMQMDtw+7sSlr72LC5we7ma98Vszd6vu+M/
         HDO0oCxrwoo1/skkk5wKumbzSTEYBUAEarhkF3O/fDRtwDKIfLc/vtySOI4q6stEli/x
         DZCwBoK+BNLHf6tUDscEEbzR1PjhmlryCRB4j/diF3y7Eh8r5rN1Wdl78+CK/8y9X6rU
         fhPpxpd2NwyQOlZmW9/gDorxBV6OYIB0EFUFclS9r9PRLbRt4VKBIvuujjOp8vy1UX/S
         OcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706146544; x=1706751344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5NL15WLk6NkJypOkLe+mhvC699JlR9mZPB9t6UM0NU=;
        b=d6oH/kUJS1mWFdeDcULLmlaEQgS1OlVG5uQy4ckfj6kimqJjVO2PDzDtMZ5S7o+IDD
         4obSYAztMkADlHvPPQL2lzFiNcrvm/Z14PFof0O4OQqDVjDyVGvdyHedYzoPR+5pOfwL
         XD1vWUmSKojiow88Is9VAfhbfqx62HmZnu/7itnq5w4X/Q0kCbrxPRd6K7/Xz9sK1Hs4
         BBidEXkzYIR29YRM5q8yEA1gjNt0DVhZQkuwe6s0FQfrRRq4fUDqXsiu8kTAFy0VSZ3F
         MzaMaQDK/yBbo6fR1MlNdqJdfK+Rhj8txzztXg2UanFNUhIMoiC045fw6PzVcao6/M2z
         S9Ow==
X-Gm-Message-State: AOJu0YxtsmrKJ6iL15KEocwFsGL1mBcZj8jnAE0awcSHc3WYDyV6JZIL
	GmEVB2MvosCFIu3jC8zpflT1wgr84ODHD6eGd/nPuv68HO0SiDqONKUzKJ0+a9k=
X-Google-Smtp-Source: AGHT+IHS4UMF831ciy4ADYrkN6MN8XRIU/+ABp6RXg/kfJImSRaWpJ4d9LHHjwWd5W66OdxMWqPoXg==
X-Received: by 2002:a4a:b106:0:b0:599:c981:61f6 with SMTP id a6-20020a4ab106000000b00599c98161f6mr304994ooo.4.1706146544311;
        Wed, 24 Jan 2024 17:35:44 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id v11-20020a056820100b00b00599bcaaaf23sm222838oor.8.2024.01.24.17.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:35:43 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] spi: samsung: Add Exynos850 support
Date: Wed, 24 Jan 2024 19:35:41 -0600
Message-Id: <20240125013543.31067-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SPI support for Exynos850 SoC in spi-s3c64xx driver, and add the
corresponding bindings. It was tested using `spidev_test' tool in all
possible modes:

  - Polling mode: xfer_size <= 32
  - IRQ mode: 64 >= xfer_size >= 32
  - DMA mode: xfer_size > 64

with 200 kHz ... 49.9 MHz SPI frequencies. The next 3 approaches were
used:

  1. Software loopback ('-l' option for `spidev_test' tool)
  2. Hardware loopback (by connecting MISO line to MOSI)
  3. By communicating with ATMega found on Sensors Mezzanine board [1],
     programmed to act as an SPI slave device

and all the transactions were additionally checked on my Logic Analyzer
to make sure the SCK frequencies were actually correct.

This series is supposed to go via SPI tree. All other related SPI
changes are independent from this series and will go via Krzysztof's
tree.

Changes in v2:
  - Collected R-b tags
  - Split the initial submission [1] by 2 patch series
  - Changed bindings patch title to "spi: dt-bindings: ..."

[1] https://www.96boards.org/product/sensors-mezzanine/
[2] https://lore.kernel.org/all/20240120012948.8836-1-semen.protsenko@linaro.org/

Sam Protsenko (2):
  spi: dt-bindings: samsung: Add Exynos850 SPI
  spi: s3c64xx: Add Exynos850 support

 .../devicetree/bindings/spi/samsung,spi.yaml       |  1 +
 drivers/spi/spi-s3c64xx.c                          | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.39.2


