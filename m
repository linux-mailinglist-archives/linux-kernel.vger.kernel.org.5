Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20137812203
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjLMWrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLMWrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:47:46 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174FBB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:47:53 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9ac148ca3so5313193a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702507672; x=1703112472; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jd0FCgelTTfELHf4+xN904J8lDue1JGGAZgJGPEpLc=;
        b=3ZoFWTnvUL2CarTbGX6sO+B27e7bsIWyR/Xo/ljYfd29aTv0z8koYZ6h+oDQhXl5lX
         M5u2QhK5rm9X1yECqJHQWOyl60Rniy2baZ20nB/08e1zRbANBOTzuDUjf1fz3AgJO/Vk
         NwllQuH76m/zZna/VCLyxju+FREjvA9uWBuMuSCXVzMonMhFVUQDhkTkPuIJgsPZwlb+
         CDSlrS5yyXyVKFmX+mYhVNLlJxnGAzCi/VuHIM7L7kanPIfZPpdstdRZmg25GRxoi7lt
         tV0nf09rj4EiA5+y4MROyVpWsiUWNIkMuMdm+sF6FkOn5fslrvwyJk7XiVxyU7zXqu0V
         rCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507672; x=1703112472;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jd0FCgelTTfELHf4+xN904J8lDue1JGGAZgJGPEpLc=;
        b=E7z0ZSuyaUH7NvssxBdOJaHOILniJu7XfsGd2iQ4k3eo2h1gzvOOUXJKkG+9Gg3VPC
         0Ia7eOg56Mv26PVdaLpWKK6uxbA71BK4TaLOq/BuT2NmAV0iAzlJWXEtSAYcu+GmXD0Y
         Bfw/67GLmckoqX3f/8uxdjIvBII9QQiXZy/Nl3Au48hYPeBHKBV8Ij4+SU/L7iAfiPOY
         lgCMtik7JHFUHS7y6JlDARxxTb8cKyYHzsowIKw60VM3GqI7X/aQFF6X13v/L7gM1PXK
         aY0VlF2aRt1lNy4ZAk20/mQfECwiwOI4vrZR9DlMoQPiHsY0OJF+XiswbLlsy54lWMXP
         8ycQ==
X-Gm-Message-State: AOJu0YxeAxGTJlnriVXYl5Fc5Uxoc+VXFaGf61pY/Wh19rZGbBb+mrDs
        g90mf0ymZuUL2GjzWaJHtmX7Lg==
X-Google-Smtp-Source: AGHT+IEI/iMw+aM52TxmVlNAm6tlxyE95Jk7Y5bCZtOELwJ+3p+SBg1OfH9FjwiYVr1FIIAYA3ET6A==
X-Received: by 2002:a05:6870:3854:b0:1fb:251b:6f82 with SMTP id z20-20020a056870385400b001fb251b6f82mr8540545oal.55.1702507672335;
        Wed, 13 Dec 2023 14:47:52 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bk21-20020a056830369500b006d855e2c56csm2375157otb.31.2023.12.13.14.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:47:51 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date:   Wed, 13 Dec 2023 14:47:46 -0800
Message-Id: <20231213-fencei-v3-0-b75158238eb7@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJI0emUC/12MQQ7CIBBFr9KwFsMMpq2uvIdxUehgZyEYMETTc
 Hdpo8a4fD//vVkkikxJHJpZRMqcOPgKetMIOw3+QpLHygIVagDopCNviaXbu1aNXb9zgxL1fIv
 k+LGGTufKE6d7iM+1m2FZ3wnETyKDVNKQVT2ANQh4jJxDYm+3NlzFUsn4Y2r1NbGaaE2LejBgw
 P2ZpZQXYFRh/9kAAAA=
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702507670; l=1448;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/YlQ8qL8rFNrU4HyEupJRRntb59YBilc0ngS06eVjfE=;
 b=jwleU1mQbFQCVc8gBuGN2sz2YjwjLX2t4LgnF5VYuL/LUu7TfGfh9AgGss4pWe4XF+aafVadm
 1D/TRXdPTnKCmqHPKcxuSadEhpKsYxnHp3FyETHGk34qPGGwR6XIfO6
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

[1] https://github.com/riscv/riscv-j-extension

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Check if value force_icache_flush set on thread, rather than in mm
  twice (Clément)
- Link to v2: https://lore.kernel.org/r/20231130-fencei-v2-0-2cb623ab1b1f@rivosinc.com

Changes in v2:
- Fix kernel-doc comment (Conor)
- Link to v1: https://lore.kernel.org/r/20231122-fencei-v1-0-bec0811cb212@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Include riscv_set_icache_flush_ctx prctl
      documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl

 Documentation/arch/riscv/cmodx.rst | 98 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 arch/riscv/include/asm/mmu.h       |  2 +
 arch/riscv/include/asm/processor.h |  6 +++
 arch/riscv/mm/cacheflush.c         | 37 ++++++++++++++
 arch/riscv/mm/context.c            |  8 ++--
 include/uapi/linux/prctl.h         |  3 ++
 kernel/sys.c                       |  6 +++
 8 files changed, 158 insertions(+), 3 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie

