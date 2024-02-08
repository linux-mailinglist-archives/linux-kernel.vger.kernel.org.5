Return-Path: <linux-kernel+bounces-57321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033A84D6FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626E41C226D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32E72262B;
	Thu,  8 Feb 2024 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOJBJaUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA201E4A7;
	Thu,  8 Feb 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351309; cv=none; b=AARwuX+rI9zyO/T0g6eWf6rZcowQYfTbXz/Khr6BIpus6UNvnogHowqRr4lmMOK+Y6nEFQ2AZpUiA08CHzBtCKd5Ha6ZOr2xoYaCUxy1jHA2HtyucKfLX3o+DmIe7GK9rBsvhm/V2Pye8smgvwBxEqI0fyoQFBtOHwBxc3pDxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351309; c=relaxed/simple;
	bh=0Khy05nhsc8IVw6OcGxTD0wL0pcsnDmwXjS5CQyzon0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EL2W0NMKyKZswuvrnTrNGzhlI6v0ZAP9tkhttgLoXmBYJHEelbq1+D0VwZCnZJkiYbRef9LTbDryekjMaXeDrcEBeVckYcPsw5G2sC9xF+sLhqdVqhg+kGtddAHI5xjYBcJmfPydsir/uCtl/YBFiLwwp4JBLxRAJ32Yaum+pWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOJBJaUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9523C43143;
	Thu,  8 Feb 2024 00:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351308;
	bh=0Khy05nhsc8IVw6OcGxTD0wL0pcsnDmwXjS5CQyzon0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fOJBJaUBcLAQwoILyMM5cB1A99wqwoQealbZLTQEtUvDIRDszPPWHDIE6fu1D9h+z
	 c0N5ravztR0NdvZihHAIdpDL0QcCW6egIZXuGd575StCX0b+I2eFTyID9sUV6H4OcB
	 gg3kbKBt6E9+e+petluXLdTBWi8MijbmYrM2MnlYAq6nCjahioTxHhcfx5/FdhfLDi
	 YgRYxgENlmbbIti1mD47gj4b4AFVe/qNIGDKjR9/o91fuJA63VXbGXuc6OuIvqRXTP
	 4oLkVl1V3ouvcuzY21Kdxcn6RKJbcAYrNJZQsj3bxYshfrVXWn4QTAbw40t5MjP0jB
	 UadiusbGZ5mjw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:14:56 -0700
Subject: [PATCH 04/11] s390: vmlinux.lds.S: Discard unnecessary sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-4-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=nathan@kernel.org;
 h=from:subject:message-id; bh=0Khy05nhsc8IVw6OcGxTD0wL0pcsnDmwXjS5CQyzon0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZNmnGd0+tUxwadNrSd+EJ9rR1cWdk5OuvQn+33C0k
 u98oVx9RykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjI0puMDCt/M736/lcgXEN4
 p/7aoBDnH4fjN97dfGvTWyEfocn1kZcY/odp2O/tfaOWWy8i8m26zZdd7smrLEQnce4qmCl1W/b
 tGz4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are some warnings around certain
ELF sections that are unnecessary for the kernel's purposes.

  s390-linux-ld: warning: orphan section `.dynstr' from `arch/s390/kernel/head64.o' being placed in section `.dynstr'
  s390-linux-ld: warning: orphan section `.dynamic' from `arch/s390/kernel/head64.o' being placed in section `.dynamic'
  s390-linux-ld: warning: orphan section `.hash' from `arch/s390/kernel/head64.o' being placed in section `.hash'
  s390-linux-ld: warning: orphan section `.gnu.hash' from `arch/s390/kernel/head64.o' being placed in section `.gnu.hash'

Add them to the discards to clear up the warnings, which matches other
architectures.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 661a487a3048..35a6b3e6cc50 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -264,6 +264,7 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(.eh_frame)
-		*(.interp)
+		*(.interp .dynamic)
+		*(.dynstr .hash .gnu.hash)
 	}
 }

-- 
2.43.0


