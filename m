Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB597BB2BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjJFH4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJFH4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:56:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7CDE4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:56:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B51C433C8;
        Fri,  6 Oct 2023 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696579009;
        bh=ZL+Ganj747VFz/C3geUBJhaSPqBfQl7e25JbU1TRwkk=;
        h=Date:From:To:Cc:Subject:From;
        b=aiTfxNV8/XQFEcJNWR4LUWdHuElIaOGMjbyV4I7dn6XEHkfPc+mK1X0xdLXvFc+XJ
         ZfeStXbOAAHYHnw5RyO7/gkmWF6dWriUC7v8k2KqqzBu+MGx1XqqKufoCvkXlUZKix
         YN4wJcUa7THMqLS1ChzmCH3jdo/rTK0gh4JryBH11jXBdjJt+uQvBwPY3ySV+XL1fQ
         0YvbjaxSDoyLZKuRPY3X6Sd9Xt3QBS+rzqiZ3NkOPQzNfdsvH0lvRzzsYUy0sSluGF
         ytUT0gBDdN3dEWRxqWwyQdxIYvU3cSTLoje+snM9R43Z7zfbVrcOKl4oYesA2J1fSm
         lmzXzZGdr5oTA==
Date:   Fri, 6 Oct 2023 08:56:45 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20231006075644.GA5946@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small batch of arm64 fixes for -rc5. There's a typo fix
for a PMU driver, a workround for a side-channel erratum on Cortex-A520
and a fix for the local timer save/restore when using ACPI with Qualcomm's
custom CPUs.

Cheers,

Will

--->8

The following changes since commit 44a5b6b5c7fee5146572b4c57f0d9d9c398d1033:

  arm64: Document missing userspace visible fields in ID_AA64ISAR2_EL1 (2023-09-18 11:59:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 4785aa8028536c2be656d22c74ec1995b97056f3:

  cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer (2023-10-04 16:31:27 +0100)

----------------------------------------------------------------
arm64 fixes for -rc5

- Workaround for Cortex-A520 erratum #2966298

- Fix typo in Arm CMN PMU driver that breaks counter overflow handling

- Fix timer handling across idle for Qualcomm custom CPUs

----------------------------------------------------------------
Jing Zhang (1):
      perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

Oza Pawandeep (1):
      cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer

Rob Herring (2):
      arm64: Add Cortex-A520 CPU part definition
      arm64: errata: Add Cortex-A520 speculative unprivileged load workaround

 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 13 +++++++++++++
 arch/arm64/include/asm/acpi.h               | 19 +++++++++++++++++++
 arch/arm64/include/asm/cputype.h            |  2 ++
 arch/arm64/kernel/cpu_errata.c              |  8 ++++++++
 arch/arm64/kernel/entry.S                   |  4 ++++
 arch/arm64/tools/cpucaps                    |  1 +
 drivers/acpi/processor_idle.c               |  3 +--
 drivers/perf/arm-cmn.c                      |  2 +-
 include/linux/acpi.h                        |  9 +++++++++
 10 files changed, 60 insertions(+), 3 deletions(-)
