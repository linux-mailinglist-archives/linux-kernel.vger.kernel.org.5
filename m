Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A957F07D8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjKSQ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjKSQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:59:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A4B110C0;
        Sun, 19 Nov 2023 08:58:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 528181477;
        Sun, 19 Nov 2023 08:59:34 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2807D3F6C4;
        Sun, 19 Nov 2023 08:58:43 -0800 (PST)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 13/27] arm64: mte: Make tag storage depend on ARCH_KEEP_MEMBLOCK
Date:   Sun, 19 Nov 2023 16:57:07 +0000
Message-Id: <20231119165721.9849-14-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
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

Tag storage memory requires that the tag storage pages used for data are
always migratable when they need to be repurposed to store tags.

If ARCH_KEEP_MEMBLOCK is enabled, kexec will scan all non-reserved
memblocks to find a suitable location for copying the kernel image. The
kernel image, once loaded, cannot be moved to another location in physical
memory. The initialization code for the tag storage reserves the memblocks
for the tag storage pages, which means kexec will not use them, and the tag
storage pages can be migrated at any time, which is the desired behaviour.

However, if ARCH_KEEP_MEMBLOCK is not selected, kexec will not skip a
region unless the memory resource has the IORESOURCE_SYSRAM_DRIVER_MANAGED
flag, which isn't currently set by the tag storage initialization code.

Make ARM64_MTE_TAG_STORAGE depend on ARCH_KEEP_MEMBLOCK to make it explicit
that that the Kconfig option required for it to work correctly.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 047487046e8f..efa5b7958169 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2065,6 +2065,7 @@ config ARM64_MTE
 if ARM64_MTE
 config ARM64_MTE_TAG_STORAGE
 	bool "Dynamic MTE tag storage management"
+	depends on ARCH_KEEP_MEMBLOCK
 	select CONFIG_CMA
 	help
 	  Adds support for dynamic management of the memory used by the hardware
-- 
2.42.1

