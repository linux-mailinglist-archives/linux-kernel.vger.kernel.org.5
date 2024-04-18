Return-Path: <linux-kernel+bounces-150077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C38A9A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55CC283486
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803313442C;
	Thu, 18 Apr 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m2Tx15Tv"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC312FF75
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444237; cv=none; b=N2F1IqxjXsGXfV2zS3mfAEOKqdUetc01WdDOyQiAduSrs9MuTRh8K6A9P1OhYusYw3OmQiMG184P+4lbBuXZlnIhWWpI25Igdpfws8kdZNCOVE1rFj3vwLVWpXRwHTAvp5A+bSZ0AKihi67e6nVgDGu9M9xv0JGD318Wx93g/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444237; c=relaxed/simple;
	bh=BSPP+JhpgqmbSOjXMNtVSOk6UyemTIHuAPZ8lvb1GHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pl8otcxzHCnpuiK42jWrLDFdA1oqoP3r7gfQc+W8NTr5XycJl6aVzYfT8/D4jvViRGkUEAdG+kU2l/mG4ejT2vQalFezBLru0vpVIIPSFTl63G+iAJYBACzdzphkR1gtk+01+hXNAwbxHJjzYOMaO+ixocVKgiK6l+kk75uehhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m2Tx15Tv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-349fd1d3723so154078f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713444234; x=1714049034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32JRcAZ8LHhKBfsqOJDGu3ZSnqgwx85ZTFPgD6hMyrs=;
        b=m2Tx15TvdFRjHOdqyJyX67kMDKVBuysCC/o7Fc9xL4ucSvqrtNxR4vZRDWYRbobUGn
         bLdFWiuGaWdEo41pwwa2YLmKM+RdWZ3DXUQxl0kTRJpZrf5R+UeEKp1SCisFyZjSyHgJ
         qgrdEIO02UcnfX5osQXMANFnB0X1WEyATveHyhPHLMXnwoMCE6PhHNY71HivWRzEjxrN
         E3lwqTgFApDl2uHX3k9u6Zxb/mf34ndDFdxZXIMfFAPvk5dh79sByNmPYnVpEmgF+4t7
         NkJB5+jU3wUJojc/JesjaejkSlKV6V4HD+tFPJtt6RDgyyZxjLBScj0AT75/KIr0RJjj
         icKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444234; x=1714049034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32JRcAZ8LHhKBfsqOJDGu3ZSnqgwx85ZTFPgD6hMyrs=;
        b=e2xEJ4TnjsFFN/ozR611gZrtZBaMpjdk8c7YoiAyL28ct1R/QWn9UNoxw8c1yxsCSW
         aTG8A9SeFR3BKZQa8SsuZLyYh+H133C2Z+NiihMxru6f+42mdbX6jtN8OrIEpgZuMIa1
         iIr71PdC9orcGnbj6Y3vklrS/hNmliEVyCQhclyQ0C6lSLcWENFSl5yMl50FwNHxrpzP
         U+B7VkPUsfWgGvoPHBmqiuYVsZT+4iQ7stWfoXs5luaaK9IxIR+EVrQ/hafCx6azG4Er
         FM8gmzKq2UHXwmbmEE8UXpBTLEhQswwuljKTH1ZbhTMBV5D5evz+UuuU9egpKPMsdtlL
         YfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXI8/OSn7TJzLg5w9osSjUQ8JVbjaphBNPnfg6VDqNqZ0GoFBw9wNbuz++ADt572uR1v7PY8vEQW44h0HHE4tvLIhWzpuG2XLPs3Ju
X-Gm-Message-State: AOJu0Yzta5Hx1AL6vV29VYCvX1Ph2MGP9HLqU+ok2s83nBXc0QvSx7e/
	A2OTmD/DHdExfYkC9Aw075SFQQmW25fMzR3UEQkS1AHA4vLBfruHMDrmBeS6ZfE=
X-Google-Smtp-Source: AGHT+IFziCRGNRnIuKdQWAYceCQlX3IZZXZCOpe0+zYvs0VTpiLEE6booy5ASHtPCGw5+ceQDaJ+5w==
X-Received: by 2002:a05:600c:1c91:b0:418:9a5b:d51 with SMTP id k17-20020a05600c1c9100b004189a5b0d51mr2042383wms.0.1713444233704;
        Thu, 18 Apr 2024 05:43:53 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b00418d5b16fa2sm3373412wmb.30.2024.04.18.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:43:53 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 00/12] Add support for a few Zc* extensions as well as Zcmop
Date: Thu, 18 Apr 2024 14:42:23 +0200
Message-ID: <20240418124300.1387978-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for (yet again) more RVA23U64 missing extensions. Add
support for Zcmop, Zca, Zcf, Zcd and Zcb extensions isa string parsing,
hwprobe and kvm support. Zce, Zcmt and Zcmp extensions have been left
out since they target microcontrollers/embedded CPUs and are not needed
by RVA23U64

This series is based on the Zimop one [1].

Link: https://lore.kernel.org/linux-riscv/20240404103254.1752834-1-cleger@rivosinc.com/ [1]

---
v2:
 - Add Zc* dependencies validation in dt-bindings
 - v1: https://lore.kernel.org/lkml/20240410091106.749233-1-cleger@rivosinc.com/

Clément Léger (12):
  dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension
    description
  riscv: dts: enable Zc* extensions when needed
  dt-bindings: riscv: add Zc* extension rules implied by C extension
  riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
  riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
  RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
  KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
  dt-bindings: riscv: add Zcmop ISA extension description
  riscv: add ISA extension parsing for Zcmop
  riscv: hwprobe: export Zcmop ISA extension
  RISC-V: KVM: Allow Zcmop extension for Guest/VM
  KVM: riscv: selftests: Add Zcmop extension to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |  24 ++
 .../devicetree/bindings/riscv/cpus.yaml       |   8 +-
 .../devicetree/bindings/riscv/extensions.yaml | 124 +++++++++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |   4 +-
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  20 +-
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  20 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  20 +-
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   4 +-
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 256 +++++++++---------
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   8 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  20 +-
 arch/riscv/boot/dts/thead/th1520.dtsi         |  16 +-
 arch/riscv/include/asm/hwcap.h                |   5 +
 arch/riscv/include/uapi/asm/hwprobe.h         |   5 +
 arch/riscv/include/uapi/asm/kvm.h             |   5 +
 arch/riscv/kernel/cpufeature.c                |   5 +
 arch/riscv/kernel/sys_hwprobe.c               |   5 +
 arch/riscv/kvm/vcpu_onereg.c                  |  10 +
 .../selftests/kvm/riscv/get-reg-list.c        |  20 ++
 20 files changed, 394 insertions(+), 189 deletions(-)

-- 
2.43.0


