Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505737AAE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjIVJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjIVJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:37:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF4199;
        Fri, 22 Sep 2023 02:36:59 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RsRtx0WslzrRtM;
        Fri, 22 Sep 2023 17:34:49 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:36:57 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 0/2] Fix two issue between removing device and error handle
Date:   Fri, 22 Sep 2023 17:36:34 +0800
Message-ID: <20230922093636.2645961-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
injection patches, and found two issue when removing device and
error handler happened together.

The first patch fix IO hang because scsi_eh_flush_done_q() would
retry command if the device is in SDEV_CANCEL state;

The second patch fix the issue which device's eh_device_reset_handler
not called in recovery when device is in removing progress.

Wenchao Hao (2):
  scsi: core: scsi_device_online() return false if state is SDEV_CANCEL
  scsi: scsi_error: Fix device reset is not triggered

 drivers/infiniband/ulp/srp/ib_srp.c         |  2 +-
 drivers/message/fusion/mptctl.c             |  6 ++--
 drivers/message/fusion/mptsas.c             |  8 ++---
 drivers/message/fusion/mptspi.c             |  6 ++--
 drivers/s390/scsi/zfcp_fsf.c                |  4 +--
 drivers/s390/scsi/zfcp_scsi.c               |  2 +-
 drivers/scsi/arm/acornscsi.c                |  2 +-
 drivers/scsi/arm/fas216.c                   |  4 +--
 drivers/scsi/bfa/bfad_im.c                  |  4 +--
 drivers/scsi/ibmvscsi/ibmvfc.c              |  2 +-
 drivers/scsi/lpfc/lpfc_scsi.c               |  4 +--
 drivers/scsi/megaraid/megaraid_sas_base.c   |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c          |  4 +--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 16 ++++-----
 drivers/scsi/myrb.c                         |  2 +-
 drivers/scsi/myrs.c                         |  2 +-
 drivers/scsi/scsi.c                         | 37 ++++++++++++---------
 drivers/scsi/scsi_debug.c                   |  2 +-
 drivers/scsi/scsi_error.c                   | 12 +++----
 drivers/scsi/scsi_lib.c                     |  6 ++--
 drivers/scsi/scsi_scan.c                    |  2 +-
 drivers/scsi/scsi_transport_srp.c           |  2 +-
 drivers/scsi/ses.c                          |  2 +-
 drivers/scsi/storvsc_drv.c                  |  2 +-
 drivers/scsi/virtio_scsi.c                  |  2 +-
 drivers/ufs/core/ufshcd.c                   |  4 +--
 include/scsi/scsi_device.h                  | 15 ++++++---
 28 files changed, 85 insertions(+), 73 deletions(-)

-- 
2.32.0

