Return-Path: <linux-kernel+bounces-95710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5987519C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA062B224C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ED512E1DF;
	Thu,  7 Mar 2024 14:15:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7282E12D773;
	Thu,  7 Mar 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820954; cv=none; b=J4LR3/LAXjzj/OTjN+uFvBubnGWLCHEjD+0wh3zLIk1BhFZJdsNq4DRCgGXxvJUDVZ50OSme6fty42QZhxNgn852C/BK4ZOSr1+Y7T2NH2POqsfUIGa69KAyYB+n3Lu849PAgfpFEeYEVIWqNicz1Isb6z+oGQ8HyVz+R5tQb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820954; c=relaxed/simple;
	bh=iGKpp0d8z1mVCzIfV5+9TMt2PLt5T167/2ptn0oeSbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PJi0WzOBcT4UZVVbmLtRagrLGox4KpIAQI/jvoccfC8Ut9qHEJb4wwZC4BrcdISI7ovF2cnGJObZrf5Wd8wF0F+nlkgAC1Uw9ghUy6vB30fCBuHgyezu35bkgDDuogDIdHc8SAi/QK5rH3LomTsswktMi7DBsVtAGhbJdjYYAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TrB9L2Qtpz2BfYp;
	Thu,  7 Mar 2024 22:13:26 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B2EC1A016C;
	Thu,  7 Mar 2024 22:15:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 22:15:48 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v4 0/2] scsi: libsas: Fix disk not being scanned in after being removed
Date: Thu, 7 Mar 2024 14:14:11 +0000
Message-ID: <20240307141413.48049-1-yangxingui@huawei.com>
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

Changes since v3:
- Revert to allocating the resp memory with alloc_smp_resp().
- Optimize goto statement.

Changes since v2:
- Based on John's suggestion, allow smp_execute_task() arguments to be on
the stack.
- Based on John's suggestion, add a helper sas_get_sas_addr_and_dev_type.
- Updated comments.

Changes since v1:
- Use sas_get_phy_discover() instead of sas_get_phy_attached_dev() in
sas_rediscover_dev() and use disc_resp to update phy info.

Xingui Yang (2):
  scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()
  scsi: libsas: Fix disk not being scanned in after being removed

 drivers/scsi/libsas/sas_expander.c | 51 ++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
2.17.1


