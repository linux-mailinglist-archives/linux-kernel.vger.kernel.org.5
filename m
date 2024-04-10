Return-Path: <linux-kernel+bounces-138548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B553B89F33A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E728A1C2700B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89915DBC4;
	Wed, 10 Apr 2024 12:58:56 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444A15B568;
	Wed, 10 Apr 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753936; cv=none; b=hPv2Mw6zPJI4ONXDjKJCKMbsTsWMd8qSdJbOlt/lm5ovDAQA4SynOeo8GRw2XAprjw7SSGdQYPQeVmktFpKRJLSj7oadvEzamv62kXq67qBngi1steJxh/++lnSqUT+1M5CCLTt9qIk4aMyQrEVSDf2i8MDh8/HMo2VmKJEY+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753936; c=relaxed/simple;
	bh=8bg/UKTj63VR5ARRukpLFgqe0WkB1c2fnEwn5KliV/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uQGO+AOEE6SK7YI7250MOEbx16kotXluviQgMknBv5ww331Jo8F8iwntcz7LQy6pG/w8PxGIeKgAQ+zRRuVMIjigeNbPHB/MvNpOk1lKhhjDbxFILmL5IMbjAjmWYoufQc+YCfgJsD9qzB41xB/WJYB18XRDEKNR77uoDf/MV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VF2tV2vG2z21kdT;
	Wed, 10 Apr 2024 20:57:54 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id D85871A0172;
	Wed, 10 Apr 2024 20:58:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 20:58:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<rkannoth@marvell.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V7 net-next 0/4] Support some features for the HNS3 ethernet driver
Date: Wed, 10 Apr 2024 20:53:50 +0800
Message-ID: <20240410125354.2177067-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
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

Currently, the hns3 driver does not have the trace
of the command queue. As a result, it is difficult to
locate the communication between the driver and firmware.
Therefore, the trace function of the command queue is
added in this patch set to facilitate the locating of
communication problems between the driver and firmware.

If a RAS occurs, the driver will automatically reset to attempt
to recover the RAS. Therefore, to locate the cause of the RAS,
it is necessary to save the values of some RAS-related registers
before the reset. So we added a patch in this patch set to
print these information.

---
changeLog:
v6 -> v7:
  - Add document the meaning of scc, suggested by Jakub Kicinski
  - Added more description about dump more reg info based on ras mod,
    suggested by Jakub Kicinski
  v6: https://lore.kernel.org/all/20240327114330.1826631-1-shaojijie@huawei.com/
v5 -> v6:
  - Delete the redundant operation of adding '\0' after scnprintf,
    suggested by Ratheesh Kannoth
  v5: https://lore.kernel.org/all/20240309100044.2351166-1-shaojijie@huawei.com/
v4 -> v5:
  - Delete a patch about dump pfc frame statistics in tx timeout log by dmesg,
    suggested by Jiri Pirko
  - Rewrite the log message of patch about command queue trace, suggested by Jiri Pirko
  - Add a new patch about querying scc version by devlink info
  v4: https://lore.kernel.org/all/20240105010119.2619873-1-shaojijie@huawei.com/
v3 -> v4:
  - Adjuste the patches sequence in this patch set, suggested by Simon Horman
  v3: https://lore.kernel.org/all/20231216070018.222798-1-shaojijie@huawei.com/
v2 -> v3:
  - Fix the incorrect use of byte order in patch
    "net: hns3: add command queue trace for hns3" suggested by Simon Horman
  - Add a new patch to move constants from hclge_debugfs.h
    to hclge_debugfs.c suggested by Simon Horman
  v2: https://lore.kernel.org/all/20231214141135.613485-1-shaojijie@huawei.com/
v1 -> v2:
  - Delete a patch for ethtool -S to dump page pool statistics, suggested by Jakub Kicinski
  - Delete two patches about CMIS transceiver modules because
    ethtool get_module_eeprom_by_page op is not implemented, suggested by Jakub Kicinski
  v1: https://lore.kernel.org/all/20231211020816.69434-1-shaojijie@huawei.com/
---

Hao Chen (1):
  net: hns3: add support to query scc version by devlink info

Hao Lan (1):
  net: hns3: add command queue trace for hns3

Jijie Shao (1):
  net: hns3: move constants from hclge_debugfs.h to hclge_debugfs.c

Peiyang Wang (1):
  net: hns3: dump more reg info based on ras mod

 Documentation/networking/devlink/hns3.rst     |   3 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  13 +
 .../hns3/hns3_common/hclge_comm_cmd.c         |  19 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |  24 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 646 +++++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     | 643 +----------------
 .../hisilicon/hns3/hns3pf/hclge_devlink.c     |  44 +-
 .../hisilicon/hns3/hns3pf/hclge_devlink.h     |   2 +
 .../hisilicon/hns3/hns3pf/hclge_err.c         | 433 +++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_err.h         |  36 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  63 ++
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   1 +
 .../hisilicon/hns3/hns3pf/hclge_trace.h       |  94 +++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  40 ++
 .../hisilicon/hns3/hns3vf/hclgevf_trace.h     |  50 ++
 15 files changed, 1459 insertions(+), 652 deletions(-)

-- 
2.30.0


