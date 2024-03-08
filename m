Return-Path: <linux-kernel+bounces-97451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47095876AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636511C213F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AEB56473;
	Fri,  8 Mar 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CC1P8bWP"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A3381D4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922362; cv=none; b=KfPCVhpcrcr+al24UR06JBwg/2V1ThcfVXOlvFNPOvkRVMu573bXPKqrGb7DngwN9zq1GxV3tVrf7/9n/87gmOx8Z8YccsMrhVS9hmm/4dNgKR301qLwnoA99KNeYrTI2eHMOhNTl0qVgT3/Lv93q5lHfi2omoEXOy6+OYgToWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922362; c=relaxed/simple;
	bh=mhSJPSDAQcTli1q8D3Nd6CYHlA7Z7/7MIiS4fHVZ1pM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CQJ92O2l6fYbDljh7cPNAZTjt/q4B9I/GRfUhAXd75dodXL24+VhHsCj9k/BSSEgR1TaEaQTngn0cTcZt3MlsTMO+aU1kHRlm+GjbOBKbt6+eOzy0f2M2aqVp+eF2MOWigSHhlrHyCi/PJgIyxtedmVtrV3mp8yENCn9lJSgmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CC1P8bWP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29b7dbe39ccso1708450a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709922360; x=1710527160; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoSjgbEckKxxEroEjUzvoD7N56Z9lulxyyOlHDmHt9o=;
        b=CC1P8bWPncOBEdB4UBaWosJz0ML9l+5gP6ZsFBhfuo4QKbOABpfP1c7E087GpQcnO9
         /AbT964FTVg1hFSs5KZXTNiPDNNrVTJ+BJvqM350zQxvoi9wGsTm2XOXI026DzX5R83l
         NjIYkrpH++1vfxRgUPx1Wcfi4TliRGJHPEwoJ4KNJyS0wQew3apITjnHdCLx3Wfe7oIo
         bl9GPDZEoHTwkgr5Pw9V0VdyOd/pWM4QGG+gyMFyesWpAHnq8bH/BrTb4z+kv3ySdA/o
         T7C91nfr2I3lKNIfTPh4PFRZK6ClMek+4fZDttWUdNCiaEhuNX9AA28jkjGCqza6R481
         VPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709922360; x=1710527160;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoSjgbEckKxxEroEjUzvoD7N56Z9lulxyyOlHDmHt9o=;
        b=nAly+aiVep+CCW6RgtTMuHsDEVqFXVO9YfpX4oawoep624Rz8t8myW+LQIMOHXJ/mv
         azYmC9Q7otNGVmhgr4o44A9xN97Qfw8+/CdzZhWIuZFDgTZsoQGog6LNnL7NPi7OXaFW
         BE853tVJCGdGCGYklkzB+yjSCyz65EuH9EbinuiPGoJ6E6ANxSVlEoIQ4WRgvMnA6HxU
         8Ej9biaM00eGbVDtql8EJBG8OETpj8KtBwAj9UiThzx1HN+YV1eG/lH6mxsOAs9or8AU
         kKqdyQn/VDigCJ5ZJ4CJ1OQDpBLP9S75BsHW7aKEbvAcn4LPSJrXbnOUxIhgmlvELMxd
         O/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWmhckjdKpUnH+c/dLeMw5FYZl0zSCWAvARj31m9gywVPFDjkQZrK5MmLhqLdHRZMWGXgkpdrm7FioyPDwKbIxDGUoc0H+996tXS33X
X-Gm-Message-State: AOJu0YznQuBjx4/WWBVeut5wzltFJU//UOuCrq+X1qGl4g4cAOBtGyIg
	D+t5o9YOIVK+ZW8atzaMaSU7SqsPl8pdVp+k6T2Pr0G1YyS3Rsnp82LB7Fr0LM8=
X-Google-Smtp-Source: AGHT+IFSkIT+TXIPw4/bXmAyNxdGsROJwo28zL5x77kShll5vQLukvADn1/0mZJpHVwpHsmR+jFDVQ==
X-Received: by 2002:a17:90a:df86:b0:29b:c432:c1bb with SMTP id p6-20020a17090adf8600b0029bc432c1bbmr257530pjv.24.1709922360133;
        Fri, 08 Mar 2024 10:26:00 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ac20d00b0029bb1bb298dsm44821pjt.35.2024.03.08.10.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:25:59 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v9 0/4] riscv: Use Kconfig to set unaligned access speed
Date: Fri, 08 Mar 2024 10:25:54 -0800
Message-Id: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADJY62UC/43QyWrDMBAG4FcJOtdF+5JT36MUo2XsCBIrSMW0B
 L975VxiisA+Df8cvlkeqECOUND59EAZ5lhimmowbyfkL3YaoYuhZkQx5Zgw0oVYrLtCf6v1Gsc
 JQn/PyUHv0zTEscOcWbBMicEwVJV7hiH+PCd8ftV8ieU75d/nwJms3eP2TDrcGR2IEGB8sPojx
 zmVOPl3n25o5Wf6Iik+QNJKKuWZ1A6CcrRBsi1J90lWSc/5YMiAmXOyQfINSeQ+ySsZPCYgNPH
 Y+gYpNiRV+6SopJNaMM0lUGUbpHyR7MgvZSUloeCCNANnuEGqLXngcLWS3mBODChrWr/UW/LA4
 bqSQtQVpXfMaPePXJblD0PDG6kWAwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709922358; l=3401;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=mhSJPSDAQcTli1q8D3Nd6CYHlA7Z7/7MIiS4fHVZ1pM=;
 b=9nd3CN2A2kFLFI1Z1TTqF/VXEKKQTjlAt9ZnI6vd03L2nOq15g+9nnrrcshi6CpFEerdBVIEC
 8i49edyJt3XBKpYQyftb+jc88oWQZWh3zRpgB731qopvdzKlje8w8xT
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If the hardware unaligned access speed is known at compile time, it is
possible to avoid running the unaligned access speed probe to speedup
boot-time.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v9:
- Clarify wording for RISCV_MISALIGNED Kconfig option
- Link to v8: https://lore.kernel.org/r/20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com

Changes in v8:
- Minor commit message changes (Conor)
- Clean up hwprobe_misaligned() (Conor)
- Link to v7: https://lore.kernel.org/r/20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com

Changes in v7:
- Fix check_unaligned_access_emulated_all_cpus to return false when any
  cpu has emulated accesses
- Fix wording in Kconfig (Conor)
- Link to v6: https://lore.kernel.org/r/20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com

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
      riscv: lib: Introduce has_fast_unaligned_access()
      riscv: Only check online cpus for emulated accesses
      riscv: Decouple emulated unaligned accesses from access speed
      riscv: Set unaligned access speed at compile time

 arch/riscv/Kconfig                         |  58 ++++--
 arch/riscv/include/asm/cpufeature.h        |  31 ++--
 arch/riscv/kernel/Makefile                 |   4 +-
 arch/riscv/kernel/cpufeature.c             | 255 --------------------------
 arch/riscv/kernel/sys_hwprobe.c            |  13 ++
 arch/riscv/kernel/traps_misaligned.c       |  17 +-
 arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
 arch/riscv/lib/csum.c                      |   7 +-
 8 files changed, 374 insertions(+), 293 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie


