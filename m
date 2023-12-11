Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4680BF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjLKCcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjLKCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:32:10 -0500
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D0107;
        Sun, 10 Dec 2023 18:32:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4SpQHm5hrBz17N0Y;
        Mon, 11 Dec 2023 10:12:36 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id ADCF3140558;
        Mon, 11 Dec 2023 10:12:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:12:39 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 5/6] net: hns3: Add support for some CMIS transceiver modules
Date:   Mon, 11 Dec 2023 10:08:15 +0800
Message-ID: <20231211020816.69434-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231211020816.69434-1-shaojijie@huawei.com>
References: <20231211020816.69434-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Lan <lanhao@huawei.com>

Add two more SFF-8024 Identifier Values that according to the standard
support the Common Management Interface Specification (CMIS) memory map
so the hns3 driver will be able to dump, parse and print their EEPROM
contents.This two SFF-8024 Identifier Values are SFF8024_ID_QSFP_DD (0x18)
and SFF8024_ID_QSFP_PLUS_CMIS (0x1E).

Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 8 ++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 38e796f61475..eed6c6393801 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1819,6 +1819,14 @@ static int hns3_get_module_info(struct net_device *netdev,
 		modinfo->type = ETH_MODULE_SFF_8636;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
 		break;
+	case SFF8024_ID_QSFP_DD:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+		modinfo->type = ETH_MODULE_SFF_8636;
+		if (sfp_type.flat_mem & HNS3_CMIS_FLAT_MEMORY)
+			modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+		else
+			modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+		break;
 	default:
 		netdev_err(netdev, "Optical module unknown: %#x\n",
 			   sfp_type.type);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.h b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.h
index da207d1d9aa9..34504ed2c086 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.h
@@ -12,9 +12,11 @@ struct hns3_stats {
 	int stats_offset;
 };
 
+#define HNS3_CMIS_FLAT_MEMORY	BIT(7)
 struct hns3_sfp_type {
 	u8 type;
 	u8 ext_type;
+	u8 flat_mem;
 };
 
 struct hns3_pflag_desc {
-- 
2.30.0

