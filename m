Return-Path: <linux-kernel+bounces-111823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9BC887155
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F51F23B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6459D6086B;
	Fri, 22 Mar 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5JDXIjJ"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B0608FD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126386; cv=none; b=i6flPHql5fRazLSm2oEL78TsELtaOtsbjg35JiZF+DXps7i7Rz5+khWPZyS1BX/F4JYnmM4sbbSscZ4zfNStvA7hvnKlShuDDgupT+uPVxJm6vAlILke+pYxALpjMyF495ou5VKxgSmsyYlr95hooCQzPgb7nQR+QLTtcF0tTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126386; c=relaxed/simple;
	bh=1igDXVcGgPluBlHDLoIaqQCElcppshSoQ7wAP1/2GMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiBAeLTHTNa53fxN2RDa3lROd2hzPQEF9nLOmL6vdJ9RvCRTi7zaG/AbFZSH6x7iKYi84e4o+QxSMbfnZYXOqaUn9PsVLUtcegSNAG79Ny2xdxIBAlBlw35iSeRZKGnF5DDIZnSBfGJ6A3ciYiwMMXKiF9JSCNvuded8lClDVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5JDXIjJ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e50e8dcc72so888806a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126383; x=1711731183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcrz+iNlkSMaXga6GjK/dXFl4dsslQPtza4Zz/b9aGg=;
        b=K5JDXIjJFFX0dP4n7csFbzd1pVAdoeRL9F4wIy2yH6Sd8a85ygOHRUL2VoixwWL/hd
         7AKgg+1K4ayMEdzYNmeHt1ZA+XJQuvAKolmYFIf8hHyqrdvDB2TLKu47iB7EVQ6T3CCX
         2CB5B4z+6YecUDmq6DZamPN4hN1bWbue0nrpia6xEKIFBQa8VVC/+Yyv+LTPjsz5mHS6
         h89MFdJ0bTI+oM6Z/Wzv2/3Z6OqeYKnVxyE4XkUZXOV/cUAWDbSG25yboHbgFCxZxy0s
         9glxm+jORA3N7Lz1ljPM8xeFtPv2oEjcLNSf5uPRxFpzZNVeteMzAvpz+sHQnelqKPXQ
         Yo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126383; x=1711731183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcrz+iNlkSMaXga6GjK/dXFl4dsslQPtza4Zz/b9aGg=;
        b=kKbmNTRNoXnnUhH6hRrF6yP7CvsCwJcOe5mySTfYE0eKPfEBr/bB9EXAeZKh28wmLy
         286lBYPuCvqk0jCgSg0R/NcpMEs1WMR4JuSPLFu+wehaSgASwiGszCLIzvEUF4xMEQ+j
         9flCWJ/0FFJG313LaJGHT96BZwQPH7pDE+OcROnvnpYTAxFp7V8D7G4sktVFYoF6FY6T
         s0ngYrcN5QhZcNQONMem9Ow1BuIVAJpO2yU1xhDKvdNVNMxYCAh+gXxQSdk/nRbZbqP+
         VqF7JnLfDNz5x/tusnVzhRoDNhN7/saq5Y8VDZ7hFLFpIlxEmxKOroorKmSvHh93Soco
         pODA==
X-Gm-Message-State: AOJu0YxVlepqr11d0WxPDfWnPJKoCak+/t0z+kQADIV1H4CdYVqjRyZr
	4jDorPbLoyna5F3zikLexdH6D7yj5fBCsOyd7Ekoui/atcSEIE2cZ6It0L4=
X-Google-Smtp-Source: AGHT+IHnay89mvxVTEIyVPO+JjskcQi/vAYJjqahDXajbrzckh3L8YDk1E/ySeWNG2F0jixB7/q6Lg==
X-Received: by 2002:a05:6830:148b:b0:6e6:97e5:7949 with SMTP id s11-20020a056830148b00b006e697e57949mr229305otq.6.1711126382941;
        Fri, 22 Mar 2024 09:53:02 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:53:02 -0700 (PDT)
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
Subject: [PATCH v4 13/16] percpu: Remove PER_CPU_FIRST_SECTION
Date: Fri, 22 Mar 2024 12:52:30 -0400
Message-ID: <20240322165233.71698-14-brgerst@gmail.com>
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

x86-64 was the last user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  1 -
 include/linux/percpu-defs.h       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9752eb420ffa..74f169772778 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1033,7 +1033,6 @@
  */
 #define PERCPU_INPUT(cacheline)						\
 	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index ec3573119923..b9ddee91e6c7 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -26,13 +26,11 @@
 #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
 #endif
-#define PER_CPU_FIRST_SECTION "..first"
 
 #else
 
 #define PER_CPU_SHARED_ALIGNED_SECTION ""
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
-#define PER_CPU_FIRST_SECTION ""
 
 #endif
 
@@ -114,16 +112,6 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
-/*
- * Declaration/definition used for per-CPU variables that must come first in
- * the set of variables.
- */
-#define DECLARE_PER_CPU_FIRST(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
-#define DEFINE_PER_CPU_FIRST(type, name)				\
-	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
 /*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
-- 
2.44.0


