Return-Path: <linux-kernel+bounces-57326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7AA84D709
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241A51C21D65
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D989136AED;
	Thu,  8 Feb 2024 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+VBM/RR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772C364BE;
	Thu,  8 Feb 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351313; cv=none; b=lMFAbasPI3iH/uX7fW2ppsqnCFeAm10mMLzn0xtB/a8F8HjhFLH9UrmW1CLlX8B7XxaYEgdKTt6QO8igV9DTuqwmRaanaebK/RqK8snkJFC8EZyeAVs86F2D82n6NdU4RblticpwGrjq2SVRjH3DkvOntRpJF2CMsbM0OvH5FZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351313; c=relaxed/simple;
	bh=oj028p9Bfp82VhGdol8YywhGeGdWcYwVFqAjOaIyq2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mx7wc8BP3RYChnFdrIEiew2ubNPHW2Pu92gx+ZzWZ1g3B9UnDXuZUyTghMOftYc6EjTU4i6sxGEmeLbv4Z3hA7Kps5wQOp9e1VknhJZbdAe42DG9dpR7fSdqxHf4O7Sg1njWuVGxKebZpyedTYvlwA8X0omsUV+L57CC2ivYfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+VBM/RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2533C4166A;
	Thu,  8 Feb 2024 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351312;
	bh=oj028p9Bfp82VhGdol8YywhGeGdWcYwVFqAjOaIyq2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a+VBM/RRARb8IGHNobHJ7/wCBuPUE+RNWDE7qcTDQwMhu3XRQ0JXtmMHgprj67GpT
	 gBtGrXaStCuN/MN0u0XAmUOhxP/HIsOIykbDmm6fa1wmY16fwVq5J1gGVABP2xdAog
	 phesGsGhOhTOuIiK4GLwwm+Rdp+ETNIcaHodPI5iAake35cjVLNrHP2Lo2n770Dji8
	 VCfgyCFM7N9DW3F9zNWojrQC5hymJWoJQ1yCn6jUtXMLK+TBH4RvQeqJFRxtnMme5w
	 WzeZMqXrmKCiyHMWqBicIETCMIdNxheCpofROUn7Ypt7/P4U4lyJbcEQAWzf4tLpXx
	 KyZ7wHdwUDqyQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:15:01 -0700
Subject: [PATCH 09/11] s390/boot: vmlinux.lds.S: Handle commonly discarded
 sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-9-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=nathan@kernel.org;
 h=from:subject:message-id; bh=oj028p9Bfp82VhGdol8YywhGeGdWcYwVFqAjOaIyq2A=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZDneq/YZ5DQ/82DhX2+QvKhZa+GrjfU3klxnbU4p8
 NDqeTi9o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExkz2KGP9xL1tQ/uxdurpiZ
 In7zlYH3p09FhheD+K2fHJLdrpd6dwrD/zB/30vGajUHP7e9SqtcVbxlyQupp7VaAYU2E29uT8n
 ewAgA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are several series of warnings
from the various discardable sections that the kernel adds for build
purposes that are not needed at runtime:

  s390-linux-ld: warning: orphan section `.export_symbol' from `arch/s390/boot/decompressor.o' being placed in section `.export_symbol'
  s390-linux-ld: warning: orphan section `.discard.addressable' from `arch/s390/boot/decompressor.o' being placed in section `.discard.addressable'
  s390-linux-ld: warning: orphan section `.modinfo' from `arch/s390/boot/decompressor.o' being placed in section `.modinfo'

include/asm-generic/vmlinux.lds.h has a macro for easily discarding
these sections across the kernel named COMMON_DISCARDS, use it to clear
up the warnings.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/boot/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 2bef450e84e9..806bca35e3f1 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -147,6 +147,7 @@ SECTIONS
 
 	/* Sections to be discarded */
 	/DISCARD/ : {
+		COMMON_DISCARDS
 		*(.eh_frame)
 		*(__ex_table)
 		*(*__ksymtab*)

-- 
2.43.0


