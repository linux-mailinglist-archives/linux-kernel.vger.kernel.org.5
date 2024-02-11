Return-Path: <linux-kernel+bounces-60824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A848509ED
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B82283CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E422F5C602;
	Sun, 11 Feb 2024 15:09:26 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F65B5C5;
	Sun, 11 Feb 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664166; cv=none; b=hG7LJaWRz8B62k9Khzz9Ey87wTp5vlxFlQBVdbSU2Obz3gcsEd06UAtc53YzVj8ikAQhns3kOam0/Duy7XkSyt84XsKi1PJLgx74OtQh6oPUUnJYN7VNevCpZZqPW//RwgkloyyK7GYQw6+nJ1/NEAeNP+FVyOut4OBoFD5qRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664166; c=relaxed/simple;
	bh=2tH5ZuF4m4p1iA/cJL23+8Jw4MvfE7ip9QiRvY/GbEc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BT4+99MXVesb68+RQaMf3rJ/OaDCHtwvI7/WUE8nJyK6wZ8+8UByFWTBcWDG01TdB0OTIjzpNUzAcYP2gg4GPOAR2VmunlyoUx0fsTxL3y6lNdPPO6ZLJ1N15CjlXow1wT7bNYfOV/AIhxHoaHIpIQMtDv1JYX0fx/Z3Z8+t/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Hannes Reinecke <hare@suse.de>
CC: Daniil Dulov <d.dulov@aladdin.ru>, "James E.J. Bottomley"
	<jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Robert Love <robert.w.love@intel.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] scsi: libfc: Remove unnecessary NULL check.
Date: Sun, 11 Feb 2024 07:09:16 -0800
Message-ID: <20240211150916.4004-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

sp is a result of shifting after dereference, so it is never NULL.
Thus, remove unnecessary NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 42e9a92fe6a9 ("[SCSI] libfc: A modular Fibre Channel library")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/scsi/libfc/fc_exch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index 4261380af97b..094d9decbcd4 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -650,8 +650,6 @@ static int fc_exch_abort_locked(struct fc_exch *ep,
 	 * Send the abort on a new sequence if possible.
 	 */
 	sp = fc_seq_start_next_locked(&ep->seq);
-	if (!sp)
-		return -ENOMEM;
 
 	if (timer_msec)
 		fc_exch_timer_set_locked(ep, timer_msec);
-- 
2.25.1


