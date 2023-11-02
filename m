Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2C7DF124
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347364AbjKBL3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKBL3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:29:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0194111
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:29:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32fa7d15f4eso482467f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698924542; x=1699529342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rix3sAtXIjSf8/fyf/2guJH5UUmYBL1Voy07HK9emJM=;
        b=Cn79hIfUCZ7lFe8Z6pvlpUfhVazS2ZUbGJo3X5jFII7pgpSQ4y/BgijKvDHCT/2GMy
         RTwR0XC3hLofTc+MOeyprFjS6uOD/I0dBP6nViEgec1hgaPQChf+Jcv96durlZoqRFJC
         7XLdtop++IZASmJu+meMvA2NWK806SfGBjQZrNrDTmXkvNpxP9vg+qfVwmo34qzIgOwC
         3WpnnC13TLDNYclHqTXf9GFh600Epruw2QtbrjO3ZktKnqr8JFVrgarughg/6OsvpLko
         K71bHzz4x13iqpRPo67ztz0w5YDg9Hd0rCuhCzgNs4R+Z870BX5T6kJf4/YbcJj1KMRM
         tqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698924542; x=1699529342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rix3sAtXIjSf8/fyf/2guJH5UUmYBL1Voy07HK9emJM=;
        b=o0iJJXNhUKSzJPw5jNPqg+UO423fssBxjymP6k23T87Fecuac6RuGaiCpUfv29g59l
         B8pcyL89K7bFMYbuZtXDXVirykLA3aMON7PvUePNqmjAvziwpryBTCIdz/dxFOcUBIlE
         1Hy1KvI7BwR0n5J0dg5DXjlulsYFCk4zGqixeH8n5aXs+2aCgsjRXQ4wZhlOE2wHPneD
         s6f9LnRnZAXGYhA97CfC0uAoRiQ1JuPdOArl12/x/puxwgrOcWwHfZjYIn1Fa4tCSyAB
         yT1OhzUtwA4v2iYVwhVFthNnfV3+fE79VfFmjRQL5iTxW6YIkeunbqZS2MBV2NKNIYRD
         Tosg==
X-Gm-Message-State: AOJu0YxdrVII87WnzhQGeGmbEKARFGTtbG4Ag2RQoaSvw4WScQBDCUQ4
        xa7MKJKdVj64BOT7B7NW5lc=
X-Google-Smtp-Source: AGHT+IE+PgBFnEq9nlG5Evi90SY1J33I1uuBwfuI4pR+vSCgo6LcX597aEm4SZNniOQ3X2GYTxNLgQ==
X-Received: by 2002:a5d:67c8:0:b0:32d:812d:907e with SMTP id n8-20020a5d67c8000000b0032d812d907emr12255644wrw.65.1698924541825;
        Thu, 02 Nov 2023 04:29:01 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d4f8a000000b003232f167df5sm2168227wru.108.2023.11.02.04.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:29:01 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] Fix and unify call thunks assembly snippets
Date:   Thu,  2 Nov 2023 12:25:45 +0100
Message-ID: <20231102112850.3448745-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently INCREMENT_CALL_DEPTH and thunk debug macros explicitly
define %gs: segment register prefix for their percpu variables.
This is not compatible with !CONFIG_SMP, which requires non-prefixed
percpu variables.

Contrary to alternatives, relocations are currently not supported in
call thunk templates. Support for relocations will be needed when
PER_CPU_VAR macro switches to %rip-relative addressing.

Due to unsupported relocations, two variants of INCREMENT_CALL_DEPTH
macro are needed, ASM_ prefixed that allows relocations and
non-prefixed version that allows only absolute addresses.

The following patch series fixes above issues by

a) Moving call thunk template to its own callthunks-tmpl.S assembly file
where PER_CPU_VAR macro from percpu.h can be used to conditionally
use %gs: segment register prefix, depending on CONFIG_SMP.

b) Implementing minimal support for relocations when copying call thunk
template from its storage location to handle %rip-relative addresses.

c) Fixing call thunks debug macros to use PER_CPU_VAR macro from
percpu.h to conditionally use %gs: segment register prefix, depending
on CONFIG_SMP.

d) Unifying ASM_ prefixed assembly macros with their non-prefixed
variants. With support of %rip-relative relocations in place, call
thunk templates allow %rip-relative addressing, so unified assembly
snippet can be used everywhere.

The patch is independent of main percpu series in -tip tree.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Uros Bizjak (3):
  x86/callthunks: Move call thunk template to .S file
  x86/callthunks: Handle %rip-relative relocations in call thunk
    template
  x86/callthunks: Fix and unify call thunks assembly snippets

 arch/x86/include/asm/nospec-branch.h | 23 +++------
 arch/x86/kernel/Makefile             |  2 +-
 arch/x86/kernel/callthunks-tmpl.S    | 11 +++++
 arch/x86/kernel/callthunks.c         | 73 +++++++++++++++++++++-------
 4 files changed, 75 insertions(+), 34 deletions(-)
 create mode 100644 arch/x86/kernel/callthunks-tmpl.S

-- 
2.41.0

