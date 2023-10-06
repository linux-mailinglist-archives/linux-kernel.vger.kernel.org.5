Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795BA7BB434
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjJFJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJFJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:29:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3399AB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:29:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406618d0992so18360855e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696584572; x=1697189372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq5rrYNyOOK7uZVK+/VCm6y827G0ymcilBxUQWM6O8Q=;
        b=3EeYVaolCSpQ0fincTxRnb6HJGNOfJlZQiX3F/X0t1TwjXzZ6AlSzBq1wKCKhy8dN/
         NaKGKYWe/PIHa6ytuUquuovrOP2HrQCtNcbZiNV9EboXBY/7qaMJ40RdHU2AprI5uJnx
         QyMIVPDRZx2fy0typ0URXw5yCm5zvNg0QJqPW6NwmSqwcrnbeDgQ2BHQwDGF/VGyW+pZ
         4BGYUdIZqTB6A4uwffawcPCpyai4WtG0W2jb+fToMXs+ZpUa+RiW6CUgh9pnSxUt8KFf
         RY1TJt1ua0YpqzTiw43I0+6devoQDQTKUz5eJc30WJAi5W1C/eSjtVswOxq4WYLvUDGf
         HAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584572; x=1697189372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aq5rrYNyOOK7uZVK+/VCm6y827G0ymcilBxUQWM6O8Q=;
        b=Lj+IiEAK8j8xkmr6eDXtnz8Cm5lhaqzI5QSV1hMjo+Rkt31MtUnPr8F/75kspFev1f
         z2wOBMLleLEZgPI+3wvjwG0POqZjRRXAx+DzmPbOLsLRheCEvYoIoo/Ovmmelj3YVp3J
         WdmL18iI9MLjRzmDJINN+HX2BepuGgB1nZKz/D8VkdxhUbrNhPnAG0fkk8qO3xjKMHr5
         ZnOrvGHTqNnfJPeaxW6/22viXO4NYodAYVJ0ib1yLB7A4+Ev+0Hk67UMwZXMC+MeSZfu
         SAZkhG6P92WoIAVDGaw4FdhywNot5UcAuittChWx67+b5afAE6vd2cgm7EJdwz6OXd4T
         NT7Q==
X-Gm-Message-State: AOJu0YxOJ8IDqCTHKwOf+16qqYxpdeziysPMvghoMojN42s9Zbs0+1wJ
        94aXgsPcss+wa9P2ImBiPn8Pig==
X-Google-Smtp-Source: AGHT+IGE5tqREDCmTaBollAfgLgxk91o9Pd50IbexKTPwcz2wvpiNku9RufkQ6YSoI+0goa1WscOyA==
X-Received: by 2002:a05:600c:2189:b0:401:bf87:9898 with SMTP id e9-20020a05600c218900b00401bf879898mr6919651wme.25.1696584572008;
        Fri, 06 Oct 2023 02:29:32 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b004054dcbf92asm3308911wmi.20.2023.10.06.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:29:31 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/2] riscv: Fix Fix set_memory_XX() and set_direct_map_XX()
Date:   Fri,  6 Oct 2023 11:29:28 +0200
Message-Id: <20231006092930.15850-1-alexghiti@rivosinc.com>
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

Alexandre Ghiti (2):
  riscv: Don't use PGD entries for the linear mapping
  riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge
    linear mappings

 arch/riscv/mm/init.c     |  12 +-
 arch/riscv/mm/pageattr.c | 263 ++++++++++++++++++++++++++++++++-------
 2 files changed, 227 insertions(+), 48 deletions(-)

-- 
2.39.2

