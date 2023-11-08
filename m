Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16827E5183
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjKHH7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:59:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14B3192
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:59:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso49925425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699430387; x=1700035187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JwSBQVb6gzPPp96ouDbhllQ0NgXknpa4e1qtpF4Lng=;
        b=WT9JjVALxLgd45Yu3oFlfhgYCddFUc9ElAy3Y7vmNH9cgpl0O2izrZL22RH4L1hkF9
         dvCOlSz2q5HtrZ+X0GSfvfxTlfjo/+bbapBZxSvsGeyMebTgj90C1kaB+sRG29TCEDxH
         OXbDk0vNRHpHon6Fq++eZR0JkAND2hsw3kzqs2D7rsELWitE+W+3yE/kORPRWVouZeP5
         n+vV/owBvm/rkMePEKo+PnWF6nvjzM4HLG2c/+LLxWJiE1doINJn3wCyY3YAeyAudsKG
         a3/jiPLAIBv2H6cx/YW3FivDQRnmdSo7xDStltAbmvYGzr65vLWHaK9WtTV1wNke4who
         kAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430387; x=1700035187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JwSBQVb6gzPPp96ouDbhllQ0NgXknpa4e1qtpF4Lng=;
        b=O83vPzfQioJ8td56IuX4RCqbhL1CeAPuqIpAcwULA1fkVdEFBzVrwOvKdkFiPmrLoA
         61Vqw5joMbFIm7P+WIDpRsgOsuc6x6CAanTeYvg/ZEU9CMQfN0nRyPPNf2aeUS8S3P52
         cTeWKq2S8WbuAi51EpgFZasRmcMG0+tvDb2gGkrcqcdSaylELqml8MH74vhmKgQRSkWv
         2rG9ArwNNqWx2kS2RZFM9NPGrqxKuCch7l38v7eGuEY+ILilt6YPfBe6O/Fh91JWbJVZ
         IqtWwqZNFhnwSMpRmBEq/22G+JDvZc+tvTuEU92/GsCXB/AcDm9Zra6CZdeGDz0OlFGn
         I2xQ==
X-Gm-Message-State: AOJu0YxESaaj1baxLD3YPs+x3Wv8upok6IPCgOqrnG1EK6KKPSPYpTft
        +Lsm/NPWtjyAr0RpZnBwOWO7Pqdj/GrLi9+m7HU=
X-Google-Smtp-Source: AGHT+IHZGNMDI0jyKZiSY6MKCJvZxFw8O9s4wGNsKWif0l8pMDZ26/WOd6aVZ9FdKc8rFEMYh9ddTw==
X-Received: by 2002:a05:600c:358a:b0:409:67bd:6fa1 with SMTP id p10-20020a05600c358a00b0040967bd6fa1mr1096777wmq.18.1699430387245;
        Tue, 07 Nov 2023 23:59:47 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b004060f0a0fd5sm18375687wms.13.2023.11.07.23.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 23:59:46 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RESEND v2 0/2] riscv: Fix set_memory_XX() and set_direct_map_XX()
Date:   Wed,  8 Nov 2023 08:59:28 +0100
Message-Id: <20231108075930.7157-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

