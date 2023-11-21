Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4DD7F3A71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjKUXrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKUXrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:47:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995411A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:38 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28517ef32c5so2349700a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700610458; x=1701215258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RixJBuqv66m88vK7HkxjwRMyXd1r/8nDIzSWxCduqJc=;
        b=dXyDZe4c3W/RobCZrnpBlIt/6LL1qSHdHYtVPjgHJtwumvpj6GE+FY6PTZmf5vyyL1
         cQ+Tiw7LOkHXy2OHP5KnyD4GkGvPpEn9+CRuWjBN665pabrAA1sCrL8tCDSZJL9IUP5s
         QWxuwkeZCeW7lVUQM7hmWmptwjHQJb8BKYzPTmZU8lyLQ0I8hJuMFjOJISQ4q6/QtPMv
         vQ3WfAXTbZAf+ppvDtFaKKKsYPvRQgsVomW+MM9erfBVEN7mommmdhObduHvDLSMSbbn
         mu58tYaQHsqPFpBuRg31/KWTp4YzoXprrm0OgzCUeuQEzjGrdMoIvZkYDP/yVl6WX2Kh
         mc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610458; x=1701215258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RixJBuqv66m88vK7HkxjwRMyXd1r/8nDIzSWxCduqJc=;
        b=mpfSz82B5OtkT2cofYQJ0oWGKZbcMliWxqoUescJcI+QQ9f+lDnXLcLbimwtV2uuBo
         dnTWSDtH+roCDxTdoSmZlNKc7EUJ2NSl5sXId+Z++GtxqIVUqhEtgMlhtlbpuKRGCkhV
         DpaynaADDDPD268m19CHkh87GQg6neA83Xl+Sw6RX15kY+K4zs9lyNqiv/chDjNGvUxC
         BEF0VKgmMUyLwFXJBDsEPWUWTrvCGpdtCB6IBGqp7ojOpuHIKVrwfQDeAg5NSAg5+uvE
         fKKzq4IpZulaegs8Kr2D+j+/0FWsWS0oHgWCQX3CQ9XKjk8WKjZ4etu9Sv+HN99b4mHo
         /T1A==
X-Gm-Message-State: AOJu0YwgRhU/wA7RKnDFmBS+7ftI1e3a8KMvlcV8FzUIqDDuQYhc4FTU
        UIuGfXY9VSfPqQwpl4xo1sV1cQ==
X-Google-Smtp-Source: AGHT+IHDkKs2xL45lFuDTJl1d3rsMKOJR5oPBJPpnDfEO73BUkwb+Y+0oJNhE0wtOzaTaMxFMtL3Lw==
X-Received: by 2002:a17:90b:1c05:b0:285:3444:94e1 with SMTP id oc5-20020a17090b1c0500b00285344494e1mr739281pjb.35.1700610458055;
        Tue, 21 Nov 2023 15:47:38 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b002802d9d4e96sm82234pju.54.2023.11.21.15.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:47:37 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/3] riscv: CPU operations cleanup
Date:   Tue, 21 Nov 2023 15:47:23 -0800
Message-ID: <20231121234736.3489608-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

This series cleans up some duplicated and dead code around the RISC-V
CPU operations, that was copied from arm64 but is not needed here. The
result is a bit of memory savings and removal of a few SBI calls during
boot, with no functional change.


Samuel Holland (3):
  riscv: Deduplicate code in setup_smp()
  riscv: Remove unused members from struct cpu_operations
  riscv: Use the same CPU operations for all CPUs

 arch/riscv/include/asm/cpu_ops.h     | 14 ++--------
 arch/riscv/kernel/cpu-hotplug.c      | 19 +++++---------
 arch/riscv/kernel/cpu_ops.c          | 14 ++++------
 arch/riscv/kernel/cpu_ops_sbi.c      | 19 --------------
 arch/riscv/kernel/cpu_ops_spinwait.c | 11 --------
 arch/riscv/kernel/head.S             |  1 -
 arch/riscv/kernel/setup.c            |  1 -
 arch/riscv/kernel/smp.c              |  2 +-
 arch/riscv/kernel/smpboot.c          | 38 ++++++++--------------------
 9 files changed, 24 insertions(+), 95 deletions(-)

-- 
2.42.0

