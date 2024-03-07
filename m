Return-Path: <linux-kernel+bounces-95237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D05874B15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FBF281DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400184A37;
	Thu,  7 Mar 2024 09:39:14 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655883CDC;
	Thu,  7 Mar 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804354; cv=none; b=nYqBrUB6LRSNaAGSg+YGajhv3e5SE+e06LoOPR5aAfXTmkFgm895tC/133HcoO+moPbq4QgmGFlyv2tdXjgGTo0Nyk/sA8CvSIKD37h4JnVQp+MhnDOxuk/gkdrtlMnjl8TwYfo5n1X24qG4o+gbvKOQp6xdv9EZSwvPDl+FqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804354; c=relaxed/simple;
	bh=jljHW6o49zjbCy/L7+hPpkUpq8yYCdikMLs4jarlKrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GdQMsCu8Z60Bl++6AcKK1VnLc9dtkZKAoLTgufwUWDIP77Xj+scMIaI2FUm6I/wH92J5DTZzVkVd6/LUInuPGJ82c4wnW9/2KcQf/RTovIcxWyBwyIIDAoHqTs3Rklmb2N/5hxSjUnV6za8X2QjbHpO/wrlV8H4vcEV9/Ipi+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tr4256r8jz1QB5L;
	Thu,  7 Mar 2024 17:36:45 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 456F91402CA;
	Thu,  7 Mar 2024 17:39:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 17:39:08 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v3 0/3] scsi: libsas: Fix disk not being scanned in after being removed
Date: Thu, 7 Mar 2024 09:37:30 +0000
Message-ID: <20240307093733.41222-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100001.china.huawei.com (7.185.36.94)

This patch series fixes an issue when do discovery on an empty PHY to
update PHY info after device unregister could cause newly connected device
to not be scanned.

Changes since v2:
- Based on John's suggestion, allow smp_execute_task() arguments to be on
the stack.
- Based on John's suggestion, add a helper sas_get_sas_addr_and_dev_type.
- Updated comments.

Changes since v1:
- Use sas_get_phy_discover() instead of sas_get_phy_attached_dev() in
sas_rediscover_dev() and use disc_resp to update phy info.

Xingui Yang (3):
  scsi: libsas: Allow smp_execute_task() arguments to be on the stack
  scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()
  scsi: libsas: Fix disk not being scanned in after being removed

 drivers/scsi/libsas/sas_expander.c | 64 ++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 22 deletions(-)

-- 
2.17.1


