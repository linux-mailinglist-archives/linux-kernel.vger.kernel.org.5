Return-Path: <linux-kernel+bounces-95763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54279875230
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109D7286A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06212E1DF;
	Thu,  7 Mar 2024 14:45:53 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2271EB2F;
	Thu,  7 Mar 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822753; cv=none; b=Mo1Y26JmPH+jYNHgNkidqqHrMhHEGyesvZ/oYCEQtYS0IsF+Qd3LbZyKgD5+TdEKFBI4dMlE+sjBk6E9a2i0+Y74Tl10YCY3IX5dh1wvL6NfmfLxytyWVM5YccZzgDwvVDVyeALeEpfj6zAQUEho7Dg4xVqP45SWbm3QV/nhj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822753; c=relaxed/simple;
	bh=1qZVm0xyYLh7JYAEGw5xTkCh+bdrOkAYksX68kfmoGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vtmkd4mFHT/ssUHo/0sGK3hG1CGcNlykUhBxS5YQI/wkd4nzhFvFNlGVpoxdwzVY8TbPGlKfsSjQJvL5aeCM+nkFQhmoubdtKoE0KeIiKqYxkGfPckUVkhJj1B+OCx9qoq/Z6KJoNjWK0mblU2NPp/FKSrSF9TBZWuQfKkVmoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TrBtT6wFlz1FLwj;
	Thu,  7 Mar 2024 22:45:37 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 56B271A016C;
	Thu,  7 Mar 2024 22:45:47 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 22:45:46 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao2@huawei.com>, <louhongxiang@huawei.com>
Subject: [PATCH v4 0/3] SCSI: Fix issues between removing device and error handle
Date: Thu, 7 Mar 2024 22:43:08 +0800
Message-ID: <20240307144311.73735-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)

I am testing SCSI error handle with my previous scsi_debug error
injection patches, and found some issues when removing device and
error handler happened together.

These issues are triggered because devices in removing would be skipped
when calling shost_for_each_device().

The issues are found:
1. statistic info printed at beginning of scsi_error_handler is wrong
2. device reset is not triggered

V4:
 - Remove the forth patch which fix IO hang when device removing
   becaust the issue is fixed by commit '6df0e077d76bd (scsi: core:
   Kick the requeue list after inserting when flushing)'

V3:
  - Update patch description
  - Update comments of functions added

V2:
  - Fix IO hang by run all devices' queue after error handler
  - Do not modify shost_for_each_device() directly but add a new
    helper to iterate devices but do not skip devices in removing

Wenchao Hao (3):
  scsi: core: Add new helper to iterate all devices of host
  scsi: scsi_error: Fix wrong statistic when print error info
  scsi: scsi_error: Fix device reset is not triggered

 drivers/scsi/scsi.c        | 46 ++++++++++++++++++++++++++------------
 drivers/scsi/scsi_error.c  |  4 ++--
 include/scsi/scsi_device.h | 25 ++++++++++++++++++---
 3 files changed, 56 insertions(+), 19 deletions(-)

-- 
2.32.0


