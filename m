Return-Path: <linux-kernel+bounces-65987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA58554CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C9228533F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334EF13EFF8;
	Wed, 14 Feb 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N/ALb08p"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FC7134740
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946174; cv=none; b=A+6uTzt0JlbBOZk4w3yIHleEgVqVwkOx506CfDYkLtAB/VWDcwaWH8S48Zruo9RJiM3M9aeQ+QDHj9DTihjHFkxSD045khJeLGVI0Yt/pbBJo8QPih8RnysTWsByUKLzJNAtM4VyX/OaZF47/MbNHdECK693hborJFJFEp4HwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946174; c=relaxed/simple;
	bh=1h+GU62VcVsLcL314hriaxQNUPcjpImRJ7JoY1S/BfM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GSKfbhki8eQn1kxwoOTnczFr/e1G0sbq6gzxFZlTPqF+z+HMXxScp/ZjxLHhEZxtJSkJt1N93vrhRXEmx0gcKMUw3gxO1eDBaQCVHbfjsKT00mtL1ZypCCUhNDyKdU9PbaZyurTs1tBjvWopnLt6/ukI3R+PO6X4gHdokq6K840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/ALb08p; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604832bcbd0so4922387b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707946172; x=1708550972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dFTWNPOxarceOkMiDWt4BFJs1kZ5yk38ZT59AswMTIA=;
        b=N/ALb08pVFsOfFx/qTqsP9I1S5YzcXoyKdAz9VmP1WeJ1/Vqxc/pca4TTrORa4mpej
         fZ4RbeP9v7REKl0BcTNlgBnUz5C6ow+DGCNeUdJhrLmp/ra2kw6B2OuqHnd6zGYjEXEM
         XKwKrgfjNZixlZE2rSysZ7FfTLwXv5xIIFPrfHev3mrZ/Op9gDZM5hos+6qeHOXkgbI4
         JtQkdpa3gWOZbSrKF8VDNUhX4wPUY9l8/Nz2RES9B7i8ZsvSVopIW66/IuBhgFImLAus
         PYYm0odIoiTBG83klqhzwBZ7rkDzR3l7Fsvi2OmpTVPyUzqbW5ykVhF/wO5TqSTrz7Lu
         OQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946172; x=1708550972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFTWNPOxarceOkMiDWt4BFJs1kZ5yk38ZT59AswMTIA=;
        b=ThXKI0r/2JMNZrLxHOvYA3TR9M2j0+s84U1dZA7Myg8j0waLOk2iyf7hepGl7HBlEI
         S6AFM0K3I5JOKJlEglxnqHSEdzCFj1wBWU91qyhaFM50CDb+IDcYFQtUgw70113m6nf+
         yfpWxWYrfmFwr99MLeTxPKLcvuRJmK4wT9YixnSft2R35J7eTYC9aExmou70DWcx2XA3
         o37TnN2il5SEXw+l5O38zwReUgehFQDiGdbXmAx1Mr74pz4IjFe9Kk+KbGsckmj7WjYo
         tesJTlRNT4P/aB4E76wuZAtt7YnBJy+2C+AMphftVpA33WkM/1AhlpeaP5TL3UAhM7/T
         YZlA==
X-Gm-Message-State: AOJu0YwPa956R8tOCPIF+7fxt3w6SXYp/MI70bHR5pIBJsZmtxAOLkAr
	4N3bBnsBgp88OwM5pSsnoV0l7qqXsDuG/cartCHGWN4JaeYWGAzbV2kykR104IeTiFVqk+xKC5I
	pMIz8cA==
X-Google-Smtp-Source: AGHT+IFqu5San60pN/HO+kKe9H5ryDNbyfTlopcSoOvmM5DJ+bcwMEr6JJfznvuPvwXLyQoTSDnHHFz4G9do
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:448b:aa1a:69fe:22b6])
 (user=maskray job=sendgmr) by 2002:a81:4fce:0:b0:604:9315:b547 with SMTP id
 d197-20020a814fce000000b006049315b547mr849276ywb.5.1707946172036; Wed, 14 Feb
 2024 13:29:32 -0800 (PST)
Date: Wed, 14 Feb 2024 13:29:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20240214212929.3753766-1-maskray@google.com>
Subject: [PATCH] x86/build: Simplify patterns for unwanted section
From: Fangrui Song <maskray@google.com>
To: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

A s390 patch modeling its --orphan-handling= after x86 [1] sparked my
motivation to simplify patterns. Commit 5354e84598f2 ("x86/build: Add
asserts for unwanted sections") added asserts that certain input
sections must be absent or empty. The patterns can be simplified.

For dynamic relocations,

*(.rela.*) is sufficient to match all dynamic relocations synthesized by
GNU ld and LLD. .rela_* is unnecessary. --emit-relocs may create .rela_*
sections for section names prefixed with _, but they are not matched by
linker scripts.

plt instead of .plt.* is sufficient to match synthesized PLT entries.

igot and .igot.plt are for non-preemptible STT_GNU_IFUNC in GNU ld (LLD
just uses .got), which the kernel does not use. In addition, if .igot or
igot.plt is ever non-empty, there will be .rela.* dynamic relocations
leading to an assert failure anyway.

[1]: https://lore.kernel.org/all/20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org/

Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 6 +++---
 arch/x86/kernel/vmlinux.lds.S          | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 083ec6d7722a..9f288f67972a 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -104,17 +104,17 @@ SECTIONS
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 
 	.plt : {
-		*(.plt) *(.plt.*)
+		*(.plt)
 	}
 	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
 
 	.rel.dyn : {
-		*(.rel.*) *(.rel_*)
+		*(.rel.*)
 	}
 	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 
 	.rela.dyn : {
-		*(.rela.*) *(.rela_*)
+		*(.rela.*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a349dbfc6d5a..b3da7b81d2b3 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -463,22 +463,22 @@ SECTIONS
 	 * explicitly check instead of blindly discarding.
 	 */
 	.got : {
-		*(.got) *(.igot.*)
+		*(.got)
 	}
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 
 	.plt : {
-		*(.plt) *(.plt.*) *(.iplt)
+		*(.plt)
 	}
 	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
 
 	.rel.dyn : {
-		*(.rel.*) *(.rel_*)
+		*(.rel.*)
 	}
 	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 
 	.rela.dyn : {
-		*(.rela.*) *(.rela_*)
+		*(.rela.*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
-- 
2.43.0.687.g38aa6559b0-goog


