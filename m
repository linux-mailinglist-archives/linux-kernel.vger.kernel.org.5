Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A5C78BA1D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjH1VR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjH1VRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:17:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E21BF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:16:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso34293395e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693257403; x=1693862203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EVE9SNGUVyRq6UTiBnNXw/lvwaXNWXuPMl3GeF9Sn5o=;
        b=gLdzaIU4LBVg14abDgyqDvXAocxrv/i5N/lkmkyPRasj6wAgr6o7cU2cUkrHBEFL6x
         zS5v9FMRa4ZrQTjKUMsL3t9qU0yPFx/e5RSDWtvGmhUZ4MlQo5tO+MOhcO5ZIfi8Gje3
         txaC98cE+rmvK8zk90LICPYQtmGxIUeI942hDPS2XRN+jgJQNp2GoSSxORRLN50XFPWQ
         LRWw+ydzkmfqgK7ijZt1gqIfLBVbyRieJC8oElJPnDTl00E6yM1cnHC37EHCvcElosKj
         64F9QMcMELkhNCTulHg+xjkJ6qbLcgs2/aF1nwzs7M43r7G1unT4VgKeG3l07A+BxwRf
         O6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693257403; x=1693862203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVE9SNGUVyRq6UTiBnNXw/lvwaXNWXuPMl3GeF9Sn5o=;
        b=KHEr1Gorsd+S4JSp/9NthiJfLOBhHAlMolOvi6L1xS9+ioZVVaGbTaxzSjxEWJW7uG
         bXlkWc8CWWPTwpAYsqHTIau083nRziDD+fcobiAecS93/Tuz/BAIjl3fJ8mlDpUeppJi
         64NKLZzXNO3p9xIMU6vod5uajaHJ1N8u7w18nOgvsuh2Fhe1+/r+AWHm/V02iqeih4Up
         ItjWlvxn2L3EDyl9IP2Hy8bhqkbSUVVDAq/GZp+xfrgValExZdI8j0HSBhaAo/9CZl/n
         ePDn3b+vSETF14jXghG6DJpXmNTs1QPGbKhQmrmOxKxsE3Lw31ibbWxxgVlwRwpoqwf8
         5hnw==
X-Gm-Message-State: AOJu0Yy3G9X/gmeTZ75/NQErd/Au/UsZPq9L6yDCWCU1gbbsVt0tUWRU
        nmnhymwciBbJ64SAZWlt2g8=
X-Google-Smtp-Source: AGHT+IGo+mf1RQSnbhoeiPn8C5RqTs8CwllkKjw2vfwGVaRpRy7mIsGb4Kk5j/R6h25edu9bH64/0w==
X-Received: by 2002:a7b:cb42:0:b0:3fb:d1db:545b with SMTP id v2-20020a7bcb42000000b003fbd1db545bmr20056219wmj.20.1693257402559;
        Mon, 28 Aug 2023 14:16:42 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id p25-20020a1c7419000000b003fe195cecb3sm15021183wmc.38.2023.08.28.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:16:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Aug 2023 23:16:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v6.6
Message-ID: <ZO0OuPfs0bMddVTW@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/cleanups git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2023-08-28

   # HEAD: 212f07a21622cbd4bb271b558b2d3ae0652e9875 x86/platform/uv: Refactor code using deprecated strncpy() interface to use strscpy()

Misc x86 cleanups.

The following commit deserves special mention:

   22dc02f81cddd Revert "sched/fair: Move unused stub functions to header"

This is in x86/cleanups, because the revert is a re-application of a
number of cleanups that got removed inadvertedly.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (7):
      x86/cpu: Fix amd_check_microcode() declaration
      x86/apic: Hide unused safe_smp_processor_id() on 32-bit UP
      x86/asm: Avoid unneeded __div64_32 function definition
      x86/purgatory: Include header for warn() declaration
      x86/alternative: Add a __alt_reloc_selftest() prototype
      x86/paravirt: Silence unused native_pv_lock_init() function warning
      x86/qspinlock-paravirt: Fix missing-prototype warning

Justin Stitt (3):
      x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()
      x86/hpet: Refactor code using deprecated strncpy() interface to use strscpy()
      x86/platform/uv: Refactor code using deprecated strncpy() interface to use strscpy()

Peter Zijlstra (1):
      Revert "sched/fair: Move unused stub functions to header"


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
 arch/x86/kernel/apic/x2apic_uv_x.c        |  5 ++---
 arch/x86/kernel/hpet.c                    |  2 +-
 arch/x86/kernel/paravirt.c                |  3 ++-
 arch/x86/platform/uv/uv_nmi.c             | 12 ++++--------
 arch/x86/purgatory/purgatory.c            |  1 +
 kernel/locking/qspinlock_paravirt.h       | 20 ++++++++++----------
 kernel/sched/fair.c                       |  6 +++---
 kernel/sched/sched.h                      |  2 ++
 18 files changed, 49 insertions(+), 36 deletions(-)
