Return-Path: <linux-kernel+bounces-115757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73388977F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA01C30CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7102022644B;
	Mon, 25 Mar 2024 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4UBlOGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA511E2EC5;
	Sun, 24 Mar 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321957; cv=none; b=Tig+l9PWT6OnIngPke777OgyOK3o2HwHEvX8GWXaMn6qOk+cKCoVtkx6JlP2QQ4jHjwKLLM4SH/2qFlt1i6fEN0Z0qOanGW8brrle7OZyz3qO3Cdj6tV0CWvS/C4k6imAj6G8qIlpoQC100bwy4N1r/oHKdUhsSUh/MJd4tjkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321957; c=relaxed/simple;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia12aKsx4YDn8c/3mx6IIf8GCl9YaZIx0fBywnLOHaDWDitQ9PVkJyRbDfzDxW1FFcwjiR1llXaCiChUUlLkNSyG57DaPFXiT2CgzeQ3F0mSFOctbhmdBNpiFrc+gaYq+yomPZ463Qx9awa61xgpE5FNqRlWpnJI+5Lr3hbowic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4UBlOGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6659C433B1;
	Sun, 24 Mar 2024 23:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321957;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4UBlOGDONZMyHvo0W7iC7Ufa6AzLo7JI/EmUFX9PAcuYhaAHbk90/CogB8WJ7St+
	 L3LBHQ7P2E7leYB9uCPS+GWcs5xmzK/p25gPBwNxnycqRhsY7U7FCntXIgzN7Mb65l
	 qXpBCFHk1LIu65weWVj+6W8jbZbzxim8X8MyO4tMblba2XPk97y5xaMy2hucFg6qur
	 +wRBK9xQriItbSveYeAgjgTtq3Os+ZGwjaRnoL6zHxxyhWEe1rI9PZj+cMS3b+fpgn
	 gvxTUJNdBf0QsVYzsQWADwLsyzJzmud6aIetpRBdupf1poD/XIuFww11oc4Wvrc9aR
	 VrNlBg7vZyYFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/451] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Sun, 24 Mar 2024 19:05:05 -0400
Message-ID: <20240324231207.1351418-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


