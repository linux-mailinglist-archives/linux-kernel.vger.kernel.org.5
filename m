Return-Path: <linux-kernel+bounces-111810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76655887147
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150FC1F236E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5765FB9C;
	Fri, 22 Mar 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfypVfih"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EE05D47A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126370; cv=none; b=uI6ahPFcemvRO2w/64lBfVITvlA7UUzk9feVK1s8uuCIesfbv/8kwx1Tnjvmqgw5spwoIxv7cXhHVrfuRxikc4JqM8mD+gbWYzi91VNlsAIsBDzpjMI4eCQ0wGQIS1RICpM2ELvKwJ3POaUZJXgS7EJNgZGPI8exL268KI3K9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126370; c=relaxed/simple;
	bh=0ghGhHkYB5a3QE//W4UnFTfqJRNvrjDLfq9w7NmbnE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec+MmrH7U8z5o0u95B+ovH/ZUC2dSd26fPuCcUUheozw3kKjC3PgUPPVefc3DnmjCaq40kZm7M2jsOc4fZmJR8b8q9dtcvAwOidcNQ2+bx6/tIbsVk2woDwp88JSCp+yF8hLAQg99Dp5ef3HcefmVfpPBfQr4BeS/XJRGwsdJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfypVfih; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78a2093cd44so187327885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126366; x=1711731166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MEvpbcjD55OPVHZv1k/P6RoxHeXbs2ZBZ6egLEjNfc=;
        b=DfypVfihvSjfHp0uF+n+R3ynH5q+gqbjWBIReNQegtnnKc0zH8uutBbwtUnV4wiC2K
         ocauUFi86+dTyiCUHnG7zBNy/j7yU5+mwsZ/idS12W55JK5Rfzf10U+pYdCF6kYPTVMC
         QtmGnALiah2V96fdSrsOPQbXjtu5wJHjkb1OgO0gZNDWrJ8agkO0NDBLtD26RF2Dkh44
         csLjUxirk12G3eelgZApK3tzm6a9fd5ljhNkVsaQV4ZlmP0bVC3QJd50HdQuv2sR0VV7
         OsUNSS2YEPj8xwr8tnolZUEgepZa5DkLQ9v01GFdEF00H2ka/p9cml47jGlxctk8v0SC
         rnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126366; x=1711731166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MEvpbcjD55OPVHZv1k/P6RoxHeXbs2ZBZ6egLEjNfc=;
        b=BX8+P7VOpxVFLjyXzHZe1q5NhRUxMWXi4DrEkdWQ4BVKfqGeMpqTANoYlLlD5XmBi2
         y38jT+eguvlz5dvCQ14IAhT6rIM4m3IT+5alPlJzqkr5WkaZeidNmn6wzu3PkKFCNdu/
         xxFgfyoI2dK8iMpoGLiA1Sq06Zb7Iyzz9a8d9xCx8qKKuUi2LzwkuLTNqoEU7LXULVY2
         fhMLHGcXnexvZDRtZ8044o+fw3OPov/V7CYfNH+UT+Bta9SOdTxjQZXROsviaMGbmwGE
         yMYnKCAytb/XUfHE2HMdK1J2JtHYVFmjeGmOVu7Hvu6nLA0kxJ7y9J3UAU/vZefqDHJt
         lt8w==
X-Gm-Message-State: AOJu0YyTwesn/pkUDU0TfH807KZKCzwEqCCDzInY8sXh7bQ532erBnQS
	onCGhQs54aQoUduCGcqD4FJmLrhG1g1dW2ZeW6jdgnAtsqTfYX4q7O+Rtfc=
X-Google-Smtp-Source: AGHT+IFuqifNiOavqmdcMCLtLrAdFCt9Togq8CGLXtlPw8/Jwid/sUQIGZLI3isE+doU+3lYv/yKBA==
X-Received: by 2002:a05:620a:2af1:b0:78a:3225:60c4 with SMTP id bn49-20020a05620a2af100b0078a322560c4mr2512675qkb.53.1711126366579;
        Fri, 22 Mar 2024 09:52:46 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:45 -0700 (PDT)
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
Subject: [PATCH v4 01/16] x86/stackprotector/32: Remove stack protector test script
Date: Fri, 22 Mar 2024 12:52:18 -0400
Message-ID: <20240322165233.71698-2-brgerst@gmail.com>
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

Test for compiler support directly in Kconfig.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 2 +-
 scripts/gcc-x86_32-has-stack-protector.sh | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 03483b23a009..f326903cbe67 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -412,7 +412,7 @@ config PGTABLE_LEVELS
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC) $(CLANG_FLAGS))
+	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	  We have to make sure stack protector is unconditionally disabled if
 	  the compiler produces broken code or if it does not let us control
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
deleted file mode 100755
index 825c75c5b715..000000000000
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# This requires GCC 8.1 or better.  Specifically, we require
-# -mstack-protector-guard-reg, added by
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
-- 
2.44.0


