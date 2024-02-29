Return-Path: <linux-kernel+bounces-86100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163586BF92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50801F23C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A7A381D1;
	Thu, 29 Feb 2024 03:48:00 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD04381B0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178480; cv=none; b=Jqykveq5XtZhJj0TW5c07ZES3ie2jaR5SgXLWuYZiTd6YsptwiGdHx8zE+yvDguJN37cbd0ivxJ3JsV0OkPLdg/V5Oe6LoLQT142FeOxtMRKwZpEbpDte7zlT2U5arx377vGmi3O3jqH72phiarixIQH2KN77kgh6ImPszF9Kms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178480; c=relaxed/simple;
	bh=fp3Mxq2ltzt6MMHBtz4FN6pPfnR8KvUSOwgEwxPR6nU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j23maUC8dwDR5+shP19xqM1JmwrAoQs19CYy/aCljJHdbgFf+7GENfZ4qKMbDVMYlmJIsIRACvxt28+SRmao0+YupU3CkqXT/mUeF0opQS8sAClFkE37YNZLaIbMC3paIRMi6pETh0Ynn+VwE2TPAWoKBDqHjdE2ax2LVsodWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rfXOM-0006Wc-2B;
	Thu, 29 Feb 2024 03:47:30 +0000
Date: Thu, 29 Feb 2024 03:47:24 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
Message-ID: <ff29447dcee834c17e4e1e99725b9454c90136ca.1709178325.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A compiler warning related to sizeof(int) != 8 when calling do_div()
is triggered when building on 32-bit platforms.
Address this by using integer types having a well-defined size.

Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: use size_t also for 'to_read' variable to avoid truncation
    (no problem in practise beyond the compiler warning)
v2: use size_t for 'bytes_left' variable to match parameter type

 drivers/mtd/ubi/nvmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
index b7a93c495d172..8aeb9c428e510 100644
--- a/drivers/mtd/ubi/nvmem.c
+++ b/drivers/mtd/ubi/nvmem.c
@@ -23,9 +23,12 @@ struct ubi_nvmem {
 static int ubi_nvmem_reg_read(void *priv, unsigned int from,
 			      void *val, size_t bytes)
 {
-	int err = 0, lnum = from, offs, bytes_left = bytes, to_read;
+	size_t to_read, bytes_left = bytes;
 	struct ubi_nvmem *unv = priv;
 	struct ubi_volume_desc *desc;
+	uint32_t offs;
+	uint64_t lnum = from;
+	int err = 0;
 
 	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
 	if (IS_ERR(desc))
-- 
2.44.0


