Return-Path: <linux-kernel+bounces-161271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF35D8B49F2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374BC281E3D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0BDDC4;
	Sun, 28 Apr 2024 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MXXy4Yu+"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A879CF;
	Sun, 28 Apr 2024 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284474; cv=none; b=W9cGWakRjK1LQj/bUDofXXg6JR9WF2YMODnQ1vkXhCY+kQArQJ0wgOkRTwSB07+Oj6KDqVRlWtjqyEe0hQzutOv8sw8skgv2vn5EP2Rv3Ua1V35KbIaSp8XPAvkUKjYSoO6tT3Iix+NMVEVGAiGPYp/ccLuuxMrfv8LGLTu6MTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284474; c=relaxed/simple;
	bh=zpHv4Q9tmQ+cK/kmvv6C4oKRKixmqOax/wm/axjVzqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KItkjzdv4HGrJVnefIuszyOwSIvKjGGK5xRIxa1yT4x1TY36wuFE7Hi9biPwbU+gJMXBXdZzCHF6hPIsAHfyBRfWSoxJC3GNKy9eMo5SqjfvkY0RzEmY6+IXJ/awlpU7ui17Zbqvy4HhL9KQa+l4LUBuUZMcdP27c0pu0xFNbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MXXy4Yu+; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714284464; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+qt4r1my8i4Gd7Xm6GOJDaOTtJRLbPfBrI+xCsEPl2A=;
	b=MXXy4Yu+jRoP8Y5dwiaIxUUfdWItUlzajhoHKmdb84yO37sAkI5hQeD2b0tME/p32AGbWdRn39BAnmgsK4AT7/5fdjEcAM+TLFTEpxQJVBhwK3a8+rlfYETxmnqvffze3yuCjPuBUlGKPhwe9lcGhXqfhowy9J7zLJGwFfq6a1Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5NLVIw_1714284461;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5NLVIw_1714284461)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 14:07:43 +0800
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
Subject: [PATCH net-next v7 01/11] net/smc: decouple ism_client from SMC-D DMB registration
Date: Sun, 28 Apr 2024 14:07:28 +0800
Message-Id: <20240428060738.60843-2-guwen@linux.alibaba.com>
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

The struct 'ism_client' is specialized for s390 platform firmware ISM.
So replace it with 'void' to make SMCD DMB registration helper generic
for both Emulated-ISM and existing ISM.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 2 +-
 include/net/smc.h          | 4 ++--
 net/smc/smc_ism.c          | 7 ++-----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 43778b088ffa..e36e3ea165d3 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -745,7 +745,7 @@ static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 }
 
 static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
-			     struct ism_client *client)
+			     void *client)
 {
 	return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, client);
 }
diff --git a/include/net/smc.h b/include/net/smc.h
index 10684d0a33df..542d12372c18 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -47,7 +47,6 @@ struct smcd_dmb {
 #define ISM_ERROR	0xFFFF
 
 struct smcd_dev;
-struct ism_client;
 
 struct smcd_gid {
 	u64	gid;
@@ -58,7 +57,7 @@ struct smcd_ops {
 	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
 				u32 vid_valid, u32 vid);
 	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
-			    struct ism_client *client);
+			    void *client);
 	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
 	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
 	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
@@ -78,6 +77,7 @@ struct smcd_ops {
 struct smcd_dev {
 	const struct smcd_ops *ops;
 	void *priv;
+	void *client;
 	struct list_head list;
 	spinlock_t lock;
 	struct smc_connection **conn;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index ac88de2a06a0..051726586730 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -222,7 +222,6 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 			 struct smc_buf_desc *dmb_desc)
 {
-#if IS_ENABLED(CONFIG_ISM)
 	struct smcd_dmb dmb;
 	int rc;
 
@@ -231,7 +230,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	dmb.sba_idx = dmb_desc->sba_idx;
 	dmb.vlan_id = lgr->vlan_id;
 	dmb.rgid = lgr->peer_gid.gid;
-	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, &smc_ism_client);
+	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, lgr->smcd->client);
 	if (!rc) {
 		dmb_desc->sba_idx = dmb.sba_idx;
 		dmb_desc->token = dmb.dmb_tok;
@@ -240,9 +239,6 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 		dmb_desc->len = dmb.dmb_len;
 	}
 	return rc;
-#else
-	return 0;
-#endif
 }
 
 static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
@@ -446,6 +442,7 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (!smcd)
 		return;
 	smcd->priv = ism;
+	smcd->client = &smc_ism_client;
 	ism_set_priv(ism, &smc_ism_client, smcd);
 	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
-- 
2.32.0.3.g01195cf9f


