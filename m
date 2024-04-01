Return-Path: <linux-kernel+bounces-126498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D121A8938AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BC71F21612
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BECABA49;
	Mon,  1 Apr 2024 07:39:59 +0000 (UTC)
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32C53BE;
	Mon,  1 Apr 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957199; cv=none; b=H7dci3k413XzyNzcA287svGFUiRLQeHN40TtrFuN30wjtnDO4VH5lAssY775Y9hLH1/ztU4gi/V1sCG42bLIBNWo7VBuDKIi3SqXY/lX4ne7OOKuorN9F4232DULD55nvtxVBvYr8a1Fdr2X4HsLcK/t/Cx2HTU3Mfv2zjCSKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957199; c=relaxed/simple;
	bh=JHGXCuwlRiOKHMe9gGAfPe04XpwLtVfK25Y8jzuc83E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbgyniXCWiijQMUWkkU3lqYUYsaTraRg0oEpxNeohvf7YbHsemh4YYvtFiEkwsd8zU37PXoT1e1KMoK3JnBNOQymzSojL0S+ts/X6NUIcCHGfJXtuot67DwJlJisF8mXMgClonZznfzy3Hn26LLx6ptzDgcvIORhBOxnCIG7+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 8961D710E6434F5E801F4A57B177CD02; Mon, 1 Apr 2024 14:39:45 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: Hannes Reinecke <hare@suse.com>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,"James E.J. Bottomley" <jejb@linux.ibm.com>,"Martin K. Petersen" <martin.petersen@oracle.com>,<linux-scsi@vger.kernel.org>,<linux-kernel@vger.kernel.org>,<lvc-project@linuxtesting.org>
Subject: [PATCH v2 2/2] scsi: aic79xx: add scb NULL check in ahd_handle_msg_reject()
Date: Mon, 1 Apr 2024 14:39:32 +0700
Message-ID: <20240401073932.600928-1-aaprelkov@usergate.com>
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
X-Message-Id: 6533A2999C3242938ABFFC4980BF55C9
X-MailFileId: A046C15860A64E06840E91E8E8BF5BA1

If ahd_lookup_scb() returns NULL and ahd_sent_msg() checks are false,
then NULL pointer dereference happens

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
v2: Removed "!= 0" check as Damien Le Moal <dlemoal@kernel.org>
suggested

 drivers/scsi/aic7xxx/aic79xx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 9e0fafa12e87..6bee62224d86 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -5577,7 +5577,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		       "Using asynchronous transfers\n",
 		       ahd_name(ahd), devinfo->channel,
 		       devinfo->target, devinfo->lun);
-	} else if (scb && (scb->hscb->control & SIMPLE_QUEUE_TAG) != 0) {
+	} else if (scb && (scb->hscb->control & SIMPLE_QUEUE_TAG)) {
 		int tag_type;
 		int mask;
 
-- 
2.34.1


