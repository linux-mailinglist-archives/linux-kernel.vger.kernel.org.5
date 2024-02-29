Return-Path: <linux-kernel+bounces-87484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079B86D4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4DE1F253DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02277145654;
	Thu, 29 Feb 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIoKWvJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A9145642;
	Thu, 29 Feb 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239240; cv=none; b=o7X48NWyd1eSi5p6uaB681FItiSGPvffAQwiF3b78D+SDxsOQ1zEs69WowfwyX7iGshhRakRZDnSTo0ykMpfR7KvWdtvWbbptKSnGKdpfouK8yj5SQBE1f6PNrsA0icZfUkSsT+pyO35oPROXnqShkHapyYzLhZ9NuuGxXUa3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239240; c=relaxed/simple;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/CnnkdEBwoXh24cFsbEG0IeNfpCF1KSxq5OZEOTEmjTRUvnJPyRdcWSumdbJzBbGQhLaQpcgYcw9WUVcHRk4FMnB0Syolqv/ainZ7Ozthu94BkFBMsMEpLKwNNBnRDMUa3Tuk/xt23RcT87B3VKPz7azOtPGILQOn3Bp+LUsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIoKWvJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31515C43390;
	Thu, 29 Feb 2024 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239240;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:From;
	b=BIoKWvJnFVfyD78CMXPc8VBykbIYrvvtSlHR5MQhL77u2ckClkIATXRCwlw/dYTER
	 uJlQCaFuvxmNra2/WGKE623g9UZZ1+PZtv7DA68WzFT/5FsID9Qbufx6tfxxFg/t5w
	 IszudrxnKt8gHMvNXYJJHrR4zTxsbumNS3kmR7Kq8k+kVnxjWHsBnTNClRlVE3PMke
	 3Gc1GWH4Jn4freM14mdeWbH3gysO3leQkh90rZnedBz3gLijdmM4I8+5NBxNfviu5V
	 WF3jjA7MyST9BZ6ElMgQVx04W9FTWzs9+UriT4Q2w5wy3Idiqgfi0XEnKpUuyGYOF7
	 lfO+7qQTn7hUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	conor@kernel.org
Subject: [PATCH AUTOSEL 6.1 01/12] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Thu, 29 Feb 2024 15:40:23 -0500
Message-ID: <20240229204039.2861519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6dd9a236042e305d7b69ee92db7347bf5943e7d3 ]

The symbol's prompt should be a one-line description, instead of just
duplicating the symbol name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/microchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
index eb656b33156ba..f19e74d342aa2 100644
--- a/drivers/soc/microchip/Kconfig
+++ b/drivers/soc/microchip/Kconfig
@@ -1,5 +1,5 @@
 config POLARFIRE_SOC_SYS_CTRL
-	tristate "POLARFIRE_SOC_SYS_CTRL"
+	tristate "Microchip PolarFire SoC (MPFS) system controller support"
 	depends on POLARFIRE_SOC_MAILBOX
 	help
 	  This driver adds support for the PolarFire SoC (MPFS) system controller.
-- 
2.43.0


