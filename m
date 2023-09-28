Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4207B20F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjI1PS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjI1PS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:18:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287E399
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:18:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3248ac76acbso549351f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695914332; x=1696519132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XhINO5OKvYBbRtcmNNCbEmBFeMKEzNeQfLz10xju9g=;
        b=xw1bgQX1oDmBM/OY6Hw9WZPVrX3zkQYOTStxbmCuXhY8HuBco3dSDWgEgegkmRL74s
         arn17s54a9sSYWK7Xyeh3Juw8HMNVknAtGzN81kl9pY+IiELzS6nchLDrfUQq//GAly3
         C8nIxz/b0A+bBQ2/QJmXYX1s8q/isCGvJR5rZ+SXwRS3dUaQ0UO6uGKL5rGEElwddK41
         bgu02zop09OwM9lcY5H2zEVgVqYO7l/0Hy1HiCU3kTYhqrib3MsQen1NjS2lhJhFX71+
         /CYNM77K9YA5H+2GQPjldbs3uGjiq19EsjdTMDIyB/jH2QzWGHFgdNsEV+VBVLvL/G72
         o1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914332; x=1696519132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XhINO5OKvYBbRtcmNNCbEmBFeMKEzNeQfLz10xju9g=;
        b=Jnj7svyMQYjI7+sw/L/pTgkG4FKOnV93nmGwcC1HgyjVBVx8xFiOmGl2JCBp5e73B+
         WP92zYUl6NE+KpH6DEcnodYGt1C8I6ShFgz8QHC0LEWT2v/0ij0RdMNoXA3LQWyXGj9y
         Nv1ZuCY7k7a9+1D0P6p59YbcZLNdLgscSoAvlWdps+rUw4HvXMBWsCDKVG+ytbdHk5hg
         I496fIdDIjY/RzvKQg8bvNxh0Vhav8YY7L2EYwWbXQIQ81KG4CbhBm+7GmwfOkvLKM6n
         +doMZ6Hd90BuK09jJ/ETmf4i70MBDvrAimuOsl2E2H93bpTJhTvqbxpSw8x+o30XcyZ4
         sqGw==
X-Gm-Message-State: AOJu0YytSmV9tyrjPYxDLsSqO3qb/ap3QHFwPh9ehvutjHcZuemW1Sw7
        CmZFeMIPnxIxGDY6zBHqT5hKtA==
X-Google-Smtp-Source: AGHT+IF3BMKsooFSz5jXnPOpNsl9uP20YFz7wKsRZjStJ3sFQX1KVDhrcuc0QJibCu2PmsavTb0EGQ==
X-Received: by 2002:a5d:4047:0:b0:324:84cd:5e67 with SMTP id w7-20020a5d4047000000b0032484cd5e67mr1401707wrp.6.1695914332582;
        Thu, 28 Sep 2023 08:18:52 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2a02:8440:4541:1a11:c4e7:d9ee:586b:e201])
        by smtp.gmail.com with ESMTPSA id a13-20020adff7cd000000b0031ad5fb5a0fsm4692046wrq.58.2023.09.28.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:18:49 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 0/2] Fix set_huge_pte_at()
Date:   Thu, 28 Sep 2023 17:18:44 +0200
Message-Id: <20230928151846.8229-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent report [1] from Ryan for arm64 revealed that we do not handle
swap entries when setting a hugepage backed by a NAPOT region (the
contpte riscv equivalent).

As explained in [1], the issue was discovered by a new test in kselftest
which uses poison entries, but the symptoms are different from arm64 though:

- the riscv kernel bugs because we do not handle VM_FAULT_HWPOISON*,
  this is fixed by patch 1,
- after that, the test passes because the first pte_napot() fails (the
  poison entry does not have the N bit set), and then we only set the
  first page table entry covering the NAPOT hugepage, which is enough
  for hugetlb_fault() to correctly raise a VM_FAULT_HWPOISON wherever we
  write in this mapping since only this first page table entry is
  checked
  (see https://elixir.bootlin.com/linux/v6.6-rc3/source/mm/hugetlb.c#L6071).
  But this seems fragile so patch 2 sets all page table entries of a
  NAPOT mapping.

[1]: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1-ryan.roberts@arm.com/


Alexandre Ghiti (2):
  riscv: Handle VM_FAULT_[HWPOISON|HWPOISON_LARGE] faults instead of
    panicking
  riscv: Fix set_huge_pte_at() for NAPOT mappings when a swap entry is
    set

 arch/riscv/mm/fault.c       |  2 +-
 arch/riscv/mm/hugetlbpage.c | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.39.2

