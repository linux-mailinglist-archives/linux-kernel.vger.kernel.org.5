Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57D57C4FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbjJKKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjJKKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5871BFB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:07:54 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S57dk41hpzkYBH;
        Wed, 11 Oct 2023 18:03:54 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:07:51 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <broonie@kernel.org>,
        <anshuman.khandual@arm.com>, <alexandru.elisei@arm.com>,
        <sashal@kernel.org>, <maz@kernel.org>,
        <gregkh@linuxfoundation.org>, <james.morse@arm.com>,
        <pcc@google.com>, <scott@os.amperecomputing.com>,
        <ebiederm@xmission.com>, <haibinzhang@tencent.com>,
        <hewenliang4@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.15 15/15] arm64: armv8_deprecated: fix unused-function error
Date:   Wed, 11 Oct 2023 10:06:55 +0000
Message-ID: <20231011100655.979626-16-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100655.979626-1-ruanjinjie@huawei.com>
References: <20231011100655.979626-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ren Zhijie <renzhijie2@huawei.com>

commit 223d3a0d30b6e9f979f5642e430e1753d3e29f89 upstream.

If CONFIG_SWP_EMULATION is not set and
CONFIG_CP15_BARRIER_EMULATION is not set,
aarch64-linux-gnu complained about unused-function :

arch/arm64/kernel/armv8_deprecated.c:67:21: error: ‘aarch32_check_condition’ defined but not used [-Werror=unused-function]
 static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
                     ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

To fix this warning, modify aarch32_check_condition() with __maybe_unused.

Fixes: 0c5f416219da ("arm64: armv8_deprecated: move aarch32 helper earlier")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20221124022429.19024-1-renzhijie2@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 758008020b59..91eabe56093d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -64,7 +64,7 @@ struct insn_emulation {
 
 #define	ARM_OPCODE_CONDITION_UNCOND	0xf
 
-static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
+static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
 {
 	u32 cc_bits  = opcode >> 28;
 
-- 
2.34.1

