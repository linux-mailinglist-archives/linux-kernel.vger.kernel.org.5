Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2C7C77BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442540AbjJLUSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344092AbjJLUSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:18:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA0B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:17:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo2355741a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697141875; x=1697746675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WEFicMsW4s3skYy4mNr+LHCDs51WUiGt3MBVpKqJRSI=;
        b=MYUZp6wTIhgiZICId8n0WzUz8xkm8vqMWvdOIC//31gUK4mEeyPPsfGml0Tgq7wB6O
         SzCFELCKQyXnUYJuCmrFoPpdgYuxlF0IwdUmfi+PIssq3BY8HSS8aIbgcKR7TNDgNyaS
         l2G501ToCK6HoDngF6venHtmWtljEpXXzP5s9/6U9G+dt4aEykNXN32tQE95LRNRWY7h
         IK8CuiqHMrTUjg7ZES/DZzzTWyXFm8l530iFJR09fI13Adr0YEAyhi/DMU2wfdi5Tove
         wqMLiww9N6B+PREz4dKE3HVJ//+SIpG3XsH2TO8iAbFUbyq9lQs5E/7oOLVs2kDGz54A
         hNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141875; x=1697746675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEFicMsW4s3skYy4mNr+LHCDs51WUiGt3MBVpKqJRSI=;
        b=GA+yhb+FA8QPzacgbiW2XUq/dAnUh9VS1PSbDZ6lGB+XJFZaTQ9pCUCEhVGD8OOTB3
         sxVIxksQ7SFP0CnPNVDao+VRlPn2SgSCr/Au/KfvaMkKIxhuGFzApj74NrSNX7KKq+9O
         20rlbMRRjQ8Tz9y4Ca+45Yf4rj4EZsJulOS4p8/tMNiLza5UTfTpzevwndl9hetnt+FD
         D2/LolyuhnJ4lc1Hg372vjWcT4ZgIZ4w3zPYk8pOpKruaxSE1pHaKqd0lZPg9V1XVFfI
         ytC3dGvo4wGAoycwE/9feav8PWrEVOcjzWlFXQgDrGGwTD5wXOg1P3bu29mLYjRP7m4g
         RnHw==
X-Gm-Message-State: AOJu0YzxZhBdZealkkt29Kzfl2esGMSuJV6ogCEFmNRXt6ZDUlqgZJ8w
        AIvhOA2X/9JzoxuPSm5xUNM=
X-Google-Smtp-Source: AGHT+IHCzOG5Qj1uWOXe+fHsuoCjTwSpfunPEUadKxQrsehhq/m4xv7XrF8ve3tA1LAlh7XjukB2Ww==
X-Received: by 2002:a17:906:73db:b0:9ae:6a9b:274e with SMTP id n27-20020a17090673db00b009ae6a9b274emr24705973ejl.8.1697141874375;
        Thu, 12 Oct 2023 13:17:54 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709064ec300b00997d7aa59fasm11692552ejv.14.2023.10.12.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:17:54 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/4]  Introduce %rip-relative addressing to PER_CPU_VAR macro
Date:   Thu, 12 Oct 2023 22:12:03 +0200
Message-ID: <20231012201743.292149-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch series introduces %rip-relative addressing to
PER_CPU_VAR macro. Instruction with %rip-relative address operand is
one byte shorter than its absolute address counterpart and is also
compatible with position independent executable (-fpie) build.

The first three patches are cleanups that fix various inconsistencies
throughout the assembly code.

The last patch introduces (%rip) suffix and uses it for x86_64 target,
resulting in a small code size decrease:

   text    data     bss     dec     hex filename
25510677        4386685  808388 30705750        1d48856 vmlinux-new.o
25510629        4386685  808388 30705702        1d48826 vmlinux-old.o

Patch series is against current mainline and can be applied independently
of ongoing percpu work.

v2: Introduce PER_CPU_ARG macro to conditionally enable
    segment registers in cmpxchg{8,16}b_emu.S for CONFIG_SMP.

Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>

Uros Bizjak (4):
  x86/percpu: Introduce PER_CPU_ARG and use it in cmpxchg{8,16}b_emu.S
  x86/percpu: Correct PER_CPU_VAR usage to include symbol and its addend
  x86/percpu, xen: Correct PER_CPU_VAR usage to include symbol and its
    addend
  x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR macro

 arch/x86/entry/calling.h      |  2 +-
 arch/x86/entry/entry_32.S     |  2 +-
 arch/x86/entry/entry_64.S     |  2 +-
 arch/x86/include/asm/percpu.h | 10 +++++++---
 arch/x86/kernel/head_64.S     |  2 +-
 arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
 arch/x86/lib/cmpxchg8b_emu.S  | 24 ++++++++++++++++++------
 arch/x86/xen/xen-asm.S        | 10 +++++-----
 8 files changed, 40 insertions(+), 24 deletions(-)

-- 
2.41.0

