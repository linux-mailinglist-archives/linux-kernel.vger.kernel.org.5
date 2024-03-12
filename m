Return-Path: <linux-kernel+bounces-100357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6B87963F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80F82819AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6537E10F;
	Tue, 12 Mar 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WYfd5Viz"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6F7D070;
	Tue, 12 Mar 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253693; cv=none; b=qStEmyQgf/ry9/Z25IVr3lNgPPWUBoUxCYx4pzbCeGN0pB2G6wh9VAWWAClboCVNOpGhhRucoe6P/JtPH3FyjyLWvEu2teBL/0yAQfaVTfeMZjqB3brwyyNBr1iFJiP7PLwQ5EXUY9RZxZZUY7XNDKI+monVzZclBbSFJVX5d1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253693; c=relaxed/simple;
	bh=dvrjP6FyooMZfH9tP3r/k0q7Zxk1MxNigKI5R5WFDZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhyf7MtLFkCiYFUNnZM7UPiS2LskCawqE59jVjvqc/hihAVF+nUzHMk7VieWQW0xQItfruXX+pyOUWwhvEFwUQADNGL12mglL2Lu7xPS8lsSuxSZvP/h3h8MEVFFHFQUOx9SOztU1VGjRIRmsOj88PIsY93GSBMjWJY/IOlZOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WYfd5Viz; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710253681; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ioFYp50r+AC0yjO8FJo0KTmmSlkoNb91N+pNLCEdIRU=;
	b=WYfd5VizNb9SE3HUzl40ZHd1jy2A9TSu6Z5YR0n2wMQSgBPGdD3OSGf4BS6n2mHE+WWTAjkyWXaw74hKvJpCLlA6k/n47mAsbLqNzTLY5V6o28be0H+K0/HP8f8U+axSUt5zh0143JOM0xSThBK8odwgmRTXvlO/+sfX0kxHDbM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2M60RJ_1710253679;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2M60RJ_1710253679)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 22:28:01 +0800
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
Subject: [PATCH net-next v3 01/11] net/smc: adapt SMC-D device dump for Emulated-ISM
Date: Tue, 12 Mar 2024 22:27:33 +0800
Message-Id: <20240312142743.41406-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240312142743.41406-1-guwen@linux.alibaba.com>
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
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


