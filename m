Return-Path: <linux-kernel+bounces-122266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941A588F472
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161DA1F2AA32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C21BDEB;
	Thu, 28 Mar 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R63pa7OF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C32F5B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588790; cv=none; b=LsNYXjFiLHl8/JwzmlS8L4ygq0LN3tuV8jDhBvgEnQzx9OlPzaW2GIR87bVr1k0bcvr/pf8gpv4PpA28s2vIoU/tVmBy0P/RbUkSpvm/nX+Q9Ff2hLMgKtpCoNIAUytc0wc+MjKWYNego0YQCQahwwRLsZIeiwFkdZIZEX/k89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588790; c=relaxed/simple;
	bh=/tMfkHoivnbhWF0CQoO+trvW9NLL7JRMxJBrXU3jLSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXBHLaeS5A8kFTARgsSmX6NarbvRXQp9oEitQqydkN/nWG7F0lizp9Z1R5ISAXzqqWsPd87iq3kqIm0HTI7a8QpTD2TJrbmjJTp0BAZ/8f6LqONFGy1ao86Hnn/RCEDvAxWw63LapzbEnFU6VIhRw+6Pi2ypnpBTvsDpOG11bF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R63pa7OF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e704078860so462300b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711588788; x=1712193588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56eIrv6lZkI0xARPD/Dq00dXsO+UKoMU+OA6m2OIX+M=;
        b=R63pa7OFYVuvN5/ZmVCFqGsBadNEb+kYUgW0C8rDGwhuvMfZQizNIyQZ5G0Hi2YyH9
         k5fLFAvfBrbVTWyYZGpWOZJMng18+Q8nZsC23OchZEmXezf1qpCfrTNYm92t2KuKnznm
         AfQNcGYJmzYFLesHNRz0649+GcA2B+K9Fn4J7d63PumFHFua51NVWGvSQkaxpFXJEwrR
         I30ckkDDYbEApc4wzwE7VrxuVgawNTm0oLJZvGlnx4tWH/9iRowffrv7eSRUa6gzQv3Y
         fZ4L1iZ7zx9OMLmOBqmzM4ffNnj/TAVJzfNeEhIjjrbM6w8O9f+Chj49y7RZ69iphz/i
         3jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711588788; x=1712193588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56eIrv6lZkI0xARPD/Dq00dXsO+UKoMU+OA6m2OIX+M=;
        b=JWV8PoKBC7vTMVdSQbzRVi+It87fMXsZZRZDi4BHplAhwmqsCiW4DjjkCmsj4Hhglp
         4/RKjr/CxwREGNKxtROslKks07E7YgZEixfOazKdJC/WZpIWFuv+69qVop1BT4DCIL07
         P3JVe7hgTLSLjVM29EkzXHonWu4BmmPtWgZ8upIsNar4kJ9tyALOZnW3pt1RDxi9ITcJ
         EIQDwdIn0dDuSG4xHDwfhMPIwxOPXECBzSXkiipuLYwB6ZkppbFr2Dt2bz6JX7Wg7Keb
         od1TGasgAtbtSZsb5YnmW5DBx+OEtC7EJGELAEl52GZECetnCbOUEpbH9jyDPfb40TSv
         jobw==
X-Forwarded-Encrypted: i=1; AJvYcCVzXRzuQe3TJplaEA3bogESPymt8Z8YIdcIPxFTgrDUFztfhR23sVu/umdsNGIMmWq1U/aHg52hkNF+UFds2D+fAig8xImz8BjRi0WB
X-Gm-Message-State: AOJu0Yx/IN0AHDFSRgVrGL7U2hi0mwn4ksaqYpfPUcaKEj7gExzTrsXr
	KJ0g6OBrLMSQMbJGcr81e1kpw417mEBCQQna/wjuwSX7oGUnSyQU0Ey5fRr8eTk=
X-Google-Smtp-Source: AGHT+IH54N5CUBZ61hcjkPxhtSl6zxDfUhr4FQa7nNAbY3iB5N+pXYTpSbCgP9IfUyz0CmB+HUt4Bg==
X-Received: by 2002:a05:6a00:2388:b0:6ea:b073:bc7c with SMTP id f8-20020a056a00238800b006eab073bc7cmr1552590pfc.33.1711588787956;
        Wed, 27 Mar 2024 18:19:47 -0700 (PDT)
Received: from ub23.localdomain (c-24-16-118-101.hsd1.wa.comcast.net. [24.16.118.101])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b006ea8c030c1esm175123pfd.211.2024.03.27.18.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:19:47 -0700 (PDT)
From: Dawei Li <daweilics@gmail.com>
To: 
Cc: Dawei Li <daweilics@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] sched/fair: simplify __calc_delta()
Date: Wed, 27 Mar 2024 18:19:35 -0700
Message-Id: <20240328011935.5894-1-daweilics@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5e963f2bd4654a202a8a05aa3a86cb0300b10e6c ("sched/fair: Commit to
EEVDF") removed __calc_delta()'s use case where the input weight is not
equal to NICE_0_LOAD. Now that weight is always NICE_0_LOAD, it is not
required to have it as an input parameter. NICE_0_LOAD could be
incorporated in __calc_delta() directly.

Also, when weight is always NICE_0_LOAD, the initial fact value is
always 2**10, and the first fact_hi will always be 0. Thus, the first
if block can be removed.

The previous comment "(delta_exec * (weight * lw->inv_weight)) >>
WMULT_SHIFT" seems to be assuming that lw->weight * lw->inv_weight is
always (approximately) equal to 2**WMULT_SHIFT. However, when
CONFIG_64BIT is set, lw->weight * lw->inv_weight is (approximately)
equal to 2**WMULT_SHIFT * 2**10. What remains true for both CONFIG_32BIT
and CONFIG_64BIT is: scale_load_down(lw->weight) * lw->inv_weight is
(approximately) equal to 2**WMULT_SHIFT. Fix the comment so that it
is correct for both CONFIG_32BIT and CONFIG_64BIT.

Update the comment for calc_delta_fair to make it more precise.

Signed-off-by: Dawei Li <daweilics@gmail.com>
---
Changes in v2:
- update commit message
- reorder the variables
---
 kernel/sched/fair.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1856e58595c3..d3fc75601861 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -252,32 +252,23 @@ static void __update_inv_weight(struct load_weight *lw)
 }
 
 /*
- * delta_exec * weight / lw.weight
+ * delta_exec * NICE_0_LOAD / lw->weight
  *   OR
- * (delta_exec * (weight * lw->inv_weight)) >> WMULT_SHIFT
+ * (delta_exec * scale_load_down(NICE_0_LOAD) * lw->inv_weight) >> WMULT_SHIFT
  *
- * Either weight := NICE_0_LOAD and lw \e sched_prio_to_wmult[], in which case
- * we're guaranteed shift stays positive because inv_weight is guaranteed to
- * fit 32 bits, and NICE_0_LOAD gives another 10 bits; therefore shift >= 22.
- *
- * Or, weight =< lw.weight (because lw.weight is the runqueue weight), thus
- * weight/lw.weight <= 1, and therefore our shift will also be positive.
+ * We're guaranteed shift stays positive because inv_weight is guaranteed to
+ * fit 32 bits, and scale_load_down(NICE_0_LOAD) gives another 10 bits;
+ * therefore shift >= 22.
  */
-static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight *lw)
+static u64 __calc_delta(u64 delta_exec, struct load_weight *lw)
 {
-	u64 fact = scale_load_down(weight);
-	u32 fact_hi = (u32)(fact >> 32);
+	u64 fact = scale_load_down(NICE_0_LOAD);
 	int shift = WMULT_SHIFT;
+	u32 fact_hi;
 	int fs;
 
 	__update_inv_weight(lw);
 
-	if (unlikely(fact_hi)) {
-		fs = fls(fact_hi);
-		shift -= fs;
-		fact >>= fs;
-	}
-
 	fact = mul_u32_u32(fact, lw->inv_weight);
 
 	fact_hi = (u32)(fact >> 32);
@@ -291,12 +282,12 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 }
 
 /*
- * delta /= w
+ * delta *= NICE_0_LOAD / se->load.weight
  */
 static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 {
 	if (unlikely(se->load.weight != NICE_0_LOAD))
-		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+		delta = __calc_delta(delta, &se->load);
 
 	return delta;
 }
-- 
2.40.1


