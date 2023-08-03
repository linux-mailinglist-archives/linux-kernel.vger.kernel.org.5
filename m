Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264D76E316
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjHCI3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjHCI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619343A95
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8E2C61CC1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A18C433C7;
        Thu,  3 Aug 2023 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691051185;
        bh=PvkPRIP3W2IXRABlybtTYGxVGP/a8h3R+NtBV7XO1qk=;
        h=From:To:Cc:Subject:Date:From;
        b=bZpwHIqj0Y3o8CC3tmNhTCMfvdTy4GMtP8zkPmfnc0xLCRmwKK6zve+YXd941NrYE
         6BEr4pxIh7NZNvo/n+tVDEONi7gOcnOh60UgY3cEM15k1lVxFmdyu0IjyvoKfcXNJP
         cz/lB8obPWDOCHbsydaXdEYcgRnMdwEokLzecX9+01Bn+sj4ad19dCblLFx/EmzQYo
         D28djguJ2Z7K5OHZm20VEvse4Zuf3pcq1Gwoo2Yw7Kqwvhih3YC+oSxoXa4LoMNY9d
         W73AUx/OXLqbcA7ErDmo0CsGCNf/QmftbeixE39pF0ELDoPkiKZVY1ffrUcGG7oh2c
         8Kmk8Vij/seBA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/7] x86: remaining -Wmissing-prototype warning fixes
Date:   Thu,  3 Aug 2023 10:26:12 +0200
Message-Id: <20230803082619.1369127-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is almost the same as before, and should let us turn
on -Wmissing-prototypes by default. I'm still unsure whether
we need to do this per architecture as some other ones still
produce a lot of warnings, or we just enabled it for everyone
and let arch maintainers deal with it now that the major
ones (x86, arm64, arm, powerpc, riscv, s390) are clean.

Changes compared to v2:
 - add amd_check_microcode() patch to the series. I had
   sent that separately as this was a regression in 6.5-rc

 - rework comment for __div64_32

 - split paravirt patch into two patches and rewrite
   the native_pv_lock_init() one as requested by Boris

      Arnd

Arnd Bergmann (7):
  x86: Fix amd_check_microcode() declaration
  x86: apic: hide unused safe_smp_processor_id on UP
  x86: avoid unneeded __div64_32 function definition
  x86: purgatory: include header for warn() declaration
  x86: alternative: add __alt_reloc_selftest prototype
  x86: paravirt: shut up unused native_pv_lock_init() function warning
  x86: qspinlock-paravirt: fix mising-prototype warning

 arch/x86/boot/compressed/error.c          |  2 +-
 arch/x86/boot/compressed/error.h          |  2 +-
 arch/x86/include/asm/div64.h              |  6 ++++++
 arch/x86/include/asm/microcode_amd.h      |  3 +--
 arch/x86/include/asm/paravirt.h           |  7 +++++++
 arch/x86/include/asm/processor.h          |  2 ++
 arch/x86/include/asm/qspinlock.h          |  7 +------
 arch/x86/include/asm/qspinlock_paravirt.h |  2 ++
 arch/x86/kernel/alternative.c             |  1 +
 arch/x86/kernel/apic/ipi.c                |  2 ++
 arch/x86/kernel/paravirt.c                |  3 ++-
 arch/x86/purgatory/purgatory.c            |  1 +
 kernel/locking/qspinlock_paravirt.h       | 20 ++++++++++----------
 13 files changed, 37 insertions(+), 21 deletions(-)

-- 
2.39.2

