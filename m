Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0962C77B99E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjHNNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHNNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:19:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FD12D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:19:01 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPZh54wBcz1GDKj;
        Mon, 14 Aug 2023 21:17:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 21:18:59 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <liliang6@email.cn>,
        <21cnbao@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH v2] perf/smmuv3: Add MODULE_ALIAS for module auto loading
Date:   Mon, 14 Aug 2023 21:16:42 +0800
Message-ID: <20230814131642.65263-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

On my ACPI based arm64 server, if the SMMUv3 PMU is configured as
module it won't be loaded automatically after booting even if the
device has already been scanned and added. It's because the module
lacks a platform alias, the uevent mechanism and userspace tools
like udevd make use of this to find the target driver module of the
device. This patch adds the missing platform alias of the module,
then module will be loaded automatically if device exists.

Before this patch:
[root@localhost tmp]# modinfo arm_smmuv3_pmu | grep alias
alias:          of:N*T*Carm,smmu-v3-pmcgC*
alias:          of:N*T*Carm,smmu-v3-pmcg

After this patch:
[root@localhost tmp]# modinfo arm_smmuv3_pmu | grep alias
alias:          platform:arm-smmu-v3-pmcg
alias:          of:N*T*Carm,smmu-v3-pmcgC*
alias:          of:N*T*Carm,smmu-v3-pmcg

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- Further illustrate the issues and how to fix this
- Use MODULE_ALIAS instead of MODULE_DEVICE_TABLE
Link: https://lore.kernel.org/all/20230807122233.28563-1-yangyicong@huawei.com/

 drivers/perf/arm_smmuv3_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 25a269d431e4..4c32b6dbfe76 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -984,6 +984,7 @@ static void __exit arm_smmu_pmu_exit(void)
 
 module_exit(arm_smmu_pmu_exit);
 
+MODULE_ALIAS("platform:arm-smmu-v3-pmcg");
 MODULE_DESCRIPTION("PMU driver for ARM SMMUv3 Performance Monitors Extension");
 MODULE_AUTHOR("Neil Leeder <nleeder@codeaurora.org>");
 MODULE_AUTHOR("Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>");
-- 
2.24.0

