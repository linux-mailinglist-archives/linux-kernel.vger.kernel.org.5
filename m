Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7746800837
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378277AbjLAKax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378239AbjLAKat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:30:49 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C572F1;
        Fri,  1 Dec 2023 02:30:54 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ShTpf6jrszvRN7;
        Fri,  1 Dec 2023 18:30:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 18:30:52 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/2] net: hns: fix fake link up on xge port
Date:   Fri, 1 Dec 2023 18:27:03 +0800
Message-ID: <20231201102703.4134592-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231201102703.4134592-1-shaojijie@huawei.com>
References: <20231201102703.4134592-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
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

From: Yonglong Liu <liuyonglong@huawei.com>

If a xge port just connect with an optical module and no fiber,
it may have a fake link up because there may be interference on
the hardware. This patch adds an anti-shake to avoid the problem.
And the time of anti-shake is base on tests.

Fixes: b917078c1c10 ("net: hns: Add ACPI support to check SFP present")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 928d934cb21a..3d923756e439 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -66,6 +66,26 @@ static enum mac_mode hns_get_enet_interface(const struct hns_mac_cb *mac_cb)
 	}
 }
 
+void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
+{
+#define HNS_MAC_LINK_WAIT_TIME 5
+#define HNS_MAC_LINK_WAIT_CNT 40
+
+	int i;
+
+	if (!mac_ctrl_drv->get_link_status) {
+		*link_status = 0;
+		return;
+	}
+
+	for (i = 0; i < HNS_MAC_LINK_WAIT_CNT; i++) {
+		msleep(HNS_MAC_LINK_WAIT_TIME);
+		mac_ctrl_drv->get_link_status(mac_ctrl_drv, link_status);
+		if (!*link_status)
+			break;
+	}
+}
+
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 {
 	struct mac_driver *mac_ctrl_drv;
@@ -83,6 +103,14 @@ void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 							       &sfp_prsnt);
 		if (!ret)
 			*link_status = *link_status && sfp_prsnt;
+
+		/* for FIBER port, it may have a fake link up.
+		 * when the link status changes from down to up, we need to do
+		 * anti-shake. the anti-shake time is base on tests.
+		 * only FIBER port need to do this.
+		 */
+		if (*link_status && !mac_cb->link)
+			hns_mac_link_anti_shake(mac_ctrl_drv, link_status);
 	}
 
 	mac_cb->link = *link_status;
-- 
2.30.0

