Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7688032BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjLDMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:32:28 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91442AB;
        Mon,  4 Dec 2023 04:32:34 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SkNGb5fmwz14LB3;
        Mon,  4 Dec 2023 20:27:35 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 4 Dec 2023 20:32:32 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v5 0/3] Fix the failure of adding phy with zero-address to port 
Date:   Mon, 4 Dec 2023 12:29:29 +0000
Message-ID: <20231204122932.55741-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series is to solve the problem of a BUG() when adding phy with zero
address to a new port.

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

Xingui Yang (3):
  scsi: libsas: Add helper for port add ex_phy
  scsi: libsas: Move sas_add_parent_port() to sas_expander.c
  scsi: libsas: Fix the failure of adding phy with zero-address to port

 drivers/scsi/libsas/sas_expander.c | 34 ++++++++++++++++++++++++------
 drivers/scsi/libsas/sas_internal.h | 15 -------------
 2 files changed, 28 insertions(+), 21 deletions(-)

-- 
2.17.1

