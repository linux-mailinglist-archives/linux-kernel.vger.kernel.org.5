Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6033E765865
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjG0QPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjG0QPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5002728
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC76B61E91
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C52C433C8;
        Thu, 27 Jul 2023 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474532;
        bh=7KNn7rpXw7ac66DODCRLJOwlmnWa2JU1UYOfQjnlV6c=;
        h=From:To:Cc:Subject:Date:From;
        b=JG33lR5+0OHRlzULPn660n4AbtENQnusIBb+FTjjBqxVrOWH7c35Bk08uVaNc3KVc
         Z8Qi9rPQ0umscUBd6XfeiBld9PKZuzbIO2l1zTAeL5XUiaBFeN+GBSRTbkzeATEnoB
         8F31rPN4Rk9GThyd6folVj1EEbePHNorW52Ue1zc3hsULePJDA9WsUU4GSvLYO2BPr
         g8cimU/O1qQqcAQkVYkCbxRKUQitC3PloPf+DEOnDq+YZm91ZOPO/y2eyhWiNdUXlt
         oKf3M3fTC+T4Qu2EQXfzAATM154Tbcfmmz3dqCp0Qm+CDOeiQAYph0xrCHkz5WgtA+
         1JXn599RHtEpQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: enable DEBUG_FORCE_FUNCTION_ALIGN_64B
Date:   Fri, 28 Jul 2023 00:03:56 +0800
Message-Id: <20230727160356.3874-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to force all function address 64B aligned as it is possible for
other architectures. This may be useful when verify if performance
bump is caused by function alignment changes.

Before commit 1bf18da62106 ("lib/Kconfig.debug: add ARCH dependency
for FUNCTION_ALIGN option"), riscv supports enabling the
DEBUG_FORCE_FUNCTION_ALIGN_64B option, but after that commit, each
arch needs to claim the support explicitly. I tried the config file in
[1] for both RV64 and RV32, I can't reproduce the build error as [1],
there is no reason for not allowing to enforce this function alignment.

Link: https://lore.kernel.org/lkml/202202271612.W32UJAj2-lkp@intel.com/ [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fbc89baf7de6..39ffd218e960 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -502,7 +502,7 @@ config SECTION_MISMATCH_WARN_ONLY
 
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
 	bool "Force all function address 64B aligned"
-	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC || S390)
+	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC || RISCV || S390)
 	select FUNCTION_ALIGNMENT_64B
 	help
 	  There are cases that a commit from one domain changes the function
-- 
2.40.1

