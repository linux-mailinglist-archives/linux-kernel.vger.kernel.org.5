Return-Path: <linux-kernel+bounces-113342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD9088838F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C7DB2160C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56069198B79;
	Sun, 24 Mar 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MytkDKW0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97755197C9A;
	Sun, 24 Mar 2024 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320143; cv=none; b=ZL5JCDE8+qb9tC0Gft/jyo//CgkbWuZoGjx9Mge6ZpV9Kz9tcyd8iCDeYk8HVphqj87C5pT4MbIblSRgL1JpI3FTNFg7qpG5z9PNc2JzrHbp6aawns7uwggufzLVjs0BheCiAEDGlgvF0ChbPC4vdaiEL1jm+jzRKZ29NMfrVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320143; c=relaxed/simple;
	bh=HTrrK1pFvDc5N5gNcuLAGS1bbir5cq4s591h36R7SGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNzhv3IspQQIx+VGIA1DtmA+qaj33npHIqT/OMaJmd9lKdUCT3qcUfHDthasyvZAu2n/YBLaxGO1K514kmaoRXhQ2ReQu6bqCOBBPMqil2Tw0VHiGJdYv8afRSUvHsOoQv4NWKRJ+rshKIH88J8g6CBWEEWFsgmQOc9KIuH04cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MytkDKW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95439C433C7;
	Sun, 24 Mar 2024 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320143;
	bh=HTrrK1pFvDc5N5gNcuLAGS1bbir5cq4s591h36R7SGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MytkDKW07SokVr15A6RUSmj24r7IbF1ApEcdrU9ig/VOOtHInAyk0Zgd7YnW56KEN
	 gjD+EWEHiVE+N2tQYhKDnc93sA5EKtVvsuJ5n2acRyRH2FwD5Mjhf4SoDLCRLEkqfS
	 iEtUh/jJ0xi71g8cFemYnBwwiYkkLxVFqj1L5Z0+Gj4B8i4qoBhUPi5kdu0iKCm5sE
	 jFuPqupFLVm6yY1bCLkjX5WpJoE+a+MBodTJ8WcA/t7tRJK4HXdq8s/TdkAplKBFNd
	 iZ7/kIcz3gUQU/NCfVOchHQx7t6AED+b0Bmwab0/6aQ9RwIS8f7w8lHZrls6kVUF46
	 C1pAi7QZmwaUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 451/715] pinctrl: renesas: Allow the compiler to optimize away sh_pfc_pm
Date: Sun, 24 Mar 2024 18:30:30 -0400
Message-ID: <20240324223455.1342824-452-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


