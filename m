Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0937B14F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjI1Hgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI1HgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:36:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E418A95;
        Thu, 28 Sep 2023 00:36:17 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rx4tH22vLztT0k;
        Thu, 28 Sep 2023 15:31:51 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 28 Sep 2023 15:36:13 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v2 0/4] SCSI: Fix issues between removing device and error handle
Date:   Thu, 28 Sep 2023 15:35:39 +0800
Message-ID: <20230928073543.3496394-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am testing SCSI error handle with my previous scsi_debug error
injection patches, and found some issues when removing device and
error handler happened together.

These issues are triggered because devices in removing would be skipped
when calling shost_for_each_device().

Three issues are found:
1. statistic info printed at beginning of scsi_error_handler is wrong
2. device reset is not triggered
3. IO requeued to request_queue would be hang after error handle

V2:
  - Fix IO hang by run all devices' queue after error handler
  - Do not modify shost_for_each_device() directly but add a new
    helper to iterate devices but do not skip devices in removing

Wenchao Hao (4):
  scsi: core: Add new helper to iterate all devices of host
  scsi: scsi_error: Fix wrong statistic when print error info
  scsi: scsi_error: Fix device reset is not triggered
  scsi: scsi_core:  Fix IO hang when device removing

 drivers/scsi/scsi.c        | 43 +++++++++++++++++++++++++-------------
 drivers/scsi/scsi_error.c  |  4 ++--
 drivers/scsi/scsi_lib.c    |  2 +-
 include/scsi/scsi_device.h | 25 +++++++++++++++++++---
 4 files changed, 53 insertions(+), 21 deletions(-)

-- 
2.32.0

