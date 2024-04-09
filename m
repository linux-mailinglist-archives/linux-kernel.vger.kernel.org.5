Return-Path: <linux-kernel+bounces-137325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A489E074
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5BA1C22B12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533EB152198;
	Tue,  9 Apr 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUMGT3VK"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D115250E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680336; cv=none; b=nNjtWX6VEtPbs3D9PGozlQOR/ym1Pvt0NGAMPIXVetsYxjaXlyR0plSJpTEPolujUjXDgtk112XaboQ4tK+0UHRDDsii1v0KgB7oehAmj58O02zcFSOWwx8es/QoxE47GTh+8n+DZ159nqfm4FA3Kz0B5CYnvLFgiIG2dXHXu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680336; c=relaxed/simple;
	bh=ANxaeljAMh9hf3ai6x402oc//jkplRQ8Ql0vRp6lZjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=em/8JFP6mBm4LT4CME5aqEGCBKRaa6Wk+N8pqVnUQeE4HnA/hCuk5sqXq32xHHjk6YY6QXrdKL+tN6ZSgMxhmEe+nLdcEeAzIDVRL6JJ1kj85oV+EiZWwPZ45peN/tewWXxdsGe9AG/FDMQWpfwHtGJFhwyk1dw89tQNilUPs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUMGT3VK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44ad785a44so687671966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680333; x=1713285133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTam/FV9ccDtGcb2kI/YArHf1tD6Me7nTANCUZclTHs=;
        b=gUMGT3VKWFLCGv1XkDOXMuPpfwwaRckFdqYwRfXBoF+Nh37X39y2HKzVKQlrXAZsGn
         uqiC3qAio53tyV8sPrHQFOZCo+1jgWb9dP4mC5A4c44ocfg5Noc/Zt3NC4sYdsqz+5ym
         8yakRuduZkuDOxkxPlHvgymYy5YVFF//iOvTmtGq8isVjutw5coECHf9vuK3bB7lIRZw
         xJofvkdRTUobGLOakXflEHV8ttgvnjJ8sv7v9KufxleOnnKkAvSAvAjdZ/nGbOmiC9NG
         zkpOU6rOHOYDTHJ7GRxtpp1sXl7o/EThtgIDsNoQGF7nC6nOeOvQZJUOK4d1JIymlJMs
         lerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680333; x=1713285133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTam/FV9ccDtGcb2kI/YArHf1tD6Me7nTANCUZclTHs=;
        b=kZKp2ztFU7lXvliA5K/TrVcorhAotUZkkv4scRpbpe8yFJiLacPPBX6UX4D0WwhGIu
         KC+mNn1oSC0FespxMwal01Djtv3WcQhfgjy+QYZbpAvBFlsAWFz68wUZQGsf+drbxhux
         UPedrYHlhyEaNDKhHbDeTTSeNDtPfzWo19J6dA3yrjH7V8lc5KS/zZsq8xHl35jvTSOU
         FO0f1ePT2nGHYCRMpLviKBFiisFoF2F6M18VfqUZffqjF5LvVMnEtzIKSa0CoAXYd+NI
         5KXABiVJoeyxCwEj5uxb4gqhEUgPwwwya/HyXS0SXUdGVlugAUwAGSNGWAJjxkUP/S2H
         cTxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Q/KB/rS3tRcJhX7FiChx4Dwjxu6bSqy077Cno++4fSSnpLidK50dWxMnIpIMJc9/8ZkcPwwlJBwT+zmsP7+DiRIDx2d6vi7ipN6x
X-Gm-Message-State: AOJu0Yywfih1FL+ba7oO1WT2l2quH6JUVPrSQ7heS2gtUU3AHqDFF+20
	413W9qNpl9K92nh3RYhrbiDw5IlojwtJpaKUtv98gPYke31P/DFQ
X-Google-Smtp-Source: AGHT+IGbJBx4Cy9gE4KDSo8xeRoilRn7tBfQWFHvN1np0+X0Bu42O7pTjbpsYdvk6BOY22on+UhRgg==
X-Received: by 2002:a17:907:7d90:b0:a51:cdfd:9095 with SMTP id oz16-20020a1709077d9000b00a51cdfd9095mr5880728ejc.57.1712680333095;
        Tue, 09 Apr 2024 09:32:13 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id gx26-20020a1709068a5a00b00a46b4c09670sm5904265ejc.131.2024.04.09.09.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:32:12 -0700 (PDT)
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
Subject: [PATCH v2 2/4] locking/atomic/x86: Introduce arch_atomic64_read_tearable to x86_32
Date: Tue,  9 Apr 2024 18:30:30 +0200
Message-ID: <20240409163200.188498-2-ubizjak@gmail.com>
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

Introduce arch_atomic64_read_tearable for 32-bit targets to load
the value from atomic64_t location in a non-atomic way. The read
might be torn, but can safely be consumed by the 64-bit
compare-and-swap loop.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic64_32.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 11e817dab44a..b4434e5ae31d 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -14,6 +14,20 @@ typedef struct {
 
 #define ATOMIC64_INIT(val)	{ (val) }
 
+/*
+ * This function is intended to load the value from atomic64_t
+ * location in a non-atomic way. The read might be torn, but can
+ * safely be consumed by the 64-bit compare-and-swap loop.
+ */
+static __always_inline s64 arch_atomic64_read_tearable(const atomic64_t *v)
+{
+	/*
+	 * See the comment in arch_atomic_read() on why we use
+	 * __READ_ONCE() instead of READ_ONCE_NOCHECK() here.
+	 */
+	return __READ_ONCE(v->counter);
+}
+
 #define __ATOMIC64_DECL(sym) void atomic64_##sym(atomic64_t *, ...)
 #ifndef ATOMIC64_EXPORT
 #define ATOMIC64_DECL_ONE __ATOMIC64_DECL
-- 
2.42.0


