Return-Path: <linux-kernel+bounces-112693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722B887D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D2DB20CAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1791BF5D;
	Sun, 24 Mar 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jjbVscq5"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA319474;
	Sun, 24 Mar 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288546; cv=none; b=ldI+7ZJA7/mkUVyMgTHzf7ufwVo8Ng/y2srLVT02Dhe/A39fDjeID3kHHQrTeOu8SiLd4JCO8/HEaMp2YAR+YAT2i0gU4izvRT+TIRcEIEGtIjyWfMuO+cJpriLAm4YV8pdv7chtVPtdR+rzUW/Vqzemy4vbuYOGR0lCthm3pR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288546; c=relaxed/simple;
	bh=aRHoZEL+nQ6d3aZ+RPDCEIDQm2FkdCVphELY1nxnGmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGigJ1CN08LtdxN6iiZM9Hry/5HlfsVvoz5WkVwEGpl1Dcm5ZeLXu8cgGbryC6A96BMvcRG9mfmspYe4NGmEeSOUORARJ7XHR2lbkNLtkW9ZVy4PacHEdx/mX6J7bY2qL+nZWO/5+6b6i1vm9DispspCmUJatS/m8HqI2g7e4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jjbVscq5; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711288540; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4CEAglaau2AvyaClWghCn2tsgC+HPTDqPG1IUCrZCKY=;
	b=jjbVscq5xuzMNzkS05TIZZA5Dqrx2KxXF2h9niR2pnfyhIDwoQ4P1KJ4TynsjP/jJzK0EVSRFWp66mwxzYeoE5jxgrBmeeS9bD4c2WV5cQl/aNMdmXRExvxJwoBcwnCyIWDLTLplpWApBkSYF9lkX6S6WqtMKBWTHAnwSaq4J7I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W373crU_1711288538;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W373crU_1711288538)
          by smtp.aliyun-inc.com;
          Sun, 24 Mar 2024 21:55:40 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH net-next v5 06/11] net/smc: ignore loopback-ism when dumping SMC-D devices
Date: Sun, 24 Mar 2024 21:55:17 +0800
Message-Id: <20240324135522.108564-7-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240324135522.108564-1-guwen@linux.alibaba.com>
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since loopback-ism is not a PCI device, the PCI information fed back by
smc_nl_handle_smcd_dev() does not apply to loopback-ism. So currently
ignore loopback-ism when dumping SMC-D devices. The netlink function of
loopback-ism will be refactored when SMC netlink interface is updated.

Link: https://lore.kernel.org/r/caab067b-f5c3-490f-9259-262624c236b4@linux.ibm.com/
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c | 2 ++
 net/smc/smc_ism.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 051726586730..97f6ae4f9b23 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -318,6 +318,8 @@ static void smc_nl_prep_smcd_dev(struct smcd_dev_list *dev_list,
 	list_for_each_entry(smcd, &dev_list->list, list) {
 		if (num < snum)
 			goto next;
+		if (smc_ism_is_loopback(smcd))
+			goto next;
 		if (smc_nl_handle_smcd_dev(smcd, skb, cb))
 			goto errout;
 next:
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 165cd013404b..322973527c61 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -84,4 +84,9 @@ static inline bool smc_ism_is_emulated(struct smcd_dev *smcd)
 	return __smc_ism_is_emulated(chid);
 }
 
+static inline bool smc_ism_is_loopback(struct smcd_dev *smcd)
+{
+	return (smcd->ops->get_chid(smcd) == 0xFFFF);
+}
+
 #endif
-- 
2.32.0.3.g01195cf9f


