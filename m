Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6412C7993D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbjIIAiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbjIIAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4C826A3;
        Fri,  8 Sep 2023 17:37:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC80C43215;
        Sat,  9 Sep 2023 00:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219801;
        bh=N1pcWlOYqiveziN0IOp5nLZqzPGbOe9ls13Mam/I8lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIispxQCHkYFFGAYMpOFxAHFdvglID+XlaZJIIG3RomGB4GLZGcuk1y1XnItDUDJM
         XXCUXEOJBctR4lB44ppsGWi/OBQ0+fKW0phTlnse8QCwBe8bgZ3QELflAcrX2Kooyp
         nmbBW8iP89u8LcV82Cp8k6LK78QJ0zcpWVtW1fsrwIxLFXKAkrDdWwqmAVkM4Fuwf8
         oKNHFfjDtFrZxzQtTWsHsh00ZQUIqlB4aeeoGTPJXxCLhi+6MKXoKk9DDQfxt2FauG
         /CY1iWuf/jMJc0wiJdw0DvULPvpxrkkDnEtvgkIGOLKYeU8/4H6WWo8tehWnXCD5qh
         6k3BI5rjS6+cQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.5 18/28] misc: open-dice: make OPEN_DICE depend on HAS_IOMEM
Date:   Fri,  8 Sep 2023 20:35:52 -0400
Message-Id: <20230909003604.3579407-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003604.3579407-1-sashal@kernel.org>
References: <20230909003604.3579407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
index 75e427f124b28..cadd4a820c033 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -496,6 +496,7 @@ config HISI_HIKEY_USB
 config OPEN_DICE
 	tristate "Open Profile for DICE driver"
 	depends on OF_RESERVED_MEM
+	depends on HAS_IOMEM
 	help
 	  This driver exposes a DICE reserved memory region to userspace via
 	  a character device. The memory region contains Compound Device
-- 
2.40.1

