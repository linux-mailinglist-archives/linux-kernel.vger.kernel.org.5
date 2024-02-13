Return-Path: <linux-kernel+bounces-63949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF48536A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BAB23667
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA125FDBE;
	Tue, 13 Feb 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV1yosfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C45FDA5;
	Tue, 13 Feb 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843368; cv=none; b=Y1lPFDu5SOH0TO4wOAFApwYAkO5TM2yElg5jTiLcCoGPlnMqIeILr6xUSuXQYRAC40JLOTQm2b5TM6VIZUR0LZyPAkTAzBh3sccMBbgtAChnYS/RcmdqVSB95Uf0vSPDobk5AdLIuwYbPSFnKMq+E+LQ9M1f9+pKE4og38G5p84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843368; c=relaxed/simple;
	bh=ZmEGmNbg7orCIXpnVHbhJQ6i7Pd0eRRr5N6YyUcq8k8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bFxI/4sNl9jhEVmhNH6/RPpoQVQP33XLdXCaHOjCRn/F4HkBy0g4sg92Nr512yVJvMgNATcMdCZYbEmtBfp2z4ZM0/hxj1eUF8Fz5kIqr4f07W5Xc7UqM8H98DjrRJ7jQ/9KIR9b9zr3AQf2tSKZvP2Ji0uqolFg2SC/+mjgWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV1yosfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FB4C433C7;
	Tue, 13 Feb 2024 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707843368;
	bh=ZmEGmNbg7orCIXpnVHbhJQ6i7Pd0eRRr5N6YyUcq8k8=;
	h=From:To:Cc:Subject:Date:From;
	b=PV1yosfOXudZVK+Vz4yeF7xCvhUbzxWBJNUoc/eb0D86jFQYLddVcH119UHcvXHBx
	 VgfhDYYijG+CLAlkCjV6DVYdUrIY/c7adxgii2dTOJzqh9/rGDtn2tTK12I0rHMjku
	 fhnHvbOIFqeXDFFDKbaOzz2XzCAXsNy2cBR4742BufF7n1l+hNhTTaksQI0HXFe9oJ
	 wLXc2ucagJCCKGt3h74sz7quMfwdgiDw9v6ro1Am26LAAi3aBwKnOk6C6CwtBY5fwp
	 yXL9BiPEuQZMUAXXRibIC6HhDLtTq21gVDnJ5qF9wuFs6hKNdqxSofNI/aK1XicRZB
	 vFOlYcNKr3iiw==
From: Arnd Bergmann <arnd@kernel.org>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Fenglin Wu <quic_fenglinw@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] leds: ktd2692: add gpiolib dependency
Date: Tue, 13 Feb 2024 17:55:50 +0100
Message-Id: <20240213165602.2230970-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The expresswire module requires gpiolib, so anything selecting it
also needs this dependency:

WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
  Depends on [n]: NEW_LEDS [=y] && GPIOLIB [=n]
  Selected by [y]:
  - LEDS_KTD2692 [=y] && NEW_LEDS [=y] && LEDS_CLASS_FLASH [=y] && OF [=y]

Fixes: e59a15af7aa6 ("leds: ktd2692: Convert to use ExpressWire library")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/flash/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index 01998d71a6a2..809b6d98bb3e 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -23,6 +23,7 @@ config LEDS_AS3645A
 config LEDS_KTD2692
 	tristate "LED support for Kinetic KTD2692 flash LED controller"
 	depends on OF
+	depends on GPIOLIB
 	select LEDS_EXPRESSWIRE
 	help
 	  This option enables support for Kinetic KTD2692 LED flash connected
-- 
2.39.2


