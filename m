Return-Path: <linux-kernel+bounces-46263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D9843D39
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4361C20F35
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4054028E11;
	Wed, 31 Jan 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yckz/Mi3"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF5381CF;
	Wed, 31 Jan 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698333; cv=none; b=IaZzI10KjmXuzQxaAgJNJX+AueisSun7wzM4AcKM2aQtGqUxBLYgjU2AMwvTVXMEymdUHEykaMS4w97qx+3X11+aDKRSErl0WwL5KTX3FMbvrO8m0HLLsfrAK2qOTFawDXEAw6EELBK3Alzx2laDgaXMuWdvPxEIG2GguLq0xno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698333; c=relaxed/simple;
	bh=DGmZU63Q37UkHlbIH8fLR3aZiFOikJYY5ANhxy7tlFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KX1mdZO3LYkuMxsYtrpXMZwJosD8aN4R8Pn/spuL2D68B134f7NFz17P2kJ2xua7yw5Hhb3ZZNTbnEDaLes5zh6ahJVNxNlJxy3G6oowdjrOpwbDeH/+QmZEasOuxoxiDxcamPbehWI6wGUdaQJjr9iNmfrJ30k955ErkQy1Zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yckz/Mi3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so5390742a12.2;
        Wed, 31 Jan 2024 02:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706698330; x=1707303130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9JeCucnsfGx7Z0QaXosTpTRVT94pSbDhvJDrTPY+cAI=;
        b=Yckz/Mi3DYHXF9eP+lW2+VGN4BHOWxaqWE1Do4AAjJteRtCOandVZCdCvvke/klS4M
         ProF+9OIGgTl4HIpYYxQ6RReT3iDo2YVKdWdIPlKNfdp+Qr8kJrhP95SV+Itqt4jaEPh
         5Cps7U2tfT8Kaz+Au2uNzrqAiv1LYGszGGUPBgwPSDO47h4cunS348y36qKlrVxZmDa0
         clSWr1EDqRNeJxmGxQj//spTWE9E9Nf2/SxGH6aa3fXk5zxvnvL09f4OjQJUODAJcvRi
         YpFPnZfwxM8HQjHEvl+vCa5vC0RI4zJclxEc8VL+Wx98PjpqI/2ePcGH4BueINGniwuZ
         HbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706698330; x=1707303130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JeCucnsfGx7Z0QaXosTpTRVT94pSbDhvJDrTPY+cAI=;
        b=A8ZaIF0XWbIg0QrGHUPjFJlx/mVTPovlSdELgxdHo2bnNH23GdjkpzsCQHT5ha3n17
         CiaYhs4Yrg6rJwWc+2Dt3XfyE6PGfAToZ0CDSK9uIIGZSDOO9FYze0SItG1ub3RO5nhw
         Swg7x1XD9kXPcKbK4fwQ/nKK3duFCZT/mLvxtFuUETMD8zE9w3FkLFf0jyw0BBHmDY7y
         nMlOBEMgnpenQ/VtXHEGmD1wV56BrZ7xgt6G1IPSq54GL7x/vDFZ/sGu76ayrfqxu0em
         +vYMamF43PnIcpI2C5W8YDOp/UlZYZZyigpZ8I1ImTSuz0kHQLcBrmBL1vEVFI7XZZdZ
         7fTw==
X-Gm-Message-State: AOJu0YynosGclbHtGCid/GkyBUJR0XKyky/it6Lz6+sBxC7Zw96kckLP
	+HZ2Ze5vGSEpKmMWI/Gb33imfbAvvldzsqyoq4SAcl4kKW3iiWx3JrP/y6ml7TtTbQ==
X-Google-Smtp-Source: AGHT+IEwNKhfe5HLqxfJdLr/mQVN/ynCYw98W6b79fk0DabFqSvzYyREmD1tVAlcRpPhAcjZDr8BpA==
X-Received: by 2002:a05:6402:b05:b0:55e:faef:b1fd with SMTP id bm5-20020a0564020b0500b0055efaefb1fdmr814674edb.2.1706698329901;
        Wed, 31 Jan 2024 02:52:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVloNtOiDmzfaijqzAGP0c1dyJjYV24FM5kStzwmqpJsPJBwke7xCJHzyBoutd4IUuNqsfhXQDqm2xSNkYlq3S6aj7zsfkSKTcE12V0fBUj4pBkVTdYWBA/j76TI7OohgN7pJXmJjky7kK+67Oba26YFMzpWnAJyNP0ZLOP3CYbbuJpzksL8W5f/UzcJa5F3STqmopfgLiSN3v0t9VejnYZ+tgzXfR9j40810sLxo+heVWA6Qe5zQLdUYoPQMJqdInx/lige+m8aipgnmk8GhcLe9yFU+H6xb0hbmU9LJw7OF6t9jo3NKCsx4GDOZ//Lgf1r+bt23CuSJEYvkNc9CTswmWk8Q58C/52DI8pyHlaPd4bOTo/5vjNM9UmtHNn60ODQg==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm4753966edz.27.2024.01.31.02.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:52:09 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v1 0/4] Tegra30: add support for LG tegra based phones
Date: Wed, 31 Jan 2024 12:51:49 +0200
Message-Id: <20240131105153.8070-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bring up Tegra 3 based LG phones Optimus 4X HD and Optimus Vu based
on LG X3 board.

Maxim Schwalm (1):
  dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880

Svyatoslav Ryhel (3):
  dt-bindings: vendor-prefixes: add LG Electronics, Inc. prefix
  ARM: tegra: Add device-tree for LG Optimus Vu (P895)
  ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)

 .../devicetree/bindings/arm/tegra.yaml        |    8 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/arm/boot/dts/nvidia/Makefile             |    2 +
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts  |  489 +++++
 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts  |  496 +++++
 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi   | 1821 +++++++++++++++++
 6 files changed, 2818 insertions(+)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi

-- 
2.40.1


