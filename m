Return-Path: <linux-kernel+bounces-137327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10389E076
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB9B28E375
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02904153595;
	Tue,  9 Apr 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpJ4jxGf"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87651153564
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680340; cv=none; b=JH4zp2MJT7L8kGTjUrPaQmCIG4AssUDOGHEpofOF9Ma54186TZHGoM/R4dAZflYAcYiUDOMkiVPnGmzlAJz5OxNnKg3LlxnCIHCQXdqcQswqv2TDaX1TZs67Pb2G0Ybf5QS5zRY+F575TPlKfwKYzxL1OFMKu8/vkk9boeBJZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680340; c=relaxed/simple;
	bh=Prub1KO2ZejF3xHKzzDA0iJLy90GBZ+yv81ZRqqRVgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZrnydi8LgyV74BdC+yp8NOWY0xiA9uv8msr3d2wdJH4WgOtSEwJ3qZv+3khc3X0fHUK9DVDkf+QtJmlSmvS9FDEJZdcQZ41MofFo0XJSZN5L3xo8so9bkpDmietF2RNHb6gPdxR7ZeZgjt/MZX47WL/1Hr+DDuPrQjt3br8CZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpJ4jxGf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso5734536a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680337; x=1713285137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J93ZkFCOknjdhXLfein2j7yobQHUNs2787CJV9a/ok=;
        b=VpJ4jxGfZIKbtLh6co6K3+HYODciF+PTVvbbe+HUcdkZFBOKBByS++bjI6+TMhOsVR
         2CZpphsQ1c+BeFY66QFPMvUoZcnlLG97S1YisBJZ+th4Esfs9jxDtxVsm9BoAYFdJQfa
         65QWu023uqa+p3jRlskiNtGYJNkMLw90oW72SbE6Jal6HsabQnr9sjrEMs7Ic5FJ/SS+
         VvFF+KPyACivBTxasF+kT09EwvFkt4dMy4gkWq8w8QYfJ4bwHbw9Q5gwHMp0P/5rRYKZ
         lF1xwRefgJq+sY7Am9OMZ+iCZvQ048MJgie3QXMKpjnUHQXxuzTSD+f79T+Qds/kzLu7
         +Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680337; x=1713285137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J93ZkFCOknjdhXLfein2j7yobQHUNs2787CJV9a/ok=;
        b=fxi5YkN9GjtJWqJFmBUBrZtiyqiKNt5a+S5PMLtJ/y46AFbMya7w7XDod6nwdEwOGB
         tS34iOQmkPlRj3ui1rCBbwVqHoGomIGXG+lNXdHJCDYC647WRl/m0SMKimhs4Qu1ZJbS
         72hkgliQSckErqLAcMzHZXJDZ/cchHbqE5A3dDne36CQjfoLxUJPzPYzS7SS/d0Qr4Q7
         vnTYr6rKbNFH5QtuBRkAKniRgCI4N6ALxE36v5P3Fgg0PeHB3pHdbolqLY+4GmMuPOlp
         9K2GgdcGF596VxvAOHHCVUYYm57Qe5Y2wTGiLQ/DO5oN0nR9EruQSvBNuoYH3/sVS0Di
         izCA==
X-Forwarded-Encrypted: i=1; AJvYcCXMRAD4gD0/5k4XhASbbzozD+2QtMdSMltau5yhE1FRYDGU2byZ4By5ocSrU+5l6KiF2eFWMjLeuS9hLpS6Pv6OihijwjhNKcJU9jKt
X-Gm-Message-State: AOJu0Yx3fXeCSt2p22j+tXiq2JldUWuLzUKtIkKy9xvYjanhW8RrK+5m
	oqJGMcHyJraPbb3yKpDKsSXoHIhOhZno8ErTmzHJCETNGNEhs6AD
X-Google-Smtp-Source: AGHT+IFz2DTuKmc+52yD+qBtAlC6PpA6Y3O/PUrWDusslSCyaeJU1vfoFH6W9CeIHvKRLv8/0Vy40Q==
X-Received: by 2002:a17:906:af7b:b0:a46:1d4b:d81 with SMTP id os27-20020a170906af7b00b00a461d4b0d81mr7671184ejb.62.1712680336800;
        Tue, 09 Apr 2024 09:32:16 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id gx26-20020a1709068a5a00b00a46b4c09670sm5904265ejc.131.2024.04.09.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:32:15 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: mark.rutland@arm.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 4/4] locking/atomic/x86: Define arch_atomic_sub() family using arch_atomic_add() functions
Date: Tue,  9 Apr 2024 18:30:32 +0200
Message-ID: <20240409163200.188498-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240409163200.188498-1-ubizjak@gmail.com>
References: <20240409163200.188498-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to implement arch_atomic_sub() family of inline
functions, corresponding macros can be directly implemented using
arch_atomic_add() inlines with negated argument.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      | 12 ++----------
 arch/x86/include/asm/atomic64_64.h | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55a55ec04350..55b4d24356ea 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -86,11 +86,7 @@ static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
-{
-	return arch_atomic_add_return(-i, v);
-}
-#define arch_atomic_sub_return arch_atomic_sub_return
+#define arch_atomic_sub_return(i, v) arch_atomic_add_return(-(i), v)
 
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
@@ -98,11 +94,7 @@ static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 }
 #define arch_atomic_fetch_add arch_atomic_fetch_add
 
-static __always_inline int arch_atomic_fetch_sub(int i, atomic_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub(i, v) arch_atomic_fetch_add(-(i), v)
 
 static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 3165c0feedf7..ae12acae5b06 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -80,11 +80,7 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(-i, v);
-}
-#define arch_atomic64_sub_return arch_atomic64_sub_return
+#define arch_atomic64_sub_return(i, v) arch_atomic64_add_return(-(i), v)
 
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -92,11 +88,7 @@ static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-static __always_inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub(i, v) arch_atomic64_fetch_add(-(i), v)
 
 static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-- 
2.42.0


