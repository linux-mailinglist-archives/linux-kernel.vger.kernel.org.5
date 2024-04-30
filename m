Return-Path: <linux-kernel+bounces-164524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67418B7EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1421C221D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF11802CE;
	Tue, 30 Apr 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftHtMFai"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7B1802B5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498627; cv=none; b=U0IkUd3OZryiX+YelVcoQ8FOXHRhLSimL6wf7HPHnJzL1SpCu7bPsK7qEWDcUSAv5ZkB3ioMoBw8jtl1Vi0s9nZD7UhaFbiPCv91P/dRnTEOKZPfGEhVcQOPzJocgF/evOnZnlDkvGxKQku5E6uHefxaDydbJpbeOfGxOrOkWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498627; c=relaxed/simple;
	bh=HwleHbMmvyClSw2hkCjqzzitfJIFUgKSvCPPJPbOXUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JyDJ1GjaPhYo+wZf8EuhuZR+80mLy+G3BkPP/LJOLPTvhYtX4+lSmdUHivVtmUDsrWWMciASXa3JOWSNG9Q0+r5YzvQt54l/RgS4tIRGhuYA8Cl4+QEF0t5pNUjq/qNYfaaUIxaZBncCQM/eZsARaW4svSWS4rPO4/zWQpR+FWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftHtMFai; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eab16dcfd8so51869985ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714498624; x=1715103424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7TCEkmJU5v9XbqMkMv7vhbRAU+5JxBsl8E5GjM9uj8=;
        b=ftHtMFaipxj1hya2+OVkgdkd2QSO3ryMoAfBnkywgVaRrfaqGZL08O474COmBBxSWC
         mbqrsACYOo7wb81W8kMSBXyqih1lnGo7UHAR+hJhXVyxTqTtf7E1v9xNUwlMG+XHeYY0
         b7Udlsl8Wzmvg8yzMJs/DckhvgShi1agj9Iw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498624; x=1715103424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7TCEkmJU5v9XbqMkMv7vhbRAU+5JxBsl8E5GjM9uj8=;
        b=Q/0ZT1MJR/08DPXCcMWIiZlyLmI1TJW+oMA8WJBFCSsezR6uCxBJcKNLoCzcntbp2j
         rGhjl8orflPkcA5gB9BKoBgDdrmBv5ChWQsgQcGwVu4j81jUXvodycPibNXeiWhn7m2H
         PxOwqSV9knJmd2TjNJee3Gty5IYGi1jP7fPYzHdXja3NJl0J9RZsVIig+CcbyvOIYhrB
         zsFtxbnZIXv2gTkvfyUcN8du0A8W23R0dqtoPwhjmmUfBoigaRXgqskXRWwT0wbjHayD
         kfYPmDzrwkrI+1FajdtEKmx9unnsZj7unrfXXourunzMhoEAxXzj2/pg3nEwol9hhs4L
         pFrg==
X-Forwarded-Encrypted: i=1; AJvYcCUVnwMevuquzkJ1vCwPXcxvzEIbtCggMgW+xzr9Yi2Te6Kxb+TCDmj19jmQEJ3f/hRQZ0YHd4Dmeg/41GWkfzZbu9gIX88nbyUbi5WS
X-Gm-Message-State: AOJu0YwTljSdCyMNRUvX/R1Hos3mGpzs0bQWvgGxjZwdtydTIYDNiqBW
	hsD+EBmDm/UQ4RqqNf78l7fIoBc5lCxRYdzOPvlhsTmzdhtNn5zwPHIf7q/41g==
X-Google-Smtp-Source: AGHT+IEgJyBdK8IaFbZBEcXMW5JQxffHszntW2uwXu4E0cAx4+VHUvWNNAEX/51rVj/TOrVaFr9SYA==
X-Received: by 2002:a17:902:eac4:b0:1ec:76a6:ea9 with SMTP id p4-20020a170902eac400b001ec76a60ea9mr98049pld.26.1714498624229;
        Tue, 30 Apr 2024 10:37:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090320cc00b001eab1258197sm10400741plb.144.2024.04.30.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:37:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] hardening: Enable KCFI and some other options
Date: Tue, 30 Apr 2024 10:37:00 -0700
Message-Id: <20240430173657.it.699-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=keescook@chromium.org;
 h=from:subject:message-id; bh=HwleHbMmvyClSw2hkCjqzzitfJIFUgKSvCPPJPbOXUI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmMSw8JAuEaLHzrMs+I0z2zE2/9ONfTrWuUhxfB
 nUIns+oImyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjEsPAAKCRCJcvTf3G3A
 JhTEEACOGEhRbFkij9Hg8wOi94RhI/kWW1frkUHlY6k9hvRUHCG4HdzS1hJHcBlfpZuXkJ8j3ub
 qAINSRxOpsnxez1sFGK5iy91hNbeRGXyJ5znmwbewZssGCdDyRs99mhcp2+zJJgcOGltMW5q44d
 C1e3GA22dEyNX7IKQneeJpm5SaZbKusp72+3dNQcpkQOc4stcvPbT+b28JZdM+gnuryWpkgwhuS
 ozeSggCI0N6FD0P0HXnFp0tQKEDDINxCW0wIyg07WLruf+R5CRt5jLkZFPN46KcygR5668GeDzS
 ToWYc44Tk88mmSaxTKzPN0afz12vfTuPkrf1+Z6QjOagPIWLEvWW0JtqXVjiw3Tc9qphdzOah/k
 /SQY3iG3kgMJ7y8oh4dPMutI5Ustzk8Vj0rmka0bFaM78u+LC9Ha5grFnsvD17eh9mLFPtn8K75
 YJi9wR7tyyCpnFjSUr/5231n8Y9Q9u+K2TalZMppSa1E2QaDg6giY4ZK3LKPsbDCfPkjyggWTR4
 kHXXHnz9MGksi/hKRITQ/Aq3qpVYyKOBChuMppK9xOqjLZRs/gosEDqtYVjN3nsbGcxnKyOgE+L
 wLHf2ApifK8pF64VYy9at8D0ixOjL8IoywKA39+LMBkzyfENJD+IN+4MRqcigX77oUDCIuuYgtI
 ySSnPDH nd/DoKkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add some stuff that got missed along the way:

- CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y so SCS vs PAC is hardware
  selectable.

- CONFIG_X86_KERNEL_IBT=y while a default, just be sure.

- CONFIG_CFI_CLANG=y globally. (And disable FINEIBT since
  it isn't as secure as straight KCFI.)

- CONFIG_PAGE_TABLE_CHECK=y for userspace mapping sanity.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v2: move CONFIG_CFI_CLANG=y to global config
 v1: https://lore.kernel.org/all/20240426222940.work.884-kees@kernel.org/
---
 arch/arm64/configs/hardening.config | 1 +
 arch/x86/configs/hardening.config   | 6 ++++++
 kernel/configs/hardening.config     | 8 ++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/configs/hardening.config b/arch/arm64/configs/hardening.config
index b0e795208998..24179722927e 100644
--- a/arch/arm64/configs/hardening.config
+++ b/arch/arm64/configs/hardening.config
@@ -5,6 +5,7 @@ CONFIG_ARM64_SW_TTBR0_PAN=y
 
 # Software Shadow Stack or PAC
 CONFIG_SHADOW_CALL_STACK=y
+CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y
 
 # Pointer authentication (ARMv8.3 and later). If hardware actually supports
 # it, one can turn off CONFIG_STACKPROTECTOR_STRONG with this enabled.
diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
index 7b497f3b7bc3..bf3d31618e12 100644
--- a/arch/x86/configs/hardening.config
+++ b/arch/x86/configs/hardening.config
@@ -10,5 +10,11 @@ CONFIG_INTEL_IOMMU_DEFAULT_ON=y
 CONFIG_INTEL_IOMMU_SVM=y
 CONFIG_AMD_IOMMU=y
 
+# Enforce CET Indirect Branch Tracking in the kernel.
+CONFIG_X86_KERNEL_IBT=y
+
 # Enable CET Shadow Stack for userspace.
 CONFIG_X86_USER_SHADOW_STACK=y
+
+# When CONFIG_CFI_CLANG is enabled, disable weaker FINEIBT landing pads.
+# CONFIG_FINEIBT is not set
diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 7a5bbfc024b7..47e6564129c3 100644
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
 
@@ -81,6 +85,10 @@ CONFIG_SECCOMP_FILTER=y
 # Provides some protections against SYN flooding.
 CONFIG_SYN_COOKIES=y
 
+# Enable Kernel Control Flow Integrity (currently Clang only).
+CONFIG_CFI_CLANG=y
+# CONFIG_CFI_PERMISSIVE is not set
+
 # Attack surface reduction: do not autoload TTY line disciplines.
 # CONFIG_LDISC_AUTOLOAD is not set
 
-- 
2.34.1


