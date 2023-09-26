Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E0C7AEF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjIZPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5201511D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so22223625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695740632; x=1696345432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIpK3OqmG3E1OUm0KgMySKOtKP9RNzbuGFCeuFimfhg=;
        b=ijk1GXx8p6gF4Ogo26Ngd17caf/oV8jwwcKV2Mq3J311kzMUj6+kvsAwEG3A472d28
         /vGnjHkOgWf1VZh94SVMCCNVXfQH6YG5b3Ecx1Eax38bqZLctul9kHdxFLTed8fELbyc
         MsujkzpvixzG069MSjZdrfiLOddDvRDnHXSQg+ye8sBN+yz7QV9pqaGdrI/DQDgXtv86
         C248DPdNgNGN0YpBfgfBWIDE1/z7bTOYd63d3AgqUb1S4LAPGP9kq5ivLcwGW1ulzXqT
         H7Ho43COYwHBq45Wmp16TFKn9jCogh+6V3FYc7QIa/RpNWarYqpnCeMidrBpZ88Izbni
         J/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740632; x=1696345432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIpK3OqmG3E1OUm0KgMySKOtKP9RNzbuGFCeuFimfhg=;
        b=RsEb7jczClhpHo8XWTY/Bs5h0qOTFpepw66pyOdIFOIY5rRvu7zrx3PvRFqsEmP991
         +GrfMYk8VshYCdUmGU1bJYevixcTe4s2mTKPR0McN915HhW3NZlCChOmpuEjiGiujZb+
         vLX2bcQOatm+/2EA3GMZmgblJ+UyS+S3WfetkeP9fnrkCdyVRXBvJ6GHmTZLxPxEvZOu
         w/u7g2ClDZfg1XkLEZqBtvBqSV314K0QAm8XxaFtPQe1FXq6dDKVjnbXEq1fjl1k/b+/
         dQNe4kbbaj1MKMmaEAK+HyU0GetFFWL9fGhUWvY2YPH12sWAGkofGwOhm1EUwZkmuzKW
         PL9w==
X-Gm-Message-State: AOJu0YwqvuWudl6r2QvncvjkTr5trGKe1lXjJJneTuMDt2TybXd0F9p4
        juzXvoJXFyuh4GeXBgFzs06YdQ==
X-Google-Smtp-Source: AGHT+IFNTxn3ZjlQ5+Jtwf6UwRV/FhwgHLgxdXUERSMM8USfscRNhwx3BHgmb3Lm8sPO6lia6aTOAA==
X-Received: by 2002:a05:600c:1d82:b0:401:c07f:72bd with SMTP id p2-20020a05600c1d8200b00401c07f72bdmr8988881wms.4.1695740631744;
        Tue, 26 Sep 2023 08:03:51 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2b3d:6c70:9dbf:5ede])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm14926060wru.41.2023.09.26.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:03:51 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Date:   Tue, 26 Sep 2023 17:03:09 +0200
Message-Id: <20230926150316.1129648-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 61cadb9 ("Provide new description of misaligned load/store
behavior compatible with privileged architecture.") in the RISC-V ISA
manual, it is stated that misaligned load/store might not be supported.
However, the RISC-V kernel uABI describes that misaligned accesses are
supported. In order to support that, this series adds support for S-mode
handling of misaligned accesses as well support for prctl(PR_UNALIGN).

Handling misaligned access in kernel allows for a finer grain control
of the misaligned accesses behavior, and thanks to the prctl call, can
allow disabling misaligned access emulation to generate SIGBUS. User
space can then optimize its software by removing such access based on
SIGBUS generation.

Currently, this series is useful for people that uses a SBI that does
not handled misaligned traps. In a near future, this series will make
use a SBI extension [1] allowing to request delegation of the
misaligned load/store traps to the S-mode software. This extension has
been submitted for review to the riscv tech-prs group. An OpenSBI
implementation for this spec is available at [2].

This series can be tested using the spike simulator [3] and an openSBI
version [4] which allows to always delegate misaligned load/store to
S-mode.

[1] https://lists.riscv.org/g/tech-prs/message/540
[2] https://github.com/rivosinc/opensbi/tree/dev/cleger/fw_feature_upstream
[3] https://github.com/riscv-software-src/riscv-isa-sim
[4] https://github.com/rivosinc/opensbi/tree/dev/cleger/no_misaligned

Clément Léger (7):
  riscv: remove unused functions in traps_misaligned.c
  riscv: add support for misaligned handling in S-mode
  riscv: report perf event for misaligned fault
  riscv: add floating point insn support to misaligned access emulation
  riscv: add support for sysctl unaligned_enabled control
  riscv: report misaligned accesses emulation to hwprobe
  riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN

 arch/riscv/Kconfig                    |   1 +
 arch/riscv/include/asm/cpufeature.h   |   6 +
 arch/riscv/include/asm/entry-common.h |   3 +
 arch/riscv/include/asm/processor.h    |   9 +
 arch/riscv/kernel/Makefile            |   2 +-
 arch/riscv/kernel/cpufeature.c        |   6 +-
 arch/riscv/kernel/fpu.S               | 117 ++++++++
 arch/riscv/kernel/process.c           |  18 ++
 arch/riscv/kernel/setup.c             |   1 +
 arch/riscv/kernel/traps.c             |   9 -
 arch/riscv/kernel/traps_misaligned.c  | 374 ++++++++++++++++++++++----
 11 files changed, 488 insertions(+), 58 deletions(-)

-- 
2.40.1

