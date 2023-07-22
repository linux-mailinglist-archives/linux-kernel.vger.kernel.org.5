Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A375DBB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGVK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGVK0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:26:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C926A3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:26:07 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R7Mvl6WNKzHqXC;
        Sat, 22 Jul 2023 18:23:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 18:26:02 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [RFC 0/1] ubi: An interface for dump the mapping between LEBs and PEBs
Date:   Sat, 22 Jul 2023 18:23:01 +0800
Message-ID: <20230722102302.1848135-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a metadata exception occurs on a device using UBIFS, we can easily
obtain the LEB number of the data exception from the log, but the PEB
number corresponding to the LEB cannot be obtained.

In some production lines, the NAND flash produced by the NAND flash
cannot provide reliable ECC error correction capabilities. The file
system damage is always related to the flash eraseblock exception.
Therefore, I hope that there is a way to quickly obtain the mapping
between LEBs and PEBs in the user space. In this way, the tool of 
user mode can be used to debug possible faulty physical blocks
more conveniently.

Currently, the implementation of this interface is rough. It does
not obtain necessary locks when traversing the entire eba_tbl. Therefore,
this operation race with the volume update process (such as resize and
wear-leveling). As a result, the user mode obtains incorrect mapping
information. However, in practice, when the development and O&M need
to use this interface, frequent volume management operations do not
occur. Therefore, this problem may be tolerated.

I hope the experts will give valuable comments on this patch. If this
interface is acceptable, I'll make it perform as well as I can.

ZhaoLong Wang (1):
  ubi: An interface is added for dump the mapping between LEBs and PEBs

 drivers/mtd/ubi/debug.c | 104 ++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/ubi/eba.c   |  24 ----------
 drivers/mtd/ubi/ubi.h   |  24 ++++++++++
 3 files changed, 128 insertions(+), 24 deletions(-)

-- 
2.31.1

