Return-Path: <linux-kernel+bounces-150301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE578A9D07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF6A285587
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDFD16ABE2;
	Thu, 18 Apr 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YU8IcQvL"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4B168AEF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450434; cv=none; b=S2NBUsgEM4jNuyOxY8x43Z2zb8nrakgL9znMQr7AvjrvAarEG8KsHMBMGdSM3Lp8pxZChKGkMV/Pe5R9AEwzgJaAU/HFVnxTXSLUrwBwflcA5CV8iZAPmlgIBa8C/vKGPNHB81GDSz6hthPODdXFZqvcCPXo7JlANhzLT+/Erf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450434; c=relaxed/simple;
	bh=4xAZjsq5NBCk8pMTWSn7cGEZjggQAqPnOuHGhTfr1N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dbcLusqlw1Zq0KffKu/QlIHt+pamlcTT4V00KRvSG1cN3AazT795PAWJ4XbN8LxHZLMF0luOE+jlQlGZACJvDMB+nAWhL/FghzgFtdf5Rc3s4NU8WdWsoivmF3/0lCPd2DiBDFM2hBlT5Sq2qm8V0ZI8fnT1ZRVHDyr9lNpu62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YU8IcQvL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343d32aba7eso184337f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713450430; x=1714055230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3RiUuSEoG2S8esV/YzS5auTHlA7j5ReVp1mTpYduo8=;
        b=YU8IcQvLzq9Q8bZtr3YqGNHYXi9jReRjVxb/R36xMx/8xGG8lrZiSXtRZhbC6+ZgLs
         wHue9C5RQ+UWNIo8YMUjUHz1hH9ys7HCBz1vIYWAdAUFOTK09+RAZ/7aKM/SilbYrx/P
         XVMJGHh2oWPHIbU5boayw1RD4dO5X4vCkuU9L57E2xV1CiV53YJpXKGwqDKGwMwa/Phk
         oaGNohhWNULpW7bhOuUv+66M8uk9ngicnDHQNBBv0+nGRstAvTGON6AdHsxZRRb5kXdt
         Rpfpm67eR4PrS6y5UGP93OwNCH/sD8wlk67qiy+ZI/XYju3s2thIjPaNP0lm4Hmn4jGI
         5abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450430; x=1714055230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3RiUuSEoG2S8esV/YzS5auTHlA7j5ReVp1mTpYduo8=;
        b=OisPw8JTGsZA2fqYdYkEOUHF2+leg9s6irjqVz2UkUDr1b+3xWbImIsasxNoelqYqz
         29w6p6Z+iGMl+wLCJMkjpuCuq6VPK+JWKwLipoOxVa/+txxbhWuFQIrzwDgHHezQkeV4
         +cyRm9+ysFwjcxi9JL5HqTuGxyKoUpqD5k04qhOqQUdR1i7Bqqmo51AhxMMjUyYYYNbo
         +6A8Ir4xhupiXyPqAQmQKZrZtNFuosy9mrmLghuq/AbvQ2c/P6ggQpxHDlyTFjWHLUKY
         D1RHPvfkgeqLT/Lj90h4j2/XzwpQlouowF9zPytN54KP9gODyHZ+JxGONRD/xurxlVni
         AQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpUW6EZAYcQce914+kaudlluEXYU2qkTOLGcz7cftQMOLgtdKvsZtQ3auLASSoGW/6Lnl+kzz0n8/wS418ZDHiTEThPTDNnaQ6s+YK
X-Gm-Message-State: AOJu0YyJmqGXWGB3IEO+W2rNUIQHZruhsYeTDE4ctYsS1rYEPK+a/okL
	zWHujA9sGgaWzjY23jOJlts4D23eV+VvIwPrQultfpNBjLEDn258kRnKqyVsRAw=
X-Google-Smtp-Source: AGHT+IFEKKLATpLTVwutm2tzIoiZ11Ga9pVF4NMfg4vCen7e5iSouPTou2BE8D1MsN0dG3NtPPHp/g==
X-Received: by 2002:a05:600c:524a:b0:418:2719:6b14 with SMTP id fc10-20020a05600c524a00b0041827196b14mr2077367wmb.3.1713450430306;
        Thu, 18 Apr 2024 07:27:10 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm2873645wmo.42.2024.04.18.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:27:09 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	Ved Shanbhogue <ved@rivosinc.com>
Subject: [RFC PATCH 0/7] riscv: Add support for Ssdbltrp extension
Date: Thu, 18 Apr 2024 16:26:39 +0200
Message-ID: <20240418142701.1493091-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A double trap typically arises during a sensitive phase in trap handling
operations — when an exception or interrupt occurs while the trap
handler (the component responsible for managing these events) is in a
non-reentrant state. This non-reentrancy usually occurs in the early
phase of trap handling, wherein the trap handler has not yet preserved
the necessary state to handle and resume from the trap. The occurrence
of such event is unlikely but can happen when dealing with hardware
errors.

This series adds support for Ssdbltrp[1]. It is based on SSE support as well as
firmware feature to enable double trap.

Ssdbltrp can be tested using qemu[1], opensbi[2], linux[3] and
kvm-unit-tests[5]. Assuming you have a riscv environment available and
configured (CROSS_COMPILE), it can be built for riscv64 using the
following instructions:

Qemu:
  $ git clone https://github.com/rivosinc/qemu.git
  $ cd qemu
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ mkdir build && cd build
  $ ../configure --target-list=riscv64-softmmu
  $ make

OpenSBI:
  $ git clone https://github.com/rivosinc/opensbi.git
  $ cd opensbi
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ make O=build PLATFORM_RISCV_XLEN=64 PLATFORM=generic

Linux:
  $ git clone https://github.com/rivosinc/linux.git
  $ cd linux
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ export ARCH=riscv
  $ make O=build defconfig
  $ ./script/config --file build/.config --enable RISCV_DBLTRP
  $ make O=build

kvm-unit-tests:
  $ git clone https://github.com/clementleger/kvm-unit-tests.git
  $ cd kvm-unit-tests
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ ./configure --arch=riscv64 --cross-prefix=$CROSS_COMPILE
  $ make

You will also need kvmtool in your rootfs. One can build a buildroot
rootfs using the buildroot provided at [6] (which contains an update
of kvmtool with riscv support).

Run with kvm-unit-test test as kernel:
  $ qemu-system-riscv64 \
    -M virt \
    -cpu rv64,x-ssdbltrp=true,x-smdbltrp=true \
    -nographic \
    -serial mon:stdio \
    -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
    -kernel kvm-unit-tests-dbltrp/riscv/sbi_dbltrp.flat
  ...
  [OpenSBI boot partially elided]
  Boot HART ISA Extensions  : sscofpmf,sstc,zicntr,zihpm,zicboz,zicbom,sdtrig,svadu,ssdbltrp
  ...
  ##########################################################################
  #    kvm-unit-tests
  ##########################################################################

  PASS: sbi: fwft: FWFT extension probing no error
  PASS: sbi: fwft: FWFT extension is present
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
  INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !

  sbi_trap_error: hart0: trap0: double trap handler failed (error -10)

  sbi_trap_error: hart0: trap0: mcause=0x0000000000000010 mtval=0x0000000000000000
  sbi_trap_error: hart0: trap0: mtval2=0x0000000000000003 mtinst=0x0000000000000000
  sbi_trap_error: hart0: trap0: mepc=0x00000000802000d8 mstatus=0x8000000a01006900
  sbi_trap_error: hart0: trap0: ra=0x00000000802001fc sp=0x0000000080213e70
  sbi_trap_error: hart0: trap0: gp=0x0000000000000000 tp=0x0000000080088000
  sbi_trap_error: hart0: trap0: s0=0x0000000080213e80 s1=0x0000000000000001
  sbi_trap_error: hart0: trap0: a0=0x0000000080213e80 a1=0x0000000080208193
  sbi_trap_error: hart0: trap0: a2=0x000000008020dc20 a3=0x000000000000000f
  sbi_trap_error: hart0: trap0: a4=0x0000000080210cd8 a5=0x00000000802110d0
  sbi_trap_error: hart0: trap0: a6=0x00000000802136e4 a7=0x0000000046574654
  sbi_trap_error: hart0: trap0: s2=0x0000000080210cd9 s3=0x0000000000000000
  sbi_trap_error: hart0: trap0: s4=0x0000000000000000 s5=0x0000000000000000
  sbi_trap_error: hart0: trap0: s6=0x0000000000000000 s7=0x0000000000000001
  sbi_trap_error: hart0: trap0: s8=0x0000000000002000 s9=0x0000000080083700
  sbi_trap_error: hart0: trap0: s10=0x0000000000000000 s11=0x0000000000000000
  sbi_trap_error: hart0: trap0: t0=0x0000000000000000 t1=0x0000000080213ed8
  sbi_trap_error: hart0: trap0: t2=0x0000000000001000 t3=0x0000000080213ee0
  sbi_trap_error: hart0: trap0: t4=0x0000000000000000 t5=0x000000008020f8d0
  sbi_trap_error: hart0: trap0: t6=0x0000000000000000

Run with linux and kvm-unit-test test in kvm (testing VS-mode):
  $ qemu-system-riscv64 \
    -M virt \
    -cpu rv64,x-ssdbltrp=true,x-smdbltrp=true \
    -nographic \
    -serial mon:stdio \
    -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
    -kernel linux/build/arch/riscv/boot/Image
  ...
  [Linux boot partially elided]
  [    0.735079] riscv-dbltrp: Double trap handling registered
  ...

  $ lkvm run -k sbi_dbltrp.flat -m 128 -c 2
  ##########################################################################
  #    kvm-unit-tests
  ##########################################################################

  PASS: sbi: fwft: FWFT extension probing no error
  PASS: sbi: fwft: FWFT extension is present
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
  INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !
  [   51.939077] Guest double trap
  [   51.939323] kvm [93]: VCPU exit error -95
  [   51.939683] kvm [93]: SEPC=0x802000d8 SSTATUS=0x200004520 HSTATUS=0x200200180
  [   51.939947] kvm [93]: SCAUSE=0x10 STVAL=0x0 HTVAL=0x3 HTINST=0x0
  KVM_RUN failed: Operation not supported
  $

Link: https://github.com/riscv/riscv-double-trap/releases/download/v0.56/riscv-double-trap.pdf [1]
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_rfc_v1 [2]
Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/dbltrp_rfc_v1 [3]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_rfc_v1 [4]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_rfc_v1 [5]
Link: https://github.com/clementleger/buildroot/tree/dev/cleger/kvmtool [6]
---

Clément Léger (7):
  riscv: kvm: add support for FWFT SBI extension
  dt-bindings: riscv: add Ssdbltrp ISA extension description
  riscv: add Ssdbltrp ISA extension parsing
  riscv: handle Ssdbltrp mstatus SDT bit
  riscv: add double trap driver
  riscv: kvm: add SBI FWFT support for SBI_FWFT_DOUBLE_TRAP_ENABLE
  RISC-V: KVM: add support for double trap exception

 .../devicetree/bindings/riscv/extensions.yaml |   6 +
 arch/riscv/include/asm/csr.h                  |   3 +
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/kvm_host.h             |  12 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |   1 +
 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h    |  37 ++++
 arch/riscv/include/asm/sbi.h                  |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |   2 +
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/entry.S                     |  52 ++---
 arch/riscv/kernel/head.S                      |   4 +
 arch/riscv/kernel/sse_entry.S                 |   4 +-
 arch/riscv/kvm/Makefile                       |   1 +
 arch/riscv/kvm/vcpu.c                         |  28 +--
 arch/riscv/kvm/vcpu_exit.c                    |  33 +++-
 arch/riscv/kvm/vcpu_insn.c                    |  15 +-
 arch/riscv/kvm/vcpu_onereg.c                  |   2 +
 arch/riscv/kvm/vcpu_sbi.c                     |   8 +-
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 177 ++++++++++++++++++
 arch/riscv/kvm/vcpu_switch.S                  |  19 +-
 drivers/firmware/Kconfig                      |   7 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/riscv_dbltrp.c               |  95 ++++++++++
 include/linux/riscv_dbltrp.h                  |  19 ++
 24 files changed, 466 insertions(+), 63 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
 create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
 create mode 100644 drivers/firmware/riscv_dbltrp.c
 create mode 100644 include/linux/riscv_dbltrp.h

-- 
2.43.0


