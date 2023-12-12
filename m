Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1180F97B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjLLVe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjLLVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:34:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAA2B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:35:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3333a3a599fso3892628f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702416899; x=1703021699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=692HNWJOlFtonZp1MhpojM8sdqlm3KHIVwJ0Hg03uAs=;
        b=Zx9ABdmelIvI892XBZPnSeYuq4sZ0jwwghjohngIlcD6LVcDMrlL24aTQSSWFPWsyL
         X+I1IAyOQYJfJ55qFzISJ4OXNCLdFRgmiCPl3rMhHrTB6m5GR+kxg4XIuH3gTL1qBL1H
         WhCjT6/utnc66ahcXxkDI1djU15KFfj1UY3YmGlHTmDsjq59jlcT3ipOUkagNiXdc9KV
         aMIcsv7YxrsYzyP67OIq8qQZETwByTLSHq+BdZtjWjAv0Rh1DOcpGpigqFd1LaiZ691P
         dG8kNSFrQJA6DuRcC1JlNLhOmKo4OqVCvRqZvPqOSLIY4dObLLfcENUUvIsAY3wRf+Ow
         5PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416899; x=1703021699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=692HNWJOlFtonZp1MhpojM8sdqlm3KHIVwJ0Hg03uAs=;
        b=PBtXW2JXazAubm5YB+U6NVdj0frLoPPO9AE61aAZ+1piuz7W1lTGuV/mn16LefJv+U
         X4EG3VFRk8hjdqV0S6XrU1ySopZPqmNAqtyYLF0uP+2fVtpHAJ9Q31aZUQBpSzDjIg1q
         rbKvXqGk8sCqvBgxjg9O5oMnUVid8AJlctoeafOsLtzsDgFoYvzgTEmI1o8MVQLPNISi
         Tjmrl6F2gvkt/wjvcgpqSnha92QzXoKe1NkdpPhmCiwRXwPPOAmqZyr3SNQXrt2UZoII
         arRN2YUod4zYIVSaFUY1VzG/y0WFbp67j62U5CNPEwTssaxpznuCHmRSFr4zWDxJy8YO
         FIzQ==
X-Gm-Message-State: AOJu0Yze+0JFfcYPnbmdpE0DOh0wUIHI2puIQK6BWZLzasRi69OH7M5b
        p+zXi4tRXlyjNJvhWlvYYZHM/g==
X-Google-Smtp-Source: AGHT+IFkzrnkDCYHfteg2uRMUBp/558DJ+5TYEbB94HHSPp6l/nbeDaimGFYdGQPy4EXupq5BMw1bw==
X-Received: by 2002:a05:600c:600b:b0:40b:5e4a:2374 with SMTP id az11-20020a05600c600b00b0040b5e4a2374mr3902004wmb.118.1702416899421;
        Tue, 12 Dec 2023 13:34:59 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bg38-20020a05600c3ca600b0040b540ff0a5sm17655337wmb.19.2023.12.12.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:34:58 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 0/2] riscv: Enable percpu page first chunk allocator
Date:   Tue, 12 Dec 2023 22:34:55 +0100
Message-Id: <20231212213457.132605-1-alexghiti@rivosinc.com>
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

While working with pcpu variables, I noticed that riscv did not support
first chunk allocation in the vmalloc area which may be needed as a fallback
in case of a sparse NUMA configuration.

patch 1 starts by introducing a new function flush_cache_vmap_early() which
is needed since a new vmalloc mapping is established and directly accessed:
on riscv, this would likely fail in case of a reordered access or if the
uarch caches invalid entries in TLB.
Note that most architectures do not include asm-generic/cacheflush.h so to
avoid build failures, this patch implements the new function on each of
those architectures. For all architectures except riscv, this new function
is implemented as a no-op to keep the existing behaviour but it likely
needs another implementation.

patch 2 simply enables the page percpu first chunk allocator in riscv.

Changes in v2:
- Rebase on top of 6.7
- Define flush_cache_vmap_early() for all architectures that do
  not include <asm-generic/cacheflush.h> to avoid build failures

Alexandre Ghiti (2):
  mm: Introduce flush_cache_vmap_early()
  riscv: Enable pcpu page first chunk allocator

 arch/arc/include/asm/cacheflush.h      | 1 +
 arch/arm/include/asm/cacheflush.h      | 2 ++
 arch/csky/abiv1/inc/abi/cacheflush.h   | 1 +
 arch/csky/abiv2/inc/abi/cacheflush.h   | 1 +
 arch/m68k/include/asm/cacheflush_mm.h  | 1 +
 arch/mips/include/asm/cacheflush.h     | 2 ++
 arch/nios2/include/asm/cacheflush.h    | 1 +
 arch/parisc/include/asm/cacheflush.h   | 1 +
 arch/riscv/Kconfig                     | 2 ++
 arch/riscv/include/asm/cacheflush.h    | 3 ++-
 arch/riscv/include/asm/tlbflush.h      | 1 +
 arch/riscv/mm/kasan_init.c             | 8 ++++++++
 arch/riscv/mm/tlbflush.c               | 5 +++++
 arch/sh/include/asm/cacheflush.h       | 1 +
 arch/sparc/include/asm/cacheflush_32.h | 1 +
 arch/sparc/include/asm/cacheflush_64.h | 1 +
 arch/xtensa/include/asm/cacheflush.h   | 6 ++++--
 include/asm-generic/cacheflush.h       | 6 ++++++
 mm/percpu.c                            | 8 +-------
 19 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.39.2

