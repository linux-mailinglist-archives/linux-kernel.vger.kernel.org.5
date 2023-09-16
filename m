Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6ED7A2FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjIPMHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjIPMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:07:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5694CF4;
        Sat, 16 Sep 2023 05:07:25 -0700 (PDT)
X-QQ-mid: bizesmtp73t1694866031tds2w2vm
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Sep 2023 20:07:08 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: +ynUkgUhZJmtm7vTiltTVNwsjg9955kZ3PdLjei3hto1fWGdv1AVL3fguQtlM
        99dLqedZSquFlCbtmWadTwBHkVhnXSkhPRUdcqjBECcYxQIgb18YaQ3wqAVPCs+91GWvIkm
        nQkK3K0VwC7sYFt/Qm/D2ppsTX5VrwwdaosAt8Ubkq5+CIwAcW5bXztHm9lK2eC4zKFBFT1
        NPXzgbvteyy0swArgiR7+1Nn189gg5ELUng7ZooQbujJRlcnrk9mAxetGhi6lWdR2y8RgsQ
        vXFnUC+xUaFpm06O0icC9xLVJZKIFAdf/p8v/IYQSudkLGk0MmxsHNkoiG4NMA5wqvDqQeC
        YfwxdwBlqHKSUoBGs36a2eZyua5L3SSOjLLKJQbDWgGv9WXkQs=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13584893247443327529
From:   Yuan Tan <tanyuan@tinylab.org>
To:     philmd@linaro.org
Cc:     tsbogend@alpha.franken.de, 42.hyeyoo@gmail.com,
        linux-mips@vger.kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org, w@1wt.eu,
        linux@weissschuh.net, tanyuan@tinylab.org
Subject: [PATCH v4 0/2] Kconfig: Add dependencies of POWER_RESET for MIPS Malta
Date:   Sat, 16 Sep 2023 20:07:07 +0800
Message-Id: <cover.1694865711.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are to add dependencies of POWER_RESET for MIPS Malta.

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
v3: https://lore.kernel.org/all/cover.1694680448.git.tanyuan@tinylab.org/

---
Changes in v2:
- Fix the mistake of using spaces instead of tabs in kconfig.

Changes in v3:
- Enable POWER_RESET and simplify the deconfig.
- Select ADB_CUDA in PPC_PMAC32 only.

Changes in v4:
- Squash last two commits.

Yuan Tan (2):
  MIPS: Cleanup malta_defconfig
  Kconfig: add dependencies of POWER_RESET for mips malta

 arch/mips/Kconfig                 |  3 +++
 arch/mips/configs/malta_defconfig | 39 ++++++-------------------------
 2 files changed, 10 insertions(+), 32 deletions(-)


base-commit: e7513eccb7d7f82e28f4730210b42da71edaa6a6
-- 
2.34.1

