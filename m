Return-Path: <linux-kernel+bounces-120512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09B88D891
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428511F2B093
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57802D05B;
	Wed, 27 Mar 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="fBzIyneo"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B678339A8;
	Wed, 27 Mar 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527344; cv=none; b=cpwLvbx+CMwK3KcxUAkJz4JSNzaFvfcr3cGvBjDjTle6dmoTEq/x+wND8zNvQNQFqWrzEZvynGKEUH7ATgAL048MnPbgYGvTLPcmSdUn0dvGS2ii0EvuubyWjlumgc2YfabB8W4bPvjVs9kOHf7q3db2i2D8vfbyZ1W3/rrpi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527344; c=relaxed/simple;
	bh=wCs2Bbu3C6J2O1X3vXpkxYOKLXy+CaCvFD4nkCkciKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAUO8MNXKvusMaYnni7STOpKBU8YUSqpTeqdWUotC4CU9A+/LMrPMoqc4HxJd7ZtVIioT6uMimVmdam10IGFoiaQG+THhbnXfTvVeYD52JYPIIz1FlyZnnDxhoiYDUYIkSr9zeuwQHOYKlf9uUGvQ4YMMJ/oPT4tp/Bmfq2BwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=fBzIyneo; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id F409B604C8;
	Wed, 27 Mar 2024 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711527340;
	bh=wCs2Bbu3C6J2O1X3vXpkxYOKLXy+CaCvFD4nkCkciKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBzIyneoLfw5GjwkPSQRdG8ZsYygVNsJ6DkfWnX2j0QSW2pasesYCJ3cC8yWQa8TV
	 O6vliLxiZnHT5pJB9TUqeRUDm0N34gs3KG8LdDtjA/L3aDBpKDL+FwDtkWW5spIu3x
	 XFHyyx7bYgymaY3LnKAj1R7jd/20ptpzEtf6tx2ObvDHJW8TYGSSW+Ipmz15ElGJhB
	 RhFMNYWZEACHe7R4bwopXvepxUUmUU2IJva0IofVYBbixQ5PgbuTzdfkutkkEScCuh
	 2F8yeWYaiN+fi39o2kLOsHC4Tv/7pWScoEyCydNBmel18DQmJI99RsEAA7d+hh2K22
	 eHlrQGj2OslrQ==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] bus: ti-sysc: Move check for no-reset-on-init
Date: Wed, 27 Mar 2024 10:15:04 +0200
Message-ID: <20240327081508.36747-2-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327081508.36747-1-tony@atomide.com>
References: <20240327081508.36747-1-tony@atomide.com>
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

