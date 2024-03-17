Return-Path: <linux-kernel+bounces-105363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D24C87DCD2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528591F21389
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE61B285;
	Sun, 17 Mar 2024 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A3JJDVuT"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70D1429E;
	Sun, 17 Mar 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710669962; cv=none; b=FFNLcdW5CCNNmDxmxkDaRyDl15mcEbnYxemz07AL3k2DaYJlDcWJcGH/if/8d5DRjc5CaCyrLtjDxoHViGOVzkrVJN1R/ZEDTnSa86iZuZ8EzOY58oupCouEiEnG6rsm3OypIlNJNWi/8g508S6K4XAtRH2G9qnpR3saC/HnmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710669962; c=relaxed/simple;
	bh=Ee+xcNTcptaiM2jTB8g+F9qmbZgu8jnu92Rr6tA1wvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ph3nRLEQ68+vO/v2LqcwOSF6QVZw+lLiRE9SiXXlLByJWJVQpxbkx2c4+6m9zV/eBCsEHRTW5HYPVrWqOfAL2ipuz3VopLetGd0jN6hEEDEpMLKIQS0A61VB4HPmFTcF0qi2RqQXxu8BJwTGtTtK7clltBAPAM08vQplh78sgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A3JJDVuT; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710669957; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ubqaBkEChBN8FJYb5WwRk2pB7ZGQw8hXZ6l87c/Z7dk=;
	b=A3JJDVuTvGFJ9nUxlaxvx2vwPTmeVpByovl5qcj9il6T/4jl7uy53SfyJ/ZN+IC1Liv5sUuZmW7O4o9CkYIMBmblEymRY5n5LK1Uw2sTrd8dntzR6LxgxxmFPXg3YQslR9pnFVWR4T/MYJ8TecyMLbSfomXGAdhrzdihRZU1FF4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2cE0vS_1710669954;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2cE0vS_1710669954)
          by smtp.aliyun-inc.com;
          Sun, 17 Mar 2024 18:05:56 +0800
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
Subject: [RFC PATCH net-next v4 04/11] net/smc: implement some unsupported operations of loopback-ism
Date: Sun, 17 Mar 2024 18:05:38 +0800
Message-Id: <20240317100545.96663-5-guwen@linux.alibaba.com>
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

vlan operations are not supported currently since the need for vlan in
loopback-ism situation does not seem to be strong.

signal_event operation is not supported since no event now needs to be
processed by loopback-ism device.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 7656a2474500..253128c77208 100644
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


