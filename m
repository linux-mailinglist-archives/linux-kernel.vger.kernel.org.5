Return-Path: <linux-kernel+bounces-138006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896F89EB06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0271C21973
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796E22071;
	Wed, 10 Apr 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="orLVkBQJ"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70132C853;
	Wed, 10 Apr 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731247; cv=none; b=fk9vBJ6FHCpzfMyDJIaG8GFy83LFwxrIvQQ6r5dQB0P37hVrI6kAU6JPJJgiWgxJ6t//q7HAhgI4KHkyratBgPT4ifquKmkbOMBFq81BkpzSvidt/zOmoQorpWWq9nxIG5Hw/Vac/Z69r0m2oGpkjQqOGlU+zHxuGeibfAKJ9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731247; c=relaxed/simple;
	bh=wCs2Bbu3C6J2O1X3vXpkxYOKLXy+CaCvFD4nkCkciKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KssEc8OiieciaIuZvqac6WUQ7+NJlCaxaN1w50o0riauoSabY5yFsXgoyLjrQEo+jN+XU4jrmVp9k1nqb9I5MvJpA9c0nULvdh9XezoCKaS6hzwc3PlIXgLIGfGf/ORwTnpB3+6k1spjJy4wFJapLeKYITtywXfomVokWkvqeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=orLVkBQJ; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 2F5896034B;
	Wed, 10 Apr 2024 06:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712731244;
	bh=wCs2Bbu3C6J2O1X3vXpkxYOKLXy+CaCvFD4nkCkciKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orLVkBQJfV+c+rBP/F3QSmmJmqSlU6ELvRrzvfbVlzQnKiRpHVIus0cBip4t6Gq9a
	 gg06zQ6Es+P7PkJ/fSqbf7Lvy1xTzS331jAjDzLW79BfYR3HBDygliYDNlVPOfb5QA
	 UoKciRsBNf+iMmB7NfHnQ0Hx61+i0omzfngzrpSYE5cn5tNXSnBTF2JYhuP+PtqRBN
	 ZeXFwGNl5CNQ4FlCVGOSrzwulPG7LyAWGiD9Q4qoZj6rdY3AytWPXtMxOk+4q3F/dm
	 13mjgqdcTV7GWWGIc7HhzLIyIaW9CqpimNX3ZuiQS8Fa9W18OBEwxmb69rPAODzzfS
	 c2q0cqXFtumGQ==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] bus: ti-sysc: Move check for no-reset-on-init
Date: Wed, 10 Apr 2024 09:40:05 +0300
Message-ID: <20240410064010.57142-2-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410064010.57142-1-tony@atomide.com>
References: <20240410064010.57142-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are wrongly checking SYSC_QUIRK_NO_RESET_ON_INIT flag in sysc_reset(),
it can be called also after init from sysc_reinit_module(). Let's fix the
issue by moving the check to the init code.

Fixes: 6a52bc2b81fa ("bus: ti-sysc: Add quirk handling for reset on re-init")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2145,8 +2145,7 @@ static int sysc_reset(struct sysc *ddata)
 	sysc_offset = ddata->offsets[SYSC_SYSCONFIG];
 
 	if (ddata->legacy_mode ||
-	    ddata->cap->regbits->srst_shift < 0 ||
-	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
+	    ddata->cap->regbits->srst_shift < 0)
 		return 0;
 
 	sysc_mask = BIT(ddata->cap->regbits->srst_shift);
@@ -2240,12 +2239,14 @@ static int sysc_init_module(struct sysc *ddata)
 			goto err_main_clocks;
 	}
 
-	error = sysc_reset(ddata);
-	if (error)
-		dev_err(ddata->dev, "Reset failed with %d\n", error);
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)) {
+		error = sysc_reset(ddata);
+		if (error)
+			dev_err(ddata->dev, "Reset failed with %d\n", error);
 
-	if (error && !ddata->legacy_mode)
-		sysc_disable_module(ddata->dev);
+		if (error && !ddata->legacy_mode)
+			sysc_disable_module(ddata->dev);
+	}
 
 err_main_clocks:
 	if (error)
-- 
2.44.0

