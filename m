Return-Path: <linux-kernel+bounces-103978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D1D87C75D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2762B22231
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF06FAF;
	Fri, 15 Mar 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAcQu3m/"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1FD63B1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710468178; cv=none; b=JNhy8ONQSwFzrHJ4HnjlDAex6PkDxtVjJ0n0qLNfIFpIlAFYRpx4E3PGWPrkOseavGz8xNlf016H+zjTJV9Lbi3g/z+vNFlL4nst85TYAAPpPHzU4WdN9eDR30Nita2tMSUCaRCMLsbuY4cWYBPvP41zurUz4kdAceex74dSOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710468178; c=relaxed/simple;
	bh=GprhAwZTA5xKKqzVaUyoGepNiZ2LOhoHorzocMt68H4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uRmSj7ISKoV3C4Pbf13PL23/yHxense4RZ2nGNC435lkMve9fuXVRjgJs0iCOtTaeRr3YnCbdqzQT1MXHD9hBCPR8aG8HXByvuT3dHCfcjwmMI8ojkCSiqLhMiSurZnE5l462zZx5aiIEoddO2T8+WYkqvvc+ACVk8lKDbYZwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAcQu3m/; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e678c24a21so219600a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710468176; x=1711072976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWmMvGpzy2YRwPpLNVsDvPWRVOnioBUgAMRFdG1NNV0=;
        b=hAcQu3m/P6v3E1Ck1yW9xDuhyZdO7ayff2U3MtElha/CZcV4JhqYi25MsJUfysuGIh
         NFZgwgGmh/cRiU2mS8ZKbMB016pF9kfBPIFgPF6A/bPK1HcWiatKCbYwep2/pxsfcTpQ
         bWHAAc+td/vj5SlHRb+ehE4Td29zSrtwzedcxoNNvF7BboxwzN5YV2B0q1sFsZEmwyDh
         AUnVfT54HaHk8lBIbKdKk2HdxDkozSXIeWwWFIIEKu6uMHYcPWhQTipCi1NZHtgIgeVD
         oTqwDq+3PuOYvXzS84MNuO3Ol3w2qxWAXETDa+LsLjJ8Vvyd2Cv0fz/cFwY7wYnNJyFX
         FyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710468176; x=1711072976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWmMvGpzy2YRwPpLNVsDvPWRVOnioBUgAMRFdG1NNV0=;
        b=W2vFg2sPxj39piceX8uuQ38sX/crn4DMQkeW6HjnhnBt9z27I41UgMqueAFRxMBb6z
         aEIxa9yBk878pucohr3XzUVG3iu+mWVefaemyExgws+2kH053+owhWvaizQXS/uk2wcb
         5Njb2QuOyFfPUNfNOQu8ak20VpBUv0DqZWWF+t5WrCkIoqjC/mvEj/QKCqPdfdQyC6B6
         Sk3Lzu4xJQU6XYzHezxPxCObCaATqpkaTPwkEINbvcKeFzY9G08CJszIVI5WxXIR+wfi
         URgZqzbJHsb47fqX7B+uT/A8RolKT2ZOo5CoDxvpFw11yZCC7p74q6VSyEK+WuLS3Znq
         ZaCg==
X-Forwarded-Encrypted: i=1; AJvYcCVgUTEt43obCjKryURBV1hpy8afsERkJEYPCtM6q2rShLGPr7nbcQ5EYnuTARgiXLO7pKG8vSW95cKnLYueipVALFe8rA6LrSfN0zoS
X-Gm-Message-State: AOJu0YwF9zmQUO0la3VTswsuR1qlseC4h8zSEl0R5DPgnpQOpy0o6UY+
	Lye2P7vfS+SSGGLjdjbQ2S8k/Wk2HHaQEc8kSXJBCd0dxoWJwZxW
X-Google-Smtp-Source: AGHT+IHzl7vikW876yO57pMY86dQvDm5NTHbwSrIFtAbGom5Q5Z5uqDlWGSykKrnoq+2brDIwHBc1Q==
X-Received: by 2002:a9d:6189:0:b0:6e4:8fa3:d861 with SMTP id g9-20020a9d6189000000b006e48fa3d861mr3606882otk.34.1710468176075;
        Thu, 14 Mar 2024 19:02:56 -0700 (PDT)
Received: from ub23.localdomain (c-24-16-118-101.hsd1.wa.comcast.net. [24.16.118.101])
        by smtp.gmail.com with ESMTPSA id q26-20020a65685a000000b005dc5289c4edsm1205320pgt.64.2024.03.14.19.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 19:02:55 -0700 (PDT)
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
Subject: [PATCH v2] sched/fair: simplify __calc_delta()
Date: Thu, 14 Mar 2024 19:02:34 -0700
Message-Id: <20240315020234.22092-1-daweilics@gmail.com>
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
index a19ea290b790..e1869cf454ea 100644
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


