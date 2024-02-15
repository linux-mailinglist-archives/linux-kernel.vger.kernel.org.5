Return-Path: <linux-kernel+bounces-66907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F4856371
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE19B280E68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6612D76C;
	Thu, 15 Feb 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z6Il3Pvm"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105612D74D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000892; cv=none; b=iu71dAL9hOmD0TkroNJoY6tGOCNAnuMNf4+7cSynNbB0g4GK59S3mSCw8QE+wsiRKm6Jqysf4OvlT8EyiDJDALxKVpk91BcsmqYccYlP/wmFCFle7L5V1fnjNPcbIlSEBuPR4hTuOfkFb92Nu7ZemdjtI1xigJAfsfsvKcoplL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000892; c=relaxed/simple;
	bh=SFCpTXqbRdAXHUBBAzzxnjc1Az5f8TRxLKC/k3F4vy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nj+ZkpQgqy16x6vlY1WwqsDzrHxS/9Tnp1BYG4SYcjUNjhgglZoEbXgZVErMC3k72W6f3hXS8t75SddJs+5PcVeEy7eknZcfQ9Qc/EdjuEEnOCryawCzLgEpzY1Uq/juJNoQh0o+ekrUmlIKY0cHc0vaIY3kKdlSlkZ2yieOHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z6Il3Pvm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394b892691so556886f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708000887; x=1708605687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MYnY7O04/x9zyqYEQqnNz4jRAg4FTDodHzcngEZrlFo=;
        b=Z6Il3PvmGKjrj3wv2OGK0Btonvz44YqMK1xp0TWb1xoWkhQa65XoKbxfGc4xOYO934
         m/LVFeHzpbYBPYTIuFYf/8H8oppIxnMTCOCUqF3/VNU10RvBjuhGKZmn9d3xD/kJ/T3k
         I/gVZwS8+kxruNjiZoCV8tvZ7DesMssZk3jW8JGuJ/IMIKDgfMTKIfHvosBNnVmBNS2D
         pPq+3LkSVikRTX1WRBGG2YFsPdSaiIKpYJTwRo02sgky/Jiqh5noDQLoEbtH+tOSVmuB
         fjM1KETp6+a/8+zIm3EnfvVvMY6n/749k/Tb0QivGn7pV/UritF3nK7xZ6zRHyfZekwV
         wLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000887; x=1708605687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYnY7O04/x9zyqYEQqnNz4jRAg4FTDodHzcngEZrlFo=;
        b=hWk4yg7WDGEVdBxVcVzA3nGUgjpS5Sd3UJKIAOBeTeyjH/xYLo49CylyTkVEaA1Wug
         FIpFhgz2j5hQpw2r+GoRtWOV1iqnsq0iwUU921JcvLYymOiyUhHdTS9Uvl525K5AjvIG
         Lsjb33PiqmPgL9kGMnpmojBBiMfgrNtFosjRNDC1XzclcJO3pVS8wUA0+9I4IAzrzxZ3
         xEjCJIkAnhBCQtZqajoGt6YQas0xdof/1FVX51Cf81AHNSUSyU/YbipDJPvmheFIx3fQ
         bkDGnipapducsvMdE58dK3bBuimgkiDhiRVWbwzdePpsAGq4cNC75fkBjaP41Xf1juRp
         sB1g==
X-Forwarded-Encrypted: i=1; AJvYcCXPI7nB577jDsUEj5SFs6p/w/ILYFeLq1qg3uqJJqXs+yKuAa93lSDftYVGdSkSM/neKbZUdHKqsXXMof93CXdSENghff04ErrhgGEt
X-Gm-Message-State: AOJu0YzJL2ve499O8NW9l6RamplUhoH4VEHUwm/n6J1ZdGjj3LnWSIpf
	+3YqkasfTKytfZD7OfroNtDo+MiFe3IWEmkcNigAvZQ6C1Ora0kdypR0a6IbnWM=
X-Google-Smtp-Source: AGHT+IGIGdB7TdXBD9OIkOScp9kvODa/Rio5A+z65NM6bDSmto8L+H13OukSXkPCKyay8Fdy8bJ5IA==
X-Received: by 2002:a5d:5591:0:b0:33c:f627:3bef with SMTP id i17-20020a5d5591000000b0033cf6273befmr1304211wrv.25.1708000887580;
        Thu, 15 Feb 2024 04:41:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d51d0000000b0033cefb84b16sm1674931wrv.52.2024.02.15.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:41:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/2] pinctrl: renesas: rzg2l: Add suspend to RAM support
Date: Thu, 15 Feb 2024 14:41:10 +0200
Message-Id: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds suspend to RAM support for rzg2l pinctrl driver.

It is expected that patches will go through Geert's tree.

Thank you,
Claudiu Beznea

Changes in v2:
- dropped patch "arm64: dts: renesas: r9a08g045: add PSCI support"
  as it was integrated
- added "pinctrl: renesas: Select CONFIG_IRQ_DOMAIN_HIERARCHY for
  pinctrl-rzg2l"
- addressed review comments

Claudiu Beznea (2):
  pinctrl: renesas: Select CONFIG_IRQ_DOMAIN_HIERARCHY for pinctrl-rzg2l
  pinctrl: renesas: rzg2l: Add suspend/resume support

 drivers/pinctrl/renesas/Kconfig         |   1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 408 +++++++++++++++++++++++-
 2 files changed, 405 insertions(+), 4 deletions(-)

-- 
2.39.2


