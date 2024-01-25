Return-Path: <linux-kernel+bounces-38590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB783C2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931F11F2193A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50B4F60C;
	Thu, 25 Jan 2024 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EY5cKp1/"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74145BF4;
	Thu, 25 Jan 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186441; cv=none; b=PiDCjurGl88dJyv904MusFzZiM95gECmfjWrXoSZkxYNU1WX9Pw9rcDxF9dBaWohpvhyhWf5EJP7aHNfD/DYYK/S37MgL+61lrrg5mz9VMWyYpHszJak7n9BWOyJzIRm4nFGjYIXLp6Wjmui+2fo6N03nKLxu+fgJjWwfvqVCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186441; c=relaxed/simple;
	bh=EdkMDFFWUiyjvHdtXKbhibX6ICrroCB3+YkEYJGcC3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TpSOsyiFS9AGiLrMFd2RNvAZ/awmrVgnQafpkWD6todr9AYRq23+FZ/7WQktcwHlrzbUhsWD1qKWPM/LokuplYqP+jO+V6zxz9TqauLGTM6cHcx6m6uYJFi6eWGtosN7IcTkaX3RMHu/yfsTzzsknLfeYWDnvdrtXlku8AhEMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EY5cKp1/; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706186434; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Fst97h1pLSmFiX0qcjI14XwdvbW5bSFhMUKZrfvSZcQ=;
	b=EY5cKp1/o5QGE/e2eePOnD5fPpDRFwjX2NrlTz+MmwzYn6Pkt6sfCCeKd6qkLw2unFfdYGhrrwls08aC3Y/60AkICpwbiM8C7+xFZit71TYHv7CIsRwtapnJV4q2/uQ9ChPv259JpUt2dcAY52mlTdDlphkHrE0BH3343XgJfE8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W.KUl5s_1706186356;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W.KUl5s_1706186356)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 20:40:34 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	mjrosato@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: fix incorrect SMC-D link group matching logic
Date: Thu, 25 Jan 2024 20:39:16 +0800
Message-Id: <20240125123916.77928-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic to determine if SMC-D link group matches is incorrect. The
correct logic should be that it only returns true when the GID is the
same, and the SMC-D device is the same and the extended GID is the same
(in the case of virtual ISM).

It can be fixed by adding brackets around the conditional (or ternary)
operator expression. But for better readability and maintainability, it
has been changed to an if-else statement.

Reported-by: Matthew Rosato <mjrosato@linux.ibm.com>
Closes: https://lore.kernel.org/r/13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com
Fixes: b40584d14570 ("net/smc: compatible with 128-bits extended GID of virtual ISM device")
Link: https://lore.kernel.org/r/13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 95cc95458e2d..e4c858411207 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1877,9 +1877,15 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 			   struct smcd_dev *smcismdev,
 			   struct smcd_gid *peer_gid)
 {
-	return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
-		smc_ism_is_virtual(smcismdev) ?
-		(lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
+	if (lgr->peer_gid.gid != peer_gid->gid ||
+	    lgr->smcd != smcismdev)
+		return false;
+
+	if (smc_ism_is_virtual(smcismdev) &&
+	    lgr->peer_gid.gid_ext != peer_gid->gid_ext)
+		return false;
+
+	return true;
 }
 
 /* create a new SMC connection (and a new link group if necessary) */
-- 
2.32.0.3.g01195cf9f


