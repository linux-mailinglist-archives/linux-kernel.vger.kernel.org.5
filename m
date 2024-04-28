Return-Path: <linux-kernel+bounces-161272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC98B49F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D6BB21489
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03722B9BF;
	Sun, 28 Apr 2024 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Po6KcTKS"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E118635;
	Sun, 28 Apr 2024 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284479; cv=none; b=nAlPDi+khIPDfAFBdPmISS3nCsHWQLeG/Jcr012Wo3CbMn4Gxr+VBFjvPdyZ6JmdeYZ73z2YLNV5rKDg8aN//hZAb4r5ZFjWeGkwi4F1KL1hNJvqJeYTuRN8x99qk3tzFe9tHayqnasI8CgjmL8G2PtLSasl1ghAVAgl5wK7FNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284479; c=relaxed/simple;
	bh=AJdcbcrNHGiYM0ziYvU3q1/zBUvUAtuNBYFZypCLXPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLDZg9EXSZSz5XB9hE8yUiXCyAwKGBvui5c1x0EWz7SdF64GL4A7beltgEMUSbHA3Zcw2F3+03MEnIeYPqEefMa+cXgMXcpn0+8S0HOYkKm3ifSE/j4ofaz7X2mFTpLzmXPmc/4h+eCI+qpmZzkfKDlImluODbDQ28by+ha6WeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Po6KcTKS; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714284474; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0XrJ37wIQzvwAcIhD3RtsLFwjDVORL03e2lPTgiYjbA=;
	b=Po6KcTKSutuZSvJD1pr9jZinpdhuwwDiNwLAdCcf8sOM08hkCLxQ2LDzvNCHww+3PqD2EDg3LB0SgNqW9FDK43UOwDmEVbLSDLSVbCqMH6hmHefQ2sGCjz15MOIuBfDMiecgfiU3K4DjExS2YqZS6iEsKuND5FflIHLrPHz8plU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5NLVMJ_1714284471;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5NLVMJ_1714284471)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 14:07:53 +0800
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
Subject: [PATCH net-next v7 05/11] net/smc: mark optional smcd_ops and check for support when called
Date: Sun, 28 Apr 2024 14:07:32 +0800
Message-Id: <20240428060738.60843-6-guwen@linux.alibaba.com>
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

Some operations are not supported by new introduced Emulated-ISM, so
mark them as optional and check if the device supports them when called.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>
---
 include/net/smc.h | 14 ++++++++------
 net/smc/smc_ism.c |  9 ++++++++-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index 542d12372c18..33b753115e43 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -59,12 +59,6 @@ struct smcd_ops {
 	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
 			    void *client);
 	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
-	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
-	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
-	int (*set_vlan_required)(struct smcd_dev *dev);
-	int (*reset_vlan_required)(struct smcd_dev *dev);
-	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
-			    u32 trigger_irq, u32 event_code, u64 info);
 	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
@@ -72,6 +66,14 @@ struct smcd_ops {
 	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
 	u16 (*get_chid)(struct smcd_dev *dev);
 	struct device* (*get_dev)(struct smcd_dev *dev);
+
+	/* optional operations */
+	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
+	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
+	int (*set_vlan_required)(struct smcd_dev *dev);
+	int (*reset_vlan_required)(struct smcd_dev *dev);
+	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
+			    u32 trigger_irq, u32 event_code, u64 info);
 };
 
 struct smcd_dev {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 051726586730..36459a3c739d 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -126,6 +126,8 @@ int smc_ism_get_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 
 	if (!vlanid)			/* No valid vlan id */
 		return -EINVAL;
+	if (!smcd->ops->add_vlan_id)
+		return -EOPNOTSUPP;
 
 	/* create new vlan entry, in case we need it */
 	new_vlan = kzalloc(sizeof(*new_vlan), GFP_KERNEL);
@@ -171,6 +173,8 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 
 	if (!vlanid)			/* No valid vlan id */
 		return -EINVAL;
+	if (!smcd->ops->del_vlan_id)
+		return -EOPNOTSUPP;
 
 	spin_lock_irqsave(&smcd->lock, flags);
 	list_for_each_entry(vlan, &smcd->vlan, list) {
@@ -368,7 +372,8 @@ static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
 		smc_smcd_terminate(wrk->smcd, &peer_gid, ev_info.vlan_id);
 		break;
 	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
-		if (ev_info.code == ISM_EVENT_REQUEST) {
+		if (ev_info.code == ISM_EVENT_REQUEST &&
+		    wrk->smcd->ops->signal_event) {
 			ev_info.code = ISM_EVENT_RESPONSE;
 			wrk->smcd->ops->signal_event(wrk->smcd,
 						     &peer_gid,
@@ -538,6 +543,8 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr)
 
 	if (lgr->peer_shutdown)
 		return 0;
+	if (!lgr->smcd->ops->signal_event)
+		return 0;
 
 	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
 	ev_info.vlan_id = lgr->vlan_id;
-- 
2.32.0.3.g01195cf9f


