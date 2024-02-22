Return-Path: <linux-kernel+bounces-76286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BA85F537
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1181F25E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BE839875;
	Thu, 22 Feb 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Fe4TK8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF538FB9;
	Thu, 22 Feb 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596212; cv=none; b=gLDYlF4AcYqhyIp2R7ZrOa3Evko6Edll514Sz0vIYpXU8dZEFdvnifI+MtlYTShDUQ2pBiX8SxJcag26w8wHcylwFEO38eJaXBA3A3BwyYg+YBmDTgBEKb6YXAC+AlECD1njGzUe7fYswWnh/FchBremZ1V1+i1+RmXWEgX9fY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596212; c=relaxed/simple;
	bh=0AggU31CGt9Ylb7dMMATQT5arx+9ift1Y5YR/y3R+MU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVA2/o63OWHAkc/V253Ee6ziw6SMBdcVL9/FT3++ZLrU4V6XpfSw0M+g2TmCg4/unAqW7yRW53x+bFWykaUIsEWAK7MO+2Wt9FdERifXdyupyLPP4YKu+HIgOMgjJ4idxxF6CdcpEPOOLg+4xtr3XoIpUdjw5mwrTA/Uv+SkQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Fe4TK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A975C433F1;
	Thu, 22 Feb 2024 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708596211;
	bh=0AggU31CGt9Ylb7dMMATQT5arx+9ift1Y5YR/y3R+MU=;
	h=From:To:Cc:Subject:Date:From;
	b=M6Fe4TK8tyMXPrN5n3UA3CMidv/F0/zv9WlgWVDiLyjsRIvkZDgUECgErqur0N4/d
	 BEpUb6hdqeYViHQjlHxqcFvFJFlQUOZKDI44b3/cKgAIZL1F/wooyjj9ABOEOu9p5Y
	 1277HuwsBDyZrDwlOY77ie08vHxOXchwQ6pmHGZjWQzOfZ6947Rte+CCDWLgxHBQmS
	 XtenB0iA0TJlpvSv5CKPxN/aYbDQhVfv4iYUKnENXlCLFwBwYO5mtI56klb44M0XhB
	 SclZjstRT4iLXKZGNMIrScxEAacBniTrTWufVS32T1dd7aKO8kjYQKxFNb/IlmUxcF
	 keHbag2tHwuZQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] igc: fix LEDS_CLASS dependency
Date: Thu, 22 Feb 2024 11:02:13 +0100
Message-Id: <20240222100324.453272-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When IGC is built-in but LEDS_CLASS is a loadable module, there is
a link failure:

x86_64-linux-ld: drivers/net/ethernet/intel/igc/igc_leds.o: in function `igc_led_setup':
igc_leds.c:(.text+0x75c): undefined reference to `devm_led_classdev_register_ext'

Add another dependency that prevents this combination.

Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index af7fa6856707..6e7901e12699 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -372,6 +372,7 @@ config IGC
 config IGC_LEDS
 	def_bool LEDS_TRIGGER_NETDEV
 	depends on IGC && LEDS_CLASS
+	depends on LEDS_CLASS=y || IGC=m
 	help
 	  Optional support for controlling the NIC LED's with the netdev
 	  LED trigger.
-- 
2.39.2


