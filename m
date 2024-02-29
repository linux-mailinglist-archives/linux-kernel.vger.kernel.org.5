Return-Path: <linux-kernel+bounces-87460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F6786D4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B2B230FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895614BF36;
	Thu, 29 Feb 2024 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fViCkLda"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697614AD2A;
	Thu, 29 Feb 2024 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239175; cv=none; b=Hf4otDQKrIDH15oj1KMh5quigvwMOZIZ7ubhJr/YCmbGLB5GWY/kSZT+wBnWMZ68X4FWo9gzSzmdS4N3WJjaGIzo/g2PTLGpo1k1cPtkr7atULEhqpCZWL4gKydYKWCfnXONiuNNrKE6erdl/xHzIG1DFT5f3bZS9roqSDwDdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239175; c=relaxed/simple;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/+lzg1sXY/ikSW0sP72CP+8fD+5roLL/uCrgmVoPnKgr1ZudKStZB2xkn1zWFB+OsL5EX0Np7R4ylc7cT2pTdfbQFGeGwrkJxU1JF6p6La6SorKzx8XNtNTQCi7UCRBQe9ps0aE+05h1Wyve0h3Ug6FKupz0QaPCgxxh258YJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fViCkLda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E54C433C7;
	Thu, 29 Feb 2024 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239174;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:From;
	b=fViCkLda10jTgXe6o+WEXRIEGV6pdeDvAqB/Who0DJPpdZ2uLyxgZZ+CXg30f+lP5
	 R9jSpY7zXmmYwOjFpSFM0dQeAjzuJo99+uWpaDSyPF40bAB7yxEvHxRZhHlh7nZjy9
	 1oSOdLi50R+hfHh7uUNeaxrdNgiVmj4rvVyl5M3pent0pmcfgMbp8pERnGWRyqfD8+
	 7y6mZ+HHpY/aP5EkdrPVcfCIkYx6X5qKl1KBc+08GRvmagj0/8w04+m9ZoHpFarwYV
	 D17u7GJ9qnK/kkT447r0SORZJrmAzZUGdHFgeHP//lUwmM/PqZJ5mT4KKaNFPHAtbj
	 0bHWEN2SA+5Vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	conor@kernel.org
Subject: [PATCH AUTOSEL 6.6 01/22] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Thu, 29 Feb 2024 15:38:54 -0500
Message-ID: <20240229203933.2861006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


