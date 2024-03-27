Return-Path: <linux-kernel+bounces-120571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A000388D986
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BE51C27542
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF7364D2;
	Wed, 27 Mar 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clf+4ABm"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DE36138;
	Wed, 27 Mar 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529618; cv=none; b=s1VJ1iOvbZ6K2M0NZ9GPW8+odbU9z0tFtE8AzsKrclmP/4V+rkGC6yf1tc4mxsms0xyBhhrDQZhQkf7qo60ojm7xKZMUqGaGpIcCZLjXavYYvsHda/8+xakJlw80IYQ0YEwGxVIa0jYvNqeyDrPBy60xi4i0J68v8XExvIdQ+LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529618; c=relaxed/simple;
	bh=xez2ioDrHnmum+g2NIQ4keedVoDjuo/J1czGEX+cjVM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uQSUFX8lJyK9UkEDO2XfXAaDG1UONe3hb6RekxxJRFu7dedsygqDmcEqqm6q/NJor+9IU6jLVpvSk3brO5/N4J+DxZiyGbrJZKmuPW3U0GCHPe2+GNEsl9TRaQ4bLCGrsfU4x40Ya4xjHahvd6QVLV1R/TnvKYbyJsXulkf2+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Clf+4ABm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so5187508b3a.1;
        Wed, 27 Mar 2024 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711529616; x=1712134416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L27nwRy0B54L75c8FppdsQdbbGjzrBj54QC46XAQ3Bg=;
        b=Clf+4ABm9elSeN1OTM3HD3zH14zZhsCRr7X/5xtk78oWnXtq2IAGVKUIa+c745mwVu
         I4AD54KqoaoehsgBjhLr7tCigh6ewKKS0urJ48sOo/ruwCF6sqCOjaoReM8OrppxA6Mr
         LJh4NCGgqZuhqaH1L82cokMis9bjR7WOeGELNPp0XPjpl456sOmpdgFm+Xw7ADQOhZVb
         3wHepBWEkxIjtnbyMhPMJsIGD2+nFvcU+QZ3b1PKoR4CmGbqHCbP40ExmRBKBubhKgQX
         wKZ2G4CQW39+w9vndhMK+1SXQWQ2BgpSW4TRhl0St2Du35EGZCzZplLHx4iFKuqOTS8P
         3ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529616; x=1712134416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L27nwRy0B54L75c8FppdsQdbbGjzrBj54QC46XAQ3Bg=;
        b=TU7oB4ZV81AdDncXK3HRX46t8/9rzyfZ20NUxmnkm9WG0HFZ0QD4ob1YUdofR3c+sC
         Hs6Mpfgxjmn4SZ0q0fu3fMdDKKX+ws218/cNFp8PceTPTjRPpRt8hZUPIFCFopEarKKl
         iQLaSckW1xJwV9GYWfpSjX2VHDqpRmiuqB/JqpqdyybfP9brBfKcQBQ9Quqj6V8tK/Yv
         RynOp+5LwhzZfiWjMslVp5utCX5sRNnRgI6WVZArFHI+QzXv5LfGX89tSrpyvkC8gy/J
         LbgSImHPuQrTbc+MmlLJ/kdT1yIqcuYeffMZrzP91bZhXG0YHgxsIZNKew/C9oZyuQfs
         o0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYMWbyC7mcuJ2cgDQ/n8yV+mT9WDqlJHO3PTYjzngq14s8dZuajFZLNR6TUFpb4CYnBeao6Ra7yVN/PTt/ZQ71FRkFHYxlDJ3BzVT6hwuNz4jmIo8+YbE9Ywv16swsf/Dayni5TgUa6/o32uqNUv5t8CcCXpoHm/k6qkPWbYYGxJX4QiUiXRMd
X-Gm-Message-State: AOJu0Ywh7Lgd2DLwkxMaQzAYQtFQu/NZKR0vs3hYQlTNMtnPdNhVTAd3
	BrhLUo3IK+ChhztCGlBh+qpC8Vmne3VhckyzCIQaFpRwTSXS83BlYZa+IKFB
X-Google-Smtp-Source: AGHT+IHqmkt9OtAKUxJa0j6kyiCFEtGlMxKMALqNdU/nVhjmwEQ9JXHQc5PYrKjshaxLA5zvrZJpTQ==
X-Received: by 2002:a05:6a21:2d8f:b0:1a3:e28b:e574 with SMTP id ty15-20020a056a212d8f00b001a3e28be574mr1652139pzb.26.1711529616478;
        Wed, 27 Mar 2024 01:53:36 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e383-3566-013c-5a87-9abc-381e.emome-ip6.hinet.net. [2001:b400:e383:3566:13c:5a87:9abc:381e])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001e0501d3058sm8356848plb.63.2024.03.27.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:53:36 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Wed, 27 Mar 2024 16:53:26 +0800
Message-Id: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2500/ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set.

Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
ast2500 SCU3C when bit1 is set.

v3 -> v4
  - Add error handling for syscon_regmap_lookup_by_phandle and
  regmap_read.

v2 -> v3
  - Fixed WDIOF_CARDRESET status bit check and added support
  for WDIOF_EXTERN1 on ast2500 and ast2600.

v1 -> v2
  - Add comment and support WDIOF_CARDRESET in ast2600

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---

Peter Yin (4):
  ARM: dts: aspeed: Add the AST2500 WDT with SCU register
  ARM: dts: aspeed: Add the AST2600 WDT with SCU register
  dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
  drivers: watchdog: ast2500 and ast2600 support bootstatus

 .../bindings/watchdog/aspeed-wdt.txt          |  4 ++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |  3 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 ++
 drivers/watchdog/aspeed_wdt.c                 | 60 ++++++++++++++-----
 4 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.25.1


