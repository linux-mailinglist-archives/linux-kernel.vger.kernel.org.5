Return-Path: <linux-kernel+bounces-100326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1285F8795C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31B1283CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6067AE73;
	Tue, 12 Mar 2024 14:12:49 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918158AD4;
	Tue, 12 Mar 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252768; cv=none; b=Bu5ntFqoMvCkmGp+VLc1MLHWZ5vrU1qonvCPWzvCaLRzzUS2HH1Gftmma6yKX3Gfsg/q0eahfFPj92OEdTxziyps9hRmZw0IRGjemT2sqFJT6YFhi1SJZX3udNUpPUBG+yEkjyEES4lbazRQy47OasC4iZRhKxsIc65Qc0bymfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252768; c=relaxed/simple;
	bh=gI1o6xntZCVjpcpqH/3EqvokOr0RrCofLs5Wk69tw7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRwuirrIsfnTzn8unSRu2Nsr51kmTa7f5ivzvGvhmDw2z+/tfS+cSZB++y4o5Go6YpcKrjvEwzWogTvxH9udCM6VkEWADWww0VoUqlm62UGNGZCkB3tOgWIxCjc4ashE//Wh+HT7okUSLR+IDFP6K52HXqEOhDcc7Toj3hqbJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TvFvw2XPlz1FM9T;
	Tue, 12 Mar 2024 22:12:28 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2279C1A0172;
	Tue, 12 Mar 2024 22:12:43 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 12 Mar 2024 22:12:42 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v6 4/4] scsi: libsas: Fix the failure of adding phy with zero-address to port
Date: Tue, 12 Mar 2024 14:11:03 +0000
Message-ID: <20240312141103.31358-5-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240312141103.31358-1-yangxingui@huawei.com>
References: <20240312141103.31358-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)

As of commit 7d1d86518118 ("[SCSI] libsas: fix false positive 'device
attached' conditions"), reset the phy->entacted_sas_addr address to a
zero-address when the link rate is less than 1.5G.

Currently we find that when a new device is attached, and the link rate is
less than 1.5G, but the device type is not NO_DEVICE, for example: the link
rate is SAS_PHY_RESET_IN_PROGRESS and the device type is stp. After setting
the phy->entacted_sas_addr address to the zero address, the port will
continue to be created for the phy with the zero-address, and other phys
with the zero-address will be tried to be added to the new port:

[562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 0000000000000000 (no device)
// phy19 is deleted but still on the parent port's phy_list
[562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
[562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 0000000000000000 (stp)
[562240.062680] port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of another port

Therefore, it should be the same as sas_get_phy_attached_dev(). Only when
device_type is SAS_PHY_UNUSED, sas_address is set to the 0 address.

Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 77daae36232b..430575b86e3e 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -271,8 +271,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
 	/* help some expanders that fail to zero sas_address in the 'no
 	 * device' case
 	 */
-	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
-	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
+	if (phy->attached_dev_type == SAS_PHY_UNUSED)
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	else
 		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
-- 
2.17.1


