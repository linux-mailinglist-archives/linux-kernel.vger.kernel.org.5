Return-Path: <linux-kernel+bounces-61408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E30851201
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A63E1F21947
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DEE38FA0;
	Mon, 12 Feb 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1OuXjK8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E722BAE7;
	Mon, 12 Feb 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736706; cv=none; b=N41Dt154xHFD4JxPseBTjjhulTok+VEX1BoraXj5KeG5nh6h7V9fD+TrOTr3NUHJeVsx8vPu2BbkMx14UDD4T07S85Esdtk6Lc+qqfIPZhvtfpeWx3ZzJZtzfSEp0pC8lsauMfc1X6xQ2uz5iURx/3sRTQMJlizV4A6amKRG06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736706; c=relaxed/simple;
	bh=1lR4IsJGmLUexDJX/zjNYB7tgsa4JkZ3HcVTMHB2dNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QIAs2vceSqIax5QePmVlBWZewiSyRJLN286BXnyu068jFSeuO1vaBLyFgL+C3BqGLYfS3fULK7JNV+6wC0ZTQSf+L6bRUr8foj3oxfeB0bf+KAcGu1PBtE/4atHoEKiWZ4j9fBrcLnWiv/7e/ML/ZlZtYfmy2SjqWbjpOgSoJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1OuXjK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2547EC433F1;
	Mon, 12 Feb 2024 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736706;
	bh=1lR4IsJGmLUexDJX/zjNYB7tgsa4JkZ3HcVTMHB2dNc=;
	h=From:To:Cc:Subject:Date:From;
	b=m1OuXjK8CZ+NAI6SOCsY1TaOBBI3XiORFTXfFMQ9vxA3c3yftkO8wpysTgFM97Q3q
	 bJUqMUv9ebPvJdBSdzXnkFLHSJgYchoroVRa8XgogGgE8l064Eo3Ghdhf3jg5hwyJl
	 4fqFxaCSroYO4hMXj0JJr2eCkQeJH2FsKa/XxCMLTF08OZi4sDZhk5d4EIO8VIn81v
	 9kacs51BlOrxwHS56vkiZ6hTcegnAOltkl8drmJ0SKdBFZ0zjLBdIfO6cP9mvxB/gj
	 zi1/nt8vcFiDJd/NTcmShtimOwOfvSTY+uyVdS4rcFPqrYrg+WxiRuF1nN9IH6umil
	 1JgxnCfdxJT7g==
From: Arnd Bergmann <arnd@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Hans de Goede <hdegoede@redhat.com>,
	Jianhua Lu <lujianhua000@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: ktd2801: fix LED dependency
Date: Mon, 12 Feb 2024 12:18:12 +0100
Message-Id: <20240212111819.936815-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new backlight driver unconditionally selects LEDS_EXPRESSWIRE, which
is in a different subsystem that may be disabled here:

WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
  Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=y]
  Selected by [y]:
  - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]

Change the select to depends, to ensure the indirect dependency is
met as well even when LED support is disabled.

Fixes: 66c76c1cd984 ("backlight: Add Kinetic KTD2801 backlight support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/backlight/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 230bca07b09d..f83f9ef037fc 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -185,7 +185,7 @@ config BACKLIGHT_KTD253
 
 config BACKLIGHT_KTD2801
 	tristate "Backlight Driver for Kinetic KTD2801"
-	select LEDS_EXPRESSWIRE
+	depends on LEDS_EXPRESSWIRE
 	help
 	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire
 	  GPIO-controlled backlight found in Samsung Galaxy Core Prime VE LTE.
-- 
2.39.2


