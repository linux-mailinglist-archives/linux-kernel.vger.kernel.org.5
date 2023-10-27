Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E327D9B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjJ0Odc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346012AbjJ0Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:33:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D8C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:33:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso16272715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698417206; x=1699022006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JwSBQVb6gzPPp96ouDbhllQ0NgXknpa4e1qtpF4Lng=;
        b=z7mRtw1t52QVAYRFB+GQHZHXeqmoE2MfBBcH71XQtlT+P9rHFEVuAys+EGebU2P3fR
         dz3ElIcF76EksC4Ib689dRotfKH1xTKMin3Iz5hJbhMK1JomR+6t9FlAtyQ5g8Q5C2uT
         3hIx3hwDEUOg3/zqb2d1pAKJPcPH7tN3fFTBgazPqnibS9ukO8BxpKhma7kQoxLrPH2i
         2QQKV56ZQViXnkXUxMb9eXXvHs5urUjBpnUieOxmy4pszMPKURUcb7xz4bvzj+O29GMw
         j0L47Lyd/lX+eIhaOJpe2xTiHSGd0HutJEdf5p5GJF+TSMfcDHSwt8g5jmze1ZdzfDKq
         vqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417206; x=1699022006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JwSBQVb6gzPPp96ouDbhllQ0NgXknpa4e1qtpF4Lng=;
        b=bjWQqBC/wfk58d0oDlIhj6fFeD8oSm3y/nRE2JingKZ0u5w/0nzDgQpo1Df2dvmPSn
         CW+wVb0RiwP+31mccLwng9g9EDUovXai968lwoWJzb8B7p7sNek/mLLvKnY4d8wAEQ/C
         +UlLVzOlE7TczmJe6yOlf9gREuefV7GbwJMi4WCmKsrdPwy609aEctw/8r6+xNFgWdln
         cdlu7ghwql9pvqrcOEq2zlPLCxGf6+skvbUi2ucHjcTN3PkFedP1ChBhVOUAqN0SS7q3
         5Qcq2+JhHPGL25q4rRB5rgjZN9oozrwha8hvqno4dAycfcnK5RUwgxjTxaH9c/QoFo+G
         C3BQ==
X-Gm-Message-State: AOJu0Yw23P6S1zL2hRR/SiAxvNxuPGAHGzN+WdLYh6J+AdD2D/X7ik/2
        bQHKWufwGfPY8LyH078XNj9Zqw==
X-Google-Smtp-Source: AGHT+IE4qImdSk09CNorktipLEcTSx86X3aQzJS9ekoeGoWSSk4YjvLWqTnQAzRvuwoDmI4fO362MQ==
X-Received: by 2002:a5d:6da8:0:b0:32f:710c:6d92 with SMTP id u8-20020a5d6da8000000b0032f710c6d92mr1459732wrs.21.1698417206391;
        Fri, 27 Oct 2023 07:33:26 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c8-20020adfef48000000b0031fd849e797sm1867433wrp.105.2023.10.27.07.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:33:26 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 0/2] riscv: Fix set_memory_XX() and set_direct_map_XX()
Date:   Fri, 27 Oct 2023 16:32:20 +0200
Message-Id: <20231027143222.115588-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those 2 patches fix the set_memory_XX() and set_direct_map_XX() APIs, which
in turn fix STRICT_KERNEL_RWX and memfd_secret(). Those were broken since the
permission changes were not applied to the linear mapping because the linear
mapping is mapped using hugepages and walk_page_range_novma() does not split
such mappings.

To fix that, patch 1 disables PGD mappings in the linear mapping as it is
hard to propagate changes at this level in *all* the page tables, this has the
downside of disabling PMD mapping for sv32 and PUD (1GB) mapping for sv39 in
the linear mapping (for specific kernels, we could add a Kconfig to enable
ARCH_HAS_SET_DIRECT_MAP and STRICT_KERNEL_RWX if needed, I'm pretty sure we'll
discuss that).

patch 2 implements the split of the huge linear mappings so that
walk_page_range_novma() can properly apply the permissions. The whole split is
protected with mmap_sem in write mode, but I'm wondering if that's enough,
any opinion on that is appreciated.

Changes in v2:
- Fix rv32 build
- Rebase on top of 6.6-rc6
- Move the flush_tlb_all outside the mmap_lock

Alexandre Ghiti (2):
  riscv: Don't use PGD entries for the linear mapping
  riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge
    linear mappings

 arch/riscv/mm/init.c     |  12 +-
 arch/riscv/mm/pageattr.c | 270 +++++++++++++++++++++++++++++++++------
 2 files changed, 236 insertions(+), 46 deletions(-)

-- 
2.39.2

