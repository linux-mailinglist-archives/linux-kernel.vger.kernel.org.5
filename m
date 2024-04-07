Return-Path: <linux-kernel+bounces-134259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D25089AFBC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFFF1F221C9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729614295;
	Sun,  7 Apr 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/oNS4eA"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C712E61
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479432; cv=none; b=Iw7/zESxdlGavNNjWG2jpSvgYvFbrN0T2Y8TvHVwnzdffWhuIf347A8Z7xSO60HC7fZYztGhUmhVEc8e1c6+NfMtSsr6wW8mPqxQOteFwneNAS5n5Tfs/y3Tb+/Ev05phi/oVW/G0/zikaUGxGNzm2QgLnhLk4wZ7a/abKPOy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479432; c=relaxed/simple;
	bh=nuxkHQMwN0iKAtrlmP1y68Lf8Q8LrkbVXJ/W+CJ68s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTzklTVeGfFSK2MP8uQCtFQU8YIbnYwhDtv7I3eY6LL4MPpfapVM96sAVQZTlluDRWGJ57+CHR2sP7Lvuk26pscWeIUyryxnNhOYvfXEzePS1nwUDdvg2ioeeumyT5pmtF/zzMgV3MwL/VRIUft517rvrhjBHiiC+3n6AsusOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/oNS4eA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so592622766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712479429; x=1713084229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaQHENn0auKGWXe0fpcoU5iWyUWMYpAgRZ3VVdGAHGo=;
        b=F/oNS4eAzFClG3Y/YiEv2rGUArvGjqyyXRqwkdcbUu3ncdT1NbWDw5bzqsAo/vIKsu
         cgxIVhMJYXf2g7v6iqXibpnIeEMXxU1ljLi3jG4NUaONqzq4pLsKDrJCNWUPNa9NXiA2
         9jEtCtusQOi43UddjeCDopq5Xbdx+Fhm+2z4ok1TX56fEV8XzEu//AhLo3tdKPnAd9iG
         OsygXI+Ea9sFGob/IsAxfqGmQnaeZ0mYmuBE4R1Nupblyve1M5yeFQZ+ZjoGohwfR60p
         LT5BJUY7mRfc6THVvT7DJOssZcR1MprN5eEEga+kb1KxDBpJfxUYRC1uAQ+Fe2eUPLI7
         liyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712479429; x=1713084229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RaQHENn0auKGWXe0fpcoU5iWyUWMYpAgRZ3VVdGAHGo=;
        b=QrRgKgJ/EqjDSlUyG6lYUNMnDOJRyDxDgRLWc5WbQ5KDqWuhuXI3r3GDYtvn4CJcM8
         9ScCZQiuuqMjUEc0drvRzUY5er7JThbGh6exKva9fgwVqoVKbq4kxh1+pH+NToslqv0C
         VYBGu2pEN1F5W6ysaFsPCci0DHPrddpDLt1fGvhv2A47sDIQq8CoVeVGGL61juRSu/+R
         4CIpxYktS5IsdwAUZIp/1IWja4x6VlEKPW8fYZC6SVLBJT9Iwx1OmTXz5KpQYlExOcas
         68AMCoC9PeE0l6VBAOfsvl4t+zbo/jfKnodMEbpeswVFs4+B39bflcRychF2GViUj8hm
         JljQ==
X-Gm-Message-State: AOJu0YysUpOQR6eQXyqBJs9a8+I92BB7zDPTqu6ChkByTbV/lwKBVEnF
	XRvXl99CDuP7UeGNbtBJWdi/GKwVrHFcUj61bM1qzAPjSARKFrpz/hGSF2A1COI=
X-Google-Smtp-Source: AGHT+IFCvL01sLhr4UbUsk/LUZV1Od8f58f2xWHGDW4M4PmT0Ivm7DKtr2ZDcf7oC9vPLbsrTVMg/Q==
X-Received: by 2002:a17:906:1b41:b0:a51:c451:4581 with SMTP id p1-20020a1709061b4100b00a51c4514581mr1840304ejg.23.1712479429048;
        Sun, 07 Apr 2024 01:43:49 -0700 (PDT)
Received: from thule.. (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00a4e28cacbddsm2891579ejz.57.2024.04.07.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:43:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/5] sched/fair: Remove NEXT_BUDDY
Date: Sun,  7 Apr 2024 10:43:18 +0200
Message-Id: <20240407084319.1462211-5-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240407084319.1462211-1-mingo@kernel.org>
References: <20240407084319.1462211-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been turned off in 2009 and hasn't been enabled since,
15 years ought to be enough to remove it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c     | 11 -----------
 kernel/sched/features.h |  7 -------
 2 files changed, 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0197ba78b89c..93ea653065f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1901,13 +1901,6 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq)
 {
-	/*
-	 * Enabling NEXT_BUDDY will affect latency but not fairness.
-	 */
-	if (sched_feat(NEXT_BUDDY) &&
-	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
-		return cfs_rq->next;
-
 	return pick_eevdf(cfs_rq);
 }
 
@@ -4671,10 +4664,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
 		return;
 
-	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
-		set_next_buddy(pse);
-	}
-
 	/*
 	 * We can come here with TIF_NEED_RESCHED already set from new task
 	 * wake up path.
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..f0df03fe24d8 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -8,13 +8,6 @@ SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 SCHED_FEAT(RUN_TO_PARITY, true)
 
-/*
- * Prefer to schedule the task we woke last (assuming it failed
- * wakeup-preemption), since its likely going to consume data we
- * touched, increases cache locality.
- */
-SCHED_FEAT(NEXT_BUDDY, false)
-
 /*
  * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
-- 
2.40.1


