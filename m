Return-Path: <linux-kernel+bounces-57318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F084D6F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361F3287DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4F12B91;
	Thu,  8 Feb 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmzQeZ1J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C90D53C;
	Thu,  8 Feb 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351306; cv=none; b=MrPXQxM1OiiS9l7qsFbGAr0RJbvETQj8X4Qv3Wr8r2a5cgLubbBVLU41tjCnYUNgHYrTYdf7h7Coomo1CjeUat7DOh84wlIOcNDsMqbyZMpTG1JLl9Pzl0uFKRffDkv4u0ookgGAaSOM2bk1zf8Ciy4OnRYERaq4fX4Y3yJH4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351306; c=relaxed/simple;
	bh=aTb4pn0CAwwvBRJP9l28pMh6aiS0FZ7vCx6nye/a3mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IwuTH7DxozE3lPPj/7vQE4SSshi+48NjVFR3A5lyLKOCcWcVu4q4e1/epS3DetpiV5VUfR9qGglokE6soXKQu7ptA6dZyosb+Qm3YX0YVxM2htJ3gtRQDZLWyLnc3iRsPvlv4RYvmOFc+UwlUQfptpX42n0CwkmcKr0uPa3SXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmzQeZ1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D99C43394;
	Thu,  8 Feb 2024 00:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351306;
	bh=aTb4pn0CAwwvBRJP9l28pMh6aiS0FZ7vCx6nye/a3mY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UmzQeZ1J/MNXygqXAlloamg9yP+I+4vauU3qPvSvews15F3rqQcwYKE8rvrfhE7jz
	 +oVQKSk4FuekTxJ2L3/A5fFhpX9I/O1qIko7ZDF8JXEg2wuuZaM91UT/gfebQUIXsJ
	 +h+rQ9d29G/kMYvoT8jHUu9nl3kQE9+F699Q8h2tvYZUS/BhUxapjnHWaesmpslhE8
	 1imGB/P/xXukEYLsX/yMlANwj8eYBLqbaTYx/dp3Qo37O3ZVDKcPpLzser7MKNyfis
	 aoaPAPYjmHWl8dec5QA3wRqUAVXTw2FXVUApdeedm+teustMzeluQLkWoRfsQz6HbQ
	 ncv/Yf581pFdA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:14:53 -0700
Subject: [PATCH 01/11] s390: boot: Add support for CONFIG_LD_ORPHAN_WARN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-1-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=nathan@kernel.org;
 h=from:subject:message-id; bh=aTb4pn0CAwwvBRJP9l28pMh6aiS0FZ7vCx6nye/a3mY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZNkrnPh9Omb8n66xZv3+5NKnc41uxtwzl2k8e/6U4
 HSeyz0KHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAivwwYGXp73A6tCo06yX0x
 Rbl2f2zYgTDf7inLw8JX/7fXzjpXVcTI8EF2/TftJ/PO3ZY5OPvB96vZIdILF7z+H6Rz9v91u6J
 FbqwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

arch/s390/boot/vmlinux uses a different linker script and build rules
than the main vmlinux, so the '--orphan-handling' flag is not applied to
it. Add support for '--orphan-handling' so that all sections are
properly described in the linker script, which helps eliminate bugs
between linker implementations having different orphan section
heuristics.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/boot/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index c7c81e5f9218..ace0bda1ad24 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -73,11 +73,12 @@ $(obj)/bzImage: $(obj)/vmlinux $(obj)/section_cmp.boot.data $(obj)/section_cmp.b
 $(obj)/section_cmp%: vmlinux $(obj)/vmlinux FORCE
 	$(call if_changed,section_cmp)
 
-LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup $(if $(CONFIG_VMLINUX_MAP),-Map=$(obj)/vmlinux.map) --build-id=sha1 -T
+LDFLAGS_vmlinux-$(CONFIG_LD_ORPHAN_WARN) := --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
+LDFLAGS_vmlinux := $(LDFLAGS_vmlinux-y) --oformat $(LD_BFD) -e startup $(if $(CONFIG_VMLINUX_MAP),-Map=$(obj)/vmlinux.map) --build-id=sha1 -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS_ALL) FORCE
 	$(call if_changed,ld)
 
-LDFLAGS_vmlinux.syms := --oformat $(LD_BFD) -e startup -T
+LDFLAGS_vmlinux.syms := $(LDFLAGS_vmlinux-y) --oformat $(LD_BFD) -e startup -T
 $(obj)/vmlinux.syms: $(obj)/vmlinux.lds $(OBJECTS) FORCE
 	$(call if_changed,ld)
 

-- 
2.43.0


