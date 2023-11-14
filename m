Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698417EB062
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjKNM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjKNM5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:57:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730F131;
        Tue, 14 Nov 2023 04:57:07 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5mX4rsVz6JB1b;
        Tue, 14 Nov 2023 20:52:28 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:57:04 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
        <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
        <rientjes@google.com>, <jiaqiyan@google.com>,
        <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <"pgonda@pgonda"@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 3/6] memory: scrub: Add function to show scrub attributes in decimal
Date:   Tue, 14 Nov 2023 20:56:44 +0800
Message-ID: <20231114125648.1146-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231114125648.1146-1-shiju.jose@huawei.com>
References: <20231114125648.1146-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add function to show scrub control attributes to the user
in decimal.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/memory/scrub/memory-scrub.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/scrub/memory-scrub.c b/drivers/memory/scrub/memory-scrub.c
index b3011e7cd062..ff5b4a52d2da 100755
--- a/drivers/memory/scrub/memory-scrub.c
+++ b/drivers/memory/scrub/memory-scrub.c
@@ -130,6 +130,20 @@ static ssize_t scrub_attr_show(struct device *dev,
 	u64 val;
 	struct scrub_device_attribute *hattr = to_scrub_attr(devattr);
 
+	ret = hattr->ops->read(dev, hattr->attr, hattr->region_id, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%lld\n", val);
+}
+
+static ssize_t scrub_attr_show_hex(struct device *dev,
+				   struct device_attribute *devattr, char *buf)
+{
+	int ret;
+	u64 val;
+	struct scrub_device_attribute *hattr = to_scrub_attr(devattr);
+
 	ret = hattr->ops->read(dev, hattr->attr, hattr->region_id, &val);
 	if (ret < 0)
 		return ret;
@@ -236,8 +250,12 @@ static struct attribute *scrub_genattr(const void *drvdata,
 	hattr->region_id = region_id;
 
 	dattr = &hattr->dev_attr;
-	dattr->show = is_string ? scrub_attr_show_string : scrub_attr_show;
-	dattr->store = is_hex ? scrub_attr_store_hex : scrub_attr_store;
+	if (is_string) {
+		dattr->show = scrub_attr_show_string;
+	} else {
+		dattr->show = is_hex ? scrub_attr_show_hex : scrub_attr_show;
+		dattr->store = is_hex ? scrub_attr_store_hex : scrub_attr_store;
+	}
 
 	a = &dattr->attr;
 	sysfs_attr_init(a);
-- 
2.34.1

