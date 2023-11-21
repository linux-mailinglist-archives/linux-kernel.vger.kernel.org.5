Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E77F28F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjKUJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjKUJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:29:32 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4929123
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:29:24 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SZJrw6gJ3z1P8k5;
        Tue, 21 Nov 2023 17:25:52 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 17:29:20 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <jonathan.cameron@huawei.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/4] arch_topology: Support SMT control for OF based system
Date:   Tue, 21 Nov 2023 17:26:00 +0800
Message-ID: <20231121092602.47792-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231121092602.47792-1-yangyicong@huawei.com>
References: <20231121092602.47792-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

On building the topology from the devicetree, we've already
gotten the SMT thread number of each core. Update the largest
SMT thread number to enable the SMT control.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/base/arch_topology.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 3ed6bdf9460e..252a436e0c1b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -526,6 +526,13 @@ static int __init parse_core(struct device_node *core, int package_id,
 		i++;
 	} while (t);
 
+	/*
+	 * We've already gotten threads number in this core, update the SMT
+	 * threads number when necessary.
+	 */
+	if (i > topology_smt_get_num_threads())
+		topology_smt_set_num_threads(i);
+
 	cpu = get_cpu_for_node(core);
 	if (cpu >= 0) {
 		if (!leaf) {
-- 
2.24.0

