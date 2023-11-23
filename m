Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57A7F55B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjKWBDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKWBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:03:24 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B471B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:03:24 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f9460cb66cso266615fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700701403; x=1701306203; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXabQ8A/xezWt9SHwrUsDTpRrD0byx6vytti1k+h2UE=;
        b=LMJg2PM112Id3QTK20OuNoQGlqTFWQ8P05NwSaSgctPCtcLvwCM0b6NARl5H5W9e1f
         lW5IbQK/islbtaM/eHlFQPwIVXGM44yl+zdW8ZiettigoT0Wb52xma98LUg+ivJXpYzf
         vfe5JK6v9soMHl/F53MkanffUypkWwnb+fMCKMssMiAYsQYQ+PW1yLPtfYkOF4rAn4sZ
         8UXTuDEKYqSrnvDA6ar+jQmLGbELXFB7Cp3SjEjjf061yJo/Uqk9cOJ4upzVZX3f1j8p
         VbLxOm6A/9wxaNNjw+AFz7OpN+LKmV0lshrgwJQV4jhGMaAWVboMS30cwAiVnL4Jl0d6
         QA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700701403; x=1701306203;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXabQ8A/xezWt9SHwrUsDTpRrD0byx6vytti1k+h2UE=;
        b=W6LZ4rokr+SyH5++RsQDklgdt5iojjqIEfLH2EfBuiwAAfofIAyYNYEXsfbz12zRb9
         rDK67BPHZcZw7qQ+/7yvmr9WB8s/3T6qc1j/CFtwHaCD7CWB90fRzMDIYVufCrxQvW8+
         kJSm3zYzvpOBWeKjXKBFFFyNTL0bhiPhLE3fWUxctGnHHMHsVBdkAhJbQqW4oej8Dta6
         +HcOpSrynBJw0ZkpvLZYfyGinvDpOzN5gk/EFr6Z5Ul3eI4DE3roSF1XvfaeCQMksUu6
         yX1vQKChMVU78/XhLjIVc/w+jzjWAiWzowpl98W3nJxY/swIuDOKem0RCnFAVbefD2mg
         ejJg==
X-Gm-Message-State: AOJu0YxqdULlEFQ6+POuFUj2ucSFj+ISd+HN2tGBRNbA1TGI2q6SR7CD
        58n1ncGH+mn9gxgpo7EpYJ2ZqQ==
X-Google-Smtp-Source: AGHT+IE3OiXSh/n62NzPcNJaO+UHvJxiRtnLq/HYy1a6CdXhApFeh1e7Zqff1Hl+t3oaIiBUu1WcOw==
X-Received: by 2002:a05:6871:e405:b0:1ef:f14e:6f0a with SMTP id py5-20020a056871e40500b001eff14e6f0amr5800832oac.0.1700701403123;
        Wed, 22 Nov 2023 17:03:23 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id oq12-20020a0568707d8c00b001dcfaba6d22sm65834oab.46.2023.11.22.17.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:03:22 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date:   Wed, 22 Nov 2023 17:03:19 -0800
Message-Id: <20231122-fencei-v1-0-bec0811cb212@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANekXmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQ0Nz3bTUvOTUTN00yzQzgxRzC5O0RAMloOKCotS0zAqwQdGxtbUABi+
 6+VgAAAA=
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700701401; l=1107;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=auzvGFp5g/T2qKBKlxbBfjnxEnv0hfKBNeuhh4Tx5wI=;
 b=RjXz/cYS321dvE4vAtGlRzqisR7ZU2GZV1umThCtWmuouptXgJgCogbp8jWViNc1v5bECzLkH
 JXVo2y0JtX4AkFFBaia53RtJSeZ1kp+askJq0Sm+YQhWqXbnbXRZHBN
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

