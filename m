Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A275E14A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGWKXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGWKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:23:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2809E6;
        Sun, 23 Jul 2023 03:22:57 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R7zqd2DXkzrRfn;
        Sun, 23 Jul 2023 18:22:05 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:22:54 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 00/13] scsi: Support LUN/target based error handle
Date:   Mon, 24 Jul 2023 07:44:09 +0800
Message-ID: <20230723234422.1629194-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The origin error handle would set host to recovery state and perform
error recovery operations, and makes all LUNs which share a same host
can not handle IOs. This phenomenon is unbearable for systems which
deploy many LUNs in one HBA.

This patchset introduce support for LUN/target based error handle,
drivers can chose if to implement it. They can implement LUN, target or
both of LUN and target based error handle by their own error handle
strategy. The first patch defined this framework, it abstract three
key operations which are: add error command, wake up error handle, block
ios when error command is added and recoverying. Drivers should
implement these three function callbacks and setup to SCSI middle level.

Besides the basic framework, this patchset also add a basic LUN/target
based error handle strategy.

For LUN based eh, it would try check sense, start unit and reset LUN,
if all above steps can not recovery all error commands, fallback to
further recovery like tartget based (if implemented) or host based error
handle.

It's same for tartget based eh, it would try check sense, start unit,
reset LUN and reset target. If all above steps can not recovery all error
commands, fallback to further recovery which is host based error handle.

This patchset is tested by scsi_debug which support single LUN error
injection, the scsi_debug patches is here:

https://lore.kernel.org/linux-scsi/20230723234105.1628982-1-haowenchao2@huawei.com/T/#t

Wenchao Hao (13):
  scsi: Define basic framework for driver LUN/target based error handle
  scsi:scsi_error: Move complete variable eh_action from shost to sdevice
  scsi:scsi_error: Check if to do reset in scsi_try_xxx_reset
  scsi:scsi_error: Add helper scsi_eh_sdev_stu to do START_UNIT
  scsi:scsi_error: Add helper scsi_eh_sdev_reset to do lun reset
  scsi:scsi_error: Add flags to mark error handle steps has done
  scsi:scsi_error: Define helper to perform LUN based error handle
  scsi:scsi_error: Add LUN based error handler based previous helper
  scsi:core: increase/decrease target_busy without check can_queue
  scsi:scsi_error: Define helper to perform target based error handle
  scsi:scsi_error: Add target based error handler based previous helper
  scsi:scsi_debug: Add param to control if setup LUN based error handle
  scsi:scsi_debug: Add param to control if setup target based error handle

 drivers/scsi/scsi_debug.c  |  19 +
 drivers/scsi/scsi_error.c  | 705 ++++++++++++++++++++++++++++++++++---
 drivers/scsi/scsi_lib.c    |  23 +-
 drivers/scsi/scsi_priv.h   |  20 ++
 include/scsi/scsi_device.h |  97 +++++
 include/scsi/scsi_eh.h     |   4 +
 include/scsi/scsi_host.h   |   2 -
 7 files changed, 813 insertions(+), 57 deletions(-)

-- 
2.35.3

