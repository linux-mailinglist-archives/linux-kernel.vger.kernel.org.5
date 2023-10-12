Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD217C7226
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjJLQMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjJLQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:12:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1707CC6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1992206a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127167; x=1697731967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m324SzpB4tRrNifTcRyeznzQLigWiB6PcnuW2+zuICA=;
        b=YRXDkE48JKzlYuADBKvGBVBNGenEP5Mf38GeTyme57HE4eMlzUSykRT2a5HpPhRE7B
         aPlqx1u3n09E7KpOjfxlnNRim7jRX8ETO0QzxXnYw82MkybRANG38n49m+yG8Bd2Kg/2
         DWsyEgCt7h4alHoMtbvdbAyDZXLVnRqzHT2EhLuxfNiIXxj/AHZvQCKy2Vp7G1OaHbUo
         dKxUCii3d8xV7QDcQ2ci19HDSnep+u47BEKKhURz0xk09EXgA8VnBCQromDRryXkH4i+
         v3zZ6Wz5LQjb7XpdjPXwQQd9WrEWOhT1wyTDrxB6LV4xAP3LzxEjP0NZ5Vb6TIsHILbP
         A5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127167; x=1697731967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m324SzpB4tRrNifTcRyeznzQLigWiB6PcnuW2+zuICA=;
        b=B4GMK/AwHziBE6NT5QnFK+jvPG9wdCfklNwCBs8fRM/ubvBrBL7kiwYfvfWmpcAYAG
         sQNz1RWC/9rQQGrB0pdwmEm0e2hdhpe9zoMXtIPGy4p52rlGRjU7EmQJ6AoW2Jm2fM9r
         rUcIBhk+6xU0TAufiwTuB4vn/5lCET9allRQXuELPCfCu6aUQABbZ7pzDVh/JND5aGdK
         EvC2150A6zMnZmm+rWR4pypto15jYjQi656IYIgKyv7fX5hw+eqlbW+BoIc0fzcnAsyp
         1z/tkRjxaxsJ+KIlklDSqRNj/o7PpJb3d2avwKBlUL51gpZmfSwxZpbnzHRh0Tvbodtk
         2VVg==
X-Gm-Message-State: AOJu0Yy4RO1yBuYKmuRztOU5hl4aDQvWTFGJ8j/uVZPFChkxv09qzoHh
        FumqMlhI/1w0jeCEJPjyMx4=
X-Google-Smtp-Source: AGHT+IG3OATQwvAdDylZaY+NQE8rIqD1qHAB+PgGQkf9k1iPsawqa69X3y4KQT9BWLEr8K6NDqfqoQ==
X-Received: by 2002:a17:906:290:b0:9b2:89eb:79b5 with SMTP id 16-20020a170906029000b009b289eb79b5mr24236684ejf.35.1697127167247;
        Thu, 12 Oct 2023 09:12:47 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm11414461ejb.141.2023.10.12.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:12:47 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/4]  [PATCH 0/4] Introduce %rip-relative addressing to PER_CPU_VAR macro
Date:   Thu, 12 Oct 2023 18:10:35 +0200
Message-ID: <20231012161237.114733-1-ubizjak@gmail.com>
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
of the ongoing percpu work.

Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>

Uros Bizjak (4):
  x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S
  x86/percpu: Correct PER_CPU_VAR usage to include symbol and its addend
  x86/percpu, xen: Correct PER_CPU_VAR usage to include symbol and its
    addend
  x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR macro

 arch/x86/entry/calling.h      |  2 +-
 arch/x86/entry/entry_32.S     |  2 +-
 arch/x86/entry/entry_64.S     |  2 +-
 arch/x86/include/asm/percpu.h |  6 ++++--
 arch/x86/kernel/head_64.S     |  2 +-
 arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
 arch/x86/lib/cmpxchg8b_emu.S  | 30 +++++++++++++++++++++---------
 arch/x86/xen/xen-asm.S        | 10 +++++-----
 8 files changed, 40 insertions(+), 26 deletions(-)

-- 
2.41.0

