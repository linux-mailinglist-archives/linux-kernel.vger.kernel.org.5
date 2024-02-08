Return-Path: <linux-kernel+bounces-57322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2684D6FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50748B22CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25ED2C1AA;
	Thu,  8 Feb 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx0QPSPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E823769;
	Thu,  8 Feb 2024 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351310; cv=none; b=Jl8NbSsLzlNsB48sgKsCg5dPKCSPs3eZulux9RTW5tF5AJ4wKL170jb2p5uuC80gD67thUpI4rZpAT4Y4/Vqmf6Xf0DemKpdBvY7Vl1Y20rJpT/gUxdSDdekjhQVuDRl+trqMED/WXkCsWKGI1t5hXbr1MyriDZA+vMvzFY26qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351310; c=relaxed/simple;
	bh=gbC1anMbNm1FG+NXPrt8YyWEwy6EM4CjZshV2LCDdrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+kFSgRAsDdgGszKOVLT82n20tGkbyXtCJsA7P3xrKh1S2BhAbG9Sh5kVpZMAfaar8ltKBvjBaZFC5q5B4+brWf1qXCfBf9crxGFPGksWOUdaBhFJ7XZmy/UsTVjUa3UOSwteQqv4+4gHtB4XUdVKRnpX6iRdhm628a7T4r401Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx0QPSPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A333DC433C7;
	Thu,  8 Feb 2024 00:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351309;
	bh=gbC1anMbNm1FG+NXPrt8YyWEwy6EM4CjZshV2LCDdrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yx0QPSPygQaFPOX7tvO4hR7s0+YKqwXoGcWLfzg18LmIjcVLenaJw5PmWLJ+2uF4i
	 LNru6iJPuzgGVxbIDDRY1W6RzV4SzmO4tuBk1qhJ+03NIP66w4pQo5JptJ6DAcUxyR
	 P0KYjI4rdj8Qat9jNLs8KU0aYJr59acs4/tOTtJgaMhQTIln3pwRyUXR7jWpbXUJab
	 skwm9j5XZnAxMdfdxyL52Fg0w7cAiSTokk4ZoBc/plDBTp6h24e/wr3V3nbGhf5Yb2
	 tdBz80eezMkzM0z1kZ1tKWP9WmmQJEOHZ31Gio98ggS7uLJo6xOkW4yjK86sHEdLV6
	 d8TgKxL64JhYw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:14:57 -0700
Subject: [PATCH 05/11] s390/boot: vmlinux.lds.S: Handle '.init.text'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-5-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gbC1anMbNm1FG+NXPrt8YyWEwy6EM4CjZshV2LCDdrc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZNmr4358lJ0kPvHbxIPyJQahjrHTauQPdr++fHByx
 ltjpV9uHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi6+IZGZ62LXwzj01OKzV1
 eZxOTXP+ReerW16+4Mgw/S+wrX3C6TSG/w7bVY6Zl83qSbnzOjb42R3L78I3fZl+xN2XvrBJZNL
 aEEYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there is a warning about the presence of
an '.init.text' section in arch/s390/boot:

  s390-linux-ld: warning: orphan section `.init.text' from `arch/s390/boot/sclp_early_core.o' being placed in section `.init.text'

arch/s390/boot/sclp_early_core.c includes a file from the main kernel
build, which picks up a usage of '__init' somewhere. For the
decompressed image, this section can just be coalesced into '.text'.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/boot/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 4aa2f340c8d9..2f0bc05664ed 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -31,6 +31,7 @@ SECTIONS
 		_text = .;	/* Text */
 		*(.text)
 		*(.text.*)
+		INIT_TEXT
 		_etext = . ;
 	}
 	.rodata : {

-- 
2.43.0


