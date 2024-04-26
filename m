Return-Path: <linux-kernel+bounces-159847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670198B3519
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E67D1F21F46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE395145B1C;
	Fri, 26 Apr 2024 10:15:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF35145340;
	Fri, 26 Apr 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126535; cv=none; b=S/DK1vxYV9G6BmAAA2gXjXNiyCUyBEPsOeZ73o8feAH7hgb/Eeke0ntatpjuTuL+twmzrgyTr5aGMTmR3i5zJRV3amLLl8plzkIxunyYEP8i7VUFY8JHREtvgDq3XS56zQcRvsiiF39DPwjGuhiISDvzcyGRadS++H2EuH1aXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126535; c=relaxed/simple;
	bh=NGHnJwDUokiw9Li15phsBu+kjcuOzx5ej1mAOXlm/ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=quwiYucZiAfpfwqhGpUMFeHPsPTY3IUc6F1C8/Ts0Ubr5BmrhQBWKf9TL7xu6gtb4srpzX0847Rx42ebPqTa9uXchVm9rDwpU7efmcy24iK9Jb9aH6iGkj/J4YgBL1MUPPxyKQ7YmSWPTnOL1VRgODm2yWQSWUoQRAYMcnLf+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQpRx2s5gzwVJM;
	Fri, 26 Apr 2024 18:12:13 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 5355818009D;
	Fri, 26 Apr 2024 18:15:26 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 18:15:19 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 0/7] There are some bugfix for the HNS3 ethernet driver
Date: Fri, 26 Apr 2024 18:00:38 +0800
Message-ID: <20240426100045.1631295-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

---
changeLog:
v1 -> v2:
  - Adjust the code sequence to completely eliminate the race window, suggested by Jiri Pirko
  v1: https://lore.kernel.org/all/20240422134327.3160587-1-shaojijie@huawei.com/
---

Jian Shen (1):
  net: hns3: direct return when receive a unknown mailbox message

Peiyang Wang (4):
  net: hns3: change type of numa_node_mask as nodemask_t
  net: hns3: release PTP resources if pf initialization failed
  net: hns3: use appropriate barrier function after setting a bit value
  net: hns3: using user configure after hardware reset

Yonglong Liu (2):
  net: hns3: fix port vlan filter not disabled issue
  net: hns3: fix kernel crash when devlink reload during initialization

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 52 +++++++++++--------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  5 +-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 20 ++++---
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  2 +-
 6 files changed, 49 insertions(+), 39 deletions(-)

-- 
2.30.0


