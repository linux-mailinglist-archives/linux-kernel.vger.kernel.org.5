Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BB7AAE60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjIVJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjIVJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:39:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A91D1A8;
        Fri, 22 Sep 2023 02:39:08 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RsRvj2s01zMlmt;
        Fri, 22 Sep 2023 17:35:29 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:39:06 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 2/2] scsi: Add comment of target_destroy in scsi_host_template
Date:   Fri, 22 Sep 2023 17:38:42 +0800
Message-ID: <20230922093842.2646157-3-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230922093842.2646157-1-haowenchao2@huawei.com>
References: <20230922093842.2646157-1-haowenchao2@huawei.com>
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

Add comment to tell callback function target_destroy of
scsi_host_template is called in atomic context.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 include/scsi/scsi_host.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 49f768d0ff37..a72248fa5adf 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -245,6 +245,9 @@ struct scsi_host_template {
 	 * midlayer calls this point so that the driver may deallocate
 	 * and terminate any references to the target.
 	 *
+	 * Note: this callback in called with spin_lock held, so donot
+	 * call functions might cause schedule
+	 *
 	 * Status: OPTIONAL
 	 */
 	void (* target_destroy)(struct scsi_target *);
-- 
2.32.0

