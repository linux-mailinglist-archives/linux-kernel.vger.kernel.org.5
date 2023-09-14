Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC747A0148
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbjINKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbjINKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:10:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E51BE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:10:10 -0700 (PDT)
X-QQ-mid: bizesmtp73t1694686198tk4ha5fg
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 18:09:56 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: VbOeDQvtdXMk45dYh0Rvdnu0TnmPU2mccxLgcvRVp/zby+SKZ/55KdJ2D3USC
        Vsom7rqs8nsZbWy6pBDerMjjxutfOJSb/nUjTzPTIodqjHUgKo+agzbfCsE6b+UiOUg+JUd
        kItvo1nTEcn2VPtjWZ86Aem+fzU92y1ZqCpOpwpcWpynP6jNT6NH+uJSk4uitK4hWgMaDYy
        2O25JsV76JG2emFOBifgAquLYerUqfS2gAojVf4tB1o0y//PrUZeJej5rF+nGwLCCZqm3/f
        zD+aVG903/BtCdCm2lt1eCKAsBqMtLjuzkP5V3dO9+aZ++DG6ifCDKOdJHq6qaFUZGcogFh
        +MeWdySPDfv8GNpfInPlAfUFaDh3zVxx0cfs2UhFfmCPWFVnP8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6639631946269461882
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, w@1wt.eu, linux@weissschuh.net,
        tanyuan@tinylab.org
Subject: [PATCH v3 0/3] Kconfig: Add dependencies of POWER_RESET for pmac32
Date:   Thu, 14 Sep 2023 18:09:55 +0800
Message-Id: <cover.1694685860.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are to add dependencies of POWER_RESET for pmac32.

As I have to use "savedefconfig" on the latest branch of different
architectures, I am sending separate patches for each architecture in v3.

To simplify the enablement of the poweroff support, selecting the
required options for CONFIG_POWER_RESET=y may make many people happy
especially when they are using a customized config (maybe tinyconfig
based) for a target qemu board. Without normal poweroff support from the
kernel side, qemu will simply hang[1] there after a 'poweroff' command,
which is a very bad experience for the automatical tests.

However, CONFIG_POWER_RESET is ineffective if there are no
dependencies that enable certain devices in Kconfig.

Currently, based on tinyconfig, it is very hard to find the exact
poweroff related option[2]. Some architectures' poweroff works well without
any dependence, the others' poweroff options are hidden deeply, which
make things hard.

After multiple verifications, these options have been identified as the
minimum dependencies required for poweroff to function normally.
Additionally, 'make savedefconfig' simplifies the defconfig
automatically.

Zhangjin and I invested a significant amount of time in searching for
the current options on these devices. We hope that this set of patches
will save time for others. If community like it, we will consider adding
dependencies for POWER_RESET on other devices.

We hope every device's CONFIG_POWER_RESET will have proper dependencies. :)

---
[1]: https://lore.kernel.org/lkml/511b2f6009fb830b3f32b4be3dca99596c684fa3.1689759351.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/all/983843582e52e83fba79ad45cea6c79e1f62ec6c.1690489039.git.falcon@tinylab.org/

v1: https://lore.kernel.org/all/20230831201727.3177853-1-tanyuan@tinylab.org/
v2: https://lore.kernel.org/all/cover.1693535514.git.tanyuan@tinylab.org/

---
Changes in v2:
- Fix the mistake of using spaces instead of tabs in kconfig.

Changes in v3:
- Enable POWER_RESET and simplify the deconfig.
- Select ADB_CUDA in PPC_PMAC32 only.

Yuan Tan (3):
  powerpc/config: Cleanup pmac32_defconfig
  Kconfig: Add dependencies of POWER_RESET for pmac32
  powerpc/config: Simplify pmac32_defconfig

 arch/powerpc/configs/pmac32_defconfig   | 46 +++++++++++--------------
 arch/powerpc/platforms/powermac/Kconfig |  1 +
 2 files changed, 21 insertions(+), 26 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

