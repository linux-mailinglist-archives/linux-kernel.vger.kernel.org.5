Return-Path: <linux-kernel+bounces-112691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C819E887D05
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40BAB2116A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA741B59C;
	Sun, 24 Mar 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hu2p9pWD"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5418E3A;
	Sun, 24 Mar 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288544; cv=none; b=OezNRkBRbBS6RGG4UsMEdSax+/H8IGxkGMrRXjabUCEF1NTB9wAzaumaFDxFJDZVqYqF94Ka9fSsmxT1MzNqa6VV3U2sfzBCLIiGhNh36xeYaWC7rmTSa/sUv7PjsQhoJ+xviiUWIYles7ps1xk1t8TGcZlolBDTpi1J/wdRYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288544; c=relaxed/simple;
	bh=je+eZyQU6jp+Pv4SlGJfzl9JB+vuOQZNigijjGElmm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yz6CPfPyJTIhH5N0xEh3GrSzlEivgdZCz9Sk5AIHa3GnrLT4V0oHtsyFoCHiScccNs3G6WrfuNqtN2QLVGgeEyx/5za6KheMAd4EJwqDfF3U5pjPCqE2caKlXOAJ9qkZ4sbiv1dvfoJjCwZ1PPKWhQKFjcUQTRA4zSshHhIkfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hu2p9pWD; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711288534; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Sx8Stdecs/B8G/DClK+hIesJCh7pZJGeKI91YYQmuB0=;
	b=hu2p9pWDpurOYMg99zNeZniNnOxGvyiuzJqBDyhfVd2qqEtyiAE2Eoee53nKTK8ogeuPUaL7ODVKiHvoC1rRNuJTh1ZBSoZT3A7Apbj8trg0EM+CpXwqXHIIUN5M3/z3sgB+pmFqug4sXPKuiiPzH6KcjTNKeWfom04jOJxDX3c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W372W5l_1711288531;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W372W5l_1711288531)
          by smtp.aliyun-inc.com;
          Sun, 24 Mar 2024 21:55:33 +0800
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
Subject: [RFC PATCH net-next v5 03/11] net/smc: implement ID-related operations of loopback-ism
Date: Sun, 24 Mar 2024 21:55:14 +0800
Message-Id: <20240324135522.108564-4-guwen@linux.alibaba.com>
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

This implements operations related to IDs for the loopback-ism device.
loopback-ism uses an Extended GID that is a 128-bit GID instead of the
existing ISM 64-bit GID, and uses the CHID defined with the reserved
value 0xFFFF.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 62 ++++++++++++++++++++++++++++++++++++++----
 net/smc/smc_loopback.h |  3 ++
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 3990f689ae79..3eb623e030eb 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -19,11 +19,62 @@
 #include "smc_loopback.h"
 
 #if IS_ENABLED(CONFIG_SMC_LO)
+#define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
+
 static const char smc_lo_dev_name[] = "loopback-ism";
 static struct smc_lo_dev *lo_dev;
 
+static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
+{
+	struct smcd_gid *lgid = &ldev->local_gid;
+	uuid_t uuid;
+
+	uuid_gen(&uuid);
+	memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
+	memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
+	       sizeof(lgid->gid_ext));
+
+	ldev->chid = SMC_LO_RESERVED_CHID;
+}
+
+static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
+			     u32 vid_valid, u32 vid)
+{
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* rgid should be the same as lgid */
+	if (!ldev || rgid->gid != ldev->local_gid.gid ||
+	    rgid->gid_ext != ldev->local_gid.gid_ext)
+		return -ENETUNREACH;
+	return 0;
+}
+
+static int smc_lo_supports_v2(void)
+{
+	return SMC_LO_V2_CAPABLE;
+}
+
+static void smc_lo_get_local_gid(struct smcd_dev *smcd,
+				 struct smcd_gid *smcd_gid)
+{
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	smcd_gid->gid = ldev->local_gid.gid;
+	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
+}
+
+static u16 smc_lo_get_chid(struct smcd_dev *smcd)
+{
+	return ((struct smc_lo_dev *)smcd->priv)->chid;
+}
+
+static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
+{
+	return &((struct smc_lo_dev *)smcd->priv)->dev;
+}
+
 static const struct smcd_ops lo_ops = {
-	.query_remote_gid	= NULL,
+	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb		= NULL,
 	.unregister_dmb		= NULL,
 	.add_vlan_id		= NULL,
@@ -32,10 +83,10 @@ static const struct smcd_ops lo_ops = {
 	.reset_vlan_required	= NULL,
 	.signal_event		= NULL,
 	.move_data		= NULL,
-	.supports_v2		= NULL,
-	.get_local_gid		= NULL,
-	.get_chid		= NULL,
-	.get_dev		= NULL,
+	.supports_v2 = smc_lo_supports_v2,
+	.get_local_gid = smc_lo_get_local_gid,
+	.get_chid = smc_lo_get_chid,
+	.get_dev = smc_lo_get_dev,
 };
 
 static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
@@ -95,6 +146,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 
 static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 {
+	smc_lo_generate_ids(ldev);
 	return smcd_lo_register_dev(ldev);
 }
 
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 77980650b2bd..11868e5ac732 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -20,10 +20,13 @@
 
 #if IS_ENABLED(CONFIG_SMC_LO)
 #define SMC_LO_MAX_DMBS		5000
+#define SMC_LO_RESERVED_CHID	0xFFFF
 
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
+	u16 chid;
+	struct smcd_gid local_gid;
 };
 #endif
 
-- 
2.32.0.3.g01195cf9f


