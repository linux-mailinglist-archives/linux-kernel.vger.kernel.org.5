Return-Path: <linux-kernel+bounces-87433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6286D456
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A54283D76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985B144031;
	Thu, 29 Feb 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U78kPCWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC24160644;
	Thu, 29 Feb 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239051; cv=none; b=i7Jic3rLrEYigIAOBJnJ+Bb43Lvy+u8c31rIYkKr8SCiLSoBSfSWqa+9m1RB/tvk/Kh9DMqgnkAJ+Hxy+hDG4qqyBl3OL/8KMc1xWZGH74DpOv2C7VkU4NqwhZAvNSIKtjA/RNA1RLxGzFB8OLUbzG5+4yugwkHZyFQ/rwdwMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239051; c=relaxed/simple;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXXcWC0KDuCoUtHkVgHQEBMzALs2Jrshfo02D961OUGXiqhaiY/iIUeRIaLT06acb2y7SBV2+kHlSL5D0jIer5/6FmeHQwoxDvso4ENQOuBtsFm0rYDaGkB35Nl1m0W2KXIbLND75p1EZAWrB+KdYHweN0jIFB4cz8lLbuk1f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U78kPCWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC05C433F1;
	Thu, 29 Feb 2024 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239050;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:From;
	b=U78kPCWe17ueHfW80zt17rGFznSzQ+41f4dFSROM9JJhhh1flohp1rwyRp+RR89Ya
	 otZVD2NhwNRsqOxvV6UFGGf37ncnxrwFaYad4PwU8eUtG8uI7GZhzLNCsCizL7O+QC
	 UJ83UoBbUsq28I2FMekqjnwLiSAzpW/FeVhXQfou3tg8Spztb1xwL2qQ8MGe1P40Hk
	 eBT2erpaUXImRGTb7MAY6y85bJsHn8g9IM6I77asXkUEpW3nEQ5rNNWWlQYscLsqmP
	 YLucy5MSTyJK81KdVxFkzCkI4Jae4TPvdy1RZhPbFSPIv3G+Paj4GCrycVi0vbyhYO
	 s+up7axmVhySQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	conor@kernel.org
Subject: [PATCH AUTOSEL 6.7 01/24] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Thu, 29 Feb 2024 15:36:41 -0500
Message-ID: <20240229203729.2860356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


