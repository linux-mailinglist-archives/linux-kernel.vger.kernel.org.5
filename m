Return-Path: <linux-kernel+bounces-105368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EFC87DCE1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0689281607
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152521360;
	Sun, 17 Mar 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aIxaZ/OP"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4571F93E;
	Sun, 17 Mar 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710669971; cv=none; b=jbYEevBtBPgBc19Zex+vybp6afdjYs5XtgpvWnlQxX2+LQctdiEU0NFNJMOxTbJLfAxbX4topgmohaccQRqoDx6YjkRL065ifUZlQKk+Q2YVyVG9+2EdxeDCrT3bTd5GbJNyYByeSgbL2APox8NbYjoeb7vrt8lpPDKPY1rA8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710669971; c=relaxed/simple;
	bh=aRHoZEL+nQ6d3aZ+RPDCEIDQm2FkdCVphELY1nxnGmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sABBnmishtxIONPy8wmEEOh5Ns8SdEDXQfH3gnZytGQqAqvSokktQE7RWEeLxB75hjpO/PRIkTeXwLCn0bxNoniungfoj+F0h1ze3dzUNvwQ0ywaQO5qNAWLIe9orc2e8+o4XNJhsQfFrf7KITPN/0Nj4GI41FvI0LbsppiLZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aIxaZ/OP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710669961; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4CEAglaau2AvyaClWghCn2tsgC+HPTDqPG1IUCrZCKY=;
	b=aIxaZ/OPVVoIS4IsnmAsmABktcEdfLEfA13lOCaWEdKoo6HEvy+i0uP9BNhQR8tTn0kDDHD3l0+d6yjwFQL/xoBZ0vH4N9nNlLFld3T3i1jbndw+chO9d7Cv3WYMJO6W6WgdseYZirs4IVC3bnI9pv8XaLFwjEsKJfy6ZyCuBho=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2c7m4u_1710669958;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2c7m4u_1710669958)
          by smtp.aliyun-inc.com;
          Sun, 17 Mar 2024 18:06:00 +0800
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
Subject: [RFC PATCH net-next v4 06/11] net/smc: ignore loopback-ism when dumping SMC-D devices
Date: Sun, 17 Mar 2024 18:05:40 +0800
Message-Id: <20240317100545.96663-7-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240317100545.96663-1-guwen@linux.alibaba.com>
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
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


