Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45F7E635D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjKIFqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjKIFp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:45:56 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5020271C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:45:49 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SQrSp732kz1P85Y;
        Thu,  9 Nov 2023 13:42:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 13:45:11 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 2/3] soc: hisilicon: kunpeng_hccs: Add failure log for no _CRS method
Date:   Thu, 9 Nov 2023 13:45:25 +0800
Message-ID: <20231109054526.27270-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231109054526.27270-1-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver gets the PCC channel id by using the PCC GAS in _CRS.
But, currently, if the firmware has no _CRS method on platform, there
is not any failure log. So this patch adds the log for this.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index dad6235dbf1a..fd3ca0eb8175 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -85,8 +85,10 @@ static int hccs_get_pcc_chan_id(struct hccs_dev *hdev)
 	struct hccs_register_ctx ctx = {0};
 	acpi_status status;
 
-	if (!acpi_has_method(handle, METHOD_NAME__CRS))
+	if (!acpi_has_method(handle, METHOD_NAME__CRS)) {
+		dev_err(hdev->dev, "No _CRS method.\n");
 		return -ENODEV;
+	}
 
 	ctx.dev = hdev->dev;
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-- 
2.33.0

