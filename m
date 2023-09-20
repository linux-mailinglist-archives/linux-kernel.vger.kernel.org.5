Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748687A7326
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjITGuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjITGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:50:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D58AD;
        Tue, 19 Sep 2023 23:50:23 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rr8Fz1Yb8zMlgF;
        Wed, 20 Sep 2023 14:46:47 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 14:50:21 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <sudeep.holla@arm.com>, <xuwei5@hisilicon.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 2/2] soc: kunpeng_hccs: add the check for PCC subspace type
Date:   Wed, 20 Sep 2023 14:47:03 +0800
Message-ID: <20230920064703.23543-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230920064703.23543-1-lihuisong@huawei.com>
References: <20230914115753.9064-1-lihuisong@huawei.com>
 <20230920064703.23543-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, HCCS driver directly uses Generic Communications Channel Shared
Memory Region which is used in type0/1/2 to communicate with platform,
but actually doesn't support type3/4/5.
So this patch adds the check for PCC subspace type.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index f3810d9d1caa..4ba3bfd45a01 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -174,6 +174,19 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	return rc;
 }
 
+static int hccs_check_pcc_info(struct hccs_dev *hdev)
+{
+	struct pcc_mbox_chan *pcc_chan = hdev->cl_info.pcc_chan;
+
+	if (pcc_chan->type >= ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE) {
+		dev_err(hdev->dev, "unsupport for subspace type%u.\n",
+			pcc_chan->type);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
@@ -1224,6 +1237,10 @@ static int hccs_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = hccs_check_pcc_info(hdev);
+	if (rc)
+		goto unregister_pcc_chan;
+
 	rc = hccs_get_dev_caps(hdev);
 	if (rc)
 		goto unregister_pcc_chan;
-- 
2.33.0

