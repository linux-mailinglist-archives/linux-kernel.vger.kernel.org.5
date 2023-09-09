Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C03799449
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbjIIAkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjIIAjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA026B6;
        Fri,  8 Sep 2023 17:39:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B05C116AB;
        Sat,  9 Sep 2023 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219933;
        bh=dt2mwOGXa0cMNQnao6lYQNoU77IMr97F4KWj+/TYbDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUlHy73jBKv01Aqj/YpiOYrKiXHVMrD42bFnh/9dVgPM1Nb+z6BzjDjZq3hTfEd2N
         +iNFAmTfG8CHpUPotxUcsBlS/qZMnKWaR38RtqR+6wDbevJMslImpaqocPU6vmZLfI
         vv3X6PYw73//UF1SS1ghZ9Acuxw5cpxsMfaTCzM9vHWcVQA04myTiYZIHqoD0/QHfx
         UOHZn26HFE79zgUA69Ilb5hSFPgPoYewxivtJBY/KgFNu1XU4OJXx2GpmTx6/vI0Xd
         GwZy+6lsZK8rfpp0LlgunVm8OeaS4BnztbWbtZja929Q3NR5EPMEzv+B3qWwrwPMox
         2eqqKb6EtIYtQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 17/24] misc: open-dice: make OPEN_DICE depend on HAS_IOMEM
Date:   Fri,  8 Sep 2023 20:38:09 -0400
Message-Id: <20230909003818.3580081-17-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003818.3580081-1-sashal@kernel.org>
References: <20230909003818.3580081-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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

[ Upstream commit aefc8b57af7787c80686e49a5841e9289cb11f53 ]

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let OPEN_DICE depend on HAS_IOMEM so that it won't be built
to cause below compiling error if PCI is unset:

------
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Derek Kiernan <derek.kiernan@amd.com>
Cc: Dragan Cvetic <dragan.cvetic@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20230707135852.24292-4-bhe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 358ad56f65245..0cef98319f0e5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -474,6 +474,7 @@ config HISI_HIKEY_USB
 config OPEN_DICE
 	tristate "Open Profile for DICE driver"
 	depends on OF_RESERVED_MEM
+	depends on HAS_IOMEM
 	help
 	  This driver exposes a DICE reserved memory region to userspace via
 	  a character device. The memory region contains Compound Device
-- 
2.40.1

