Return-Path: <linux-kernel+bounces-81380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE5867557
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEC2B2854C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2177F48C;
	Mon, 26 Feb 2024 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="O7s4FlkV"
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D587EEE6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.198.35.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950901; cv=none; b=hIptGGZdkCvnkL6+o6MYuK0ru1wR7tyGhl071dVdptOtSIomt8sHa2VH+FTBwfXkhN9tiG5hyUFAKjKBmMW8IGo4yS8AKaNdRmKo2MsSHtH5MEhFB+ES9RTUNBwG/dbCLXnLgXl3jLC19fDSRTeT8FQve3ugA0SY0yrPHs60vKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950901; c=relaxed/simple;
	bh=81pTHnCU6Nto2fHtyUQ5FVyLC5AbHwV19wF5abl1n5Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B0399cNsxCoeL+/FaOjnnE1JjOlw7c4DtFnDzrfY6aNog0ZxPRlHHuSqsuACJZsqQvFvAs+lAbw9/m16gMNiFjdRvonpvjtvCGjcBdAxHtoLEk5DkX+uuwJvEgx08egVIYwxSaScph70wepz+EfVgZAj0O1NekRgB2g90PkbG3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=O7s4FlkV; arc=none smtp.client-ip=92.198.35.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
	t=1708950344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
	bh=lI4ikcSlVF3UUdLk19htP1QoiLwNpscT9ljbxdrNkVo=;
	b=O7s4FlkVwvaM6fZGJCet6vxeso9C4vvLVz47WSNwAKRXBRLmVbRQOxfG4lzjPKxZ/lQmos
	tvB1Xs0VlKGGXtAsc8/MR86rmoyIXGGHzVt5GPSeMNFKlhHNfdN2tNYWl0ANYtF+BEC0Xb
	qWIan+y4738eD+0uyq69XDejl3RADeCiTXV0S5+Q/vEzOYUqqyjErNizUxLym9FECb8tP/
	1F/0zSh37rk/HFD4MHfTUUf0tmBxOpLiFgWe/A21YBpPJmo24mRXjOx7cmr/94l3qXry4L
	eAc4NJr0SMyJ/y0ur2ep4Dua5aPDE4LY59WoTgB2yu2JhXARmxk0/qjCJzAIzg==
To: linux-kernel@vger.kernel.org
Cc: Boris Brezillon <bbrezillon@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Mon, 26 Feb 2024 13:25:37 +0100
Message-Id: <20240226122537.75097-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Looks like a copy'n'paste mistake introduced when initially adding the
dynamic timings feature with commit f9ce2eddf176 ("mtd: nand: atmel: Add
->setup_data_interface() hooks").  The context around this and
especially the code itself suggests 'read' is meant instead of write.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 4cb478bbee4a..dc75d50d52e8 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1370,23 +1370,23 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 	 *
 	 * NRD_PULSE = tRP
 	 */
 	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
 	totalcycles += ncycles;
 	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
 					  ncycles);
 	if (ret)
 		return ret;
 
 	/*
-	 * The write cycle timing is directly matching tWC, but is also
+	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
 	 * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
 	 *
 	 * NRD_SETUP is always 0.
 	 */
 	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
 	ncycles = max(totalcycles, ncycles);
 	ret = atmel_smc_cs_conf_set_cycle(smcconf, ATMEL_SMC_NRD_SHIFT,
 					  ncycles);

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.39.2


