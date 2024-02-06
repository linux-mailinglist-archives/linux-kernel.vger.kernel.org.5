Return-Path: <linux-kernel+bounces-55126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDAA84B813
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7AC1C21BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACF132C3F;
	Tue,  6 Feb 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d1nDfybm"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939DE132C18
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230282; cv=none; b=MxNJ8a8C5Fn0igsX3enJgKyQQKoy7C+LPGGMsXvNxw6ju7TzC0bwq6LoPbw9duO4G1a/kYfVRV1QPfuk+Xkr+T8pSZAbkT5cX67mwOZkKHZDnQsqoIfuHjTGDyJzZFwkqkyUqMgSKraHPX8KYQcCkjvZdBq42IAuoVtjvba5U8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230282; c=relaxed/simple;
	bh=qCtYwolXZnavl0Sd6oLqndUOVdi0NBe84oy1jvw5Hf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJ+8wC/ttKOO/NPCmOI/YcZMELb2XXjXCizfDado1Dqghnnfp3OUQKRg7MGo7lKcF+wQEshkbotqn3YlSL8WqG4bql09jp7pHAeuzzyMlu6bdysSDf/F7WuWuubN2AazwPP6zrm1bu115kX4r1JNn/Ya9waDDwQGXaNYWYLmyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d1nDfybm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a359e6fde44so105884866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707230278; x=1707835078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vF7suW/1TS6qocxyvv/s8H/7vu3Cb51VVYgV+cySIg=;
        b=d1nDfybmgqIhk+XfreoVz6/jsnWOtwiVgj394bmQzjyaawUKn+OmQJ5kL1TTN/EJUA
         /ShVl5BJS0dsjeL5Yq0Rl4cUHf/TnGvnJMLRcputvRQjdSX7zd3hX8D3YLJlVWi5raZ2
         89DODsFlB6t80Ad8rJa62s447eckycyksJVyECooU0kzbb6T1vRxLnKjjVGAX3lDnaIW
         Arz5idtmA3lRMxs9PvLWSajc3DDf1KUS8+LnP6pQ0cLgdiTxwOXbgoJCEn0u2Kn4oVf7
         2Sw/yy9eunBZ8sq/G6EyPTkc+8FDqmNnmd+Pvp+y6YVZzIIdXR5QqbuSkrGIiwE+U/un
         VGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230278; x=1707835078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vF7suW/1TS6qocxyvv/s8H/7vu3Cb51VVYgV+cySIg=;
        b=WuvPtdDKBWCqYdKLRAcCOtjfBdOaLV3ahCDQUlTN04Mw0QDxwAh6ke4XW5x122yUOj
         zhNIaVdT7Pv+tDFcyTPC2Q76AlF1Ji9DaIbhwVWYH+mukFpXFGpLOzTkvKllp80Kj+mj
         2QOAxBHJ6MU5TmNWZjgyqyOpBuuEVLM6uVMzkzXRbz4LCf8SzP9gUCSeoICKr/4m+v3L
         qtwRY6+C+VGs+Alqqxv518a/AKGx9AdchUNbTCAAb4zMy7LCSBiQDWaCLM2Pz6zbG7V8
         ObyG9PKXHOeJUppQngBUMEDVg6qoipJcFIBiFiLh5cC65T635D0Z2QmhuJkfLwOU9Oqm
         bALQ==
X-Gm-Message-State: AOJu0Yw6kj3eMELN0Cz+Wv/EdS2itNVpCH+XfMnUw0Y1yg6lUDhy5HJo
	Rf1yphXvnhxiIG3kur/4qYePoqMR+76lTvoRIbHOTH/1YSJkGXdMTrBxmr2oWXk=
X-Google-Smtp-Source: AGHT+IHj0HtY8SzoVivBKzXBSyJMbIxEV8FnkFEryAPl79AxFxmn1uuzci9liogNUSCvs50RIiyaLQ==
X-Received: by 2002:a17:906:2e92:b0:a38:40c:5911 with SMTP id o18-20020a1709062e9200b00a38040c5911mr2287110eji.20.1707230277895;
        Tue, 06 Feb 2024 06:37:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUu96QIev3G7AKOTetfby9vEMbsek5UkU7upCeDF5tSF7c/MeK2fVG0fw4hzpDAaWaMvaXJRMsNBEsNDUI+69YY2K/lDyZjhxOhCHbUokqg+6sDTig3NcwmjlTm6pYpFhpvfCMbdEYh4nxSMlnlSN5aIOWh0Bp843YDMliA2q8NqVIInjiw5e5mY2j8rNnhLyVt0UN56mOHRY8LnVeIDo2ZuBnKOfag9DpCkHWLeTTQC/EmDij29Wi49dSclEb/rXgr8rERdEg4HKCEaFe8AbhsF9btBV6y1TPC9s1DnPhzLVAICklNMlAZDYWOqXKawqEPCO6mgMCjoss38HGP4XfV2XudnTswqnvDHWmGiuNUIboBfIOJw2+pDSqxCSQEvisMERpTkYEjtZLNL2ucvdlOwBFZWmMOxgSbKvVLWyzY6rM2QYap
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709062c1600b00a37585d5dcesm1224418ejh.51.2024.02.06.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:37:57 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 0/4] soc: ti: k3-socinfo: Add support for nvmem cells
Date: Tue,  6 Feb 2024 15:37:07 +0100
Message-ID: <20240206143711.2410135-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

am62 has a number of efuse fields that are situated in the device range
of the current chipid device node. As other devices require these
information as well, I am trying to establish a new nvmem layout for the
information available in this register range.

In this series the conflicting chipid driver is updated to support
nvmem-cells and the chipid node gets the register range removed and
replaced with nvmem cells on am62.

In a follow-up series the opp table will be updated.

Best,
Markus

Markus Schneider-Pargmann (4):
  nvmem: core: Read into buffers larger than data
  dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
  soc: ti: k3-socinfo: Add support for nvmem cells
  arm64: dts: ti: k3-am62-wakeup: Add chip efuse nodes

 .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    | 36 +++++++++-
 drivers/nvmem/core.c                          |  6 +-
 drivers/soc/ti/k3-socinfo.c                   | 67 +++++++++++++------
 4 files changed, 107 insertions(+), 25 deletions(-)

-- 
2.43.0


