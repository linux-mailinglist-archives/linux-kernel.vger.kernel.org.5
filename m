Return-Path: <linux-kernel+bounces-126573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAEB8939BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E803228456A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687310A11;
	Mon,  1 Apr 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlJJsKVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39601095A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964884; cv=none; b=Q09Hi5oNQ8COWtLZNjwHvWclcEscUpLc7XthtSMBqzIoWPpEzPZkxr/tVI1U/2xsjdXSDfaDKWvTIyltqjxdwyWe3ZiMtyBqhKi97G0P7BZKKq0+66N40r3ceG7axP1IGZx0WvSpHWjRB97gL9+PjCnNzjEe7u6FItjjzkVkEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964884; c=relaxed/simple;
	bh=9FjL7Gk4yg+RLbu8ygy3B4kxvcDbjpFdU9WPgWfD7wc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CH/EQD1mFITT+5C61UMa74cRekImKaAsNSOA0Cy81R83FAuu8aBxHLkeQ5PtpCVMezaOjZ+C0n6NsAAqKzElYttXa178feqEHUZzK8iEpG1/37WzG+A5pTniYxySVMdj3tyrqarAM6dyos50ZV2I28jqoYrZ8zOwsTjSfXWZbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlJJsKVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5507FC433C7;
	Mon,  1 Apr 2024 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711964883;
	bh=9FjL7Gk4yg+RLbu8ygy3B4kxvcDbjpFdU9WPgWfD7wc=;
	h=From:To:Subject:Date:From;
	b=XlJJsKVl7chfcjDyYCQCWQPoPo3F+uloFJr2cmeJqsGlrnviWe20AYbiev77OYzIX
	 veR3hHxBXP9feVdxJ3B236ygUQMhSqwfQfKfGSdZIx+nnlcBzb5ta3TSGNvqTjOAkJ
	 olLg4JjFWxXwnit9SpD2ZHsHyUkSe8C71NNaZ27L+Fsi351VwEBN9gTmPk3LcJMfLE
	 ThYpoFL8Wm027zeYos9ZAGparLeoPov29+64dxoU5zfKUI5H/MQz/hw6Czogo3dE3t
	 RZQ7a31qZt2hxcZ6NQ/V9FC6iWPlmUWvpsDWKkJcUMnERJkmuHyed/imBLRhaXC2lo
	 c8vGqt42dudIw==
Received: by pali.im (Postfix)
	id 7A5DA344; Mon,  1 Apr 2024 11:48:00 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/boot: This program cannot be run in DOS mode.$
Date: Mon,  1 Apr 2024 11:47:19 +0200
Message-Id: <20240401094719.29536-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is a well known requirement which everybody knows: Every PE binary
executed in DOS must print legendary and famous message to the computer
screen:

  This program cannot be run in DOS mode.

Linux kernel binary bzImage with enabled config option CONFIG_EFI_STUB is
bootable EFI binary. Every bootable EFI binary is in PE format. So bzImage
is also PE binary, but currently it does not meet that error message
requirement.

So fix this issue by properly filling all fields in the MZ DOS header part
of PE binary. And add a simple code which prints the required message on
the computer screen to fulfil the requirement.

In this case the required message "This program cannot be run in DOS mode."
is not fully truth as for example LOADLIN.EXE application can run Linux
kernel from DOS mode. So extend error message and prints additional line:

  Use DOS loader LOADLIN.EXE.

For sure it helps users to know what they should do when they unexpectedly
try to run Linux kernel from DOS mode.

Note that DOS strings are not null-terminated but rather dollar-terminated.
Therefore it is required to pay for printing this error message in $$$.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v2:

Due to big popularity of the first version, now after years I'm sending a
second version of this patch. Second version fixes booting issue by not
moving content of PE header (it is not needed now as the PE code after
years evolved) and patch is rebased on the top of the master branch.
---
 arch/x86/boot/header.S | 60 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359b..b0a8d89b510c 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -42,14 +42,58 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 	.code16
 	.section ".bstext", "ax"
 #ifdef CONFIG_EFI_STUB
-	# "MZ", MS-DOS header
-	.word	MZ_MAGIC
-	.org	0x38
-	#
-	# Offset to the PE header.
-	#
-	.long	LINUX_PE_MAGIC
-	.long	pe_header
+dos_header:
+	# "MZ", DOS header
+	.word	MZ_MAGIC                        # e_magic - Magic number
+	.word	(pe_header-dos_header)%512      # e_cblp - Bytes on last page of file
+	.word	(pe_header-dos_header+511)/512  # e_cp - Pages in file
+	.word	0                               # e_crlc - Relocations
+	.word	(dos_start-dos_header+15)/16    # e_cparhdr - Size of header in paragraphs
+	.word	0                               # e_minalloc - Minimum extra paragraphs needed
+	.word	0xffff                          # e_maxalloc - Maximum extra paragraphs needed
+	.word	0                               # e_ss - Initial (relative) SS value
+	.word	0xb8                            # e_sp - Initial SP value
+	.word	0                               # e_csum - Checksum
+	.word	0                               # e_ip - Initial IP value
+	.word	0                               # e_cs - Initial (relative) CS value
+	.word	dos_start-dos_header            # e_lfarlc - File address of relocation table
+	.word	0                               # e_ovno - Overlay number
+	.word	1                               # e_ver - Linker version, 1 for DOS compatibility
+	.word	0                               # e_res[1] - reserved
+	.word	0                               # e_flags - Old exe header flags, behavior bits
+	.word	0                               # e_res[3] - reserved
+	.word	0                               # e_oemid - OEM identifier
+	.word	0                               # e_oeminfo - OEM information
+	.word	0                               # e_res2[0] - reserved
+	.word	0                               # e_res2[1] - reserved
+	.word	0                               # e_res2[2] - reserved
+	.word	0                               # e_res2[3] - reserved
+	.word	0                               # e_res2[4] - reserved
+	.word	0                               # e_res2[5] - reserved
+	.word	0                               # e_res2[6] - reserved
+	.word	0                               # e_res2[7] - reserved
+	.long	LINUX_PE_MAGIC                  # e_res2[8], e_res2[9] - unknown
+	.long	pe_header-dos_header            # e_lfanew - File address of new exe header
+
+	# DOS start code (must be paragraph aligned)
+	.balign	16, 0
+dos_start:
+	# Print dos_msg string (ds:dx)
+	push	%cs
+	pop	%ds
+	mov	$(dos_msg-dos_start), %dx
+	mov	$0x09, %ah
+	int	$0x21
+
+	# Terminate program
+	mov	$0x4c01, %ax
+	int	$0x21
+
+dos_msg:
+	.ascii	"This program cannot be run in DOS mode.\r\n"
+	.ascii	"Use DOS loader LOADLIN.EXE.\r\r\n"
+	.ascii	"$"
+
 pe_header:
 	.long	PE_MAGIC
 
-- 
2.20.1


