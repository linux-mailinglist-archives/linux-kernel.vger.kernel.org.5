Return-Path: <linux-kernel+bounces-113865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC370888709
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CF61C2627A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3462137C24;
	Sun, 24 Mar 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teKTcbwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AD1EAD45;
	Sun, 24 Mar 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320919; cv=none; b=HN6Evns8b4m68DPfdQBrWS1R6ticyFFpeT9IV9PoJlKHrabahVOGplwT5HvyEmczojIM9nDeRr5H/pWuWnew7BsZBeER4yp0eQ6NFHyF7RqSUIAwlFB1AqnaYgtkfMH0XYMDPPDmYHuUdqb/lg+pW7089dM5QZK9s9x0hNzs2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320919; c=relaxed/simple;
	bh=HTrrK1pFvDc5N5gNcuLAGS1bbir5cq4s591h36R7SGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOSOYNNCRa4LeUQcPsBQBEF9CWSIa/bL0yiySWyIoqStIQ8c3XxFy44X8u3ew48VKAORDNDbzsK/8xZ3AYdCCnH3UELbYKJYLG67QL1R+akAO9vh++8CR+eNasdplcM1SA5zWqMp/7tkwm7UIrwW+TxtwSUa/N8Z10pf7TBfdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teKTcbwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A36C433F1;
	Sun, 24 Mar 2024 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320919;
	bh=HTrrK1pFvDc5N5gNcuLAGS1bbir5cq4s591h36R7SGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teKTcbwJYJoPdpcyVpi0POj1ztzxYo6hxj5cjJ0RApO3pQLqcorP6ICq3fRVn69bP
	 RwTZ2EU1RtaLaIbrty36SAVrXrNoEKXFnLo1NCA+HfUJH/IVLX2M+q08Hb9YD1dEbB
	 59aNxTIJLwYD/A3enMUnlg5mJfML9iB1ySU4XKEJyX+OzENyhiamAvyS+mi2NnP9ei
	 d7+oiJv/pqN1x29eCEc7022oqrM5iz0pXUjNi7uwAYjZDx6Ok2TzJd63rmD58W6eQo
	 hSRKtoSsjM++nbDhCWStunSbg1/OXPfZkA3M25RnbJ53sRE8haZ3Z7hXVR00FV3dn7
	 0obvViPcEEZOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 483/713] pinctrl: renesas: Allow the compiler to optimize away sh_pfc_pm
Date: Sun, 24 Mar 2024 18:43:29 -0400
Message-ID: <20240324224720.1345309-484-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


