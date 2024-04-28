Return-Path: <linux-kernel+bounces-161277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC28B4A04
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CBE1F215CF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01120B667;
	Sun, 28 Apr 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T2Qs28WF"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4945957;
	Sun, 28 Apr 2024 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284492; cv=none; b=mP+0RLCCps3OzzRrudKGzUP52o6HANvh0l+rt2ks72/zsF/Uow4irpoX52hdig2mxIi4sFxPpeCkdFLDGMjD33TzOofRDGaZGA4LtO5qcPrByOti9sU+lvVgJ5gh+XNcRxFEhxOTmPBABRceYfPOw/aTl4GnNczkE9b33o8/500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284492; c=relaxed/simple;
	bh=nsm4NeXb0YM1r0uCW+zvzo7Dj5N9/3GfB/plqdZtmuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9sqWIfA5Qt1tGc43gKjObNUGyc8ZlttV1BuW28dPl7kRAl1f5y5vaJp7X9FhnLR36JhRePBKf3Ze0JAruLHHtd2p9IcokUU/Is5w565Tc4Jlg7HsQTomHA0w1klZ9Xjs1dGaaUCYoG8oYL16V9yoO4WtCMwFHB+ihl4bzIA5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T2Qs28WF; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714284482; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uiPgxHAmyGEeXTIhklWvYyRqvQyR9VlV6BbT80+tMdY=;
	b=T2Qs28WFIFuZmOuLiTXak4pybFHl8qIPdPCAPO3ljt36jRxcGEB00dskSQwP8UPKVfSJgAmJh8YylmBEV3J7/0plle4T1N3p0+m9wtuW+oRMOKV4kJc6H7r8Syd1dH4vZn1tnN184JlfsPE0J6rBDGBggEKFneUV0Ji3Q2CS03c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5NOUvM_1714284478;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5NOUvM_1714284478)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 14:08:00 +0800
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
Subject: [PATCH net-next v7 08/11] net/smc: add operations to merge sndbuf with peer DMB
Date: Sun, 28 Apr 2024 14:07:35 +0800
Message-Id: <20240428060738.60843-9-guwen@linux.alibaba.com>
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

In some scenarios using Emulated-ISM device, sndbuf can share the same
physical memory region with peer DMB to avoid data copy from one side
to the other. In such case the sndbuf is only a descriptor that
describes the shared memory and does not actually occupy memory, it's
more like a ghost buffer.

      +----------+                     +----------+
      | socket A |                     | socket B |
      +----------+                     +----------+
            |                               |
       +--------+                       +--------+
       | sndbuf |                       |  DMB   |
       |  desc  |                       |  desc  |
       +--------+                       +--------+
            |                               |
            |                          +----v-----+
            +-------------------------->  memory  |
                                       +----------+

So here introduces three new SMC-D device operations to check if this
feature is supported by device, and to {attach|detach} ghost sndbuf to
peer DMB. For now only loopback-ism supports this.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>
---
 include/net/smc.h |  3 +++
 net/smc/smc_ism.c | 40 ++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ism.h |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/include/net/smc.h b/include/net/smc.h
index 33b753115e43..db84e4e35080 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -74,6 +74,9 @@ struct smcd_ops {
 	int (*reset_vlan_required)(struct smcd_dev *dev);
 	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
 			    u32 trigger_irq, u32 event_code, u64 info);
+	int (*support_dmb_nocopy)(struct smcd_dev *dev);
+	int (*attach_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
+	int (*detach_dmb)(struct smcd_dev *dev, u64 token);
 };
 
 struct smcd_dev {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 6bed0a61b746..84f98e18c7db 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -250,6 +250,46 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	return rc;
 }
 
+bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd)
+{
+	/* for now only loopback-ism supports
+	 * merging sndbuf with peer DMB to avoid
+	 * data copies between them.
+	 */
+	return (smcd->ops->support_dmb_nocopy &&
+		smcd->ops->support_dmb_nocopy(smcd));
+}
+
+int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
+		       struct smc_buf_desc *dmb_desc)
+{
+	struct smcd_dmb dmb;
+	int rc = 0;
+
+	if (!dev->ops->attach_dmb)
+		return -EINVAL;
+
+	memset(&dmb, 0, sizeof(dmb));
+	dmb.dmb_tok = token;
+	rc = dev->ops->attach_dmb(dev, &dmb);
+	if (!rc) {
+		dmb_desc->sba_idx = dmb.sba_idx;
+		dmb_desc->token = dmb.dmb_tok;
+		dmb_desc->cpu_addr = dmb.cpu_addr;
+		dmb_desc->dma_addr = dmb.dma_addr;
+		dmb_desc->len = dmb.dmb_len;
+	}
+	return rc;
+}
+
+int smc_ism_detach_dmb(struct smcd_dev *dev, u64 token)
+{
+	if (!dev->ops->detach_dmb)
+		return -EINVAL;
+
+	return dev->ops->detach_dmb(dev, token);
+}
+
 static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 				  struct sk_buff *skb,
 				  struct netlink_callback *cb)
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index e6f57e5e1ef9..6763133dd8d0 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -48,6 +48,10 @@ int smc_ism_put_vlan(struct smcd_dev *dev, unsigned short vlan_id);
 int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 			 struct smc_buf_desc *dmb_desc);
 int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
+bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd);
+int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
+		       struct smc_buf_desc *dmb_desc);
+int smc_ism_detach_dmb(struct smcd_dev *dev, u64 token);
 int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
-- 
2.32.0.3.g01195cf9f


