Return-Path: <linux-kernel+bounces-57323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E584D700
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083DD1F22713
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443743399F;
	Thu,  8 Feb 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQcPoXsg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DC29CFB;
	Thu,  8 Feb 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351310; cv=none; b=uQHK1xH+CvO7j/CEhxqoZrmr8mjzUmS7wk7863apdxYKRaInpTmB+Hsxclk54dksKaxq8n0QmRbGfGovYOQm1hYCJdRCcfahnTkBLaA1j3To5ToUGsaF7oYFQrA2hFYI2t3zPneC3lhGbk4y/2FX1RkXdG7xeFLLaDXqzj8A9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351310; c=relaxed/simple;
	bh=KRQSj+pCd28VbnV16E5i5W+KSoyksfan092qVAxtBJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L04h1H+iZXYbWqf+e3wIOl62WjQU+8trubWh9lXyQQqPblTARuCQyutCI3Tms1b8K5aedk0pEGrKgjmb7AfxMcL1Z50OMXGbIe5N5motdwZvknJTQSnvmpk7oURWA0z5dtvBCcUKNqHxw6MDtMouuYhVfkWKRUfuKNJ1H10zgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQcPoXsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA59C433B1;
	Thu,  8 Feb 2024 00:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351310;
	bh=KRQSj+pCd28VbnV16E5i5W+KSoyksfan092qVAxtBJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pQcPoXsgBOiC3EZXF7EKZeBNRfnk5uYo2Op//tZzA/PAck1qoq5FAzzBkbQI6oW8/
	 qPU1uQkewIHyVSpCHq1i53jzBptofiKJo/ggIWiaPWwYHkvqZbphDvBPQjFyhxnZ5U
	 URqNdlV1Qmz8T87Oqe6IKhXGChCNYZ5cd3eCgRIe9Org6GQcdMhdVxDAhCtrpiSQPI
	 HluD+MbAeIBtG+3tY6+nEuWpDL1RRbfQr6yNT2YsvIRtIAknKFnZ7aYhR5yWqUmNOn
	 aQjpO8XSm/UQjKqSqn/OAs4ev+mTjoF3uo6k13+xaJ1ps7G3GdDj+UWY44Sv92O9xy
	 X6CCzQ0R7aN8w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:14:58 -0700
Subject: [PATCH 06/11] s390/boot: vmlinux.lds.S: Handle '.rela' sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=nathan@kernel.org;
 h=from:subject:message-id; bh=KRQSj+pCd28VbnV16E5i5W+KSoyksfan092qVAxtBJs=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZNnLdM2i2RqEDtvvUo6Zrzm7s0liSoR8XciqxwUGs
 dsOnnjcUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACayyoThv3/f89x/z8UDPj/Y
 1c3qvnz//gnrrnzYLyn/9P3NiU8Ko14zMryTlw7PXbGlbknvRemJcxfwHZg861O15oPDLfvXaii
 tYWUCAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are several warnings from
arch/s390/boot/head.o due to the unhandled presence of '.rela' sections:

  s390-linux-ld: warning: orphan section `.rela.iplt' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.head.text' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.got' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.data' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.data.rel.ro' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.iplt' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.head.text' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.got' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.data' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'
  s390-linux-ld: warning: orphan section `.rela.data.rel.ro' from `arch/s390/boot/head.o' being placed in section `.rela.dyn'

These sections are unneeded for the decompressor and they are not
emitted in the binary currently. In a manner similar to other
architectures, coalesce the sections into '.rela.dyn' and ensure it is
zero sized, which is a safe/tested approach versus full discard.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/boot/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 2f0bc05664ed..ff8c62d84f98 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -137,6 +137,10 @@ SECTIONS
 		*(.igot .igot.plt)
 	}
 	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 
 	/* Sections to be discarded */
 	/DISCARD/ : {

-- 
2.43.0


