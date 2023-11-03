Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CFC7E00D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjKCGv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjKCGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:51:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD2A1B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:51:17 -0700 (PDT)
Received: from dggpemd200001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SMBB35CX8zPnxc;
        Fri,  3 Nov 2023 14:47:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Fri, 3 Nov
 2023 14:51:14 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v4 0/5] ubi: Enhanced fault injection capability for the UBI driver
Date:   Fri, 3 Nov 2023 14:55:31 +0800
Message-ID: <20231103065536.3778940-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200001.china.huawei.com (7.185.36.224)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.31.1

