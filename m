Return-Path: <linux-kernel+bounces-164823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1818B8378
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953DCB214ED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0F4400;
	Wed,  1 May 2024 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kwBwHkxg"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C41109
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521746; cv=none; b=hFyYw2Ny5Ib0XF7pqYYReIFV4vfts+S5iyuBO3unsJ3o3wU1j0+d7pJpzt6hSBpOs3chMAY1pltxpY+kd/I6A2ZOfxe6sVm9Bfs6Zpu5abAW9xasjQpC92RHnqq02qJZqD9fSjtg9dy5zT5v2jk2ij8ODSUJTcrNYaC0nRw6LxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521746; c=relaxed/simple;
	bh=ulDNw/dTdqEw0P5LS7YX4UHclLYMZBwZ4qj/77v2d+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ol0Ej/Cfh/4pluwM/q4h7ThngqhZwrtblbYz7ZpRXJgh4BIDY9s1jMVkOvbhuPGI0/lkKiswxUsKBrReddcJhTiDGTSroJSvt6/M98ZcpoE/XahgPYzQcaoJN5NhMQJ9NsuSYARTc8zPP9ar9eFbNTGblzINGwqUJBrVDV3riCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kwBwHkxg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so40538725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714521744; x=1715126544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nxn6SCMz5lVVXCZzlqH1YfFaziZDiU8+cMzwDJO3R4=;
        b=kwBwHkxgNVxQ9sZc0MHlralht3mT28/nfTf+gWaVM55a5dhuz4vwg1mfZXbghjimuV
         8J0fqXO0bk5ta56cBPagwB6R7Sb6KB5dy6dfDM5ojpiC1pLZMwwNAQ3pqydbDC+hMmxS
         w+6VdmcnY5r73TcwCJ/ZB7pki7VgI8vr6ZPhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521744; x=1715126544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nxn6SCMz5lVVXCZzlqH1YfFaziZDiU8+cMzwDJO3R4=;
        b=mCu8p4Fk9rSfnCk41t92iOGREYg24WbtQYW0rjL2dai6DQ0CyU72yuVuDEKTE+Zt/F
         yP5FMKbfYOGxN53wbfCkxsGd3r4BUFBJ2b7+5E5Za7NhYVqrBdSHsjBBzRlcJzAbcknU
         po7yb3f9REbSHrQ/8OB6n62UA+i517Iva48RuSneDvCjrFs6/KbuzyTHnVsyqCpEHGYQ
         IPZ7U0Bn7VKOdUjJ3ihu2iOA7bYwG9XMISeOcdYMsebCexMmFUA93q6AV5v2SITeA0UP
         C6mIR5k+GV57w1LkyjeEaUs2xnA72jxBOc808q4VPL98whx2Z3PNH1e8EHN4dg5R53F4
         3lGw==
X-Forwarded-Encrypted: i=1; AJvYcCWgGu18Qc0nOAxGSyfrvfa0yHNa0P4fddDpi3o1JP/6GyBVgaHoHZuJgMW0AwFzraronl0tLg+bn7gNXcaGPT09+SKj0EBxiPE1QuTw
X-Gm-Message-State: AOJu0Yyv9XCwq03YcUslksJk6VKa9JleehvyCtmBEzLrZ3tg6Wi8l6hH
	Bqca2qMUFBMBitCZMsCUq5nJZILtfPJ2wBruGEHPmcUCOx1/vSjAEWn5UA7J8w==
X-Google-Smtp-Source: AGHT+IGQ7+uHcauYymFMd1a9l+W+Ookyr5oT1C+Il/oslPkJPGipBryZKj9OsrcmmX0CvT/vx/s0Xg==
X-Received: by 2002:a17:902:8682:b0:1e2:9066:4a8b with SMTP id g2-20020a170902868200b001e290664a8bmr1054365plo.26.1714521744025;
        Tue, 30 Apr 2024 17:02:24 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b001eb0ef6ab56sm8693683plh.64.2024.04.30.17.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 17:02:23 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/alternatives: Make FineIBT mode Kconfig selectable
Date: Tue, 30 Apr 2024 17:02:22 -0700
Message-Id: <20240501000218.work.998-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3307; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ulDNw/dTdqEw0P5LS7YX4UHclLYMZBwZ4qj/77v2d+g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmMYaNiBd/XlJFp0ZZ9P3bb7NESL+wUOlhanba9
 R3cjKKT6liJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjGGjQAKCRCJcvTf3G3A
 JimOD/0TJNCCGvcLiriuaFgxG3n3TYUsY+GKhj0nnIshN1RlfzpGc6osmYkDqg+ih4j0AftMnkW
 iLjkxikX8o11WwTScsbS1hztczb6BCb0jXOxdfu9UDgQEPMJs60II2/bMLGmeNWbPA6XS0KRY/6
 wMpKIwUxdSKjhVU0fHOyAXgmffaQzZLa8fQgMuJ73fRDWxyEhpxYrvuNYj3/cV19EM1+UyaJRN1
 N1jzqpkVUOeoBY+/pPN1BIg69b34jrdnykvZYEZWaH5udT3V0IzpenNe+SWrfurYbOrFR5PJ1Lt
 jDuDd+frTpG9M+9sapZ/OHmfQnzkEe0cvDyavXNkNGvTeiQGIQ9ztx4PSGqJpv+8K9s5fwcWZsD
 +W7hxsNYQR79URK5RK+jjZPV8hZWxkZRV4OOvyS54sVQugTGQfsb48ZtKc8OLO+7og3AgYlDZGM
 tg4f1hA93QSQAo43o5el2pzcHMtqAWGvyGdAiyM8qdyXlHUpjizp2gnzppYDxglPC4W7BQSsaHp
 Y2eB8/yRvZS/E4/s0452cGrPP0uV8pWgOSPpK4fMflNoQiMB/3KZnL6N0tCmwac7sN/Ajo30vWL
 WOrsfkJzwI8/arxr9SmNGtmUy3mn32qRfPxugXt5OSzPgqIsU1WZz8e52oPqwLyfWl5K2ZbNGJh
 +X0RK1z j1olrq8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since FineIBT performs checking at the destination, it is weaker against
attacks that can construct arbitrary executable memory contents. As such,
some system builders want to run with FineIBT disabled by default. Allow
the "cfi=kcfi" boot param mode to be selectable through Kconfig via the
newly introduced CONFIG_CFI_AUTO_DEFAULT.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig              | 9 +++++++++
 arch/x86/include/asm/cfi.h    | 2 +-
 arch/x86/kernel/alternative.c | 8 ++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4fff6ed46e90..d5cf52d2f6a8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2424,6 +2424,15 @@ config STRICT_SIGALTSTACK_SIZE
 
 	  Say 'N' unless you want to really enforce this check.
 
+config CFI_AUTO_DEFAULT
+	bool "Attempt to use FineIBT by default at boot time"
+	depends on FINEIBT
+	default y
+	help
+	  Attempt to use FineIBT by default at boot time. If enabled,
+	  this is the same as booting with "cfi=auto". If disabled,
+	  this is the same as booting with "cfi=kcfi".
+
 source "kernel/livepatch/Kconfig"
 
 endmenu
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 7cd752557905..31d19c815f99 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -93,7 +93,7 @@
  *
  */
 enum cfi_mode {
-	CFI_DEFAULT,	/* FineIBT if hardware has IBT, otherwise kCFI */
+	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
 	CFI_OFF,	/* Taditional / IBT depending on .config */
 	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
 	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 45a280f2161c..e8d0892d89cf 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -902,8 +902,8 @@ void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
-#ifdef CONFIG_FINEIBT
-#define __CFI_DEFAULT	CFI_DEFAULT
+#ifdef CONFIG_CFI_AUTO_DEFAULT
+#define __CFI_DEFAULT	CFI_AUTO
 #elif defined(CONFIG_CFI_CLANG)
 #define __CFI_DEFAULT	CFI_KCFI
 #else
@@ -1011,7 +1011,7 @@ static __init int cfi_parse_cmdline(char *str)
 		}
 
 		if (!strcmp(str, "auto")) {
-			cfi_mode = CFI_DEFAULT;
+			cfi_mode = CFI_AUTO;
 		} else if (!strcmp(str, "off")) {
 			cfi_mode = CFI_OFF;
 			cfi_rand = false;
@@ -1271,7 +1271,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
 		return;
 
-	if (cfi_mode == CFI_DEFAULT) {
+	if (cfi_mode == CFI_AUTO) {
 		cfi_mode = CFI_KCFI;
 		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 			cfi_mode = CFI_FINEIBT;
-- 
2.34.1


