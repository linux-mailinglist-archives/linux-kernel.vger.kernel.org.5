Return-Path: <linux-kernel+bounces-95268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DB2874B88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73CEB228A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB585272;
	Thu,  7 Mar 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yGLylFo3"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7584FC8;
	Thu,  7 Mar 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805348; cv=none; b=Lk/yi5ROcOdQo3KIvT2lLppLLGmgi9tej0nEkQ1wwrNxE/0x4eSKakyAFxwC+S7ZQHNZQJDojyd6uBs3/Xbd4U+uuVNiQrxhShIcGtwVsKuJISWg+n4oR6izRufHkAngvGcULvEqUdX0cefieYXyyxu3Z8wfS+3UUjvHzHubULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805348; c=relaxed/simple;
	bh=dvrjP6FyooMZfH9tP3r/k0q7Zxk1MxNigKI5R5WFDZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCZMLAKC+xaINfv51ucEheyHj756RAb8bvvncRGRocs/B7bXsB3iKr8ts+mGOY75Id0jCARV+KX3mfBHOB7PwZ8B6RkqaGASg7NkZ792bFw4SavWg/Lu8V8OdIMWgKjwnxTgqSV5MpI3R8Nn5acBGzQieSFtGQb+AfpSd1cUPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yGLylFo3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709805343; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ioFYp50r+AC0yjO8FJo0KTmmSlkoNb91N+pNLCEdIRU=;
	b=yGLylFo3Zsr+RyzFXz7NsCZTODR/Vc+bFgAl8cpui8M3/8Plb4SeBb3sLvaLFFSCMB49bliGPK4gbXiSDRYVix1ScdZxVPEIKqpvmTDIc8FIt/EGiOAxOa3IKZPBCRfR3mXNvSt8FVjiiskzZ4yc4YRMEj2GmdrlXyXTvmOCIvc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2-KdwB_1709805340;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2-KdwB_1709805340)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:55:43 +0800
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
Subject: [PATCH net-next v2 01/11] net/smc: adapt SMC-D device dump for Emulated-ISM
Date: Thu,  7 Mar 2024 17:55:26 +0800
Message-Id: <20240307095536.29648-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240307095536.29648-1-guwen@linux.alibaba.com>
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction of Emulated-ISM requires adaptation of SMC-D device
dump. Software implemented non-PCI device (loopback-ism) should be
handled correctly and the CHID reserved for Emulated-ISM should be got
from smcd_ops interface instead of PCI information.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index ac88de2a06a0..b6eca4231913 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -252,12 +252,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
 	struct smc_pci_dev smc_pci_dev;
 	struct nlattr *port_attrs;
+	struct device *device;
 	struct nlattr *attrs;
-	struct ism_dev *ism;
 	int use_cnt = 0;
 	void *nlh;
 
-	ism = smcd->priv;
 	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &smc_gen_nl_family, NLM_F_MULTI,
 			  SMC_NETLINK_GET_DEV_SMCD);
@@ -272,7 +271,15 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
 		goto errattr;
 	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
-	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
+	device = smcd->ops->get_dev(smcd);
+	if (device->parent)
+		smc_set_pci_values(to_pci_dev(device->parent), &smc_pci_dev);
+	if (smc_ism_is_emulated(smcd)) {
+		smc_pci_dev.pci_pchid = smc_ism_get_chid(smcd);
+		if (!device->parent)
+			snprintf(smc_pci_dev.pci_id, sizeof(smc_pci_dev.pci_id),
+				 "%s", dev_name(device));
+	}
 	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
 		goto errattr;
 	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
-- 
2.32.0.3.g01195cf9f


