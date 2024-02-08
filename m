Return-Path: <linux-kernel+bounces-57320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5225384D6FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C58B22447
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A970D1D6AA;
	Thu,  8 Feb 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsbkhM9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792214A86;
	Thu,  8 Feb 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351308; cv=none; b=AMICjPNHdIAeBBXpNxma/dCZBWTbcEynf60h7RmcGFikGMoSHe8DVTA2yOSHx4jksrSfbzRmK+ACGKiwhmZaXYPbWQ2fd6OdmZBL/qpL6rbjY7NpDIrQCW398p74H3lqms6nm5SXKbOi4GbUzYZf3NgFua3OsSiRP2Uc9+rK5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351308; c=relaxed/simple;
	bh=sNJVGaszF4wsBn8pvY9hRM/14d9MfTxR5UedI/mXje0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJKnBNCi45u4/ott0QKyo4J7kO3q26G0e+1nFhtDHX8dVYCVMPJ01nEoDm30TvWdlNpbnQhpFrp7Dn3AwBQEVPr2uCnsDsyNv4tqxUdyAqtVc4zz1x3TdcGKRCsmQo5RRcm7++kMNK0AwE4M+WNgoA07yK1vgfKjYfCy9wuM8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsbkhM9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187F8C433B2;
	Thu,  8 Feb 2024 00:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351307;
	bh=sNJVGaszF4wsBn8pvY9hRM/14d9MfTxR5UedI/mXje0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FsbkhM9i0zyiFRilq/ijYn96wApOfyna1m/Y5IHX9AlimAnuvUNTHbYqDCat8EhKH
	 UHpfIz2j7d8EbWKMRUniH3XsR7GSwgsCOlMir+ycxL2ab1ybF6gNvZyBCJJ4wAkWqg
	 evnJAdXxVcWWTWOQ7vMclOk4CIKXZ5DU5QwAurU+GHDTYoNw0n/fNDWaIiKCMxqQta
	 94ypXv8DxJlljnQWf6AJIwSA8DWcw/i3Pq6BJlNUNS9cSiAjSJ0aIqyZINYZhpSiF2
	 tYnqvllgafOvguci9epDQ6LVRU3w6chtoIxyxaOnzfXmCFIt+D4EyRjNq5xWt9FEhl
	 Ea5Xe8zdUDX5w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:14:55 -0700
Subject: [PATCH 03/11] s390: vmlinux.lds.S: Explicitly handle '.got' and
 '.plt' sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-3-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375; i=nathan@kernel.org;
 h=from:subject:message-id; bh=sNJVGaszF4wsBn8pvY9hRM/14d9MfTxR5UedI/mXje0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZNlr3kel7O7/cdQpccMtK97/yvKeIpbJPwX3Od7Qd
 Gn//+dqRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjI4UuMDM3b41klGQrrE9bf
 2PKix6aV6dtVaRMDvU1Si/tXGnl1CDD8s6mc+FTOSv4Ha2k6z4sLhS5B//nmxzhKOjx2fC81Pcy
 EAQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are a lot of warnings around the
GOT and PLT sections:

  s390-linux-ld: warning: orphan section `.plt' from `arch/s390/kernel/head64.o' being placed in section `.plt'
  s390-linux-ld: warning: orphan section `.got' from `arch/s390/kernel/head64.o' being placed in section `.got'
  s390-linux-ld: warning: orphan section `.got.plt' from `arch/s390/kernel/head64.o' being placed in section `.got.plt'
  s390-linux-ld: warning: orphan section `.iplt' from `arch/s390/kernel/head64.o' being placed in section `.iplt'
  s390-linux-ld: warning: orphan section `.igot.plt' from `arch/s390/kernel/head64.o' being placed in section `.igot.plt'

  s390-linux-ld: warning: orphan section `.iplt' from `arch/s390/boot/head.o' being placed in section `.iplt'
  s390-linux-ld: warning: orphan section `.igot.plt' from `arch/s390/boot/head.o' being placed in section `.igot.plt'
  s390-linux-ld: warning: orphan section `.got' from `arch/s390/boot/head.o' being placed in section `.got'

Currently, only the '.got' section is actually emitted in the final
binary. In a manner similar to other architectures, put the '.got'
section near the '.data' section and coalesce the PLT sections,
checking that the final section is zero sized, which is a safe/tested
approach versus full discard.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/boot/vmlinux.lds.S   | 19 +++++++++++++++++++
 arch/s390/kernel/vmlinux.lds.S | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 389df0e0d9e5..4aa2f340c8d9 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -39,6 +39,9 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
+	.got : {
+		*(.got)
+	}
 	NOTES
 	.data :	{
 		_data = . ;
@@ -118,6 +121,22 @@ SECTIONS
 	}
 	_end = .;
 
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got.plt : {
+		*(.got.plt)
+	}
+	ASSERT(SIZEOF(.got.plt) == 0, "Unexpected GOT/PLT entries detected!")
+	.plt : {
+		*(.plt)
+		*(.plt.*)
+		*(.iplt)
+		*(.igot .igot.plt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
 	/* Sections to be discarded */
 	/DISCARD/ : {
 		*(.eh_frame)
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index d231a3faf981..661a487a3048 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -62,6 +62,9 @@ SECTIONS
 	.data.rel.ro : {
 		*(.data.rel.ro .data.rel.ro.*)
 	}
+	.got : {
+		*(.got)
+	}
 
 	. = ALIGN(PAGE_SIZE);
 	_sdata = .;		/* Start of data section */
@@ -241,6 +244,22 @@ SECTIONS
 	DWARF_DEBUG
 	ELF_DETAILS
 
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got.plt : {
+		*(.got.plt)
+	}
+	ASSERT(SIZEOF(.got.plt) == 0, "Unexpected GOT/PLT entries detected!")
+	.plt : {
+		*(.plt)
+		*(.plt.*)
+		*(.iplt)
+		*(.igot .igot.plt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
 	/* Sections to be discarded */
 	DISCARDS
 	/DISCARD/ : {

-- 
2.43.0


