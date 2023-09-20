Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31C7A71E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjITFWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjITFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521EC6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=e2ywRdf3MvouMcsL3vuCFcCDBJuhMwwdxm+h7lrRIeE=; b=xMY22ZCjCjXQIJKeHiLjDC/djU
        K+xeZcJ1kB2hmuEHKbbhE4f9yVydVelQblWk4nG31aXJxeLQ+EvLtmOZGeROerNGfQrp5wphVE46A
        4htzELWGbVqHklf79qTS5w659ExT6SAMObk6chxNFSRyf9O3Lv+0jCfyGEHOXwKO1xwE8xrsDo/GN
        Q55iwBkxenVbV+iUu5VWWE8olwMlci3troojjTVv2OdfuHW2S8phKHZqRSTgyqQN1ooOZlyMaFB+F
        JPr8KZPjXJFL06RVRYAbv1nTLdn63GqMbHDlrBzcJmSC8NsunautRIeUlFHlrT+XhCxocRGuhyPiJ
        kKgjuSjw==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipeg-001tym-0B;
        Wed, 20 Sep 2023 05:21:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 00/16] xtensa: fix W=1 build warnings
Date:   Tue, 19 Sep 2023 22:21:23 -0700
Message-ID: <20230920052139.10570-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes all xtensa W=1 build warnings that I have seen
with the exception of some in arch/xtensa/boot/. [1]

These have been through defconfig, allnoconfig, tinyconfig, allyesconfig,
allmodconfig, and many randconfig builds.

 [PATCH 01/16] xtensa: FSF: define XCHAL_HAVE_DIV32
 [PATCH 02/16] xtensa: fault: include <asm/traps.h>
 [PATCH 03/16] xtensa: irq: include <asm/traps.h>
 [PATCH 04/16] xtensa: ptrace: add prototypes to <asm/ptrace.h>
 [PATCH 05/16] xtensa: processor.h: add init_arch() prototype
 [PATCH 06/16] xtensa: signal: include headers for function prototypes
 [PATCH 07/16] xtensa: stacktrace: include <asm/ftrace.h> for prototype
 [PATCH 08/16] xtensa: traps: add <linux/cpu.h> for function prototype
 [PATCH 09/16] irqchip: irq-xtensa-mx: include header for missing prototype
 [PATCH 10/16] xtensa: smp: add headers for missing function prototypes
 [PATCH 11/16] xtensa: hw_breakpoing: include header for missing prototype
 [PATCH 12/16] xtensa: tlb: include <asm/tlb.h> for missing prototype
 [PATCH 13/16] xtensa: iss/network: make functions static
 [PATCH 14/16] xtensa: boot: don't add include-dirs
 [PATCH 15/16] xtensa: umulsidi3: fix conditional expression
 [PATCH 16/16] xtensa: boot/lib: add missing prototypes for functions

1:
arch/xtensa/boot/boot-elf/bootstrap.S:68: Warning: value 0x1a0003000 truncated to 0xa0003000

 arch/xtensa/boot/Makefile                       |    3 +--
 arch/xtensa/boot/lib/zmem.c                     |    4 ++++
 arch/xtensa/include/asm/hw_breakpoint.h         |    1 +
 arch/xtensa/include/asm/processor.h             |    5 +++++
 arch/xtensa/include/asm/ptrace.h                |    3 +++
 arch/xtensa/include/asm/smp.h                   |    1 +
 arch/xtensa/include/asm/tlb.h                   |    2 ++
 arch/xtensa/kernel/hw_breakpoint.c              |    1 +
 arch/xtensa/kernel/irq.c                        |    1 +
 arch/xtensa/kernel/ptrace.c                     |    1 -
 arch/xtensa/kernel/signal.c                     |    2 ++
 arch/xtensa/kernel/smp.c                        |    1 +
 arch/xtensa/kernel/stacktrace.c                 |    1 +
 arch/xtensa/kernel/traps.c                      |    1 +
 arch/xtensa/lib/umulsidi3.S                     |    4 +++-
 arch/xtensa/mm/fault.c                          |    1 +
 arch/xtensa/mm/tlb.c                            |    1 +
 arch/xtensa/platforms/iss/network.c             |    4 ++--
 arch/xtensa/variants/fsf/include/variant/core.h |    1 +
 drivers/irqchip/irq-xtensa-mx.c                 |    1 +
 20 files changed, 33 insertions(+), 6 deletions(-)

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
