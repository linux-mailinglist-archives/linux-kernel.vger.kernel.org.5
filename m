Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A17BC361
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjJGAl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjJGAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:41:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03ABBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 17:41:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c87e55a6baso20686675ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696639278; x=1697244078; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hp0ECJm0gFf8INn0HiZKpVqg/IUsayxsh+1diajkmI=;
        b=0snFmb3PiemW40ppTS6XhdS+2Q2BYx3bB5yjqUtuthVDYihbbHjT4n/ZhmtNuDQ3Ot
         wv1n5sY4TbZHk0RL0/NtPlmSZZF/Gb/HxGPwmOHplmP3eWImzxG1lP9AvVUFBQR132Dt
         SERJgx2ksaS6ZVM/MhxsjwymIu2RactGqsKWdN06g6p+9hNXH4CyyVjRzw6mnCa0rsaq
         kHBPS8EYWktLwkSUqLX5MmPPTZEsdfs5eFQHbZEiObnPavb7jMsFGNzkGllRtT8h/GrB
         tLbcO166lHTlsUurqH76vXIqYVNNCVDMc7V+59BCDTEKvzKgMuhXJ7Kj4oPYwju1enNh
         S8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696639278; x=1697244078;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Hp0ECJm0gFf8INn0HiZKpVqg/IUsayxsh+1diajkmI=;
        b=udW/LGgm9locIHcVC/PtGLMV7+eqMflF/h/K6LTOQd2CMA3rwGx6I6K+5jnjkxcJUt
         nBAgpn25YLmtL1yZXp3xePbfAXV0/HGmmHa/1gRa/SUGCdbLDOh0gveg5I4rJXFi1x9/
         0whpq1Ih6jRCE0SGp2DGM1W1JLtoPL22xqBBNR62RSzs31cM9DzCd4Cc6x5rmcwPVl0D
         yC8wym7mI0P411tjhZeSUDAQWCPPjKL9LjME0r2mSEZdjpO7aIu3WWzYxxs7pJJnjk4P
         /nMx+gWIxqbVBGXkkdDe8kVjsJIVP/0vexf6U8aY273850fgohxnyJ/+yvSO3HhSu+8d
         pUVw==
X-Gm-Message-State: AOJu0Yxb/o1ibziJCWvj6b01uRuxwt2hngQoigaH7ITwz8WrrnkCFkTp
        hV7x+C0+gyfHN+gi7nZurTucjw==
X-Google-Smtp-Source: AGHT+IH9WxpF3kdiS9QaTEtUj5obvaHiYFW9XD6AGPsPbfksFSz9GOfBX62HTFtC8jFHFpfd0gjD2A==
X-Received: by 2002:a17:902:c112:b0:1c0:93b6:2e4b with SMTP id 18-20020a170902c11200b001c093b62e4bmr9338829pli.33.1696639278389;
        Fri, 06 Oct 2023 17:41:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001c582de968dsm4534540plg.72.2023.10.06.17.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 17:41:17 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] riscv: Add remaining module relocations and tests
Date:   Fri, 06 Oct 2023 17:41:05 -0700
Message-Id: <20231006-module_relocations-v2-0-47566453fedc@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGpIGUC/22Nyw7CIBREf6W5azFQlD5W/odpTAu39iYtGKhE0
 /DvYuPS5ZnMnNkgoCcM0BYbeIwUyNkM5aEAPfX2joxMZih5KXnDa7Y485zx5nF2ul9zO7BRSY1
 GncVgKsjDh8eRXrv02mWeKKzOv/ePKL7pTyfkP10UjLNhkKY+qQqrRl48RRfI6qN2C3QppQ8nx
 buxtwAAAA==
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of module relocations were missing, this patch includes the
remaining ones. I also wrote some test cases to ensure that module
loading works properly. Some relocations cannot be supported in the
kernel, these include the ones that rely on thread local storage and
dynamic linking.

ULEB128 handling is a bit special because SET and SUB relocations must
happen together, and SET must happen before SUB. The module linking
ignores a SET unless it is followed by a SUB. In order to find the
corresponding SET, module linking starts at the relocation above the SUB
and iterates up until it hits the SET. If a SET is not found, module
linking fails.

This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
RISCV_MODULE_LINKING_KUNIT.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Added ULEB128 relocations
- Link to v1: https://lore.kernel.org/r/20230913-module_relocations-v1-0-bb3d8467e793@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Add remaining module relocations
      riscv: Add tests for riscv module loading

 arch/riscv/Kconfig.debug                           |   1 +
 arch/riscv/include/uapi/asm/elf.h                  |   6 +-
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/module.c                         | 247 ++++++++++++++++++---
 arch/riscv/kernel/tests/Kconfig.debug              |  32 +++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 ++
 .../tests/module_test/test_module_linking_main.c   |  73 ++++++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 ++
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 ++
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 ++
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 ++
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 +++
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 ++
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  20 ++
 18 files changed, 574 insertions(+), 26 deletions(-)
---
base-commit: 82714078aee4ccbd6ee7579d5a21f8a72155d0fb
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

