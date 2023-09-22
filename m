Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF807AAE08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjIVJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjIVJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:29:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A6E6F;
        Fri, 22 Sep 2023 02:29:34 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RsRhf6r1vzMln8;
        Fri, 22 Sep 2023 17:25:54 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:29:31 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v5 00/10] scsi:scsi_debug: Add error injection for single device
Date:   Fri, 22 Sep 2023 17:28:56 +0800
Message-ID: <20230922092906.2645265-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The original error injection mechanism was based on scsi_host which
could not inject fault for a single SCSI device.

This patchset provides the ability to inject errors for a single
SCSI device. Now we supports inject timeout errors, queuecommand
errors, and hostbyte, driverbyte, statusbyte, and sense data for
specific SCSI Command. Two new error injection is defined to make
abort command or reset LUN failed.

Besides error injection for single device, this patchset add a
new interface to make reset target failed for each scsi_target.

The first two patch add an debugfs interface to add and inquiry single
device's error injection info; the third patch defined how to remove
an injection which has been added. The following 5 patches use the
injection info and generate the related error type. The last one just
Add a new interface to make reset target failed.

V5:
  - Using rcu list to sync between error inject add, remove and check
  - Add module parameter "allow_restart" to control scsi_device's
    allow_restart flag

V4:
  - Fix BUG_ON triggered by schedule in atomic context when rmmod scsi_debug
    Closes: https://lore.kernel.org/oe-lkp/202308031027.5941ce5f-oliver.sang@intel.com

V3:
  - Add two more error types to fail abort command and lun reset
  - Fix memleak when rmmod scsi_debug without clearing errors injected
  - Fix memkeak because did not implement release in sdebug_error_fops
  - Fix possible NULL point access in scsi_debug_slave_destroy
  - Move specific error type's description to each single patch which
    implement this error type
  - Add interface to make target reset fail

V2:
  - Using debugfs rather than sysfs attribute interface to manage error

Wenchao Hao (10):
  scsi: scsi_debug: create scsi_debug directory in the debugfs
    filesystem
  scsi: scsi_debug: Add interface to manage single device's error inject
  scsi: scsi_debug: Define grammar to remove added error injection
  scsi: scsi_debug: timeout command if the error is injected
  scsi: scsi_debug: Return failed value if the error is injected
  scsi: scsi_debug: set command's result and sense data if the error is
    injected
  scsi: scsi_debug: Add new error injection abort failed
  scsi: scsi_debug: Add new error injection reset lun failed
  scsi: scsi_debug: Add debugfs interface to fail target reset
  scsi: scsi_debug: Add param to control sdev's allow_restart

 drivers/scsi/scsi_debug.c | 557 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 552 insertions(+), 5 deletions(-)

-- 
2.32.0

