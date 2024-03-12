Return-Path: <linux-kernel+bounces-100325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6D8795BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CF51F21F75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681347AE49;
	Tue, 12 Mar 2024 14:12:48 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE797A72E;
	Tue, 12 Mar 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252768; cv=none; b=knNYf308UBqTMVKtNPcGu0qtBdbBmvZ3nQfgV7A522FqSEhlJ5NPUQ890vd01TG4PyPRYlnZrexrVchk3/RAjVz5esZQv0JCHjKyZBpq+kD8vCv4ypayn66RsBnQlqogZa2QfVl6OXyHCuwob3jWNjry4KDIVkL72CX6j86CIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252768; c=relaxed/simple;
	bh=ewBWYCx0hbntCPFBw8DhVmmlOMYM1PWFjKYyV98nukc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikypjJuTT8/X1OVo4EDL9LmSPuCgNel0wiz6iC7AX5bAg/K6Wh6JygvQ7yuaMcMgrGGgPyPQnyFawqTgTjAlryVm3kNXYfEma4W+czKBMaikmjtBv6GRbEfsdrNqeUtssmYLizgPJ7Cj/OkpcwQ3G23nlEZp8elJr2KJGtEDCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TvFvv4w2xz1FM4D;
	Tue, 12 Mar 2024 22:12:27 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 74036140416;
	Tue, 12 Mar 2024 22:12:42 +0800 (CST)
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
Subject: [PATCH v6 0/4] scsi: libsas: Fix the failure of adding phy with zero-address to port
Date: Tue, 12 Mar 2024 14:10:59 +0000
Message-ID: <20240312141103.31358-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)

This series is to solve the problem of a BUG() when adding phy with zero
address to a new port.

v5 -> v6
1. rename sas_add_parent_port() to sas_ex_add_parent_port() based on
   John's suggestion.
2. Distill port settings into a single patch.
3. Update comments information.

v4 -> v5
1. Add new helper sas_port_add_ex_phy() based on John's suggestion.
2. Move sas_add_parent_port() to sas_expander.c based on John's suggestion.
3. Update the comments.

v3 -> v4:
1. Update patch title and comments based on John's suggestion.

v2 -> v3:
1. Set ex_dev->parent_port to NULL when the number of PHYs of the parent
   port becomes 0.
2. Update the comments.

v1 -> v2:
1. Set ex_phy->port with parent_port when ex_phy is added to the parent
   port.
2. Set ex_phy to NULL when free expander.
3. Update the comments.

Xingui Yang (4):
  scsi: libsas: Add helper for port add ex_phy
  scsi: libsas: Move sas_add_parent_port() to sas_expander.c
  scsi: libsas: Set port when ex_phy is added or deleted
  scsi: libsas: Fix the failure of adding phy with zero-address to port

 drivers/scsi/libsas/sas_expander.c | 38 +++++++++++++++++++++++-------
 drivers/scsi/libsas/sas_internal.h | 15 ------------
 2 files changed, 30 insertions(+), 23 deletions(-)

-- 
2.17.1


