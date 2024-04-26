Return-Path: <linux-kernel+bounces-160736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701068B422D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08311F233A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130638DEC;
	Fri, 26 Apr 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NX7egTYo"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DC383A0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714170588; cv=none; b=EzcgeY+2nDNg7zK9teeL7mma3c5noXQUuJHUW6rUwiBO9okj/U5fkxNSo9tkq47r2uemFeb4o7SbCx6c0aJjeClGpdOFkIjFWiL45CwiTA4dLXjbqzs0CLYBSf28nB+9H1xlbjSxF6hG5+exTvYSYriG/M+bGLgvmG92Cstk53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714170588; c=relaxed/simple;
	bh=/JAZTw8Az0ztBUDk0sA4JmrZ5DFUfKzaFS+/N6fB7wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MuNTHhSGcbWhv3UTOqBle1G+mLnWYyLaaBQ/sQe4j+QwPIIjVNh9Ap8K/2st+RdnjJTh5dpBhW4e68xLJiTvk8hHYzc7D4ODns6UGX6hlaTYD/S9D9OEeIAa0EfwylYHHCK5W6JVXdL+pjWKdVtwnVzT84Iv8Mq1gZwNeCFhRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NX7egTYo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ece8991654so2595632b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714170586; x=1714775386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTG05S8dcgv/sc7Li2lyTqnr2la76aTbmug3Zcxgoi8=;
        b=NX7egTYogfmlVqPKr8MLsSrWx7LE1NGVL6k+lPC1oeMCxBptu8ii0etQe9jmGc06gn
         jwK5Y9IZmLFB6MZgETEtlyXt2eEZ6LQxdSQ84h+3DJ0U7IOFg3VMG9KRC38BJidczKYU
         M+Y99OWGDgp2a2rDXYx7C2TnJq+SPv3d7zV1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714170586; x=1714775386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTG05S8dcgv/sc7Li2lyTqnr2la76aTbmug3Zcxgoi8=;
        b=skYw9rVVSSZqq0Uu/yG7EWHNk3afVxT1ufZ3qijnI95Sd79Mw7r9Rle7qKYplm2FTM
         POYhBkxCUf/obLSeRyVx/k8Yu5WCzybBLJZhLvGdpCnYI1XQvw4YSXbNCvpe0Xk8CH1/
         bF6eUdd2Img8OXOrjSFy742K57x/Q4NFRdLICzHyhumFdlKolXYuFrRvj+X7E8Na2Az1
         UwJNoFicqtINMFA/vdcoNbaenaB5jSczj9BtF7YwmvOXwr+tVD8WztS/ZgHYAPtwo5ab
         qaV/+eu8IwAVraGXiSOkszLOiB/7uqtOm8fJMFSg1DBVySMZ5qCDZHMNzTPB1TuoqCsQ
         I8ww==
X-Forwarded-Encrypted: i=1; AJvYcCXeeSYirfPiQDk1Rr/82oONC54P6P9pxTGUHy/OE1RNcUYY4xc/RiIO/6OWZ/w0wq2mZPduOXe/c8ta2F2SYlkKwZG532atki+zv9QM
X-Gm-Message-State: AOJu0YzH4VzUgDLq0vvel6qfT6peZW4mfL644rCqmyNI23OACLO+/Unb
	CvwpjK82t1iqTpWQIfSFecpgLfRqCKoDAzSASAWu1x0+Mxbzz2LkTtczh7lwxg==
X-Google-Smtp-Source: AGHT+IH8I81rI/UYedWPzxdcow5LQXZWeOzoAWeMJFfXQml/lLZDlyAtRk5OTEESinibkaS3ST7vqQ==
X-Received: by 2002:a05:6a21:3942:b0:1ae:426a:b53b with SMTP id ac2-20020a056a21394200b001ae426ab53bmr3809062pzc.1.1714170585921;
        Fri, 26 Apr 2024 15:29:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k14-20020aa79d0e000000b006ecd942161fsm15290328pfp.190.2024.04.26.15.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 15:29:45 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hardening: Refresh KCFI options, add some more
Date: Fri, 26 Apr 2024 15:29:44 -0700
Message-Id: <20240426222940.work.884-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198; i=keescook@chromium.org;
 h=from:subject:message-id; bh=/JAZTw8Az0ztBUDk0sA4JmrZ5DFUfKzaFS+/N6fB7wg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmLCrX8Y9C46/LOVocPQD+qsoHgG7tK3cJ+oBHy
 rHReedMZSOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiwq1wAKCRCJcvTf3G3A
 JsqaD/sHGOQsjFazK/JXw46/Wv4E4bcBtjgtHgo9OCskfnXNqnz0P4c9gHMNMWYw/p4ub+t4+bx
 wzzstZOSmhYV811Gx0vJ2ulo0jPPnh8y6/2x9nkGkvWgrtWxiNlHvOmJMSv9fGi8vP3exHn6CCG
 BUaxsodIlWT5neJdhD58ePBffk+31Og+gHc5/WD2Gng3env+B/4okSiDxsAqA1hgMmrvYbzFX3d
 EnzewxsoW2SV8Bwt/QP8QajLjiSy11N8sRwXD+rBRzJ/ay1lBJh9iGNMwRi+/b4yI3/tEiYfU1U
 FFwrNDQcr4zsU0LxFHx2PRjc44yfRrYYAJ3cp5gwpD6LpP8XcYyoio9gbIbe3wpTAcgIu1fsOQK
 d7mdnmP+1D6CNCQAOpVIk51N72SSC3cT7HTxCY/LjXycHo27tMZYehu6xV5ePlB75cUWq8bM4rC
 tGP/LbmOiQf9tg9vYWOSBi3Iyxu1sktbYrjp9HMToikeKYnbLz/5yVklefYALIS+z6RoQJPg3Ho
 vqV4lSwin4S08KSoVpJuAPdWTdt4XhpYTLl2avGVt0gsmcZpF2RQc6LdYIHIPq3A68lpxRztPRQ
 aRsWgfhBD2CTUhRRZjeJU4RwzGYeE27Orz5Ygo65aJqqmcuvlCIWtSVbc5Ns9QexMHAHLhzASPj
 hgh8L94 FruAYSaQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add some stuff that got missed along the way:

- CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y so SCS vs PAC is hardware
  selectable.

- CONFIG_X86_KERNEL_IBT=y while a default, just be sure.

- CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
  it isn't as secure as straight KCFI.)

- CONFIG_PAGE_TABLE_CHECK=y for userspace mapping sanity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev
---
 arch/arm64/configs/hardening.config | 5 +++++
 arch/x86/configs/hardening.config   | 9 +++++++++
 kernel/configs/hardening.config     | 4 ++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/configs/hardening.config b/arch/arm64/configs/hardening.config
index b0e795208998..e8a18fec7a3e 100644
--- a/arch/arm64/configs/hardening.config
+++ b/arch/arm64/configs/hardening.config
@@ -5,6 +5,7 @@ CONFIG_ARM64_SW_TTBR0_PAN=y
 
 # Software Shadow Stack or PAC
 CONFIG_SHADOW_CALL_STACK=y
+CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y
 
 # Pointer authentication (ARMv8.3 and later). If hardware actually supports
 # it, one can turn off CONFIG_STACKPROTECTOR_STRONG with this enabled.
@@ -20,3 +21,7 @@ CONFIG_ARM64_E0PD=y
 
 # Available in ARMv8.7 and later.
 CONFIG_ARM64_EPAN=y
+
+# Enable Kernel Control Flow Integrity (currently Clang only).
+CONFIG_CFI_CLANG=y
+# CONFIG_CFI_PERMISSIVE is not set
diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
index 7b497f3b7bc3..b47e5f411dd3 100644
--- a/arch/x86/configs/hardening.config
+++ b/arch/x86/configs/hardening.config
@@ -10,5 +10,14 @@ CONFIG_INTEL_IOMMU_DEFAULT_ON=y
 CONFIG_INTEL_IOMMU_SVM=y
 CONFIG_AMD_IOMMU=y
 
+# Enforce CET Indirect Branch Tracking in the kernel.
+CONFIG_X86_KERNEL_IBT=y
+
+# Enable Kernel Control Flow Integrity (currently Clang only), but disable
+# weaker FINEIBT landing pads.
+CONFIG_CFI_CLANG=y
+# CONFIG_CFI_PERMISSIVE is not set
+# CONFIG_FINEIBT is not set
+
 # Enable CET Shadow Stack for userspace.
 CONFIG_X86_USER_SHADOW_STACK=y
diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 7a5bbfc024b7..4be0de1f085c 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -23,6 +23,10 @@ CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
 CONFIG_RANDOM_KMALLOC_CACHES=y
 
+# Sanity check userspace page table mappings.
+CONFIG_PAGE_TABLE_CHECK=y
+CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
+
 # Randomize kernel stack offset on syscall entry.
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 
-- 
2.34.1


