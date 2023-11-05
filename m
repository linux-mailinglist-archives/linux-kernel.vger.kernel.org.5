Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB2D7E16DC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjKEVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:37:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA3CC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:37:43 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d242846194so552490566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 13:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699220262; x=1699825062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18SjVPy4NSFeiatOHzuMVv6funGi9z3Nzj9MWVkJt80=;
        b=PeBvngmCCAHVu/gYY2sze4FGqjI7Ra+HJwKWyQ+7qMsJLQT2VVDX4mPr05ht2Gy88k
         BjsHmkQRVWBRPR49wHmvtErH6kcvxD84IkmRhmGFLXpDVEkPSUkPRRc0gy3+iTrNB10P
         OH3SjEmYcr1TGHjQLkitQsRxBSE2mIdgLp217kS8SGizMkDsvZdBNabxFTsX4YoBd0UJ
         fiFPzVLkUqcWMzxlCgK42f0JlzYzfSY0mgzA3s/aiWFzAZOZkVYoE3GuLC5n93lo6xqB
         d9BCVNART4oQ0hw1lZb4d6W2WIBDqqcahjCCeQxvPe7SBVx/aE1XeGJzZCZqpZfDX3k4
         /stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699220262; x=1699825062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18SjVPy4NSFeiatOHzuMVv6funGi9z3Nzj9MWVkJt80=;
        b=QDiwv6ij11AQ3ABcSQSdIUF7UiU+xib4Ay/0gH7ldoU4cVQAgj87EtF7etUWKDyAEX
         GgJJ5bNK7GZu7OyuPY6owU0FNBqwpzeyQsg7je7evV/Viu9gjYlRyMcPH6ur+tCbJ6yh
         GzfUlBH+hndBJXXMVcaM+JyYz/S5OIAknz2QULIFwghj6eM04H5VvZNYccfJGKC+RUxA
         Y8MczMUkRxDKe+U6FKJ5abott2p/uPIiQHQz/BB07TVMTs4twv1hHpDyiuib+roeRcpy
         nypptdSzjUnhI77rOQYCa2yaBEpl+HodV8O3bGrf4un8rkIbfm3BD1C92gG8PklmfDEZ
         yWGg==
X-Gm-Message-State: AOJu0Yym7oXzlRT+7MLNR/gNRfxmGmkjFDVDNpnPOi6f9KIKkP02JDyA
        XPcOs5AAcEI/kS734So0Abw=
X-Google-Smtp-Source: AGHT+IEyeR0zj9vUuWrtNAiXrqAK6F+5p5k/olzqfhLQ1repIGTY+LtecSE7RX7VwlV6uRToBXdhpA==
X-Received: by 2002:a17:906:d14c:b0:9be:4bb0:64f with SMTP id br12-20020a170906d14c00b009be4bb0064fmr9833746ejb.54.1699220261702;
        Sun, 05 Nov 2023 13:37:41 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709064e5700b009c5c5c2c5a4sm3386559ejw.219.2023.11.05.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 13:37:41 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -tip v2 0/3] x86/callthunks: Fix and unify call thunk assembly snippets
Date:   Sun,  5 Nov 2023 22:34:34 +0100
Message-ID: <20231105213731.1878100-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
call thunk templates.  Due to unsupported relocations, two variants of
INCREMENT_CALL_DEPTH macro are needed, ASM_ prefixed that allows
relocations and non-prefixed version that allows only absolute
addresses.

The following patch series fixes above issues by

a) Making PER_CPU_VAR macro from percpu.h also available without
__ASSEMBLY__, so it can be used in 'asm' statements to conditionally
use %gs: segment register prefix, depending on CONFIG_SMP.

b) Re-using existing infrastructure from alternative.c to allow
%rip-relative relocations when copying call thunk template from its
storage location.

c) Fixing call thunks debug macros to use PER_CPU_VAR macro from
percpu.h to conditionally use %gs: segment register prefix, depending
on CONFIG_SMP.

d) Unifying ASM_ prefixed assembly macros with their non-prefixed
variants. With support of %rip-relative relocations in place, call
thunk templates allow %rip-relative addressing, so unified assembly
snippet can be used everywhere.

v2:
- Make PER_CPU_VAR macro available in 'asm' statements instead of
  moving 'asm' statements to *.S assembly files.
- Re-use existing relocation infrastructure from alternative.c

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Uros Bizjak (3):
  x86/percpu: Define PER_CPU_VAR macro also for !__ASSEMBLY__
  x86/callthunks: Handle %rip-relative relocations in call thunk
    template
  x86/callthunks: Fix and unify call thunks assembly snippets

 arch/x86/include/asm/nospec-branch.h | 23 ++++++--------------
 arch/x86/include/asm/percpu.h        |  5 +++++
 arch/x86/include/asm/text-patching.h |  2 ++
 arch/x86/kernel/alternative.c        |  3 +--
 arch/x86/kernel/callthunks.c         | 32 ++++++++++++++++++++++------
 5 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.41.0

