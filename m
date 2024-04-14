Return-Path: <linux-kernel+bounces-143963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298758A401E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899EBB215FB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75128E11;
	Sun, 14 Apr 2024 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hl5O50iK"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01C17BDC;
	Sun, 14 Apr 2024 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067412; cv=none; b=R+6gTkx/PjXnsmZl+RTkZFbzom1PloGEd4l7Mpfm5iV+NPLHA1nZjdI3ugy3Z7tLRUPgWTew2K2EMDj6OZfHVK5OsPPur/lg3tJBZi0gC8uQd0EY7l0RU5Hqfg6WQwDCI7VkJF44J6eEHukoHMpuXMFbAsDGKfjFdTkZ22OY/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067412; c=relaxed/simple;
	bh=uFbJhhhMYWiSbcv9blCYFXI6D0n3flGlOhUlq3LlIqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1cg7CibxyT2bLEldw+hk7JYcgAP6KvvTFVX+sP6wwA+1vChvVc4RrrlX4vflIxDVgV+fHego95vtd8/g1YnlmUr3tyNuGTWQBn+bNF8xjbN4etKb9PlXa3f55XM7oisCn0aesbXgg6+wh+wWB650a3JmQ2zvYo1FkhROe7ObyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hl5O50iK; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713067402; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sKFvkjT+Rzys7wvDjVUr5wFumHm9dd041DQHXEb1uTA=;
	b=hl5O50iKsVBjqow6RhuFzu5LpunSKz70rZB8zDf+jX3Nvy6mqBq3bUMJ670nWoaKXCHMh7lATiLkJeyK11CNv+tIiyAXQHCakyLADE4s+Uj+zIrBgfkEwgo4yaOMR4qkEpoKR4dYhsCcZM8ca6f+WVCSXpdYbYLb+FeVEUxQerU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4RqRHR_1713067398;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4RqRHR_1713067398)
          by smtp.aliyun-inc.com;
          Sun, 14 Apr 2024 12:03:20 +0800
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
Subject: [PATCH net-next v6 06/11] net/smc: ignore loopback-ism when dumping SMC-D devices
Date: Sun, 14 Apr 2024 12:02:59 +0800
Message-Id: <20240414040304.54255-7-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
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
index 36459a3c739d..188fd28423c2 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -322,6 +322,8 @@ static void smc_nl_prep_smcd_dev(struct smcd_dev_list *dev_list,
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


