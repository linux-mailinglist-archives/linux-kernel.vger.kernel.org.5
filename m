Return-Path: <linux-kernel+bounces-111811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83D887148
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442791C21728
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567595FDAE;
	Fri, 22 Mar 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvFEJW9w"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98A5F466
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126371; cv=none; b=Tcc4bMbEJqAqDNSLJluVNbu8VgGQEYIRYmk/yeYWq68EajilrAC7Y+ADo1oGVEizKfCBXmW9CE3rvpsElHD8g6Ic81OBSnFI+eJid+9Ih+WnmaPL1N9rkngk4L16ArjUPD5naC7hUUJqovUxUT1T3bAWFPg7xu8eH7dQYe0BfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126371; c=relaxed/simple;
	bh=EDpNl4LRcs64R7xLYeFg83XcegfrjomehPC/gIvBDvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ04Eh13wbkDJxQVtEy+x1APncTKZEktQg26omCXzSONbS1HH5YpaaakYz3mIUzpdX1k2EiRCAGTe4/iCmEe8jKJu9+ajhVtfs4ueSjGhmU+mIzsKP9b6ggqbshRW3nwLeg2PyrPQh79y2tUrHZF1PKaliukCeSMR5fue3JlKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvFEJW9w; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789db18e169so176877485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126368; x=1711731168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKTOB+egwNuleK2drTZ0+IAwoS6KwJYp/cKDBgEAyxM=;
        b=VvFEJW9wtjg5IaxppjnlMCL/YM6kp1Woq6wqVQ0Uh09xcdCfRGZZ/u6yASeJo6HrCX
         vRjOG48poSa66xL2oLggduqIwfYqJy8c4Xi0zCJK6pOPXUl1sLvRo+gZIh7AigyyyjjH
         cihwuEVijjtEvoWiQJiasntFSOYR8ScCusWtd0XFqabIfdbNuOG3VQ/FUQm6IZqDkOe+
         1aDGJTwPTpWTK6wgHNOFYQwnCTNqBvwE+GY5ZqM+qpo+ALWGw5mMbSqYg2ECkJjoofIO
         6ZKXUpxgsUffNQnoVRlO1zxyuLl3Q++6HfIRu+9lpBkw+a2SvWh445eorJhx/H1f9UDe
         Z7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126368; x=1711731168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKTOB+egwNuleK2drTZ0+IAwoS6KwJYp/cKDBgEAyxM=;
        b=F0IPx4E+S1VGT/1qGGX/fHC1vJt5z4GlQsSQpOI1cg6DhMRKkyt43jtki+n+UUNN5o
         zjOO6dwW4c1IKNONu9TSKIcicBWv6hJw2uCJufyoqLL9N9wHg5+dPrL56ecxHI7W4meG
         my/JOVb35WQxqXM3SltYbuntorxyklgVdQyKCBMAtJ+J1pZ6Fg8NpWiLr+4Xwkf4uGdG
         ROn5GZ8UTHe2Qngw4c3YDGTy3UITHqGnHinlNqs07JxIXuDl89Jbu5h171oIdRJrBMku
         nP7SovNrEHg1CjokG4r2NnzjkGznZJRljmSMtd/qfpLFwRDfx9qY5+8MscMxw9Za9Wr8
         cdIA==
X-Gm-Message-State: AOJu0YyxTBaDgIU71oE1uzG287UpaomWXcPfpWnWnsNo8VYLZAnKggNp
	PZZbHCmkqnYpk171jtIap1KY5hOiSIr6MenbNoR+3aIEsoln44a8GEtayJU=
X-Google-Smtp-Source: AGHT+IFf/jYKwZ7fhbLQiCg5reXblzCosOYHLI6zgNxe3fSzI5gD+r/7AwZUtmskhFxLLGIHxbAKUA==
X-Received: by 2002:a05:620a:5656:b0:789:cf19:2e05 with SMTP id vw22-20020a05620a565600b00789cf192e05mr2813358qkn.38.1711126368077;
        Fri, 22 Mar 2024 09:52:48 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:47 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 02/16] x86/stackprotector/64: Remove stack protector test script
Date: Fri, 22 Mar 2024 12:52:19 -0400
Message-ID: <20240322165233.71698-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test for the stack protector was added in 2006 to make sure the
compiler had the PR28281 patch applied.  With GCC 5.1 being the minimum
supported compiler now, it is no longer necessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 5 ++---
 scripts/gcc-x86_64-has-stack-protector.sh | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f326903cbe67..88d72227e3cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -411,12 +411,11 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
+	default y if 64BIT
 	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	  We have to make sure stack protector is unconditionally disabled if
-	  the compiler produces broken code or if it does not let us control
-	  the segment on 32-bit kernels.
+	  the compiler does not allow control of the segment and symbol.
 
 menu "Processor type and features"
 
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
deleted file mode 100755
index 75e4e22b986a..000000000000
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.44.0


