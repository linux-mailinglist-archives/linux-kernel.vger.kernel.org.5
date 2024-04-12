Return-Path: <linux-kernel+bounces-142065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185AC8A26F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3769287881
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2045BF1;
	Fri, 12 Apr 2024 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JBLmwOVr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF24481DB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904545; cv=none; b=bcAEx2xe450e0bjcpZdHZYfy3h41sncO8RiUbjkSBG0M0no39uwJIoXaLLMOvsWWMapbhW75ZDXuKevcOVKowx2jXFxv+AMGYSLzp43UnN66BWK3DBtf+IaJTNidgRnFWavnyA0gfRKEVrINi2sN5dt54eqsvuBPF1XdfIih4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904545; c=relaxed/simple;
	bh=nuMVzIYiPUK+rdCRW/LSWIvAdix9AYm7Os5AfBHAvj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a/a2YDSfnrF7j5hYBMXHdvyrsToTEsbMmCIJ5fBaMResf6Qok0k1R/BJwNnRsK0vmT0hoa0N4OnvzCtEH5ufRpHqg10KrtPRxwAOWr+7DswzvKOie7JZRoE91kQuW95nxL3HLS/ADhQzZpsHtpQt61jH1QgToVnBxtaP0/7Jx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JBLmwOVr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e220e40998so4323745ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712904543; x=1713509343; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USfQfM+UR81v7lHRAxHQQ1oLkFkV+dRc3UOcjHi01P4=;
        b=JBLmwOVrBWUGKVFHHKIyDNLlyaYSHDMb/MiYRd/6+2vqsJrSOviBqxXyEAgQV363UJ
         t31g8lmEyGhomgRVnmZwQz2BRQvu4dJ3AWww1/DRPVjKA58F5kJY+eE2dDs/z9u0fCZL
         mvz5T0AOlcEqlHxoSBaLvb/FV5oDuyXEbFCBuzxR9JmwphEtGFop4/M8GtxZLSWHDY4A
         k1TIblC0WVlXknri2UH3YnMLwwJ/fpIKYWoTHct5rG8sZlhEE+GurKZW0MKoWzySkRxQ
         zD+UNMgJsG0oCZ/n+mN0jUqxyVgIRFqVvhkqfmmyDb4OHQIHDCCSlt9of66eaPixGQBC
         31bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904543; x=1713509343;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USfQfM+UR81v7lHRAxHQQ1oLkFkV+dRc3UOcjHi01P4=;
        b=Gq8IXiM5Adc8U/DIHDUypQjWh+oXVH0UfNowhgW5VxdnwO3yuGWG971aBKmi1Q9NtG
         O/0/u8WxA5UkCO9UO9MewPp2Y2xJx5TnEnKq1FBThQpoQklwSeVF69Tr30gUF/DTl957
         /nMLzXuBa8TxtoLs1NAIdVantp/2zwtvvV9Cj5M0OxYqFXD8w826qyG1tlZ+ZW970Xpf
         bj1vjSZUJKMRzrj8oD2kDOJoxbsSdUegvOMOr/XbmgFDyIb2GhD3C7mABMKRXDvCRUa5
         I9oA40XayuRGf/05eYG7bNkmjjBRtajs9AY7pfjmLUW2XLvs0KcOl3edTFpjQCFDOc4g
         1nyg==
X-Forwarded-Encrypted: i=1; AJvYcCUCjvVpJgQg+GEHoCbEz4dJ25zkiN8xhnMMedUqAu3dinnqNISp3B821262J0gaEG4aXEpc2HYiauBMy3gPm4HOwoSsZM8vpWK2c/0i
X-Gm-Message-State: AOJu0YzuqCG78Ptr112JT1ShM3bFbh0S6UivbCTp8twY46mwr97JoMIn
	AfcKsEj9p1ilra5JhIbJimbFKew1mhXOOOP4Ucw1nzBov3riFXRtlM7bIE/lOq8=
X-Google-Smtp-Source: AGHT+IFGt59LZRrXTn7Yc6vTc14Z01BARI2Go5M4fYmzWCSl9LbWjZdfj71Auc/wFDqRBDgRn+JM8A==
X-Received: by 2002:a17:902:d50c:b0:1e4:e5fe:ce0 with SMTP id b12-20020a170902d50c00b001e4e5fe0ce0mr1931056plg.43.1712904543043;
        Thu, 11 Apr 2024 23:49:03 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm2258818plr.191.2024.04.11.23.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:49:02 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v4 0/9] Support Zve32[xf] and Zve64[xfd] Vector
 subextensions
Date: Fri, 12 Apr 2024 14:48:56 +0800
Message-Id: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjZGGYC/3XOsQ6DIBDG8VcxzD0DiFU79T0aBwJHvUFtgJJa4
 7sXnVw6/pO7X76VBfSEgd2KlXlMFGiecqhLwcygpycC2dxMcql4JVr4JgSLEU3Ml1Bzwa9WWl3
 LhuWfl0dHn8N79Lmdn0eIg0d9VpRQslayFF1XNyBAT3YpzUDveyBHCUszj7s2UIizX45xqdrNf
 ztSBRxQSKuk4I3T7Vnqt237AUdoMbbpAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-a684c

The series composes of two parts. The first part provides a quick fix for
the issue on a recent thread[1]. The issue happens when a platform has
ununified vector register length across multiple cores. Specifically,
patch 1 adds a comment at a callsite of riscv_setup_vsize to clarify how
vlenb is observed by the system. Patch 2 fixes the issue by failing the
boot process of a secondary core if vlenb mismatches.

The second part of the series provide a finer grain view of the Vector
extension. Patch 3 give the obsolete ISA parser the ability to expand
ISA extensions for sigle letter extensions. Patch 3, 4 introduces Zve32x,
Zve32f, Zve64x, Zve64f, Zve64d for isa parsing and hwprobe. Patch 5
updates all callsites such that Vector subextensions are maximumly
supported by the kernel.

Two parts of the series are sent together to ease the effort of picking
dependency patches. The first part can be merged independent of the
second one if necessary.

The series is tested on a QEMU and verified that booting, Vector
programs context-switch, signal, ptrace, prctl interfaces works when we
only report partial V from the ISA.

Note that the signal test was performed after applying the commit
c27fa53b858b ("riscv: Fix vector state restore in rt_sigreturn()")

This patch should be able to apply on risc-v for-next branch on top of
the commit ba5ea59f768f ("riscv: Do not save the scratch CSR during suspend")

[1]: https://lore.kernel.org/all/20240228-vicinity-cornstalk-4b8eb5fe5730@spud/T/#u

Changes in v4:
- Add a patch to trigger prctl test on ZVE32X (9)
- Add a patch to fix integer promotion bug in hwprobe (8)
- Fix a build fail on !CONFIG_RISCV_ISA_V (7)
- Add more comment in the assembly code change (2)
- Link to v3: https://lore.kernel.org/r/20240318-zve-detection-v3-0-e12d42107fa8@sifive.com

Changelog v3:
 - Include correct maintainers and mailing list into CC.
 - Cleanup isa string parser code (3)
 - Adjust extensions order and name (4, 5)
 - Refine commit message (6)

Changelog v2:
 - Update comments and commit messages (1, 2, 7)
 - Refine isa_exts[] lists for zve extensions (4)
 - Add a patch for dt-binding (5)
 - Make ZVE* extensions depend on has_vector(ZVE32X) (6, 7)

---
---
Andy Chiu (9):
      riscv: vector: add a comment when calling riscv_setup_vsize()
      riscv: smp: fail booting up smp if inconsistent vlen is detected
      riscv: cpufeature: call match_isa_ext() for single-letter extensions
      riscv: cpufeature: add zve32[xf] and zve64[xfd] isa detection
      dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA extension description
      riscv: hwprobe: add zve Vector subextensions into hwprobe interface
      riscv: vector: adjust minimum Vector requirement to ZVE32X
      hwprobe: fix integer promotion in RISCV_HWPROBE_EXT macro
      selftest: run vector prctl test for ZVE32X

 Documentation/arch/riscv/hwprobe.rst               | 15 ++++++
 .../devicetree/bindings/riscv/extensions.yaml      | 30 ++++++++++++
 arch/riscv/include/asm/hwcap.h                     |  5 ++
 arch/riscv/include/asm/switch_to.h                 |  2 +-
 arch/riscv/include/asm/vector.h                    | 25 ++++++----
 arch/riscv/include/asm/xor.h                       |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h              |  7 ++-
 arch/riscv/kernel/cpufeature.c                     | 56 ++++++++++++++++++----
 arch/riscv/kernel/head.S                           | 19 +++++---
 arch/riscv/kernel/kernel_mode_vector.c             |  4 +-
 arch/riscv/kernel/process.c                        |  4 +-
 arch/riscv/kernel/signal.c                         |  6 +--
 arch/riscv/kernel/smpboot.c                        | 14 ++++--
 arch/riscv/kernel/sys_hwprobe.c                    | 13 ++++-
 arch/riscv/kernel/vector.c                         | 15 +++---
 arch/riscv/lib/uaccess.S                           |  2 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  |  6 +--
 17 files changed, 174 insertions(+), 51 deletions(-)
---
base-commit: ba5ea59f768f67d127b319b26ba209ff67e0d9a5
change-id: 20240318-zve-detection-50106d2da527

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


