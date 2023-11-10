Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5972A7E81C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjKJSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbjKJScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:32:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4B738795
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:07:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40a46ea95f0so4445035e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699625243; x=1700230043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lab8I/AjLwx8QNQ8rr3txbgHn2fsKjkqhEzna/zmzw=;
        b=pOES+n2F8B2QDH4/4oKWkP7kW3omn6lQJy3idaXgDpA59dEhNsx26nVp+X7R1IUbBr
         qx4CyJtfQTQMRHj56mQMf99A7pcLZygxkPuhAJHzXmmLfKeBK0vdpnviGrCuBNhTK5x0
         QBHcg3cUInh7PhBKSm7ODQc59uLSR3CJwmiLQ9qVqv9oTz0ytbxyg7p8TsfDTYvU6P5t
         fP1bODYa1mVZCRYIYdNlvN7ZHC+M7D/2Jdr2VeGV8brrf+/qm7wzQMT5hKHx/tS5ojhU
         buaJrovlA+NaZX1F8sbs5XO3803IqjKDR4tC8LmM2z8TVdXIXsPcUf2MEh/PqMaQI3rb
         q0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625243; x=1700230043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Lab8I/AjLwx8QNQ8rr3txbgHn2fsKjkqhEzna/zmzw=;
        b=WRSVDu5q1TV9lckwPpAWpQ0rWo09+qnmjQNjH4bB6bhY730VIDEGNWNgfTPMtDRjle
         UTbU9ywVwfUomIsW2js3daOSFvH4AhaPPtpXDSWt2NGSgP4GSuUcfiq7dn+ixN09JLGX
         IsDpEJH/RWPl6lKyfE+XhMoJmIdrQOt19FXJCTtqrx1ofGj/9+bW7GeADCyYoGgaFPAZ
         cs/WJ3DRaKp3IudHJmRcz5P+JloxcPRcB/Y01BZ/vzIVB5mizlHMaj9GmMpz82C02Cph
         OQAI87+3xYeYC39s/O3UfpK3iwddvMrpS7AaSOHgYs1RAAwAaVYEz6t/aGiCkCoq8dVm
         RomA==
X-Gm-Message-State: AOJu0YwTLkK4VPfYqXINGNLG15x+ANevIy3Qz6r00GyF1QvDc+RNfHi2
        IrKOsfaCwI1vuAEUPCTQ0pEN8A==
X-Google-Smtp-Source: AGHT+IG/nzRUsjO/+F11wysLbEQoEvuhHFDBxf/OGj/AjOAzkEpq6agysQ71COSHFWk4cO26ym7ZUg==
X-Received: by 2002:a05:6000:18a1:b0:32f:bd90:c22 with SMTP id b1-20020a05600018a100b0032fbd900c22mr6532442wri.62.1699625243298;
        Fri, 10 Nov 2023 06:07:23 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d560a000000b0032f7865a4c7sm1983318wrv.21.2023.11.10.06.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:07:22 -0800 (PST)
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
Subject: [PATCH 0/2] riscv: Enable percpu page first chunk allocator
Date:   Fri, 10 Nov 2023 15:07:19 +0100
Message-Id: <20231110140721.114235-1-alexghiti@rivosinc.com>
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

patch 2 simply enables the page percpu first chunk allocator in riscv.

Alexandre Ghiti (2):
  mm: Introduce flush_cache_vmap_early() and its riscv implementation
  riscv: Enable pcpu page first chunk allocator

 arch/riscv/Kconfig                  | 2 ++
 arch/riscv/include/asm/cacheflush.h | 3 ++-
 arch/riscv/include/asm/tlbflush.h   | 2 ++
 arch/riscv/mm/kasan_init.c          | 8 ++++++++
 arch/riscv/mm/tlbflush.c            | 5 +++++
 include/asm-generic/cacheflush.h    | 6 ++++++
 mm/percpu.c                         | 8 +-------
 7 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.39.2

