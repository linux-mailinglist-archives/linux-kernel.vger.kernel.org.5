Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB8E80BF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjLKCW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKCW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:22:57 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B314BD;
        Sun, 10 Dec 2023 18:23:03 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SpQWh22NYz14M0c;
        Mon, 11 Dec 2023 10:22:56 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id 3E321180069;
        Mon, 11 Dec 2023 10:23:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:23:00 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <mkubecek@suse.cz>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <lanhao@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH ethtool] net: ethtool: Add default branch to sff8636_show_all_ioctl switch
Date:   Mon, 11 Dec 2023 10:18:21 +0800
Message-ID: <20231211021821.110467-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
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

The current sff8636_show_all_ioctl code uses a switch statement
to determine the module type, and exits directly with a return statement
when a match is found. However, when the module type cannot be matched,
the sff8636_memory_map_init_buf and sff8636_show_all_common functions
are executed. This writing style is not intuitive enough.
Therefore, this patch adding a default branch in the switch statement
to improve the readability of the code.

Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 qsfp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index eedf688..a2921fb 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -985,11 +985,12 @@ void sff8636_show_all_ioctl(const __u8 *id, __u32 eeprom_len)
 	case SFF8024_ID_SFP_DD_CMIS:
 	case SFF8024_ID_SFP_PLUS_CMIS:
 		cmis_show_all_ioctl(id);
-		return;
+		break;
+	default:
+		sff8636_memory_map_init_buf(&map, id, eeprom_len);
+		sff8636_show_all_common(&map);
+		break;
 	}
-
-	sff8636_memory_map_init_buf(&map, id, eeprom_len);
-	sff8636_show_all_common(&map);
 }
 
 static void sff8636_request_init(struct ethtool_module_eeprom *request, u8 page,
-- 
2.30.0

