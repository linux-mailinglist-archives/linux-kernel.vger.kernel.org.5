Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4490F80F9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377588AbjLLVsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjLLVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:48:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA4B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:48:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616BEC433C7;
        Tue, 12 Dec 2023 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702417729;
        bh=BPAdG+oACXLZR8/adiQ5gMuFjpTAdv8WeoWfNUPMLGs=;
        h=From:To:Cc:Subject:Date:From;
        b=tIfrdAcFA7VhDmw1ujVQSY0BkueuygHvl6NJMj3NNfyft50rA+tKCoi9lO4beB4+r
         l45CQ2WVFiW0Nyx+Pidlls+qP3E3NRTTwdsfjKnm+QnI2hzHO4nKKRJM3ebUeah2r8
         inwoqJCWg+oY7INHYk5ex19Wi+bgg3TnwwlvJFm24A7c7P2XW43zGrumH0MOdi9eUB
         bzwHZILIVbNE+urUkkqB+uEZhcdpsn5aHVg2x/be/gGTfJTarycnyISGxPd04xD5Vz
         htSoG00k3vpD+zPZBrUVe4F54Fh1KhrZOAxvr0bRkzhroIdqnYO2s2JyjafwR1IjHP
         txJf8HjxmhYtA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: arm64: export acpi_arch_thermal_cpufreq_pctg
Date:   Tue, 12 Dec 2023 22:48:38 +0100
Message-Id: <20231212214843.256622-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The cpufreq code can be in a loadable module, so the architecture support
for it has to be exported:

ERROR: modpost: "acpi_arch_thermal_cpufreq_pctg" [drivers/acpi/processor.ko] undefined!

Fixes: 310293a2b941 ("ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/arm64/thermal_cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
index d524f2cd6044..582854914c5c 100644
--- a/drivers/acpi/arm64/thermal_cpufreq.c
+++ b/drivers/acpi/arm64/thermal_cpufreq.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/acpi.h>
+#include <linux/export.h>
 
 #include "../internal.h"
 
@@ -18,3 +19,4 @@ int acpi_arch_thermal_cpufreq_pctg(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(acpi_arch_thermal_cpufreq_pctg);
-- 
2.39.2

