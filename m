Return-Path: <linux-kernel+bounces-141889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D98A24B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBA428283D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41553199B4;
	Fri, 12 Apr 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G6zikBDk"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A717C7F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895097; cv=none; b=DTAcAF3pOFsLY3Om1u8kLnoRg2wd9DQ/j21aCWtiqceVvAld3XaXhuEaQaN0a6PMGxZZr1u4nOWIDFhfOuayvjgmj73YFeby9BkyWIpYTOcuN5YVy0vzdhXK0z9fEMO9+6HSlI7/D4OfCHeUqhVFw6J941m0U2LFr/yyroboRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895097; c=relaxed/simple;
	bh=194g6ODbPi6DXCUbZzbcQ+OHHq9FcyCjGD2rlljMNLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I8Sf8FeAEAwSEhOBMFqTiXVnVqSOc5WmQKe2kPLvAZvq28LMOQHjZJ5kqOln6HaibGxKkYQzuHLDDdbD+PQTxqjDV8wU8R7EH9rFXtaek5xAy5rET3nN7lX0sBTHvZv0W35xQ8hiMbHI5T/GRhX6HJ1moeqc1c8xFz7eMULjIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G6zikBDk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea1f98f3b9so319105a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895094; x=1713499894; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4vFuc+KZXLr0HPAAI1Y3TxTNAhGubXRyuAzsTo1eCs=;
        b=G6zikBDkvwnptGx8GOMSBtCebXOY1DALnFHNHUUBRgFxcvWL+dG8X6ExEFXcaPV3OZ
         m44ZIbGjoBiWVLzCm3GBFs8NGFn/wOcNeF5TjKLQc5/SgpebdB6Z35Y0QVJWP0IW7q6r
         BPr+nicHx1fiaBbMNJfFPjaBnck3eUfmLmrYCCd8J8z4H8jqfJNCvzua8BS7C0i/l80b
         OJGZOYcyQr2olTTEb7qM23LOH7eZQlrfx8QLqSRSvIAxtmla9leVLEq3A41IFiDVoHWk
         DACK2ZOh9Un9G7srYRdPmg1vWvjhNrBQdCj5hCV7FESL3/RlqU8BgKmCXlBKh9vaR1YS
         sTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895094; x=1713499894;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4vFuc+KZXLr0HPAAI1Y3TxTNAhGubXRyuAzsTo1eCs=;
        b=xMSZn90spz0iJnZnSi7O0gKH7p7UrHvemL0/zgPCWsjKs7+G5TqfETy4qMAIc3KYi/
         R4mEhrF0suzPLR+e0jLmo/ilYVKfSFCbMfKhbDRlKRfM5GX2Tyq9ZDn8Lc0RqUlBpEWY
         MAQLHh+7VD4map6aBB9vvUypdATl1vwF6LL0rVmqy+ofoz5K4rW1pp95wO+4hFHkszCT
         xgt+qNd5rpwy9rJTlsuPe6hVSSm6oMeYLGGxJGM7teGjLqy4ZJnjq8vsQ4Ew9SczDInW
         1OVc55qSdh0hdEO6/m2ODHrE7235MsAjhJM/jrLUHsU+5g/cDkSlzhwHm2v44qytedHO
         r18g==
X-Forwarded-Encrypted: i=1; AJvYcCUmlUGiFcg4pTQIbtqFuNycnUuatp0afyVIm1ABU9yliRk57OXHpf4/GYSBtLumU8rmQrqP77gzJDzXKzSNd0ejKlgZsMbV5JqcDkmn
X-Gm-Message-State: AOJu0YzD8DcqzfeV2oMYrLG6YYBlDLuGgKiQETF8Mn0QVNgwmpRVZ9iy
	iYpPqgYRWXe6VFPbH0jhib1LvBDsLFsvCEb6boqh2QaD+H0B+IcXEQ2L21Q7/i8=
X-Google-Smtp-Source: AGHT+IFXcRrLjz2BzICl9U4RnOlnbIB1p9qCDuofL5zEbRRd7RbQN9I5ujZpsBrF05T5OBKkX8okrQ==
X-Received: by 2002:a05:6808:a83:b0:3c5:ffa6:eaad with SMTP id q3-20020a0568080a8300b003c5ffa6eaadmr1623898oij.40.1712895093790;
        Thu, 11 Apr 2024 21:11:33 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:32 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 00/19] riscv: Support vendor extensions and xtheadvector
Date: Thu, 11 Apr 2024 21:11:06 -0700
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFq0GGYC/x2N0QrDIAwAf6XkeYHG2UH3K2OIaNoGRpVoZVD67
 5M9Hgd3JxRW4QLP4QTlJkXS3oFuA4TN7yujxM5gRmNHS4SRG3ajH2EsR85Jq6sb++gah5rUPdy
 MNM20BOPtnSL0VFZe5PvfvN7X9QPk2l6XdgAAAA==
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=5676;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=194g6ODbPi6DXCUbZzbcQ+OHHq9FcyCjGD2rlljMNLM=;
 b=EhvZyYlJsQ3OvMXR9LRZNS0MNw+nCAiK2mU2Dzq2c9vBmPTSMtx9J5TU7CI3jKWv6Pv6x4pnE
 PfLzDO9FtxmCmOPXd/ITlf11zybMZFjoUZT9yABJ32RPul/JV1y5wzH
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This patch series ended up much larger than expected, please bear with
me! The goal here is to support vendor extensions, starting at probing
the device tree and ending with reporting to userspace.

The main design objective was to allow vendors to operate independently
of each other. This has been achieved by delegating vendor extensions to
a new struct "hart_isa_vendor" which is a counterpart to "hart_isa".

Each vendor will have their own list of extensions they support. Each
vendor will have a "namespace" to themselves which is set at the key
values of 0x8000 - 0x8080. It is up to the vendor's disgression how they
wish to allocate keys in the range for their vendor extensions.

Reporting to userspace follows a similar story, leveraging the hwprobe
syscall. There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_0 that
is used to request supported vendor extensions. The vendor extension
keys are disambiguated by the vendor associated with the cpumask passed
into hwprobe. The entire 64-bit key space is available to each vendor.

On to the xtheadvector specific code. xtheadvector is a custom extension
that is based upon riscv vector version 0.7.1 [1]. All of the vector
routines have been modified to support this alternative vector version
based upon whether xtheadvector was determined to be supported at boot.
I have tested this with an Allwinner Nezha board. I ran into issues
booting the board on 6.9-rc1 so I applied these patches to 6.8. There
are a couple of minor merge conflicts that do arrise when doing that, so
please let me know if you have been able to boot this board with a 6.9
kernel. I used SkiffOS [2] to manage building the image, but upgraded
the U-Boot version to Samuel Holland's more up-to-date version [3] and
changed out the device tree used by U-Boot with the device trees that
are present in upstream linux and this series. Thank you Samuel for all
of the work you did to make this task possible.

To test the integration, I used the riscv vector kselftests. I modified
the test cases to be able to more easily extend them, and then added a
xtheadvector target that works by calling hwprobe and swapping out the
vector asm if needed.

[1] https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc
[2] https://github.com/skiffos/SkiffOS/tree/master/configs/allwinner/nezha
[3] https://github.com/smaeul/u-boot/commit/2e89b706f5c956a70c989cd31665f1429e9a0b48

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (18):
      dt-bindings: riscv: Add vendorid and archid
      riscv: cpufeature: Fix thead vector hwcap removal
      dt-bindings: riscv: Add xtheadvector ISA extension description
      riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
      riscv: Fix extension subset checking
      riscv: Extend cpufeature.c to detect vendor extensions
      riscv: Optimize riscv_cpu_isa_extension_(un)likely()
      riscv: Introduce vendor variants of extension helpers
      riscv: uaccess: Add alternative for xtheadvector uaccess
      riscv: csr: Add CSR encodings for VCSR_VXRM/VCSR_VXSAT
      riscv: Create xtheadvector file
      riscv: vector: Support xtheadvector save/restore
      riscv: hwprobe: Disambiguate vector and xtheadvector in hwprobe
      riscv: hwcap: Add v to hwcap if xtheadvector enabled
      riscv: hwprobe: Add vendor extension probing
      riscv: hwprobe: Document vendor extensions and xtheadvector extension
      selftests: riscv: Fix vector tests
      selftests: riscv: Support xtheadvector in vector tests

Heiko Stuebner (1):
      RISC-V: define the elements of the VCSR vector CSR

 Documentation/arch/riscv/hwprobe.rst               |  12 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  11 +
 .../devicetree/bindings/riscv/extensions.yaml      |   9 +
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   4 +-
 arch/riscv/include/asm/cpufeature.h                | 143 +++++++---
 arch/riscv/include/asm/csr.h                       |  13 +
 arch/riscv/include/asm/hwcap.h                     |  23 ++
 arch/riscv/include/asm/hwprobe.h                   |   4 +-
 arch/riscv/include/asm/sbi.h                       |   2 +
 arch/riscv/include/asm/vector.h                    | 228 ++++++++++++----
 arch/riscv/include/asm/xtheadvector.h              |  25 ++
 arch/riscv/include/uapi/asm/hwprobe.h              |  10 +-
 arch/riscv/kernel/cpu.c                            |  20 ++
 arch/riscv/kernel/cpufeature.c                     | 264 +++++++++++++++---
 arch/riscv/kernel/kernel_mode_vector.c             |   4 +-
 arch/riscv/kernel/sys_hwprobe.c                    |  59 ++++-
 arch/riscv/kernel/vector.c                         |  22 +-
 arch/riscv/lib/uaccess.S                           |   1 +
 tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
 tools/testing/selftests/riscv/vector/Makefile      |  17 +-
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  93 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  66 +++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   7 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 295 ++++++++++++---------
 27 files changed, 1114 insertions(+), 331 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240411-dev-charlie-support_thead_vector_6_9-1591fc2a431d
-- 
- Charlie


