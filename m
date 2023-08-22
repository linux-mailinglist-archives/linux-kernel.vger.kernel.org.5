Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F7A783F03
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjHVLco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjHVLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A213E63;
        Tue, 22 Aug 2023 04:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDC365257;
        Tue, 22 Aug 2023 11:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD772C433C8;
        Tue, 22 Aug 2023 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703929;
        bh=1py0y39GPE7PL6VgFa1+mZiwMR1bB5ccoSWup0ZTgnA=;
        h=From:To:Cc:Subject:Date:From;
        b=eBVan6nT8786LVTGb/dmJXZ8KFuzBapA6yX9pahPw/+5ZasuGibUAtQBBXJJIf1km
         limS/1vsAvWjj1d4kuXgKA9NiIR0NXXPOw4Nn5K/4E+2FKdp1+1HVZJjIXplKfdn/r
         7Rhpv5hkNLxSwgGX7ycy2BnbeEsL/W7Bd1TwBoAf/BmUHFEZU60XWdWqumTUIFp/fH
         UTls0ZDj+6PB4pA8kE7jQ9Icj+c2dtAamUGhWexZRWslMb0ZemA0Ls5PchQKytUaUN
         fOLr5mcdo42bOr+92Lg7VTEpRitUF05evlijE2HLFxdY0brSEDKTC9yWVH3PG5GsrF
         H2Ppo0bPpJgZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 1/4] clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
Date:   Tue, 22 Aug 2023 07:32:03 -0400
Message-Id: <20230822113207.3550238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.191
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baoquan He <bhe@redhat.com>

[ Upstream commit e7dd44f4f3166db45248414f5df8f615392de47a ]

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM so that it won't
be built to cause below compiling error if PCI is unset:

------
ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
clk-fixed-mmio.c:(.text+0x5e): undefined reference to `of_iomap'
ld: clk-fixed-mmio.c:(.text+0xba): undefined reference to `iounmap'
------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Link: https://lore.kernel.org/r/20230707135852.24292-8-bhe@redhat.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4ae49eae45869..df739665f2063 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -356,6 +356,7 @@ config COMMON_CLK_BD718XX
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
 	depends on COMMON_CLK && OF
+	depends on HAS_IOMEM
 	help
 	  Support for Memory Mapped IO Fixed clocks
 
-- 
2.40.1

