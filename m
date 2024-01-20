Return-Path: <linux-kernel+bounces-31686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44D833281
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF62836BE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE746A3;
	Sat, 20 Jan 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXMMWiVM"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1020FA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719063; cv=none; b=T281k4NrWBZCP8iFRW0hhw9EvQou0UlYIaEWkC1ZEY902PwMNQjp6bGn88Ldrd9jHQcWH4deaRAogC+wkIggNcqIwvwJJYe7hD0J8WkKJD3PxH88ypTrR6K5zbAPWwFjON38azox+l8RRpgIDmQJx7OP8nX804esofpZHsYcTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719063; c=relaxed/simple;
	bh=OMBbdYX8nOdWmRvXvgL49m4b2eYizvAW2/Ifazlfivo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3I+bM9dkeC1dLT4FHGNvPLqGqeTUhXruhzW7ysrk/AaoKJucUwSq9HTKACJxqYg3JLvQXwSr1RA/PqGlZGvCn3mXY/Qnz+zzppsCAGYpvGxcrU6P6t0fUcc7IsZDB7RHsfZW988hWFMtl8sjXO9ejLXZGLp+b0L3FD7Uim8QTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXMMWiVM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ffaabdcccbso4277367b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719061; x=1706323861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLcBksejFtB67CxPfS8EreSpNvKNv16Sj+tueH02QvE=;
        b=bXMMWiVM/zLsvQKhRVgfCi+oyjBFOnfnbJ1UVQraiOHWyfpbsb5UQ66s50gc7Mhudy
         Po/YLi0sMFbztX+VFA6guFg3MrsTQgCBiSEaE5lAAURL9H6ehM0rg6eoRY9lv0MaaNYp
         VCfiAHomXYB4GxRi9JVDI4gT5uPM/ROrLOLKTImtPXNHJEPcIbpLJhxwsjmuG5kizWgN
         /kV29pGRVRqiqxhkVA13f65neecDiyT7c6rgtnH2UfUl4Qa5v5ocRflV/lBa6k01I4IB
         5UMTBCC7km/GzCuBckqQ9BUwoA9BZXc09DOXYBZy3SaLDC1zPvdTaY5YX01xpBcXSsLp
         6/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719061; x=1706323861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLcBksejFtB67CxPfS8EreSpNvKNv16Sj+tueH02QvE=;
        b=ekEhCcEo1F7VpnPk1TjNSFDx+sdd8ImWyHY5N9ES06ClU8BK9XyOqGEcsn+L0GlY7a
         /ikm4sjUxkaRLZZJZ9IQ8MVvAUM3UFPxOnpejIav/Dj68Rp1gU/d6cR5tJTIZ34WGSM+
         NfcjDexYAmTXpxRs1lWLMRKF2AVhqekeQ7L1/yo/6w/rt44xojDepDJH+B06LiiVCoFo
         sO5gjq7mKqiggZ/pVRWzyzaeIotlXRLcvuhXUXT2NiqOlbx+zuQChG3znxVeF0tlzfIl
         XdEo1yNqdivRNiinCz6AoIJP5CVYryQXQZdGDCDeZjPQisK00Z/LnGZUi/yvX3cBOlCD
         6N1w==
X-Gm-Message-State: AOJu0Yxc4bS/BFOlR7TjVcabTX3z54b6O4zZPRdhb8ELPPt1s+P7/FkE
	GheNthdvhPXhkm51tK6q6LrD1dQX8LY+6gHczHEp6jfGl8WafPy+
X-Google-Smtp-Source: AGHT+IHUfD1EUetixqI92Fcs1eodbLCLUE9NLpwn48zqo4+AwLgnBKW+VbglRqVVxjeVD36mN2k6Uw==
X-Received: by 2002:a0d:e747:0:b0:5ff:9f17:654e with SMTP id q68-20020a0de747000000b005ff9f17654emr760006ywe.94.1705719060684;
        Fri, 19 Jan 2024 18:51:00 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id r124-20020a819a82000000b005e92fd632e0sm7897419ywg.24.2024.01.19.18.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:50:59 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 3/9] lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
Date: Fri, 19 Jan 2024 18:50:47 -0800
Message-Id: <20240120025053.684838-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120025053.684838-1-yury.norov@gmail.com>
References: <20240120025053.684838-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because nmsk and irqmsk are stable, extra atomicity is not required.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
NAKed-by: Ming Lei <ming.lei@redhat.com>
---

Regarding the NAK discussion:

  > > > > I think this kind of change should be avoided, here the code is
  > > > > absolutely in slow path, and we care code cleanness and readability
  > > > > much more than the saved cycle from non atomicity.
  > > >
  > > > Atomic ops have special meaning and special function. This 'atomic' way
  > > > of moving a bit from one bitmap to another looks completely non-trivial
  > > > and puzzling to me.
  > > >
  > > > A sequence of atomic ops is not atomic itself. Normally it's a sing of
  > > > a bug. But in this case, both masks are stable, and we don't need
  > > > atomicity at all.
  > >
  > > Here we don't care the atomicity.
  > >
  > > >
  > > > It's not about performance, it's about readability.
  > >
  > > __cpumask_clear_cpu() and __cpumask_set_cpu() are more like private
  > > helper, and more hard to follow.
  >
  > No that's not true. Non-atomic version of the function is not a
  > private helper of course.
  >
  > > [@linux]$ git grep -n -w -E "cpumask_clear_cpu|cpumask_set_cpu" ./ | wc
  > >     674    2055   53954
  > > [@linux]$ git grep -n -w -E "__cpumask_clear_cpu|__cpumask_set_cpu" ./ | wc
  > >      21      74    1580
  > >
  > > I don't object to comment the current usage, but NAK for this change.
  >
  > No problem, I'll add you NAK.
  
  You can add the following words meantime:
  
  __cpumask_clear_cpu() and __cpumask_set_cpu() are added in commit 6c8557bdb28d
  ("smp, cpumask: Use non-atomic cpumask_{set,clear}_cpu()") for fast code path(
  smp_call_function_many()).
  
  We have ~670 users of cpumask_clear_cpu & cpumask_set_cpu, lots of them
  fall into same category with group_cpus.c(doesn't care atomicity, not in fast
  code path), and needn't change to __cpumask_clear_cpu() and __cpumask_set_cpu().
  Otherwise, this way may encourage to update others into the __cpumask_* version.

 lib/group_cpus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 063ed9ae1b8d..0a8ac7cb1a5d 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 		if (cpu >= nr_cpu_ids)
 			return;
 
-		cpumask_clear_cpu(cpu, nmsk);
-		cpumask_set_cpu(cpu, irqmsk);
+		__cpumask_clear_cpu(cpu, nmsk);
+		__cpumask_set_cpu(cpu, irqmsk);
 		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
@@ -36,8 +36,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 			if (cpus_per_grp-- == 0)
 				return;
 
-			cpumask_clear_cpu(sibl, nmsk);
-			cpumask_set_cpu(sibl, irqmsk);
+			__cpumask_clear_cpu(sibl, nmsk);
+			__cpumask_set_cpu(sibl, irqmsk);
 		}
 	}
 }
-- 
2.40.1


