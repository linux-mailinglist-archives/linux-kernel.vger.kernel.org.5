Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E6783F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjHVLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjHVLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:32:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775DFCE7;
        Tue, 22 Aug 2023 04:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5323E652C0;
        Tue, 22 Aug 2023 11:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC5C433D9;
        Tue, 22 Aug 2023 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703941;
        bh=KsOKHiygKpqL3JfDSmiPSy4RSTpplxLAURixhu/LNgA=;
        h=From:To:Cc:Subject:Date:From;
        b=etU2YWjxcaBBfoDte9X+PChSHeEqKS/M6IUPn172r2RfeivgA6ZXQmoVlS22PIrOQ
         aKShA+XK/fMlLfYCnH1xwNamXkkdLZjA9/m8UdKdpT1i9IMKi8dSEo2wuJ7Gs6F6Fr
         0+rq+Wwyx5mBkrJBLA9gffYC5cBWoZcA/7vE0QKGU0CiODpgtNe3L2ZaplaG5eyaSd
         UNZpDc6jguv9bu1sdTVFtAoSguUJ8dxGKdwx3/Afsa/m5/HQkR19dzBjbv4cY1O8hq
         wSwlVViajwt++N9u0ujj9ulThveoG0SZAuUBuPPzE85KHwK6MWzENAM5yQhhSMLoPh
         7PTJvgURejTCQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 1/3] clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
Date:   Tue, 22 Aug 2023 07:32:16 -0400
Message-Id: <20230822113218.3550311-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.254
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
index cc871ae3a1792..5b34dbc830ee4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -302,6 +302,7 @@ config COMMON_CLK_BD718XX
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
 	depends on COMMON_CLK && OF
+	depends on HAS_IOMEM
 	help
 	  Support for Memory Mapped IO Fixed clocks
 
-- 
2.40.1

