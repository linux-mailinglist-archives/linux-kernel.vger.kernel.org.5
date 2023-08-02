Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D976C55A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHBGhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHBGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:37:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90C9F122
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:37:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CBAFD75;
        Tue,  1 Aug 2023 23:37:48 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.53.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B8FC3F6C4;
        Tue,  1 Aug 2023 23:37:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: trbe: Directly use ID_AA64DFR0_EL1_TraceBuffer_IMP
Date:   Wed,  2 Aug 2023 12:06:58 +0530
Message-Id: <20230802063658.1069813-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_trbe_available() checks for the TRBE support via extracting TraceBuffer
field value from ID_AA64DFR0_EL1, and ensures that it is implemented. This
replaces the open encoding '0b0001' with 'ID_AA64DFR0_EL1_TraceBuffer_IMP'
which is now available via sysreg tools. Functional change is not intended.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 94e67009848a..ebb9108d8e24 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -24,7 +24,7 @@ static inline bool is_trbe_available(void)
 	unsigned int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0,
 								 ID_AA64DFR0_EL1_TraceBuffer_SHIFT);
 
-	return trbe >= 0b0001;
+	return trbe >= ID_AA64DFR0_EL1_TraceBuffer_IMP;
 }
 
 static inline bool is_trbe_enabled(void)
-- 
2.25.1

