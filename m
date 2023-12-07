Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564D3808B53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjLGPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjLGPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:03:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B910C0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:03:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c09d62b70so12540405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701961431; x=1702566231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzUGYpwYAIocf74DCpTux4YFllX1H7F6zPZyiGHWp1Y=;
        b=GLL16fO29Orq5Jz30/saRHWQMHiNkAiqhbqsgY8aiyAaU0vEXnE+0M/K1ydxsZ73XM
         SlUV0ARtINt/6M3b/YChKOd7VwvQUhi169uNz08xR4Li1JflFw3Je2+teSA4H4I0cCPW
         K39pBh8Oy2OvAZwLnca5NHaGY7ZEZOtMYQCdGB4RgJKCuGaBOJ56jCXXv/wyGkGf9o4M
         MuhRBDAbMNRd815kI8aeNcCLSiHgfm9lv/jR8EXh8IpQo2UhqubuJm0/aD+190RkeeLW
         liGDlm5uVli0iD0w/1z+2x0wuE2UFOd7Q+dXR93vK1W/UEXWRhhQ/I/Ucx6qGvPsx7Sq
         MZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961431; x=1702566231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzUGYpwYAIocf74DCpTux4YFllX1H7F6zPZyiGHWp1Y=;
        b=FOVQ6i6zGkWYomUamU2lK92bSLXKJaZEpOtIi/zJBHOCd1VwpSgZ+O0/sp0DwQGemq
         SNfBqZ16iBNM806J3W48ZVEjW5Z7kGDXwt6hgb9qqRXtmP8UuUHw5O6JSC+JCr24scNq
         UQBJgrGzsWKfqQNmET7odp53iJiIKj+QuvntJRX9dzk3Jo0KLFsRmDdwXuvkcXCkITS8
         sI2lvS5ju3B5Bwc21eOsx1JN4UMvNEuzphNj7hjl6i8JpLmvMfEB/beIKOi82rfLaaOa
         U+Iq3RbdgTJLgbqZhCTzb/er+7h5vJjRQFmq5em/Pn9v4Wp9bQlSAqZplBmC9nZ/IcU7
         R9pQ==
X-Gm-Message-State: AOJu0Yy7N/l1/N/9HcjLOSy+rhKWo27VhknJwUywS0sZueY0TYkTul2l
        4roXrl6XNKBCEUXd0Y1LhFrt7g==
X-Google-Smtp-Source: AGHT+IEfU8bcWPltllq4UxddBOusN19bKPp7FZtm1tNb3JVSGuXfSF/1fbnNg3hbcLptFO8P4+JaSw==
X-Received: by 2002:a05:600c:198b:b0:40c:5ee:2dda with SMTP id t11-20020a05600c198b00b0040c05ee2ddamr1118146wmq.177.1701961430948;
        Thu, 07 Dec 2023 07:03:50 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0040b42df75fcsm2187533wmq.39.2023.12.07.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 07:03:50 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ved Shanbhogue <ved@rivosinc.com>,
        Matt Evans <mev@rivosinc.com>,
        Dylan Jhong <dylan@andestech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RFC/RFT 0/4] Remove preventive sfence.vma
Date:   Thu,  7 Dec 2023 16:03:44 +0100
Message-Id: <20231207150348.82096-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RISC-V, after a new mapping is established, a sfence.vma needs to be
emitted for different reasons:

- if the uarch caches invalid entries, we need to invalidate it otherwise
  we would trap on this invalid entry,
- if the uarch does not cache invalid entries, a reordered access could fail
  to see the new mapping and then trap (sfence.vma acts as a fence).

We can actually avoid emitting those (mostly) useless and costly sfence.vma
by handling the traps instead:

- for new kernel mappings: only vmalloc mappings need to be taken care of,
  other new mapping are rare and already emit the required sfence.vma if
  needed.
  That must be achieved very early in the exception path as explained in
  patch 1, and this also fixes our fragile way of dealing with vmalloc faults.

- for new user mappings: that can be handled in the page fault path as done
  in patch 3.

Patch 2 is certainly a TEMP patch which allows to detect at runtime if a
uarch caches invalid TLB entries.

Patch 4 is a TEMP patch which allows to expose through debugfs the different
sfence.vma that are emitted, which can be used for benchmarking.

On our uarch that does not cache invalid entries and a 6.5 kernel, the
gains are measurable:

* Kernel boot:                  6%
* ltp - mmapstress01:           8%
* lmbench - lat_pagefault:      20%
* lmbench - lat_mmap:           5%

On uarchs that cache invalid entries, the results are more mitigated and
need to be explored more thoroughly (if anyone is interested!): that can
be explained by the extra page faults, which depending on "how much" the
uarch caches invalid entries, could kill the benefits of removing the
preventive sfence.vma.

Ved Shanbhogue has prepared a new extension to be used by uarchs that do
not cache invalid entries, which will certainly be used instead of patch 2.

Thanks to Ved and Matt Evans for triggering the discussion that led to
this patchset!

That's an RFC, so please don't mind the checkpatch warnings and dirty
comments. It applies on 6.6.

Any feedback, test or relevant benchmark are welcome :)

Alexandre Ghiti (4):
  riscv: Stop emitting preventive sfence.vma for new vmalloc mappings
  riscv: Add a runtime detection of invalid TLB entries caching
  riscv: Stop emitting preventive sfence.vma for new userspace mappings
  TEMP: riscv: Add debugfs interface to retrieve #sfence.vma

 arch/arm64/include/asm/pgtable.h              |   2 +-
 arch/mips/include/asm/pgtable.h               |   6 +-
 arch/powerpc/include/asm/book3s/64/tlbflush.h |   8 +-
 arch/riscv/include/asm/cacheflush.h           |  19 ++-
 arch/riscv/include/asm/pgtable.h              |  45 ++++---
 arch/riscv/include/asm/thread_info.h          |   5 +
 arch/riscv/include/asm/tlbflush.h             |   4 +
 arch/riscv/kernel/asm-offsets.c               |   5 +
 arch/riscv/kernel/entry.S                     |  94 +++++++++++++
 arch/riscv/kernel/sbi.c                       |  12 ++
 arch/riscv/mm/init.c                          | 126 ++++++++++++++++++
 arch/riscv/mm/tlbflush.c                      |  17 +++
 include/linux/pgtable.h                       |   8 +-
 mm/memory.c                                   |  12 +-
 14 files changed, 331 insertions(+), 32 deletions(-)

-- 
2.39.2

