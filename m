Return-Path: <linux-kernel+bounces-103596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDD87C194
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD475282142
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975474401;
	Thu, 14 Mar 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErNhm2O9"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3EDF53
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435452; cv=none; b=dgVgDMv8Tf3Z1dJ8HROeIL7du5TwueDtiPot2TjOAtd/Nc8mfbb4aHXgdwmPGLFLZcs38fyUtFHNAm/XuvXzTJVr++pEqpwx3lTtRFNIzQGsUokzrwX/x2+GHprQSZGqD1IFCPkO+g0jxSF5uat1LldE57OhR8ZLW3j9zyMiKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435452; c=relaxed/simple;
	bh=Lc7T9CwvabXSHXQoAQ3XzXXaICRUuhaivlLTmNLQz3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FR8u0nMwL0D7SEAi1HJrKGJHqmgNakTP3zPuN6/uwmj/9DvWwOeLje2Yev5xs2TCwrhvXmunntNcQHo27ir0GQDu4CRGr/H3cB/0QoUs35SqbfCn/4mkscAkvYJTKMqOcaQ/Kj+53L3zmE3eWHXyPHeBS4Y5KL2oWU+h6nT8fpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErNhm2O9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e966f56c7so1192552f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435449; x=1711040249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKUbuj/lspDpHBEhCOmHm+yq86ioE00a9Av6voGLKAc=;
        b=ErNhm2O9W0CzA8zgCGdsyDdIlaSdbklQwlvSjmPMbdXRc/BSc67fgnmhxJTZHYJdv9
         y+uyeoQ18Itki9jUNvz1yUJASX4/wyJAMygJ9XEM/GiqZDoL5k8HUaMFc0Ix1j4T1Mfo
         pPxHzHyO9wCI9NEjvsCq1Fp17K+/NpK40PI2+w2ZtFqbMLn2SOeFu/K9yYjpOa0aqpmJ
         zAhiNr6wGRgAXCQRSceAj7irWzYc/E9SrH75YR58Dlvfz1PL0DCeuzQnHXB0krEcrqQD
         6dq+NQm4Jc0uuI7KQ9AwHYa4ZuhVab8ttHCEDL8mpHyXkk/YdRxinE4vAPrjhUnCfeaP
         tUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435449; x=1711040249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKUbuj/lspDpHBEhCOmHm+yq86ioE00a9Av6voGLKAc=;
        b=FlanPSJ/ksENwoMHvVD20wDqJU8D9aGRhcld+jQHnJAkpO1ow80gGAbgH8A9w4BnSs
         O9yjUs3gRzug6aH8s1el/Uu958mEkwYHkkX8FE2ILZQowaxL9ExlFRgdZd9k/qFJmh3G
         uh/8CaJJXZRQxX8QTdjVmJvEKCrivlFtCLv0W/JGoOGuJCSgggTsZKbyVE0XZbzQtALV
         MZXn7CGDLQywJBGdMK64wjpzsJ54huiKxH0AUGIDolutUPqMMLyGtCcIzCjCkyz8Matj
         2vowVp/gK3uLMFIPyrX0hd5JwkfZVqjWsYMXC7iKsrftgmFJ1ff3907dKGuoWb3/k3Cp
         9Y4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBMuZyDzWNqGoQv/NJ7l1THQquNzHMIoPKlxOaXkvb5CPGPPXUglv5rRN5iDWsNWw9CCb/VhV/CkODrVknu1GuNgTOhgfidGUTTHic
X-Gm-Message-State: AOJu0YwQTGlX9d276HesYzFUEz1zoDgJk8Z+gNm3X3v10dMSEPAErFfu
	fqYmBf35HnYPizdtSc9F46fkhMW8ewi9gxVCBd+iM7eorBNuYSM=
X-Google-Smtp-Source: AGHT+IG1sedm4Ibtz3z+lqA26T46KaMz2S2EqPOqFf7cFaKpisxZYcFeIL63vw20OND1y3yGQiTI3g==
X-Received: by 2002:a5d:604d:0:b0:33d:3566:b5c8 with SMTP id j13-20020a5d604d000000b0033d3566b5c8mr501780wrt.13.1710435448551;
        Thu, 14 Mar 2024 09:57:28 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.38])
        by smtp.gmail.com with ESMTPSA id a26-20020a5d457a000000b0033e7e9c8657sm1142177wrc.45.2024.03.14.09.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:57:27 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	hpa@zytor.com,
	adobriyan@gmail.com
Subject: [PATCH 1/1] x86_64: cleanup memset16(), memset32(), memset64()
Date: Thu, 14 Mar 2024 19:57:15 +0300
Message-ID: <20240314165715.31831-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* use "+" constraint modifier,
  simplify inputs and output lists,
  delete dummy variables with meaningless names,

  "&" only makes sense in complex assembly creating constraints on
  intermediate registers. But 1 instruction assemblies don't have
  inner body so to speak.

* write "rep stos*" on one line:
  Rep prefix is integral part of x86 instruction. I'm not sure why
  people separate "rep" with newline or semicolon pretending rep is
  separate instruction. It is not and never was.

* use __auto_type for maximum copy pasta experience,

* reformat a bit to make everything looks nicer.

Note that "memory" clobber is too much if "n" is known at compile time.
However,

	"=m" (*(T(*)[n])s)

doesn't work because -Wvla even if "n" is compile time constant:

	if (BCP(n)) {
		rep stos
		: "=m" (*(T(*)[n])s)
	} else {
		rep stosw
		: "memory"
	}

The above doesn't work.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/include/asm/string_64.h | 45 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 857d364b9888..9d0b324eab21 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -30,37 +30,40 @@ void *__memset(void *s, int c, size_t n);
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
-	long d0, d1;
-	asm volatile("rep\n\t"
-		     "stosw"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (v), "1" (s), "0" (n)
-		     : "memory");
-	return s;
+	const __auto_type s0 = s;
+	asm volatile (
+		"rep stosw"
+		: "+D" (s), "+c" (n)
+		: "a" (v)
+		: "memory"
+	);
+	return s0;
 }
 
 #define __HAVE_ARCH_MEMSET32
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
-	long d0, d1;
-	asm volatile("rep\n\t"
-		     "stosl"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (v), "1" (s), "0" (n)
-		     : "memory");
-	return s;
+	const __auto_type s0 = s;
+	asm volatile (
+		"rep stosl"
+		: "+D" (s), "+c" (n)
+		: "a" (v)
+		: "memory"
+	);
+	return s0;
 }
 
 #define __HAVE_ARCH_MEMSET64
 static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 {
-	long d0, d1;
-	asm volatile("rep\n\t"
-		     "stosq"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (v), "1" (s), "0" (n)
-		     : "memory");
-	return s;
+	const __auto_type s0 = s;
+	asm volatile (
+		"rep stosq"
+		: "+D" (s), "+c" (n)
+		: "a" (v)
+		: "memory"
+	);
+	return s0;
 }
 #endif
 
-- 
2.43.2


