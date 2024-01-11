Return-Path: <linux-kernel+bounces-23537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D924982AE26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D09B1F25091
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC515AD1;
	Thu, 11 Jan 2024 12:01:20 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8E15AC9;
	Thu, 11 Jan 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-Pgn2k_1704974458;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-Pgn2k_1704974458)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:01:09 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/15] net/smc: improve SMC-D device dump for virtual ISM
Date: Thu, 11 Jan 2024 20:00:22 +0800
Message-Id: <20240111120036.109903-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240111120036.109903-1-guwen@linux.alibaba.com>
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction of virtual ISM requires improvement of SMC-D device
dump. Software implemented non-PCI device (loopback-ism) should be
handled correctly and the CHID reserved for virtual ISM should be got
from smcd_ops interface instead of PCI information.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index ac88de2a06a0..66bcfddd3fcf 100644
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
+	if (smc_ism_is_virtual(smcd)) {
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


