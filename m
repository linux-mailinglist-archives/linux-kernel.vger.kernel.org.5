Return-Path: <linux-kernel+bounces-112692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84260887D08
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A05DB211CB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2531B81E;
	Sun, 24 Mar 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ICbZUbo2"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F21AAB9;
	Sun, 24 Mar 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288546; cv=none; b=a1AJqgSrRaVufLbPLC4eezzg3nJzl8u++IxqNK2fp4Q5ozK1vJS/iPc0CDQIEQBIvwIm07QqoM3IKZrB/nh1uGF/NPr5J8MiBzh0m89oFG/IKU9Cbd/lyFbl8Yelkxv807asqDbCNthj4350EKLbjpLcm3OMadckmI5t38TBex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288546; c=relaxed/simple;
	bh=WYbhRMGR0W01lVww6SeqPkwW5gyATMicfULdP3ORxAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKEKBFRp8Idtl4HoogcPkwEDC1q/lsUYbcwviyPXZ6h+MUd7hsuwXs3c8T5S76p5/tuOZsUeoPmLz0nZSGGttu0BoySydY0VRSL2WmTENwSEwCPWYgomyAFx8EgpbGZLLDX440Qy++edFfwpSS/m7oyaRwMTB9ZE8B3ijhIeoxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ICbZUbo2; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711288536; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jpdnQZnDvs15szWBmPNF0c29jZHdspFSHq1dvNgAgXk=;
	b=ICbZUbo2EVTZ2um+Dt++8IeA6UeqNZ9RtJOOK1P4C953JzxwZZ0QrGVk7+JnCff6IFysP1X/XgdDas8jKL3PWpXwlghnf5ZntLA4WVsyE2iCgndRCEp57lBUJ3u79r016K1V377gay/3jz2VVzJAwApIQ4+1JU5VlI9lkNAPbp0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W372t9q_1711288533;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W372t9q_1711288533)
          by smtp.aliyun-inc.com;
          Sun, 24 Mar 2024 21:55:35 +0800
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
Subject: [RFC PATCH net-next v5 04/11] net/smc: implement some unsupported operations of loopback-ism
Date: Sun, 24 Mar 2024 21:55:15 +0800
Message-Id: <20240324135522.108564-5-guwen@linux.alibaba.com>
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

This implements some operations that loopback-ism does not support
currently:

- vlan operations, since there is no strong use-case for it.
- signal_event operations, since there is no event to be processed by
  the loopback-ism device.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 3eb623e030eb..4b5e864ebca3 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -49,6 +49,32 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_set_vlan_required(struct smcd_dev *smcd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_reset_vlan_required(struct smcd_dev *smcd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
+			       u32 trigger_irq, u32 event_code, u64 info)
+{
+	return 0;
+}
+
 static int smc_lo_supports_v2(void)
 {
 	return SMC_LO_V2_CAPABLE;
@@ -77,11 +103,11 @@ static const struct smcd_ops lo_ops = {
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb		= NULL,
 	.unregister_dmb		= NULL,
-	.add_vlan_id		= NULL,
-	.del_vlan_id		= NULL,
-	.set_vlan_required	= NULL,
-	.reset_vlan_required	= NULL,
-	.signal_event		= NULL,
+	.add_vlan_id = smc_lo_add_vlan_id,
+	.del_vlan_id = smc_lo_del_vlan_id,
+	.set_vlan_required = smc_lo_set_vlan_required,
+	.reset_vlan_required = smc_lo_reset_vlan_required,
+	.signal_event = smc_lo_signal_event,
 	.move_data		= NULL,
 	.supports_v2 = smc_lo_supports_v2,
 	.get_local_gid = smc_lo_get_local_gid,
-- 
2.32.0.3.g01195cf9f


