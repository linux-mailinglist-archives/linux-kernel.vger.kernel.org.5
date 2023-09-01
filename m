Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3020678F741
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbjIACnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbjIACnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:43:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95CE72;
        Thu, 31 Aug 2023 19:43:03 -0700 (PDT)
X-QQ-mid: bizesmtp74t1693536160toaj6r1k
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Sep 2023 10:42:37 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: Q4gfBD3K7t8LHx8FTZT7R0pzOr2xQ6PVUi1NqX923gFepa7VKzyhODmAnf/j0
        FFzWi/HfxQmD+/itG5KD65p28ioecp5k/AJ+x1vHkVpR/b5F0y7QQvib9awrU1wl1sKPmgR
        DGcWYU0UGPPOFXS0wtLkBVDtTntXGwDgSJYX2GGowmoGMr6K4cFE9c9WYMhLDQQfrnqjY4F
        Zz2mRZtdE0ujBac9ry3WNOT8lOQbTUrLOs6YLl9H9jMnB89w1yfbN+4wILm134/jMTdE/k0
        gEvzTPdgjWMiPXf+dfGlNIRjeKO3tZEQZmPMyn5OocSfuJPkfkpla+lAgDMxG5FeEuR626H
        Pz0sgpL5DCfb6CCkwJ452J6ANiL5/P1yKGEH0dvVSFZT1JEi58=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14128962257822734387
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, mingo@redhat.com, tsbogend@alpha.franken.de,
        hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v2 0/3] Add dependencies of POWER_RESET for MIPS Malta, x86, and PowerMac
Date:   Fri,  1 Sep 2023 10:42:36 +0800
Message-Id: <cover.1693535514.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are to add dependencies of POWER_RESET for MIPS Malta, x86,
and PowerMac.

I am really sorry I forget to use --thread in v1[1] as I stayed up too
late. So here I am resending v2 patch with a mirror fix and
consolidating them into a thread.

To simplify the enablement of the poweroff support, selecting the
required options for CONFIG_POWER_RESET=y may make many people happy
especially when they are using a customized config (maybe tinyconfig
based) for a target qemu board. Without normal poweroff support from the
kernel side, qemu will simply hang[2] there after a 'poweroff' command,
which is a very bad experience for the automatical tests.

Currently, based on tinyconfig, it is very hard to find the exact
poweroff options[3]. Some architectures' poweroff works well without
any dependence, the others' poweroff options are hidden deeply, which
make things hard.

After multiple verifications, these options have been identified as the
minimum dependencies required for poweroff to function normally.

Zhangjin and I invested a significant amount of time in searching for
the current options on these devices. We hope that this set of patches
will save time for others. If community like it, we will consider adding
dependencies for POWER_RESET on other devices.

---
[1]: https://lore.kernel.org/lkml/20230831201727.3177853-1-tanyuan@tinylab.org/
[2]: https://lore.kernel.org/lkml/511b2f6009fb830b3f32b4be3dca99596c684fa3.1689759351.git.falcon@tinylab.org/
[3]: https://lore.kernel.org/all/983843582e52e83fba79ad45cea6c79e1f62ec6c.1690489039.git.falcon@tinylab.org/

---
Changes since v1:
- Fix the mistake of using spaces instead of tabs in kconfig.

Yuan Tan (3):
  kconfig: add dependencies of POWER_RESET for mips malta
  kconfig: add dependencies of POWER_RESET for x86
  kconfig: add dependencies of POWER_RESET for PowerMac

 arch/mips/Kconfig                       | 3 +++
 arch/powerpc/platforms/powermac/Kconfig | 1 +
 arch/x86/Kconfig                        | 2 ++
 3 files changed, 6 insertions(+)

-- 
2.34.1

