Return-Path: <linux-kernel+bounces-10921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34FE81DEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109061C2163E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68691846;
	Mon, 25 Dec 2023 07:13:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DA15A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sz8H354KVzvSYb;
	Mon, 25 Dec 2023 15:12:15 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F0541402E0;
	Mon, 25 Dec 2023 15:13:15 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 25 Dec
 2023 15:13:14 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v5 0/5] ubi: Enhanced fault injection capability for the UBI driver
Date: Mon, 25 Dec 2023 15:10:50 +0800
Message-ID: <20231225071055.1721000-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd200001.china.huawei.com (7.185.36.224)

The existing fault injection capability of UBI is too simple.
It uses hard-coded fault probability values and lacks other
configurable options. As a result, these interfaces are difficult
to use when digging defects in the abnormal path of code and
reproducing some problems.

The kernel provides a powerful fault injection framework, which
provides rich configurable fault injection attributes during runtime.
So it can be used to improve the fault injection capability of the 
UBI driver.

This series of patches refactor the existing fault injection interface
and add some fault injection types to help testers and developers
find potential problems in the code.

This series of patches enhance the existing fault injection interface
and retain the old debugfs interface, and add some fault injection types
to help testers and developers Look for potential problems in the code.

V2:
 - Retain the old fault injection interface.

v3:
 1. Corrects the initialization of the error mask, which should start at 1.
 2. Change the read format of the mask value to readable hexadecimal.
 3. The interface definition style is consistent when the new interface is added.
 4. Redundant CONFIG_MTD_UBI_FAULT_INJECTION macro are removed.
 5. Correct the fault injection hook position error: ubi_io_read_data -> ubi_io_write_data.
 6. UBI_IO_BITFLIPS is returned in ubi_io_read() in advance to prevent the 
    return value from being overwritten.
 7. In the last commit, example of the use of fail_function is given.

v4:
 - Delete redundant space characters.

v5:
 - Delete the redundant semicolon of the first patch.

ZhaoLong Wang (5):
  ubi: Use the fault injection framework to enhance the fault injection
    capability
  ubi: Split io_failures into write_failure and erase_failure
  ubi: Add six fault injection type for testing
  ubi: Reserve sufficient buffer length for the input mask
  mtd: Add several functions to the fail_function list

 drivers/mtd/mtdcore.c   |   5 +
 drivers/mtd/ubi/Kconfig |   9 ++
 drivers/mtd/ubi/debug.c | 107 ++++++++++++--
 drivers/mtd/ubi/debug.h | 304 +++++++++++++++++++++++++++++++++++++---
 drivers/mtd/ubi/io.c    |  86 +++++++++++-
 drivers/mtd/ubi/ubi.h   |  45 +++---
 6 files changed, 497 insertions(+), 59 deletions(-)

-- 
2.39.2


