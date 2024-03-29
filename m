Return-Path: <linux-kernel+bounces-124311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62555891588
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9396A1C21CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125D39FD3;
	Fri, 29 Mar 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxD7m77P"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15B28DD8;
	Fri, 29 Mar 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703574; cv=none; b=HpdTTg9Vo6Lo6cfI7vAIn8nTxhDne8sYQjWOkgIKgexZI3tRYujV07nfHWBm+fUvc5kL4MWThTReuuD6n151YUG5IaGFdPXB98SL51dIDrkSodg/KtKkzVZlxWlcH7E75JJr9lhOI7AJ8IgnzLBy6rx9C4PiG7kH3CQ/LnkwhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703574; c=relaxed/simple;
	bh=qaxppLhCSHPM33MPJAT65Zm3XxPQ0v9O+gkQyEnMzUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZ5MMyY3SfznHGLrRYeZh3w5ahf/pRp2OiWfSHdr2dW46dP7/7PEDbGZ3vusC08sXp0BX3ZHFoeZWg9gjLE44Gq9RwrJ0jOn1AhhMi2Fd2ZzrJYoAdwhm7/elTd3mpxmzLe7HQWM3amjbQ89ccn5CI3IVvDy0mAIRMXavAM1drQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxD7m77P; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29f66c9ffa5so365975a91.0;
        Fri, 29 Mar 2024 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711703573; x=1712308373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAayv7XvZLUblJMfvedgbhqIze3msKxkzIyQbNFVnsE=;
        b=VxD7m77PJK01TOcySdDUyGH3tVfmAKswTb/o+tw6oOm9A0JA8iXwf58vEYNW5TIa8b
         8vL9YWM+m5cJM6yCRtRGI5KoimnT1Tgp9RGj9vayOh416uE08UYdNaoDMvjvcyb9D4gx
         j/JB7H1FVAbSbI+QldLM4XBZqohHc5YgOD8zlYmP0CWQfL2Dmm0VypMU0rGv0qVsNz5t
         G+FC03mQHSmNWPmiu1/YZQkqz68lVQR9lnq+Ylzt6uPsjUZ1w/L8pClRq8kgJV4Eeq+P
         GMWpmNOkekvwxX77kXX4IKaIBiKCfBF7zVXDPfNYj/bD+6UTXg1P275ZGP8/ZN3djdW9
         b1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703573; x=1712308373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAayv7XvZLUblJMfvedgbhqIze3msKxkzIyQbNFVnsE=;
        b=ezJmefc7lJDV2D5F1cpmgwK/TPZsmzPxILlRQ1kgWr9Zwj65GTpHOqJGoa8ZDyY1cI
         r8pyVeRuzQCiCTj+UkPTcYL7h66VPionfk0PX0FAVdo1wYzrpnFUEucNzImfJlp2d1Fq
         tL/TloZXmSgTM2PPi221TPxAGsi2QcIlsgJz6ZXf1kt10fwb7pQbOQnYHteDFgEvhnNd
         4DcB57olsyOohw4gKPT9Zmm7hCO2IK23amc6fQNf8zbXKpB5ojdi9/fqYm6JaNV2FIKJ
         OEFKz7waCAFwEHkmraN6bLppUTPcbClZlNoo6KrUur6SFVGaT3FCBn7zW2CX0P5MbLUi
         Y8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbxt3FfxSLeDkQp9+pdL0bppFtRd6/28ezhe+Q/brafstZyzRS6qhhTGel+L2h2HDbnE0mwm6Uhxrm/wO26gFKpS2Lx4UBmEoFJuIF5xOlQ3bVjlRREFwnUzQqX/BwF4HQw1RLoPBcxQg=
X-Gm-Message-State: AOJu0YwaaZapj6mxYBelgF/96G6Ofl78UjcG1WzoKHRBR2AgcBz6rguu
	kj60eetO4pTZBgB8nHEYN0tZ53+5IlGsK09BNR0a6GYVwseu4C3M
X-Google-Smtp-Source: AGHT+IFFB/5KN/9REDmDJwt0c2DHFCyDmwo+BXs9b+ZfOCEGF5Llx/zZsy2xZy3Hq+rmRZTlKak72g==
X-Received: by 2002:a17:90b:2786:b0:29b:ef73:44ff with SMTP id pw6-20020a17090b278600b0029bef7344ffmr1834850pjb.1.1711703572609;
        Fri, 29 Mar 2024 02:12:52 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:15a5:ff4:bac0:6a2e])
        by smtp.gmail.com with ESMTPSA id lm14-20020a17090b334e00b0029bc319f7c9sm4687036pjb.39.2024.03.29.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:12:52 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: axboe@kernel.dk
Cc: akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] blk-wbt: Speed up integer square root in rwb_arm_timer
Date: Fri, 29 Mar 2024 17:12:45 +0800
Message-Id: <20240329091245.135216-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comments in rwb_arm_timer says, we should speed up the process of
integer square root with some variant versions. The implementation of
the variant integer square root "int_fast_sqrt()" is based on the
equation $lg(\sqrt{x}) = lg(x) / 2$ , where "lg" stands for logarithm
with base 2. After we take the first approximation by calculate
$2^{lg(x)/2}$ , we utilize Newton's method for three times in order to
enhance the precision.

To prove "int_fastsqrt" is indeed faster than the "int_sqrt", we take
some bench experiments to calculate the integer logarithm from 1 to 10^6
and use "perf stat --repeat 100" to measure the performance of each
function.

As the result shown, the origin version of integer square root, which is
"int_sqrt" takes 35.37 msec task-clock, 1,2181,3348 cycles, 1,6095,3665
instructions, 2551,2990 branches and causes 1,0616 branch-misses.

At the same time, the variant version of integer square root, which is
"int_fastsqrt" takes 33.96 msec task-clock, 1,1645,7487 cyclces,
5621,0086 instructions, 321,0409 branches and causes 2407 branch-misses.
We can clearly see that "int_fastsqrt" performs faster and better result
so it's indeed a faster invariant of integer square root.

The experiments runs on x86_64 GNU/Linux Architecture and the CPU is
Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 block/blk-wbt.c     |  2 +-
 lib/math/int_sqrt.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0bb613139..8d25c0e55 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -407,7 +407,7 @@ static void rwb_arm_timer(struct rq_wb *rwb)
 		 * though.
 		 */
 		rwb->cur_win_nsec = div_u64(rwb->win_nsec << 4,
-					int_sqrt((rqd->scale_step + 1) << 8));
+					int_fastsqrt((rqd->scale_step + 1) << 8));
 	} else {
 		/*
 		 * For step < 0, we don't want to increase/decrease the
diff --git a/lib/math/int_sqrt.c b/lib/math/int_sqrt.c
index a8170bb91..e25ba179e 100644
--- a/lib/math/int_sqrt.c
+++ b/lib/math/int_sqrt.c
@@ -40,6 +40,27 @@ unsigned long int_sqrt(unsigned long x)
 }
 EXPORT_SYMBOL(int_sqrt);
 
+
+/**
+ * int_fastsqrt - faster invariant of int_sqrt
+ * @x: integer of which to calculate the sqrt
+ *
+ * Computes: floor(sqrt(x))
+ */
+
+unsigned long int_fastsqrt(unsigned long x)
+{
+	unsigned long y = ((31 - __builtin_clz(x | 1)) >> 1);
+	unsigned long z = 1 << y;
+
+	z = (z + (x / z)) >> 1;
+	z = (z + (x / z)) >> 1;
+	z = (z + (x / z)) >> 1;
+
+	return z;
+}
+EXPORT_SYMBOL(int_fastsqrt);
+
 #if BITS_PER_LONG < 64
 /**
  * int_sqrt64 - strongly typed int_sqrt function when minimum 64 bit input
-- 
2.34.1


