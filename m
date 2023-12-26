Return-Path: <linux-kernel+bounces-11303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6D781E451
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A71F224D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F47DA47;
	Tue, 26 Dec 2023 01:03:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B26A29
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Szc2h2RvfzMp8D;
	Tue, 26 Dec 2023 09:03:08 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D3FE18005E;
	Tue, 26 Dec 2023 09:03:29 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Tue, 26 Dec
 2023 09:03:28 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v6 0/5] ubi: Enhanced fault injection capability for the UBI driver
Date: Tue, 26 Dec 2023 09:01:08 +0800
Message-ID: <20231226010113.742079-1-wangzhaolong1@huawei.com>
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

This series of patches refactors the existing fault injection interface
and add some fault injection types to help testers and developers
find potential problems in the code.

This series of patches enhance the existing fault injection interface
and retain the old debugfs interface, and add some fault injection types
to help testers and developers look for potential problems in the code.

v2:
 - Retain the old fault injection interface.

v3:
 1. Corrects the initialization of the error mask, which should start at 1.
 2. Change the read format of the mask value to readable hexadecimal.
 3. The interface definition style is consistent when when adding the new interface.
 4. Redundant macros are removed.
 5. Correct the fault injection hook position error: ubi_io_read_data -> ubi_io_write_data.
 6. UBI_IO_BITFLIPS is returned in ubi_io_read() in advance to prevent the 
    return value from being overwritten.
 7. In the last commit, an example of the use of fail_function is given.

v4:
 - Delete redundant space characters.
 
v5:
 - Delete the redundant semicolon of the first patch.
 
v6:
 - Check the patch completely and fix English syntax errors.

ZhaoLong Wang (5):
  ubi: Use the fault injection framework to enhance the fault injection
    capability
  ubi: Split io_failures into write_failure and erase_failure
  ubi: Add six fault injection type for testing
  ubi: Reserve sufficient buffer length for the input mask
  mtd: Add several functions to the fail_function list

 drivers/mtd/mtdcore.c   |   5 +
 drivers/mtd/ubi/Kconfig |   9 ++
 drivers/mtd/ubi/debug.c | 108 ++++++++++++--
 drivers/mtd/ubi/debug.h | 304 +++++++++++++++++++++++++++++++++++++---
 drivers/mtd/ubi/io.c    |  86 +++++++++++-
 drivers/mtd/ubi/ubi.h   |  45 +++---
 6 files changed, 498 insertions(+), 59 deletions(-)

-- 
2.39.2


