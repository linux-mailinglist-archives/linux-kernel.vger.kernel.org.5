Return-Path: <linux-kernel+bounces-100573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0484879A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A96A284855
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A8C138483;
	Tue, 12 Mar 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="oMCXll2L"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500C7E588;
	Tue, 12 Mar 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263150; cv=none; b=OOe7hPvMpGqR/lQ9dNwIRU3otbAzIeEy7pJsQnbeoOGOd4KKYC9I/HFFa76xdtGy6U9x9u2OyOmP1/RQ1pIBv173sf0SdMI9+77VsTjJc+2lPFOrSZn7PYWqtEHAGxjWdAJMTEapBg+89vjjpShcrKjYKo721kJgilk8H31RPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263150; c=relaxed/simple;
	bh=LzMfc3Bfkh1i6+N8DfOBZ/1219smYkJwNoEcdXTyU20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CM6hrwai+CrkBOxO/Yz2rjct/D8BmFN61DdCXTLLk056Ns+WT+pbnjOK9GLzYC9xtf+F/ee8F3+Vdr1tItsfgDIJw0qasqWnltDnduquQqEoR8AC+6CZDO2V7r+VyJ+WUM06G6InJWzn3a3W07tmbNvWrk1T0c9CQ9xvSMCTfWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=oMCXll2L; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ykarpov.intra.ispras.ru (unknown [10.10.2.71])
	by mail.ispras.ru (Postfix) with ESMTPSA id A9ABC40AC4FF;
	Tue, 12 Mar 2024 17:05:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A9ABC40AC4FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1710263144;
	bh=knlMtRguI/MJIyBOh76sCNenk73mrRDyUepnbXn7MG8=;
	h=From:To:Cc:Subject:Date:From;
	b=oMCXll2LI9+rl4uX+je3gSIoHKI9ST9i+DGS8WLG8iZ8gIXeIHG6elpnlS+8wS+oL
	 rTNMTsmFVcfeZNRrnK8dRdg5zsA09XqmJxM5BOI1XoTSrxymnpJiYwwYD290VbbJrh
	 9OolDIOSVhl8JHMEbY+4qYRJAGGrWT2r0B2EkICM=
From: Yuri Karpov <YKarpov@ispras.ru>
To: Don Brace <don.brace@microchip.com>
Cc: Yuri Karpov <YKarpov@ispras.ru>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Alexey V. Vissarionov" <gremlin@altlinux.org>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] scsi: hpsa: Fix allocation size for Scsi_Host private data
Date: Tue, 12 Mar 2024 20:04:47 +0300
Message-Id: <20240312170447.743709-1-YKarpov@ispras.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct Scsi_Host private data contains pointer to struct ctlr_info.

Restore allocation of only 8 bytes to store pointer in struct Scsi_Host
 private data area.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bbbd25499100 ("scsi: hpsa: Fix allocation size for scsi_host_alloc()")
Signed-off-by: Yuri Karpov <YKarpov@ispras.ru>
---
 drivers/scsi/hpsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..4ad32de61bb8 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5850,7 +5850,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
 
-	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info));
+	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info *));
 	if (sh == NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
-- 
2.34.1


