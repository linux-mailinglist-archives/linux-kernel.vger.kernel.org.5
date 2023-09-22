Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDCC7AAE50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjIVJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjIVJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:37:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533F192;
        Fri, 22 Sep 2023 02:37:00 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RsRty3PB1z15NP6;
        Fri, 22 Sep 2023 17:34:50 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:36:58 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 1/2] scsi: core: scsi_device_online() return false if state is SDEV_CANCEL
Date:   Fri, 22 Sep 2023 17:36:35 +0800
Message-ID: <20230922093636.2645961-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230922093636.2645961-1-haowenchao2@huawei.com>
References: <20230922093636.2645961-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDEV_CANCEL is set when removing device and scsi_device_online() should
return false if sdev_state is SDEV_CANCEL.

IO hang would be caused if return true when state is SDEV_CANCEL with
following order:

T1:					    T2:scsi_error_handler
__scsi_remove_device()
  scsi_device_set_state(sdev, SDEV_CANCEL)
  					    scsi_eh_flush_done_q()
					    if (scsi_device_online(sdev))
					      scsi_queue_insert(scmd,...)

The command added by scsi_queue_insert() would never be handled any
more.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 include/scsi/scsi_device.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 75b2235b99e2..c498a12f7715 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -517,7 +517,8 @@ static inline int scsi_device_online(struct scsi_device *sdev)
 {
 	return (sdev->sdev_state != SDEV_OFFLINE &&
 		sdev->sdev_state != SDEV_TRANSPORT_OFFLINE &&
-		sdev->sdev_state != SDEV_DEL);
+		sdev->sdev_state != SDEV_DEL &&
+		sdev->sdev_state != SDEV_CANCEL);
 }
 static inline int scsi_device_blocked(struct scsi_device *sdev)
 {
-- 
2.32.0

