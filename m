Return-Path: <linux-kernel+bounces-106007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E703687E773
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC521F22A67
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF51E527;
	Mon, 18 Mar 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Cie3cON9"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C726AC1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758404; cv=none; b=LxVC+YRkYRxbfYsHCba+LRxyOt2E1nU7/LT9mV2NTnkn+TciqpEUi8op1zBWNgDL9AOLpnuX8Ccd2py97Z6+YrPqbugyNb2tIZkpSGPlJVqE59i8VLajrPEVFK6QHWuxl32Pxxq1tVfirQjenrWnxgGlhAuuNjBtiKvTGWV3Eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758404; c=relaxed/simple;
	bh=fnpFiMr3sDJw+gw4JYAit/P3p7arQxre0TOz9l1njew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RMDbn0Iw2uvez9AUm+KJmcqBEo8RInjD/FkzFHI4t6Dq3XtsAvM1RH8vHDetSEITKmjuqWdvn8QoXC8l0uejada4XKPkE7I/4j2xCJZwrhCoZBp5oxtwccQxh/NVxjmD97Q8TBszWHF9qLP3mfkPsooaZkEbsmf/KxseOQAFPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Cie3cON9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b5aa0b52so3493090b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710758402; x=1711363202; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ID0p7f2CL6yvEozBjg6sfwc1IPzOU4d80fq7ceZnco=;
        b=Cie3cON9EkDvk1UHE/UhHLme4zCMPo5foyD2MREZ9uBznohKfYfWY58EA9rsCx5jSo
         A7jjOetoejSemzXc6DGy8Al6HIRFTG0t6bxRQu1vaJGa7WDCJOO6HXTsALiL2B2CA04x
         vnowsIevg0ju4DKHqVsSYAVZ6T3f3XqjVHCJkJoIBRz912Hsyn5dMjkrTvRS3Ba9V6hc
         HQ7yZI3NcnNVzUuE5xBRXlYTCvTAxqPlqX/veVRIR/sRsTJWdkjRFxQLqJ3g9BfOf331
         YrvqM4zPTvFiLHi1PhzGXUG6W9ni1tBwpCf44J9GKg6plCWQAmKx41+CMHjDo1LKJzJI
         LtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758402; x=1711363202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ID0p7f2CL6yvEozBjg6sfwc1IPzOU4d80fq7ceZnco=;
        b=MtybSQxRuVi7hwahrxOV1SDXa7VzzZMYwGdAkgyGvD04cWFKATyPWUt7ZG9xo8TgZQ
         plKIZ6wunKHsd+AnVZJzxLMM0CrmGFmsfnGJ62kbHvz7Rc8RBsnlWeU8CUPXo+ky0NmJ
         FzXKfToSgezlEA5uNR1n88wm/OZuDyLyf0MOtksgqIeXZuoga8odrWEvqjlwH4BypKo2
         SYZwnD70kf9wZJ/1zHIoCpmbyFbCj0LyNz7O1vlCDFcrqun1Y5X+Ic/6+v+oidSkhUig
         FcVSC9VmCZZ9Cyx9k+A2aPyaJiTZDP5VUswI34n9MmbDwk6aMwJ6rpVNOkP5wskjynZF
         5bTg==
X-Forwarded-Encrypted: i=1; AJvYcCUpEEJvlD6pUerc1sZsQFKHytph2sDjjEaGbD+rSNvPf3k+nfmojYrz6yZbRmCgeq2dBJwEg2KTRr+otuSA5tZKcUTyItg3QXGqkLsh
X-Gm-Message-State: AOJu0YxrHb6Trjd9+QWBuQwckGl6Rop4Htlmi4UopQTjxXGVEp/xKt6U
	m7RS1ANGqhSqY/GSqY3Cz+Z4YzT+vUvz/hFgTiNL1jCkSmPhxBwWloCy9LDSHoo=
X-Google-Smtp-Source: AGHT+IFybbfcMxdPeEklAEm0VGt4DQEXS5sWv1NO8Ih8hC+93i804/jYj2EHmREofX0BM04dNDwUXA==
X-Received: by 2002:a05:6a00:23d2:b0:6e6:9cea:69e7 with SMTP id g18-20020a056a0023d200b006e69cea69e7mr12433497pfc.29.1710758401876;
        Mon, 18 Mar 2024 03:40:01 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00008b00b006e647716b6esm7838969pfj.149.2024.03.18.03.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:40:01 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 0/7] Support Zve32[xf] and Zve64[xfd] Vector
 subextensions
Date: Mon, 18 Mar 2024 18:39:53 +0800
Message-Id: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPkZ+GUC/03MQQ6CMBCF4auQWTtNO7QirryHcdG0g8wCMG0lK
 uHuNq5cfsl7/waZk3CGc7NB4lWyLHNFe2ggjH6+M0qsBtJkdWtO+FkZIxcOpS7RaaOPkaJ31EH
 9PBIP8vr1rrfqIS0TljGx/69YY8lZUqbvXYcG/RzfKozyvGQZZGUVlgn2/Qs5CNDYnQAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andy Chiu <andy.chiu@sifive.com>, Vincent Chen <vincent.chen@sifive.com>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Greentime Hu <greentime.hu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
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
programs context-switch, signal, ptrace, prctl(sysctl knob) interfaces
works when we only report partial V from the ISA.

This patch should be able to apply on risc-v for-next branch on top of
the commit 099dbac6e90c ("Merge patch series "riscv: Use Kconfig to set unaligned access speed"")

[1]: https://lore.kernel.org/all/20240228-vicinity-cornstalk-4b8eb5fe5730@spud/T/#u

v2 of this series can be found at: https://lore.kernel.org/all/20240314142542.19957-1-andy.chiu@sifive.com/

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
Andy Chiu (7):
      riscv: vector: add a comment when calling riscv_setup_vsize()
      riscv: smp: fail booting up smp if inconsistent vlen is detected
      riscv: cpufeature: call match_isa_ext() for single-letter extensions
      riscv: cpufeature: add zve32[xf] and zve64[xfd] isa detection
      dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA extension description
      riscv: hwprobe: add zve Vector subextensions into hwprobe interface
      riscv: vector: adjust minimum Vector requirement to ZVE32X

 Documentation/arch/riscv/hwprobe.rst               | 15 ++++++
 .../devicetree/bindings/riscv/extensions.yaml      | 30 ++++++++++++
 arch/riscv/include/asm/hwcap.h                     |  5 ++
 arch/riscv/include/asm/switch_to.h                 |  2 +-
 arch/riscv/include/asm/vector.h                    | 21 +++++---
 arch/riscv/include/asm/xor.h                       |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h              |  5 ++
 arch/riscv/kernel/cpufeature.c                     | 56 ++++++++++++++++++----
 arch/riscv/kernel/head.S                           | 14 +++---
 arch/riscv/kernel/kernel_mode_vector.c             |  4 +-
 arch/riscv/kernel/process.c                        |  4 +-
 arch/riscv/kernel/signal.c                         |  6 +--
 arch/riscv/kernel/smpboot.c                        | 14 ++++--
 arch/riscv/kernel/sys_hwprobe.c                    | 13 ++++-
 arch/riscv/kernel/vector.c                         | 15 +++---
 arch/riscv/lib/uaccess.S                           |  2 +-
 16 files changed, 163 insertions(+), 45 deletions(-)
---
base-commit: 099dbac6e90c620d8ce0bbf75bbdc94da1feb4fb
change-id: 20240318-zve-detection-50106d2da527

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


