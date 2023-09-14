Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194687A01CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbjINKgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjINKgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:36:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2941BEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:36:16 -0700 (PDT)
X-QQ-mid: bizesmtp85t1694687756t88dzc2b
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 18:35:54 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: LG+NUo/f6sEUMONClK+11md+5xqu6zIlbMPJrekhWFfJ0GAu41AM2fZGVaAlN
        ENlhOksv6ZpQuVRMoUjdX/Qn/2vcIOApf/sc7sSxHPgH3aCJ3zb/DeoyuM3E5+To9KyK0eX
        1QjdaS5lECew5jPmD+c4gjwSuJxiycUeBZHR6foJXKuD4NgAkSzeXGpK3QR8JCg0zsfjvEI
        wCnOJgHwy04zrUM6EtVjagkhLR4Rmuji26gVj3/WI/waGtH4F0iRvxjYeLyupyOhP2PwqUO
        82rscBh8blJAshAVevuAd7juWd2463mxn2IILLqW8p5wsdwZV1htZXjdHPPvWTCES/IkxLJ
        olZQZ8cmLwAe/QtrhSOd3Sm32/mK+xd+QRBhbgnfvZIBa7ecyS9I6zXoe34NH/xXY/LsG24
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9684224307865873303
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, falcon@tinylab.org,
        w@1wt.eu, linux@weissschuh.net, tanyuan@tinylab.org
Subject: [PATCH v3 0/3] Kconfig: Add dependencies of POWER_RESET for x86
Date:   Thu, 14 Sep 2023 18:35:52 +0800
Message-Id: <cover.1694687048.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are to add dependencies of POWER_RESET for x86.

I sent v1 and v2 to the wrong x86 repository and email list. Here is v3.

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

Yuan Tan (3):
  x86/config: Cleanup i386_defconfig and x86_64_defconfig
  Kconfig: Add dependencies of POWER_RESET for x86
  x86/config: Simplify i386_defconfig and x86_64_defconfig

 arch/x86/Kconfig                  |  2 ++
 arch/x86/configs/i386_defconfig   | 31 ++++++++++---------------------
 arch/x86/configs/x86_64_defconfig |  9 ++-------
 3 files changed, 14 insertions(+), 28 deletions(-)


base-commit: 84b81a67e9cba5466178e47c20c0628359a242b0
-- 
2.34.1

