Return-Path: <linux-kernel+bounces-73589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC785C48E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DBFB249A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621B14AD14;
	Tue, 20 Feb 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wa8glPLf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237C14A4E7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456926; cv=none; b=euWIAhLBpL1h4D0y7Qh4YEMpdrORiANffaGY5P8X4oaNuHSS+txYUyd4bUvq+nffEoBzYZujOUf5Yo3sQYsEVhG8QbPn05mRhs9G7yqZWMX4Adx7yuiPZPo2Iw5dSAvGDk6kRBQg7Q+1EBrUFZEU5ssr8upgirfPT3mp9QoHJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456926; c=relaxed/simple;
	bh=YvRYM8i58qO9GNFhuBTMfwU9co90ceu+7bZFp+D65vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeZY2KEjEvBB/3PqpzDjvJDdNtv5OY0Bb5gMrQ8snPVzqmbNww2XrhfcPIIDy2kygvgAajnPHNpu5fJYJP2vWDsqf9OKvdIIDKjCIxAfAI48X1LdF6hiF9GeZ0LB042Wf0XDZ/7tyF+YFHD9Z5njVWCBQSodY4YRgcIvANaFjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wa8glPLf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4126df1e7bbso12975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708456923; x=1709061723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7U0RSylINsLRGIXJSZNu+mJjZueu22Q0XGcAKOsxOI=;
        b=wa8glPLfZ+Bwsh+1VK4LO57lm7yVCI0FwJx/9vin8TanQVJY6lF8KDt+5gPcUT1ACG
         BuibXbBvbbeB3xPoD6OTLhpABVRyXm/jRqwJKtm8UlQ9xZjE3XCIvoovAa3Ky96FApqU
         vMkhwQJHULKTWPFX6Ejjn25VauRgNYlhII23euBhoUDH2hD9+rZ6XajiNVi3YdfnMa4r
         C08QAse5SZr41VjYy6auGlDresAVKsHWhm+Li4mGL+Aw8hBn++5yZGynKvmQ+F9FYhCq
         7C8yHH/2D5NDK3gohxSvXijaiQ0u7TMAwFgq3lPN1NLyX6DctJ+SfucQsyJJ0inxFhO1
         xe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456923; x=1709061723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7U0RSylINsLRGIXJSZNu+mJjZueu22Q0XGcAKOsxOI=;
        b=Mpc1pUhT+Otxm4QtiEyjQAxSg9YHiLYI+l15TVIheSrNcQnyYFBBVrk0fRKar8raIV
         Zx//EzAp1NyTvCNyP5y7gH+WTxaa5oj/d2RQfbf5FHQg0I/HOsLOpXcD4Q4Mr5zEeYVT
         Kim4HN0DtE3LxEtWimOCnBSsBg56excr9tuNeTxTVLt/6tD1Uqd48AvmWmWn4eajRCMF
         81mSmXjuVgOs0W5MrCvsUhkOU1mfxOOheeZ5wyI06qT7yhchKOMve8Fr+UHh3OhQakBd
         lpOiJofzs8V5BwKUTKIogWuKSDrMvAEGitOmBNtU5yqzwi5qpgRzSnxFJQRzo8YObxVz
         +hdw==
X-Forwarded-Encrypted: i=1; AJvYcCXTcX0c7HmMt8p1TvNGNqsJtB3xtvge1ToAgtASlnROc9F3xXw2v5Upj37gNDlU8ec56FsM+z3hSRsl8MBzuhLoE2ROhTCVWx20Elc/
X-Gm-Message-State: AOJu0Yx9xS2U3Lid9o/cMozKsoIEKLgp9OgvwbBTw2vH4CJ3lF8Jxmwy
	VCSBcTivoaN7znq19LzvlWMLXMW5L45D4lP/9V2kIz1od7kYe1KqSN6jV8KaCg==
X-Google-Smtp-Source: AGHT+IGcedxzJz2WNcGuwjeVodU4TQZZTA4K4vYJ4Eu3ny3lEGYtXDNqRlIwfudRcxPgBF4oBzewEQ==
X-Received: by 2002:a05:600c:b86:b0:412:689a:10f0 with SMTP id fl6-20020a05600c0b8600b00412689a10f0mr16973wmb.2.1708456923408;
        Tue, 20 Feb 2024 11:22:03 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:cba0:1b55:6833:859e])
        by smtp.gmail.com with ESMTPSA id ay23-20020a05600c1e1700b004120c78fc39sm5048wmb.3.2024.02.20.11.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:22:01 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 3/3] x86/boot: avoid recompiling kaslr.c for incremental rebuilds
Date: Tue, 20 Feb 2024 20:21:44 +0100
Message-ID: <20240220192144.2050167-4-jannh@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240220192144.2050167-1-jannh@google.com>
References: <20240220192144.2050167-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, every kernel rebuild needs to compile kaslr.c again because
UTS_VERSION changes on every rebuild.
Move the build string into a separate object file to speed things up.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/boot/compressed/dynamic_vars.c |  8 ++++++++
 arch/x86/boot/compressed/dynamic_vars.h |  3 +++
 arch/x86/boot/compressed/kaslr.c        | 10 ++--------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/dynamic_vars.c b/arch/x86/boot/compressed/dynamic_vars.c
index cda64ff4b6da..15a57fbb05e3 100644
--- a/arch/x86/boot/compressed/dynamic_vars.c
+++ b/arch/x86/boot/compressed/dynamic_vars.c
@@ -1,9 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/const.h>
 #include "dynamic_vars.h"
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
+#include <generated/utsversion.h>
 #include "../voffset.h"
 
 const unsigned long vo__text = VO__text;
 const unsigned long vo___bss_start = VO___bss_start;
 const unsigned long vo__end = VO__end;
 const unsigned long kernel_total_size = VO__end - VO__text;
+
+/* Simplified build-specific string for starting entropy. */
+const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
+		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
+unsigned long build_str_len = sizeof(build_str)-1;
diff --git a/arch/x86/boot/compressed/dynamic_vars.h b/arch/x86/boot/compressed/dynamic_vars.h
index a0f7dc359cb6..3ebc4a3144d4 100644
--- a/arch/x86/boot/compressed/dynamic_vars.h
+++ b/arch/x86/boot/compressed/dynamic_vars.h
@@ -9,3 +9,6 @@
 /* Variables containing VO__text, VO___bss_start, VO__end */
 extern const unsigned long vo__text, vo___bss_start, vo__end;
 extern const unsigned long kernel_total_size;
+
+extern const char build_str[];
+extern unsigned long build_str_len;
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3ede59ad67eb..c14e4e7a6b08 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -23,14 +23,12 @@
 #include "error.h"
 #include "../string.h"
 #include "efi.h"
+#include "dynamic_vars.h"
 
-#include <generated/compile.h>
 #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/ctype.h>
-#include <generated/utsversion.h>
-#include <generated/utsrelease.h>
 
 #define _SETUP
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
@@ -38,10 +36,6 @@
 
 extern unsigned long get_cmd_line_ptr(void);
 
-/* Simplified build-specific string for starting entropy. */
-static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
-
 static unsigned long rotate_xor_one(unsigned long hash, unsigned long val)
 {
 	/* Rotate by odd number of bits and XOR. */
@@ -75,7 +69,7 @@ static unsigned long get_boot_seed(void)
 {
 	unsigned long hash = 0;
 
-	hash = rotate_xor(hash, build_str, sizeof(build_str));
+	hash = rotate_xor(hash, build_str, build_str_len);
 	hash = rotate_xor(hash, boot_params_ptr, sizeof(*boot_params_ptr));
 
 	return hash;
-- 
2.44.0.rc0.258.g7320e95886-goog


