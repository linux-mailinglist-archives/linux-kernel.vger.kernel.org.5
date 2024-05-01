Return-Path: <linux-kernel+bounces-165177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1E8B8918
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883EA1F21A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DC58210;
	Wed,  1 May 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="haNFRWk0"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436848CE0;
	Wed,  1 May 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562163; cv=none; b=ex8Ht904hs+/ADCxNduO+MMY1MsY50VqZXVE5FeM1VxNFsJZkYLYZsWZqz/2Z/bHI8km/ncibXQzqVSjOQEcfCxZ1Z23I1C9jJOEKppwVynbqK02lFIX94ZS+1EQiXqXMSndMsRL/KwfxO7uzRqATFOk0kXOAxf01TE+VlX70X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562163; c=relaxed/simple;
	bh=WrVzGn8KPWtlAdktWSnKisYZX5ONnAb2Sjp21iUZoxU=;
	h=Date:Message-Id:Subject:MIME-Version:Content-Type:From:To:Cc; b=EAnsCuRkOI8wpilIF9y6Onbjjaqko2ZzD3gs/CKQJZLKyElo/cKBIGNkHWoDmBHSDZTBkt9YBVnHr8iqd7Jfb7lwNNsRdDNJMpF6/H5fdz/hpCdNSM7tcuyTfYuSE3uvTm+2qYSVbOS54+m7/EY6zmdWmMMXmRByCqwqWBja0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=haNFRWk0; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714562159; bh=WrVzGn8KPWtlAdktWSnKisYZX5ONnAb2Sjp21iUZoxU=;
	h=Date:Subject:From:To:Cc:From;
	b=haNFRWk06TEuzRzNretw0HYSkvnEWL4JcrhIGNkGmmsEFOZ5wSK7laIOh6xTuMUtJ
	 AugGMS1x5Costci2JNubtpTVfnMujlRxad1d/mIOK/wy8DPAlFH92A6dtMRY0x41hi
	 8U8ksplQ6VjmqgU2SGHBEFycoM4Y/tmKMLvBv7cZ/yDyFlggaz9VZUsQAFtDPuUN9A
	 uhICQiyvbwI6wzvEMIBMjD1jHY/6GAv8sRLuMuC+WDFgP1jqKa91vd4PVSJZS3FWj7
	 ZXeQbTuv9z3dz71l5eDf3f26YNr12FxrDMjPgvcDnSyR+8hw9IqooRxz+fqran7yZ3
	 I+7t4R44OZWBA==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VTvdC1SNLzBL;
	Wed,  1 May 2024 13:15:59 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Wed, 01 May 2024 13:15:58 +0200
Message-Id: <bb6b85722d80d665779e3043d1499c4fc38f0ff3.1714562004.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH] pinctrl: renesas/sh73a0: use rdev_get_drvdata()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc:	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org

Replace `reg_data` access with the official wrapper. The field is going
away soon.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404301218.URkWO6dj-lkp@intel.com/
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/pinctrl/renesas/pfc-sh73a0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-sh73a0.c b/drivers/pinctrl/renesas/pfc-sh73a0.c
index ca5adf2095be..41587233aa44 100644
--- a/drivers/pinctrl/renesas/pfc-sh73a0.c
+++ b/drivers/pinctrl/renesas/pfc-sh73a0.c
@@ -4024,7 +4024,7 @@ static const struct pinmux_irq pinmux_irqs[] = {
 
 static void sh73a0_vccq_mc0_endisable(struct regulator_dev *reg, bool enable)
 {
-	struct sh_pfc *pfc = reg->reg_data;
+	struct sh_pfc *pfc = rdev_get_drvdata(reg);
 	void __iomem *addr = pfc->windows[1].virt + 4;
 	unsigned long flags;
 	u32 value;
@@ -4057,7 +4057,7 @@ static int sh73a0_vccq_mc0_disable(struct regulator_dev *reg)
 
 static int sh73a0_vccq_mc0_is_enabled(struct regulator_dev *reg)
 {
-	struct sh_pfc *pfc = reg->reg_data;
+	struct sh_pfc *pfc = rdev_get_drvdata(reg);
 	void __iomem *addr = pfc->windows[1].virt + 4;
 	unsigned long flags;
 	u32 value;
-- 
2.39.2


