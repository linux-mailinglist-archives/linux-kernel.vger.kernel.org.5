Return-Path: <linux-kernel+bounces-161274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC78B49FB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC81281E06
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71DAD4E;
	Sun, 28 Apr 2024 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NfEeyswJ"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE852A1CF;
	Sun, 28 Apr 2024 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284481; cv=none; b=TfM3U4OaS5hfry7OZnoIezur27JW4LTId8bgtghvCvbCR6qAq0zNAcPQJ/BBYnYK1nCzXjoS8KKWe2Bls8LrX+UnWX4eNvf2nZxiuDzrh8c0ajLT2eEAM7LQtyWNapUxaQXEs/oPJUxDhW4jQ5XtsffaaBfHqpAadtc4W3OBsr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284481; c=relaxed/simple;
	bh=1JQxQkQu+eycNvPHIcvaTtnK6KJeeCWc01FzIlP3PHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqwoGOT/TRdjr5nC0Q0l5P+/N9sm61D5fygOxHpI9MzgN4a2c6m8+KGNbgsgxwpRiL0gupnd2+suMhfzHfJL8fahooZi7bM87HeBoF/VkZUrQnU1JKjNgQUmOt44bPaCYwNDB1NkXu6Yfk04DefjGT5BGtJuTJDF6ab4XHXTGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NfEeyswJ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714284477; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=amtQ9xRDlPUZxKPiAQamAg0aoynwXc4CEw6KroOqPls=;
	b=NfEeyswJ7LLrYIW2icJs5PZQj3GB59MoTbMkb2XvSxxAMLfhuowfKZS884tpBVvLryUcbMKgzZio3azF6TECAD8M+0YTHlJh1JVaCfwxkX01HZXiUDjxxniZlvJ9P8a6M2e17cp8Mfg6QxU5OrnHBae189WtWmp4n2keobWAdEs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5NS3Cl_1714284474;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5NS3Cl_1714284474)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 14:07:56 +0800
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
Subject: [PATCH net-next v7 06/11] net/smc: ignore loopback-ism when dumping SMC-D devices
Date: Sun, 28 Apr 2024 14:07:33 +0800
Message-Id: <20240428060738.60843-7-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240428060738.60843-1-guwen@linux.alibaba.com>
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
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
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>
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


