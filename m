Return-Path: <linux-kernel+bounces-108165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A8880702
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958FE1F22C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CCE4F5F2;
	Tue, 19 Mar 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gpnpnNQt"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A842A86
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885559; cv=none; b=mrF94B5Lxaai3BEJgQZq4n2CwkbN0VWDodC84P7oT9i9eW9lVCxpKg8YIsgaZ0gz4/TNvXZJz+5fW2QBtBn8mUrG4dfmzACkNBCZAjUY7UJZvIWU4ldcax/kp7MUbYGH52sf3SVhul7oWB47+WrYANU6eQg/Myi1vG2oeNuldg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885559; c=relaxed/simple;
	bh=JrhTzLNU7JDIXj1MsuBxCmEsCkl39IGeWPNJ9ltYd2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZWcELOisKkCQZYdLgLghIzAL+0RncU5jRgKOf3CJr8xA0PJmCXYpv/6xPConr+WcvOVLjv9DOqEQ9Ie9hRXNOy0p9HCgRDsO7N/Cc8gJGC+qTP7w53k0gvTRcLRZEN/6ev+SJigvBMXPFIfMF0sb88k4EimyQHUyk0wpe+NuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gpnpnNQt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso5786601b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885557; x=1711490357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmlb8dkFyYxdz94/c3CDo0QI5YbaWEmRF37tY2/vORM=;
        b=gpnpnNQtlGY4/QW2SSNOxZiMmeVOK4pkFOqn8wUWwX5IDIGbQ23tgl/KyXWJmfL9EW
         Ha4Wrgtw0X3K2uN33bdvaG/pno+QAi9ynJSyYmfgPU8VK6u0eu7DkNOmQC4/0/dDCfNd
         uBM5l6Flc1faxubX3ncCt2/Av8HzHfmljsOy9qL+w9a5cIGTT4k/zRo1xs2+xknQO4Vv
         W9wkF4Ejp/Pce2WpFZ3gGtKvM3irz3pN3w5g5E6e4fMVFi/iMPHRfNlrI1QxMn+Yt4uN
         vgYHoy7bP4ItlejmelK8ZYl5nZNGbdzV2TjwwUZ9BYKYBwR2fAI6UaI9PR03+s/lD0Vx
         Ek4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885557; x=1711490357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rmlb8dkFyYxdz94/c3CDo0QI5YbaWEmRF37tY2/vORM=;
        b=gOilcbtO9aGs+xrEBNpYy1QsSXnNoUbukPFHMO6+lVdjk4aAb4TigdwQl6fVxfQ0L/
         t/iFaE++L9LIhmh31fy2uXxUzhceLQes1no/tssrmnAzkP00Vu/dC1QWHjkn66viJcB2
         xy4vKKvi/+lMzwwpqY8mIrpZWWi+DuEKObtAtnwJLwaAwZasJm4kaR3iWoT+HG7CV+cm
         GRJKsnjfUHDOHvfAL9thdNJkrF5jPEQCVX+wFRb8UJNOcn02owdrIcrl7xTx4cReO7mg
         fZc4HnlWEw1P2hwioS1Ro8/0ActevwxQn4m4wk65SZ9SyXT8d2HTIGJUHwuCKCiUJGYd
         4IgA==
X-Forwarded-Encrypted: i=1; AJvYcCWyz8h6kBjM2tnsC8LJgVj1vVN8hT3swhq4+0zb4lG9uc8kKQdN2tDKyDe+t6MS+J/O+DdzGB9rMuZag7tQoGYodnty+AdbCk+H0JXG
X-Gm-Message-State: AOJu0YwaV1qDwNCYJalIvY5O1t9qHmcBECGzraDXxx/MX2esxUdn9Bcj
	VKD/XNReCOFNa/du7Tc98FSqtzgDcVstSdUotRUgV71K2adtx1dytrebYTah09g=
X-Google-Smtp-Source: AGHT+IFq09XmFNSIoRgARl6YR9z7iEUW5Yif2KVMNG/hMOVVaxwVphqnsk3Rt+lVEueTdkA4OIwSpQ==
X-Received: by 2002:a05:6a00:a22:b0:6e7:4abe:85a0 with SMTP id p34-20020a056a000a2200b006e74abe85a0mr457780pfh.14.1710885556934;
        Tue, 19 Mar 2024 14:59:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:16 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	tech-j-ext@lists.risc-v.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [RFC PATCH 0/9] riscv: Userspace pointer masking and tagged address ABI
Date: Tue, 19 Mar 2024 14:58:26 -0700
Message-ID: <20240319215915.832127-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V defines three extensions for pointer masking[1]:
 - Smmpm: configured in M-mode, affects M-mode
 - Smnpm: configured in M-mode, affects the next lower mode (S or U-mode)
 - Ssnpm: configured in S-mode, affects the next lower mode (U-mode)

This series adds support for configuring Smnpm or Ssnpm (depending on
which mode the kernel is running in) to allow pointer masking in
userspace by extending the existing PR_SET_TAGGED_ADDR_CTRL API from
arm64. Unlike arm64 TBI, userspace pointer masking is not enabled by
default on RISC-V. Additionally, the tag width (referred to as PMLEN) is
variable, so userspace needs to ask the kernel for a specific tag width
(which is interpreted as a minimum number of tag bits).

This series also adds support for a tagged address ABI similar to arm64.
Since accesses from the kernel to user memory use the kernel's pointer
masking configuration, not the user's, the kernel must untag user
pointers in software before dereferencing them.

This series can be tested in QEMU by applying a patch set[2].

KASAN support is not included here because there is not yet any standard
way for the kernel to ask firmware to enable pointer masking in S-mode.

[1]: https://github.com/riscv/riscv-j-extension/raw/a1e68469c60/zjpm-spec.pdf
[2]: https://patchwork.kernel.org/project/qemu-devel/list/?series=822467&archive=both


Samuel Holland (9):
  dt-bindings: riscv: Add pointer masking ISA extensions
  riscv: Add ISA extension parsing for pointer masking
  riscv: Add CSR definitions for pointer masking
  riscv: Define is_compat_thread()
  riscv: Split per-CPU and per-thread envcfg bits
  riscv: Add support for userspace pointer masking
  riscv: Add support for the tagged address ABI
  riscv: Allow ptrace control of the tagged address ABI
  selftests: riscv: Add a pointer masking test

 .../devicetree/bindings/riscv/extensions.yaml |  18 +
 arch/riscv/Kconfig                            |   8 +
 arch/riscv/include/asm/compat.h               |  16 +
 arch/riscv/include/asm/cpufeature.h           |   2 +
 arch/riscv/include/asm/csr.h                  |  16 +
 arch/riscv/include/asm/hwcap.h                |   5 +
 arch/riscv/include/asm/processor.h            |  10 +
 arch/riscv/include/asm/switch_to.h            |  12 +
 arch/riscv/include/asm/uaccess.h              |  40 ++-
 arch/riscv/kernel/cpufeature.c                |   7 +-
 arch/riscv/kernel/process.c                   | 154 +++++++++
 arch/riscv/kernel/ptrace.c                    |  42 +++
 include/uapi/linux/elf.h                      |   1 +
 include/uapi/linux/prctl.h                    |   3 +
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/tags/Makefile   |  10 +
 .../selftests/riscv/tags/pointer_masking.c    | 307 ++++++++++++++++++
 17 files changed, 646 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/tags/Makefile
 create mode 100644 tools/testing/selftests/riscv/tags/pointer_masking.c

-- 
2.43.1


