Return-Path: <linux-kernel+bounces-66951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC86856404
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1526EB2A707
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590012F5A0;
	Thu, 15 Feb 2024 13:03:56 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3558ABC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002235; cv=none; b=MfKiwouiK0uo11arfUk6FSsRmL6U0MUR/+EHtUIc3OpT7+K9qRZIcoNnk6uomCvuCbEjnpEiXUGIiWvpH/snDFDPtGPYUF5xhbTmdJRBzjsC64SDg4ZF3/OJFVga7+08gKi2AjUGXAbX15gOGiO2jsT4rwH3GADWSxiMeVzSIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002235; c=relaxed/simple;
	bh=g063c6mfbeUy0PcgSIIdWAMOgQxBDicgTnmvxo0W8cA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZyz4y0bL9jYYxPKmkH7L1lj9nbDOaIlvz8WI1mmVHGoXlE7mzfmaQ8MHvxyCYHFv7muTBaIzkPvtzRO45v/wCyTZeRA3P47UHnE8iCcgtnSDlIytP+xlRbwNEN8EEYOLKg3Or5R90PNH2NZzauCeAdGJgcDt9oCc7NzzP5qSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by xavier.telenet-ops.be with bizsmtp
	id nR3r2B00H0LVNSS01R3r79; Thu, 15 Feb 2024 14:03:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabOy-000gx8-EY;
	Thu, 15 Feb 2024 14:03:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabP5-00HYHC-Ns;
	Thu, 15 Feb 2024 14:03:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] intel_th: Use bitfield helpers
Date: Thu, 15 Feb 2024 14:03:50 +0100
Message-Id: <b72856c9d2d3f9938ce7f3124a466754534981d9.1708002102.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the FIELD_{GET,PREP}() helpers, instead of open-coding the same
operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/hwtracing/intel_th/msu.c |  8 ++++----
 drivers/hwtracing/intel_th/pti.c | 13 +++++++------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 9621efe0e95c4df8..b6e76c5f8d2f38ea 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -787,8 +788,8 @@ static int msc_configure(struct msc *msc)
 	reg &= ~(MSC_MODE | MSC_WRAPEN | MSC_EN | MSC_RD_HDR_OVRD);
 
 	reg |= MSC_EN;
-	reg |= msc->mode << __ffs(MSC_MODE);
-	reg |= msc->burst_len << __ffs(MSC_LEN);
+	reg |= FIELD_PREP(MSC_MODE, msc->mode);
+	reg |= FIELD_PREP(MSC_LEN, msc->burst_len);
 
 	if (msc->wrap)
 		reg |= MSC_WRAPEN;
@@ -1699,8 +1700,7 @@ static int intel_th_msc_init(struct msc *msc)
 	INIT_LIST_HEAD(&msc->iter_list);
 
 	msc->burst_len =
-		(ioread32(msc->reg_base + REG_MSU_MSC0CTL) & MSC_LEN) >>
-		__ffs(MSC_LEN);
+		FIELD_GET(MSC_LEN, ioread32(msc->reg_base + REG_MSU_MSC0CTL));
 
 	return 0;
 }
diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index 09132ab8bc23265a..eadc236ec43e0ad3 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -152,12 +153,12 @@ static int intel_th_pti_activate(struct intel_th_device *thdev)
 	u32 ctl = PTI_EN;
 
 	if (pti->patgen)
-		ctl |= pti->patgen << __ffs(PTI_PATGENMODE);
+		ctl |= FIELD_PREP(PTI_PATGENMODE, pti->patgen);
 	if (pti->freeclk)
 		ctl |= PTI_FCEN;
-	ctl |= pti->mode << __ffs(PTI_MODE);
-	ctl |= pti->clkdiv << __ffs(PTI_CLKDIV);
-	ctl |= pti->lpp_dest << __ffs(LPP_DEST);
+	ctl |= FIELD_PREP(PTI_MODE, pti->mode);
+	ctl |= FIELD_PREP(PTI_CLKDIV, pti->clkdiv);
+	ctl |= FIELD_PREP(LPP_DEST, pti->lpp_dest);
 
 	iowrite32(ctl, pti->base + REG_PTI_CTL);
 
@@ -179,8 +180,8 @@ static void read_hw_config(struct pti_device *pti)
 {
 	u32 ctl = ioread32(pti->base + REG_PTI_CTL);
 
-	pti->mode	= (ctl & PTI_MODE) >> __ffs(PTI_MODE);
-	pti->clkdiv	= (ctl & PTI_CLKDIV) >> __ffs(PTI_CLKDIV);
+	pti->mode	= FIELD_GET(PTI_MODE, ctl);
+	pti->clkdiv	= FIELD_GET(PTI_CLKDIV, ctl);
 	pti->freeclk	= !!(ctl & PTI_FCEN);
 
 	if (!pti_mode[pti->mode])
-- 
2.34.1


