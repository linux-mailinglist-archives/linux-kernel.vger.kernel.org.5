Return-Path: <linux-kernel+bounces-115705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672188947B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2644295A16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044C9259996;
	Mon, 25 Mar 2024 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx6gaTIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38938153833;
	Sun, 24 Mar 2024 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321703; cv=none; b=Cyl2fpDhu+tZWX6XaaC6K7ws5GV7WRpuKHFfCnS2cK6sbxtUONL425URpxsnJXTeqC5/VF9kTcGRejnu3gZTCqWueJzj0K1Vs23KXiFA78OSfekdkiiXdQgwJcbPgUtvBlJqom40c93ux0GKb6+K0gElOnXiKb1VGB3bnsTIJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321703; c=relaxed/simple;
	bh=HTrrK1pFvDc5N5gNcuLAGS1bbir5cq4s591h36R7SGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUvwEO1p2lgN5rx7QDCPzPfPmGWmPi/NlkQJZS4dUTu6cYm3TmAxAdmOMfMXFexhzUnGS75MurznLxW4Ro8YsJr9+FPlL7LdxFMF1r800tMq8ey0Viw3bNGHUG0r/lgGhxq6bAxL+UTwysS+MeWpX2cBDzuojzu4B6upF9YIgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qx6gaTIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2376CC43399;
	Sun, 24 Mar 2024 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321702;
	bh=HTrrK1pFvDc5N5gNcuLAGS1bbir5cq4s591h36R7SGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qx6gaTIFHvjWKUnZeP59ndL32UmsBrX6avmWyXjT/Gyq7rTP0htW8M8rPCoseYXcC
	 eb8Y7yWtF9OwsLC3w6qKgN+84usUJxum3fJEY7v3igu69Fhy5vJRl8CHt96Xc5yML+
	 z2VcGfIZx5jiWjOrbAbcMzFTbPnBIcMmLKQibGCLo/a4fC/dWTJ93BxOt3QeWB5zde
	 Q6LmGBl6fAEaLSnkhjZ4RXumyM0MI5eqBBVHOJ50iQkGMSMUHtQdVthNMtW3Lw6f3V
	 OUx/NgokabcTCml11jBq+aWqrA4XsjBZ31ryuh38KYB/Y8I6o9NBdNbOl6khz7vAoc
	 wFdZesbqfFdGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 431/638] pinctrl: renesas: Allow the compiler to optimize away sh_pfc_pm
Date: Sun, 24 Mar 2024 18:57:48 -0400
Message-ID: <20240324230116.1348576-432-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit a6f06b909fee72c679c565adfa7f080f9595e336 ]

The conversion to DEFINE_NOIRQ_DEV_PM_OPS() lost the ability of the
compiler to optimize away the struct dev_pm_ops object when it is not
needed.

Fix this by replacing the use of pm_sleep_ptr() by a custom wrapper.

Fixes: 727eb02eb753375e ("pinctrl: renesas: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/6238a78e32fa21f0c795406b6cba7bce7af92577.1708513940.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index 93e51abbf519a..d1e92bbed33ad 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -731,10 +731,12 @@ static int sh_pfc_resume_noirq(struct device *dev)
 		sh_pfc_walk_regs(pfc, sh_pfc_restore_reg);
 	return 0;
 }
+#define pm_psci_sleep_ptr(_ptr)	pm_sleep_ptr(_ptr)
 #else
 static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
 static int sh_pfc_suspend_noirq(struct device *dev) { return 0; }
 static int sh_pfc_resume_noirq(struct device *dev) { return 0; }
+#define pm_psci_sleep_ptr(_ptr)	PTR_IF(false, (_ptr))
 #endif	/* CONFIG_ARM_PSCI_FW */
 
 static DEFINE_NOIRQ_DEV_PM_OPS(sh_pfc_pm, sh_pfc_suspend_noirq, sh_pfc_resume_noirq);
@@ -1415,7 +1417,7 @@ static struct platform_driver sh_pfc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.of_match_table = of_match_ptr(sh_pfc_of_table),
-		.pm	= pm_sleep_ptr(&sh_pfc_pm),
+		.pm	= pm_psci_sleep_ptr(&sh_pfc_pm),
 	},
 };
 
-- 
2.43.0


