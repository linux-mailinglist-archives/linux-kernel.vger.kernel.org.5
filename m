Return-Path: <linux-kernel+bounces-43258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACCE841182
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C603BB22FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE77604C;
	Mon, 29 Jan 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eA/EIvsM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FA7602B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551250; cv=none; b=H123YO1VZocVY+NaHZDSqJDVP6V/mensAqtjzPyCR29V1WFQngPzG5EWhSFAsqq9UKSZoQiiS5eTCy9PYd8pR4+9npMcNCO9DswtF5cIlkyVFDtiIh7X0b8Qtfi/a+wxXsBlCEgpIqDQzcaRxF0a07AfOO0+PvKTme33GXd7nPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551250; c=relaxed/simple;
	bh=ZGGqBUPumN+idc9ens24RKWiq23wqMqhdGfjFbkJcRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgZ0ZPIpNM71+cEH7qLJ/F79xzk1DwoLm7Bs0ggIh1hx0UF1L+tDFsFvUGb0pc0Z+y127bYsEex+k/c2Ukzxh6FOguFc1QHLx05ZAHpgoiukf3D7bdGHnTei1qum11xLHeH5criilBNwnkNAe8rhYkoBfM55vIS98/2pSdI+x6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eA/EIvsM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so1305038b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706551248; x=1707156048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+CW+in6EnK2znPTJ0AfQ7xRsovW5JNd4hWidmf+BiM=;
        b=eA/EIvsMZ3JtvygLEp+XdI4nquW1ZX4bLgP9CHpIeDb/7wUhhgybI20kG1mHI5CwBc
         ztcrXShmDkU9D4Us13ouRA3+VtIKNnGvzy5B0kaS+xez+9WSh6Q1vvSSnT9dBg8yEqas
         NqlAgpkq613CW+DBudYfBYAKk8FDTSMTzI6Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551248; x=1707156048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+CW+in6EnK2znPTJ0AfQ7xRsovW5JNd4hWidmf+BiM=;
        b=JV8Ws389y2ttofPXjRMSst53QdNETy0gTvpdaiHfBBh4us3l1Q3s+ekACHrEtZZ3WT
         WRuFcUXwB2CuqG/leRMSCSSw1KbX42HhPZUn0hZZDcCtd/RDmzQY93gU98eep6Qi9eJd
         Gonqrvg/eei+u4mmW/yxLf26ZKmOSrMZiYHrP8TfxLHPwFyWVcBlKSzS2fLDHfu1hz+j
         oI7ByHwyl2wubFd0kA2BeiwQajptbX0STvAhzNHcVCmLGZ5GSk3lSkP4lTVZJomdAkjZ
         jcTR5bG3lTE7hNjlaI/v7+V6FCH4Mky+G9O5JVSucRZbzHF2qJCDxdkzRaJh+wEJ46Nu
         BM+w==
X-Gm-Message-State: AOJu0YwtgiN6NYIQUL6Y+pzF1qVfQTH4o0MuMSSS12sp+/pUTm4jO2zY
	0mLBA1mwdNbpbuZL/6aSXGL46ms/axeKa0bcabxJTcAKRvb/rxJyf5dOVM1GwYkp/vC3BjAXU1w
	=
X-Google-Smtp-Source: AGHT+IHzMbnsAAlCzNBmOOUIN7GWD2qtf0TQqIGnd2N24RJxcnvtRd6Jpb1GCe1rOCRHM6gjcuNAQA==
X-Received: by 2002:a05:6a20:e18f:b0:19e:25ab:5d30 with SMTP id ks15-20020a056a20e18f00b0019e25ab5d30mr329007pzb.49.1706551247798;
        Mon, 29 Jan 2024 10:00:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902968a00b001d71729ec9csm5622621plp.188.2024.01.29.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Fangrui Song <maskray@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/6] ubsan: Introduce wrap-around sanitizers
Date: Mon, 29 Jan 2024 10:00:37 -0800
Message-Id: <20240129175033.work.813-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZGGqBUPumN+idc9ens24RKWiq23wqMqhdGfjFbkJcRQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt+fKr4C/1Uw/qKiym8JNIHrticwbGItvtoLwR
 XmESZ6nhtiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfnygAKCRCJcvTf3G3A
 JsyCD/4l4Nk/URvw3kj0okH6XFWIxs/ZeiLVH2vDL41SvfbPQhpi+lCU4RKMP2XieuJ3KygVmGa
 mA8ABOVAJUOmhBNIrC2l9M7tjVcPoXBkTHKV6M282fJYo2pN03EHVZsbjNcng9HMLjgRm2WGjnU
 JYorKquSB4s3PocpIMNr0b0Ct3bnUCnp5tZOjSeEE8EQbNWGc5jPJSnV4UCPkXhZoWb7lAFZuYJ
 UDpE+Wz79/BRLULF+tLwiIQPu8rKVxn5AbO1gRgU8bbUsR4rg0nfIj04eTdS/hnQ+eqjuEtRymG
 E+8Bwd67rfWxhYkbZiIwif6Pz9zuXsENRBB5j/NnsqrrBl1/oBPprzdG3xIUlNfGh3lC2p/XUaH
 X9mtGkfvMvv8ir2VhNed6tLbbUOhodLmPen/S96YcxNcbPM/RZTfibLcuCBWLPOaOtBZnKKdz3f
 YTArlBA0afCW3HPJiMHkpmtMdzhbOs8QtVpKTCyQCuULqrciWRtrNdoMB6Loguv794PpwIkL6Uy
 CnsREXq/qSq/CbmirNh0yylWWz13AjMoedgfxjqXRJX8V43XC/w5iSrcmUwQhbxW2aU8jJ6HqrH
 YRZouC6AHWt83CGOCCLGr7yFpxF0+Un/xkB2uSHPWP8vndnHTl+jscCvIXPaRnlUzY+zoVpk7BA
 zhUdRD7 sxkuuu9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Lay the ground work for gaining instrumentation for signed[1],
unsigned[2], and pointer[3] wrap-around by making all 3 sanitizers
available for testing. Additionally gets x86_64 bootable under the
unsigned sanitizer for the first time.

The compilers will need work before this can be generally useful, as the
signed and pointer sanitizers are effectively a no-op with the kernel's
required use of -fno-strict-overflow. The unsigned sanitizer will also
need adjustment to deal with the many common code patterns that exist
for unsigned wrap-around (e.g. "while (var--)", "-1UL", etc).

-Kees

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]

Kees Cook (6):
  ubsan: Use Clang's -fsanitize-trap=undefined option
  ubsan: Reintroduce signed and unsigned overflow sanitizers
  ubsan: Introduce CONFIG_UBSAN_POINTER_WRAP
  ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL
  ubsan: Split wrapping sanitizer Makefile rules
  ubsan: Get x86_64 booting with unsigned wrap-around sanitizer

 Documentation/dev-tools/ubsan.rst | 28 +++-------
 arch/arm/Kconfig                  |  2 +-
 arch/arm64/Kconfig                |  2 +-
 arch/mips/Kconfig                 |  2 +-
 arch/parisc/Kconfig               |  2 +-
 arch/powerpc/Kconfig              |  2 +-
 arch/riscv/Kconfig                |  2 +-
 arch/s390/Kconfig                 |  2 +-
 arch/x86/Kconfig                  |  2 +-
 arch/x86/kernel/Makefile          |  1 +
 arch/x86/kernel/apic/Makefile     |  1 +
 arch/x86/mm/Makefile              |  1 +
 arch/x86/mm/pat/Makefile          |  1 +
 crypto/Makefile                   |  1 +
 drivers/acpi/Makefile             |  1 +
 include/linux/compiler_types.h    | 19 ++++++-
 kernel/Makefile                   |  1 +
 kernel/locking/Makefile           |  1 +
 kernel/rcu/Makefile               |  1 +
 kernel/sched/Makefile             |  1 +
 lib/Kconfig.ubsan                 | 41 +++++++++-----
 lib/Makefile                      |  1 +
 lib/crypto/Makefile               |  1 +
 lib/crypto/mpi/Makefile           |  1 +
 lib/test_ubsan.c                  | 82 ++++++++++++++++++++++++++++
 lib/ubsan.c                       | 89 +++++++++++++++++++++++++++++++
 lib/ubsan.h                       |  5 ++
 lib/zlib_deflate/Makefile         |  1 +
 lib/zstd/Makefile                 |  2 +
 mm/Makefile                       |  1 +
 net/core/Makefile                 |  1 +
 net/ipv4/Makefile                 |  1 +
 scripts/Makefile.lib              | 11 +++-
 scripts/Makefile.ubsan            | 11 +++-
 34 files changed, 278 insertions(+), 43 deletions(-)

-- 
2.34.1


