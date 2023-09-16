Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0027A2EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbjIPJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjIPJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:11:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F30173B;
        Sat, 16 Sep 2023 02:11:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BF3C433C8;
        Sat, 16 Sep 2023 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694855491;
        bh=NwSx+V/Cu+eKysd1GiNut197AabZGnY2SMY7krJafgo=;
        h=From:To:Cc:Subject:Date:From;
        b=hU6Wcb0cAjnVRO1p6MA3ztx8XY5zWcx6nPnHBEC6/ZKkXkiCNpAXuEluhkDAtyk5q
         OHnGArj2Zvlf5DVFhhiRqhNo6W01AHcBfHciz7pXDfXmg3a+063gc4YaWYCQ4Cu3Mt
         BZQz2xsHvKylTf4paSBlpwbKwtwpdKqVElIabfYyA6JQUlT7BggBtYYaDNwtRdNRTW
         qxnwIQvqQxjR1L3mE1YhkygTS3EhUQWpp+BD+3z6K3W1LPBVSqTj9+pk7RHwLF8AnW
         DhhQt7LO37/mWig/wMlV4GuYZcRlo+iFg8xpwrApQ4hUDgx3stfZ43WFlpVA3b8L1x
         V3KkHPPQCLbEg==
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Subject: [RFC PATCH 0/2] vlynq: remove bus support
Date:   Sat, 16 Sep 2023 11:11:22 +0200
Message-Id: <20230916091125.3221-1-wsa@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

I'd like to clean up the 'drivers' directory and Kconfig menu, at least
a little. One major thing I noticed is that VLYNQ can actually be
removed. From patch 2:

---
There are no users with a vlynq_driver in the Kernel tree. So, remove
the bus driver which hardly has seen any activity since 2009. It was
even marked EXPERIMENTAL as long as that symbol existed. OpenWRT had
some out-of-tree drivers which they probably intended to upport, but AR7
devices are not supported anymore because they are "stuck with Kernel
3.18" [1]. So, this code can go nowadays.

[1] https://openwrt.org/docs/techref/targets/ar7
---

Patch 1 removes MIPS specific bus initialization code which is the only
user of the VLYNQ bus currently.

Sending out as RFC to gather comments. Patches are based on 6.6-rc1 and
created with "--irreversible-delete" to save some space. They are
compile tested only, buildbots were happy.

I think this mainly goes to Florian Fainelli. Florian, what do you
think?

All the best!

   Wolfram


Wolfram Sang (2):
  MIPS: AR7: remove VLYNQ init
  vlynq: remove bus driver

 MAINTAINERS                          |   7 -
 arch/mips/Kconfig                    |   1 -
 arch/mips/ar7/platform.c             | 193 +------
 arch/mips/include/asm/mach-ar7/ar7.h |   1 -
 drivers/Kconfig                      |   2 -
 drivers/Makefile                     |   1 -
 drivers/vlynq/Kconfig                |  21 -
 drivers/vlynq/Makefile               |   6 -
 drivers/vlynq/vlynq.c                | 799 ---------------------------
 include/linux/vlynq.h                | 149 -----
 10 files changed, 1 insertion(+), 1179 deletions(-)
 delete mode 100644 drivers/vlynq/Kconfig
 delete mode 100644 drivers/vlynq/Makefile
 delete mode 100644 drivers/vlynq/vlynq.c
 delete mode 100644 include/linux/vlynq.h

-- 
2.35.1

