Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D984C7F3C25
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjKVDGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVDGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:06:30 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F9190
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b833e11c96so822717b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700622385; x=1701227185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4I/LD7GmsgMbduRtQjHbuBVYFqV+JeYB9eIa+Lz0UU=;
        b=He//zPNqCvhzPY85ocBT3g/uIKaGcbWfxyFWQMDuVsPK1bFRVJqEJTvkEwZl75olGl
         yJlr/0vRMaQaQzHsYqYRh4NgHJo6897Ivwp/hGCLTNF8DPL0Ee6r9gWJUn9XeXhHFZxt
         /d/1yviEggLz/AFR9uVAfh0ROXxIh1SMFqY38q4kTbAwVqHSlVRgCsyAPNZVfceDS6zf
         m55xg28TO3pH/svWuDChaOL80oPqtvdBUx3rV2LDVHSpWaUxlOzXk4/WYVRe5/Ffe12V
         RHFhFv37EeVTWZ79vg20ya4/gFCGZ/drVjHcP3XzfACsQiUH7qjGLmHK8/Cg7YRJHGER
         y7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700622385; x=1701227185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4I/LD7GmsgMbduRtQjHbuBVYFqV+JeYB9eIa+Lz0UU=;
        b=TSFa+2wUiVUxR15LH3y57G6s0YhNBH1CmmyC/Am/7ilajcg9m4lMVg1mky7xUI66st
         J/Um+UV2XsfZqrgWE4WjHTAQtyqlHo/1odVrJ8Kma1Ngj8+kSbwTWHMmh13NPKXnYUIL
         /JX02Jk7reyk6iYSsKedad5ClpSghpc7TJW8BRsN5Kh5Mc7RWH1Qyen0PaCg9H/Nb1gi
         Ff69dyq1qVKlypV5tnrDtMNubcRRn2sc15rRlcyXoxDOCTuJJDX4iPuYeaQSHiymaXty
         Ks5JT1OPE1rJi4Ttx1VvHd0xQVsyEKTiubOm56B8iEhXgEu/jx2uwCBD6BNWWfAn12vq
         PrBQ==
X-Gm-Message-State: AOJu0Yw+w9nEqM3m9zSs+knqf28Rw1GGPFxrz0Is0Gt9V61MYKoG2Uo0
        AN/cW30uav2erCDhmaZwYVIv2A==
X-Google-Smtp-Source: AGHT+IEIpXI2h8pXg+ykpqNNYZiarqi3t5LKkDhtbal14Y2nnzqjhX+0ng3mTUwJLxHE3tG0iOG9Lg==
X-Received: by 2002:a05:6808:bce:b0:3b8:3ec6:8a41 with SMTP id o14-20020a0568080bce00b003b83ec68a41mr673776oik.45.1700622383389;
        Tue, 21 Nov 2023 19:06:23 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s2-20020aa78282000000b006a77343b0ccsm8614917pfm.89.2023.11.21.19.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:06:23 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/3] riscv: Add kernel-mode FPU support for amdgpu
Date:   Tue, 21 Nov 2023 19:05:12 -0800
Message-ID: <20231122030621.3759313-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows using newer AMD GPUs (e.g. Navi) on RISC-V boards
such as SiFive's HiFive Unmatched. Those GPUs need CONFIG_DRM_AMD_DC_FP
to initialize, which requires kernel-mode FPU support.

I'm sending these patches as one series so there is a user along with
the infrastructure being added. I assume patch 3 would be merged
separately, after patches 1-2 are merged.


Samuel Holland (3):
  riscv: Add support for kernel-mode FPU
  riscv: Factor out riscv-march-y to a separate Makefile
  drm/amd/display: Support DRM_AMD_DC_FP on RISC-V

 arch/riscv/Makefile                            | 12 +-----------
 arch/riscv/Makefile.isa                        | 15 +++++++++++++++
 arch/riscv/include/asm/switch_to.h             | 14 ++++++++++++++
 arch/riscv/kernel/process.c                    |  3 +++
 drivers/gpu/drm/amd/display/Kconfig            |  5 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c |  6 ++++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dml2/Makefile   |  6 ++++++
 8 files changed, 53 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/Makefile.isa

-- 
2.42.0

