Return-Path: <linux-kernel+bounces-126474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF4893871
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A459B1C20CFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713668F7A;
	Mon,  1 Apr 2024 06:34:51 +0000 (UTC)
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE610F1;
	Mon,  1 Apr 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711953291; cv=none; b=IEIs1RZOFawKwYeKIeUxa1GXNxW397Zfmmqm5P9jhcN3Bz9+JAe8dqdYoBkbte4KKu8DJwEiIk+5vZYhNjaZUUv4k0yDxTHKs4m7oC1EXtzfGCb5wsBvzBlHRIzNQjhXnuLbI6SP27NOgtkebq0ltXXDdG63Nawm9l65vl/0lkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711953291; c=relaxed/simple;
	bh=g3kKNBeSxCXtJC/2ghym1i87QEqVcPCGl4pvQJeMAWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdLS5p9FeEdBzQh5yszRBmWoniX2HMNpiB1vbwreiDSV2KWF3qcjnkcLrIm8PoumyHyJxyFS92iJxGnkWXFKfMUmLiVt4HSDBxPFMC/YE329FFeCjJaR58Fds83qz6EcdGPxrfC7TuSqhN/YBSSfo68cE9IvVcYxtF5QGEuaHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 AEBED27C39F1428DAFA9DA846F2A5809; Mon, 1 Apr 2024 13:34:38 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: Hannes Reinecke <hare@suse.com>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,"James E.J. Bottomley" <jejb@linux.ibm.com>,"Martin K. Petersen" <martin.petersen@oracle.com>,<linux-scsi@vger.kernel.org>,<linux-kernel@vger.kernel.org>,<lvc-project@linuxtesting.org>
Subject: [PATCH] scsi: aic79xx: add scb NULL check in ahd_handle_ign_wide_residue()
Date: Mon, 1 Apr 2024 13:34:17 +0700
Message-ID: <20240401063418.596364-1-aaprelkov@usergate.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ESLSRV-EXCH-01.esafeline.com (192.168.90.36) To
 nsk02-mbx01.esafeline.com (10.10.1.35)
X-Message-Id: BF037BEAB1D44598BF2C2B973BE6A734
X-MailFileId: F9AC490D2C974D1BA7DF8BBA20C15E28

If ahd_lookup_scb() returns NULL and (ahd_inb() & DPHASE) != 0
NULL pointer dereference happens inside ahd_get_transfer_dir()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 3e3100dbfda3..bac23ee11c62 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -5664,7 +5664,7 @@ ahd_handle_ign_wide_residue(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 	 * Perhaps add datadir to some spare bits in the hscb?
 	 */
 	if ((ahd_inb(ahd, SEQ_FLAGS) & DPHASE) == 0
-	 || ahd_get_transfer_dir(scb) != CAM_DIR_IN) {
+	 || (scb && ahd_get_transfer_dir(scb) != CAM_DIR_IN)) {
 		/*
 		 * Ignore the message if we haven't
 		 * seen an appropriate data phase yet.
-- 
2.34.1


