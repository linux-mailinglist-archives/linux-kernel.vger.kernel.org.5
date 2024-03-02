Return-Path: <linux-kernel+bounces-89295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B674786EDED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548721C21799
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2956FCA;
	Sat,  2 Mar 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="La5R0TSZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CB46A4
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343942; cv=none; b=O4QTKHE6NZSOT6jN8oOj+773AhZSZsgJ2DPUQu5ifyjPwsWy7M/q6KIIAiPcvrjJlk6eNMaD5XCMHREaP6GEPSVZv0T8Rfz0ZydfALwJ3bxsR6JwgAvmfr+HXQA0TydzGt8oMpMmnnPE9be6TTyIczaGcl2py7r4hobFtcTynnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343942; c=relaxed/simple;
	bh=AF/qtPzIolOaxe9/FTqC+uBJizpQ6vi9O7Mq+l5S1Qo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GEZr4nkjcKboTaYRnKr/7Tftsd1sSC0mYSAjHZ2FvBABR0tURsnWggpFV5bQ4U+JPQ+B9n8cDcGTSsupcyyIdRR0sK+olvlGabXJ0NlpPDzboB6VQmyiX0mbo/nYO3VJKg178cNdduXH46GFh3AD7b2h48l8SulwPYm0ljFcSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=La5R0TSZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dcad814986so24226985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709343939; x=1709948739; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5mFoFuFbcNJOPQmIAO2L9Vn4st8gXt84zb/i3w3TkE=;
        b=La5R0TSZbnI+qRoVim0qpcz9ocxEwkXuFBl0KaCUlkar4iCXI8FOjJJ7XuRnGlvCbx
         8gnkwKdvZljfasALJFDPOI4xKlJsUlvCkzThc50uqq8whLD/RQ38yXy5X8NCIudN+stm
         +VfWIgupRoR0ebdlHKFywXha7F6xe2i0pcZEd016tWroV/18ep7xz2fBdVqJE6koUHL7
         ZTgKhHZ3LTeaPxrcuynqr0P5H3oS4GCwqxYDdoc4GcjVWQ1yHMt6FTdm6ohcfzjax8pI
         f6WgyN5eEvRGKWvWsN5oJKfCSumucvNs9Xn2McZNwRM3m8R5w6EuSBW3rE/u304tgLON
         H/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709343939; x=1709948739;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5mFoFuFbcNJOPQmIAO2L9Vn4st8gXt84zb/i3w3TkE=;
        b=AtPyLVe2dubxEn+v69vTBWHAYYynmU5SGLqXG9OPINSf7WyztztVOzr2a8XBS4UVQS
         OQQvZSopw4PzHy3wK86fX86I8Q7qMTNizJi0U0d/brYBe+fjgvwQrQ2ZMpEHlKDUocoR
         A/VP5qHLDfIky1/rup8dUu0HlMG8aHF6lKdE+EM+1D583x5LZ6UB3GrKM1DUO4keHMo7
         CSqoL/YKdMJJ7ScSAeQTzcFmjTbb1vRGwZ6Db9CwPYxJamaBFcCNYGXqi64gO6nHnfr2
         Sie/daKN0n9l+fRI8NFWTMRJzgqHm3NQ1MWjap49FZnpe2gJwfCGmTslx3Vc+2BhqFL1
         qAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9PIiT2Dp34h2R6fvNNcm6xSpdOA6sGrK126eetPRW8s/JCqOYu/hl0/lhGIVHM4+lBj/sm46YRQjnsKlT2nREiKvC1zAbfn3QM5Pr
X-Gm-Message-State: AOJu0YwBsLscCCUf3mVskjJj23Ci1J03rint+Z9a6Uox4+35vzKDkAcy
	WBhNfHwSoCp1TpB1EmygmPF1rKh8IR3iifM5LM6a+73G5yfol80E2pjgT3tT/23TT799rjr6IAO
	U
X-Google-Smtp-Source: AGHT+IE0pm1Ved8FSNSap/X5JQA5ih5TOaWSZiqZ2l0wNiPwXcQnN865flvrlFZVHf68Fg+S+qfvwg==
X-Received: by 2002:a17:903:2312:b0:1db:f03b:6f5b with SMTP id d18-20020a170903231200b001dbf03b6f5bmr4480786plh.56.1709343939487;
        Fri, 01 Mar 2024 17:45:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d71729ec9csm4129039plj.188.2024.03.01.17.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:45:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 0/4] riscv: Use Kconfig to set unaligned access speed
Date: Fri, 01 Mar 2024 17:45:31 -0800
Message-Id: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALuE4mUC/43Ny2rDMBCF4VcJWtdFd8ld9T1KMLqMnYFEClIxK
 cHvXiWbmmJwVsM/i+/cSYWCUMnH4U4KzFgxpxb67UDCyaUJOoytCadcUiZYF7E6f4bh0u4ZpwR
 xuJbsYQg5jTh1VAoHThg19oI05VpgxNtz4evY+oT1O5ef5+DMHt/X7Zl1tOttZEpBH6KznwXnX
 DGF95Av5MHP/I/k9AWSN9KYILT1EI3nG6RYk3yfFI0MUo49G6nwXm+QckUyvU/KRsZAGSjLAnV
 hg1Qrkpt9UjXSa6uElRq4cf/IZVl+AUKHzL4dAgAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709343937; l=2745;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=AF/qtPzIolOaxe9/FTqC+uBJizpQ6vi9O7Mq+l5S1Qo=;
 b=DxHWkIvZOJ4jwk8nWNt+XaA2f9CDv4zvoJntx/UIADDVjk1h/1Ra18dSlDBspY6sPMiWm4gKN
 lx4qP5yDMTzDvgP4Kgl/o42OQCvqNlgNMHUhis9MVSm2fNoeiobTJxM
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If the hardware unaligned access speed is known at compile time, it is
possible to avoid running the unaligned access speed probe to speedup
boot-time.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v6:
- Consolidate Kconfig into 4 options (probe, emulated, slow,
  efficient)
- Change the behavior of "emulated" to allow hwprobe to return "slow" if
  unaligned accesses are not emulated by the kernel
- With this consolidation, check_unaligned_access_emulated is able to be
  moved back into the original file (traps_misaligned.c)
- Link to v5: https://lore.kernel.org/r/20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com

Changes in v5:
- Clarify Kconfig options from Conor's feedback
- Use "unaligned" instead of "misaligned" in introduced file/function.
  This is a bit hard to standardize because the riscv manual says
  "misaligned" but the existing Linux configs say "unaligned".
- Link to v4: https://lore.kernel.org/r/20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com

Changes in v4:
- Add additional Kconfig options for the other unaligned access speeds
- Link to v3: https://lore.kernel.org/r/20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com

Changes in v3:
- Revert change to csum (Eric)
- Change ifndefs for ifdefs (Eric)
- Change config in Makefile (Elliot/Eric)
- Link to v2: https://lore.kernel.org/r/20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com

Changes in v2:
- Move around definitions to reduce ifdefs (Clément)
- Make RISCV_MISALIGNED depend on !HAVE_EFFICIENT_UNALIGNED_ACCESS
  (Clément)
- Link to v1: https://lore.kernel.org/r/20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com

---
Charlie Jenkins (4):
      riscv: lib: Introduce has_fast_unaligned_access function
      riscv: Only check online cpus for emulated accesses
      riscv: Decouple emulated unaligned accesses from access speed
      riscv: Set unaligned access speed at compile time

 arch/riscv/Kconfig                         |  58 ++++--
 arch/riscv/include/asm/cpufeature.h        |  31 ++--
 arch/riscv/kernel/Makefile                 |   4 +-
 arch/riscv/kernel/cpufeature.c             | 255 --------------------------
 arch/riscv/kernel/sys_hwprobe.c            |  21 +++
 arch/riscv/kernel/traps_misaligned.c       |  22 +--
 arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
 arch/riscv/lib/csum.c                      |   7 +-
 8 files changed, 383 insertions(+), 297 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie


