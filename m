Return-Path: <linux-kernel+bounces-73587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D41185C48C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADB02838F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2B14A0AB;
	Tue, 20 Feb 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnZrOTMc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A301353EF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456921; cv=none; b=aczp8FsWVq6QSXWClH+nN4h2wzWmefs2J3R96+J9r80+bfmJ2cksKaWJXVhgktnwVRvMjuZ5bAd1HIegKhhSYaA4S0LqYqMagaYoj3Si3bAmK/xB2IvghicRgeOUSYFKD57FOH0MHfyGSflF6JIoPO7X7CCqynZOnpuCMEOlsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456921; c=relaxed/simple;
	bh=O0CZLNJD1ve6sw6w5oRCfLQxN+HSkwW+t7kr5ppkfwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihFiaJmdrDYlf3IyOZypKr4wZ8H/x5paJ2jxYyb968wMf5RXJziQgRtZsWcZ1AUtJm+Ud9OLRbYdTXmGVQny453QqK8ixH+fS7G0Kgbk/fZPPpqYWESBEyRCN5nxtsdJzLXIrJXp4RKcfVFdxzAgzrJpEtcNT4uekE/xoyM+nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnZrOTMc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4120933b710so13515e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708456918; x=1709061718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA2O3Llhx71J8bGYTlEPNCq93E6hVPmmgkxfFVoSWL8=;
        b=tnZrOTMcWD0ycnpdKVDgyG9dxlGI97Y7Q2sEQFGvm75XGZFTsp8Yaol/xwkuRcH56w
         L9MEFB69D33psdUp++bkmwrUWSl6pCCDEYvTeA5XuXGL3BbnGQKt2xizotVnSrdfro+h
         +B8hHBfhWWyHDShdlfXSdJ2LImi89tIZ30RHFNNdqS/2Ofc6nU5Fa1gd+7+sX0dHQpQF
         scff3/tuv8SkN9i/sb+6lTD652c31aK+5NQtm5i9V+RLNIGMI/oXadgk8aGlizk8lU0F
         kVQt2tM/c1FcS7JXYc9mz1DA7yHjOdEmTcLSjMc7DMN+DKA9MRym7J+RuKx13f5WzWZm
         1NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456918; x=1709061718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA2O3Llhx71J8bGYTlEPNCq93E6hVPmmgkxfFVoSWL8=;
        b=pAoq3/t8+1VpiJ0FlLo3fxx7atWaTdUDLBNcoyXL/OLCUiPM7kVkKEwXH6PSbjy5GE
         jTeFv/okrEFwEzAsa6BpPpexfvWEIaefrcg17xaocFl0PPVC31FldZv3fLyjNJkpcJl5
         EJbJIslUnd31gw2mseO0wgbKey9UgP/+t1rhNa9VF9XGxAF51PvZLEMYFEGnVw0ySmdM
         P94wOTzhMLKTFYBar2bdMY44IzvQMgVel/nQ1u2hoiQNHlusckklmnf2iU3N/OYRU4d4
         m5XCFhpNiL5i265WPphs6uMLIPYTXGltNOJuEE6Z4QrURtx4w0KwJxQVAQ+ZiHiO0Lo/
         pzsA==
X-Forwarded-Encrypted: i=1; AJvYcCVPqSx1n4vHqtAd2YyEqVOfsUZWO2qvivaKZBj6eYs0uwz434fJW+kIwGwGshSzdThY0Xo5cLIrMo6OXJY3lmYuTELiQ0ErELQmSxGW
X-Gm-Message-State: AOJu0Yybk8ZXeSL8U4JRElwr1HxFlqNZsBQWH0/NGET6cbxK/VoiRiRZ
	HB/wW/Lnq8ChC8q3F8WcAsG4+342ClZ19EH3Kl0rJSO3QfTlgyYhosWwbDaCMg==
X-Google-Smtp-Source: AGHT+IHi/kCIw1HBEXm2HhZQa0zukennPazSrDQbfFktQMZF5J5nWqVGKaBEMcIJ6PWHywYIy1cWlA==
X-Received: by 2002:a05:600c:5187:b0:412:730d:ab69 with SMTP id fa7-20020a05600c518700b00412730dab69mr13734wmb.4.1708456918160;
        Tue, 20 Feb 2024 11:21:58 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:cba0:1b55:6833:859e])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c211600b00412706c3ddasm1723wml.18.2024.02.20.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:21:57 -0800 (PST)
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
Subject: [PATCH 1/3] x86/boot: fix KASLR hashing to use full input
Date: Tue, 20 Feb 2024 20:21:42 +0100
Message-ID: <20240220192144.2050167-2-jannh@google.com>
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

rotate_xor() currently ignores up to 7 bytes of input. That likely doesn't
really matter but it's still kinda wrong, so fix it.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/boot/compressed/kaslr.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index dec961c6d16a..3ede59ad67eb 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -42,17 +42,30 @@ extern unsigned long get_cmd_line_ptr(void);
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
 
+static unsigned long rotate_xor_one(unsigned long hash, unsigned long val)
+{
+	/* Rotate by odd number of bits and XOR. */
+	hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
+	hash ^= val;
+	return hash;
+}
+
 static unsigned long rotate_xor(unsigned long hash, const void *area,
 				size_t size)
 {
 	size_t i;
 	unsigned long *ptr = (unsigned long *)area;
+	unsigned long rest = 0;
+
+	for (i = 0; i < size / sizeof(hash); i++)
+		hash = rotate_xor_one(hash, ptr[i]);
 
-	for (i = 0; i < size / sizeof(hash); i++) {
-		/* Rotate by odd number of bits and XOR. */
-		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
-		hash ^= ptr[i];
+	i = i * sizeof(hash);
+	for (; i < size; i++) {
+		rest <<= 8;
+		rest |= ((unsigned char *)area)[i];
 	}
+	hash = rotate_xor_one(hash, rest);
 
 	return hash;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


