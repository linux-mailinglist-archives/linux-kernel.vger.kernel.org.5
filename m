Return-Path: <linux-kernel+bounces-117050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E224488B137
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B6BB47A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C77351F;
	Mon, 25 Mar 2024 12:47:51 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BF6FE35;
	Mon, 25 Mar 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370870; cv=none; b=of6RwFe2g2u4GzLMaw9F9XmGFTfoKuVA+iU9yp35wBiGzBEhHyNvrJ5IJmjxSbONDfBsNcKRBOPNwkmDMG+YsAVl3F3+bgnok3tTJdbNGKVYuWV5/hu00eCT0Jnr6REVIrkLUQkBZCiOuSFyxvFRONNbak437312chPly4jePr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370870; c=relaxed/simple;
	bh=u0GK0R5ubC3Dy+GhijKCcQ6Q7lOTGHT40M8EgXw9RRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZWd4zulHzlqK3FTVpSvdJC49sdgv84vxAsABm8xA43ROrLq+aIcHEXWPMdbJ164ZS2VMYJYQ4UPd5uq9vtq50pCPBRcoVHZVVqVhC2bN8tJVwFaKHVm+wWxKJ7KsSM9By7mB6C8LH3/MHsHdWgGUwo4YqqQcxvuXRxYAXKP5v7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V3CPF2xGzz1vxgl;
	Mon, 25 Mar 2024 20:46:57 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id D868C1400D4;
	Mon, 25 Mar 2024 20:47:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 20:47:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.kubiak@intel.com>, <rkannoth@marvell.com>,
	<jiri@resnulli.us>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V4 net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Mon, 25 Mar 2024 20:43:08 +0800
Message-ID: <20240325124311.1866197-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

---
changeLog:
v3 -> v4:
  - Fixed an unclear sentence in commit log, suggested by Michal Kubiak
  - Used devl_lock to disallow reload to race with initialization, suggested by Jiri Pirko
  v3: https://lore.kernel.org/all/20240318132948.3624333-1-shaojijie@huawei.com/
v2 -> v3:
  - Fixed a syntax error in commit log, suggested by Ratheesh Kannoth
  v2: https://lore.kernel.org/all/20240316111057.277591-1-shaojijie@huawei.com/
v1 -> v2:
  - Fixed some syntax errors in commit log and comments, suggested by Michal Kubiak
  - Optimized the code by using a flag, suggested by Michal Kubiak
  v1: https://lore.kernel.org/all/20240315100748.2913882-1-shaojijie@huawei.com/
---

Jian Shen (1):
  net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
  net: hns3: fix index limit to support all queue stats

Yonglong Liu (1):
  net: hns3: fix kernel crash when devlink reload during pf
    initialization

 .../hns3/hns3_common/hclge_comm_tqp_stats.c   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 19 +++++++++++++++++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  4 ++++
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.30.0


