Return-Path: <linux-kernel+bounces-108620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16795880D12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AFAB23A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFCA3AC10;
	Wed, 20 Mar 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViXuf08v"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4FF3A29C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923500; cv=none; b=ravz1ph3cuRZgqThby/0BbeK4hXJy82L6PNRAyqQzVaGnFVqlpXgYT0kJSIfPGWoAePcOPzJbVnZ+U3XRfX9KZlfCWYHlQ15ZPqf4YHvcC11GROimtE5PpzjbMLJ8lQOTyDqgdcrBexpYUdkwkxTRKs9GebLqFQ7UbQPPULvqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923500; c=relaxed/simple;
	bh=sgmfjV9aS8WJMDgPsm1pycn2OnI1g78nGg0DKds0GgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL5ygI7frSMRLURoH85gbzY++nk6lb3uucf+uDAZvoyMtqjG/Y8SqxmBhqqYbWQSqp0Id0IHXpvdK0EYjee6zai/7pl3++1spwX/iLfpUM/57Qt9fvblR2IS9K6E70E/7hiGp7h5Igv3BoF9hSCa/wrrwgrQCg8zVzEAnqFlnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViXuf08v; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a468226e135so588791766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710923497; x=1711528297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vw69qJYpxB5fInrsmlHx2n0WeliEtSWSuZCkk4NJCb4=;
        b=ViXuf08vZJxODDYFYEVwJnLkFp0O57G9BzYnWM3g4RmyqSS1rhBlyDPKs0mDD8b/VN
         BrE8167ViatcuQLbFs0NYY1otg4ih1ErVuFFYLHQ1VHusbFaj97xFbH+XW4slJMNkmJf
         xSZUUSgWp/CXLMRvwxjWd4Lki/5qCafJg884oMhC+DYU1fi6Xi9/dDGI40+yS7+a6VVa
         0lfLjL1hnnZ4fZBYFn5mnsqPhFZiVUg+2V43uI/unlFyrmfCU7EgxVHPD6Ql4bfnEVbK
         b1G3sMDwzKD4neDdTgzA7UGPwYPh7hl7m7aB6TTz7AvUJXZKTmS9s/GGwWfLhYy3w+S0
         TrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710923497; x=1711528297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw69qJYpxB5fInrsmlHx2n0WeliEtSWSuZCkk4NJCb4=;
        b=EyJCERYbs+zBrQYr8ZwGB+ZA74/kaAExmx3t68+nme0lVL86PHt9T0wqAwDYQLwMr6
         8tAAaZP6FMya7Y0OGTFb3tkqgV4/YsXrKOfHQxBRryNCcpeH454y9vFpTkBh8v2Bc8yc
         yLZuJwZxnj54mrJeeohUkSgwU6aPLQmYxlLwU6J1FKq30SCHYQ1YlWlHMHG8IlohxXZS
         Rzh5YEOB2lU5pqpGK4/GxLRyVyLq1x0fQVSGDxDlPy5/WWTowamCbjgDm5K1Rt8ksgwm
         ML/BXBRlnfirK1M+cu4dAyxyh2kVdIW5pobm3NiI1M5tceOl5sJf0e2jKWVnydXN6aMT
         UFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcM/8JLotRWP3xLx3v/JTTuGN2ZMoE4im+LYiGy9haxQfNW6vKenesgOzBnuF9CcD7WEC2AODdizrka8zlrR1vOkT1ufLorx0tjz0C
X-Gm-Message-State: AOJu0YzZD8fFfnCGXL5Aky1XJPosTH9vstcTKvKqFJCPhsZO4osrC4WC
	68o/m6GQVCPBiiUugCsiNNFd9Oe82u2+3haLf8vV3YdMzvl6LKqR
X-Google-Smtp-Source: AGHT+IF9kKOxCuYkpnxGZzy1SeBmoTey9U9BYnu6Xgu/jpRyZA/a+fDbgBoLE7J1p/zSgNMWDDXugw==
X-Received: by 2002:a17:906:30cd:b0:a46:4e14:c9fd with SMTP id b13-20020a17090630cd00b00a464e14c9fdmr11863130ejb.23.1710923497150;
        Wed, 20 Mar 2024 01:31:37 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ci20-20020a170906c35400b00a46e92e583bsm1170769ejb.149.2024.03.20.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 01:31:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/percpu: Move raw_percpu_xchg_op() to a better place
Date: Wed, 20 Mar 2024 09:30:41 +0100
Message-ID: <20240320083127.493250-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320083127.493250-1-ubizjak@gmail.com>
References: <20240320083127.493250-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move raw_percpu_xchg_op() together with this_percpu_xchg_op()
and trivially rename some internal variables to harmonize them
between macro implementations.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index de991e6d050a..7563e69838c4 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -229,6 +229,17 @@ do {									\
 	(typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
 })
 
+/*
+ * raw_cpu_xchg() can use a load-store since
+ * it is not required to be IRQ-safe.
+ */
+#define raw_percpu_xchg_op(_var, _nval)					\
+({									\
+	typeof(_var) pxo_old__ = raw_cpu_read(_var);			\
+	raw_cpu_write(_var, _nval);					\
+	pxo_old__;							\
+})
+
 /*
  * this_cpu_xchg() is implemented using cmpxchg without a lock prefix.
  * xchg is expensive due to the implied lock prefix. The processor
@@ -499,18 +510,6 @@ do {									\
 #define raw_cpu_or_1(pcp, val)		percpu_to_op(1, , "or", (pcp), val)
 #define raw_cpu_or_2(pcp, val)		percpu_to_op(2, , "or", (pcp), val)
 #define raw_cpu_or_4(pcp, val)		percpu_to_op(4, , "or", (pcp), val)
-
-/*
- * raw_cpu_xchg() can use a load-store since it is not required to be
- * IRQ-safe.
- */
-#define raw_percpu_xchg_op(var, nval)					\
-({									\
-	typeof(var) pxo_ret__ = raw_cpu_read(var);			\
-	raw_cpu_write(var, (nval));					\
-	pxo_ret__;							\
-})
-
 #define raw_cpu_xchg_1(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
-- 
2.44.0


