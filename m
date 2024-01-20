Return-Path: <linux-kernel+bounces-31685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC6833280
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391D21C213E9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F82105;
	Sat, 20 Jan 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H996nqN/"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA021375
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719061; cv=none; b=kDYzvkVHG4QYGzD07lIWRuIuIjKxamX2ULDOHwn7ugs57O7/52nnIzGzBTfLrzFY+IweBSzKNgm2tQYhtwoauDvE4Elknr0jpcuflznWpGuVPm4zy5pKDbzhwWFA4p+t24eisld6Gj7jRCHgFQxQZi2A5eQdaUiplh407NizjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719061; c=relaxed/simple;
	bh=FVVUMvujZhZjmYkcGH7AjE35UQGcTY7BYcUBQUAOERE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C83gSIWzNX36YU+MfAEcuV/DH1vGbs86IQmEuObG8k+CnKQg0bFxB8iQhSdY4+Yu8pE4o2PitGj0zjxtwKUHwZLkStgw8khwXQZvNSOCEeYZCF8L1eWR6Ht4kib3w1rCvUdDQczClM51WxfCe7uQ6wBSt36QHuVgOwTh62Ql8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H996nqN/; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc2501ed348so1046679276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719059; x=1706323859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHRAsDAn8C4kdn9sH3kl576WyN+RLpoPnrMOrraWnqU=;
        b=H996nqN/BwKi5OJBP+83SlUaIecrSP5MoV2qn66jZq3TYwFyIt++IUoXtp45Md1ZFX
         W85P/cTsFsQK/GZQ4kt4ukseMdouGpqUhYSEqoxaj99LR5Pl2fQNHLz3y9c06lVYyYYe
         1uBMs/f2BG5yzkJBu7Dr+3p5hJvN3m17ZyhjXLru4Fk+6fLt16NT8phwbyUlZKM6clqy
         lbjVFAiad9IuadFnjqFvzuV9JhcOggX+VuwJpfyrKv3MHI3H942UThbVyZ0xnGh6SKr9
         bpiVRGVOsO3eGQBDq449aQXAt/tZrBmwwR2P3YQGgdr0sk0R4U8BGNP+hIMf/9pnesU+
         nmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719059; x=1706323859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHRAsDAn8C4kdn9sH3kl576WyN+RLpoPnrMOrraWnqU=;
        b=UL/7VdS+lkY3r+av9eovVyN0UqTKgEIp94zbWsV6F9Pa4POzH3A+awRshoiqSF+m1W
         MMvoXvpV50E48BXPqOqTcl+3wfhmHIINmKoT4rcFH0Ml+rAF06kwDLLYo+mLwZGxo85o
         J8+O6eqBQBl0KCHyBThLY7HLKxU4ldKcEDZ1fW1hrMSg7FsaLBCG2z1PSwZOlVeOOEQe
         yIEK3Yi2ZgAzNvPChK7yyBCv7+mQlqU1j4/SOswxy5EQ98lmpDtLaXLuhsTfZ2kx0rEf
         4O3ui55eFtTq5OqMQfZqY3b96vlx+hQBKsvCXar1MzQOnH111oQiDlTIimAu/Za9RNXo
         gXaw==
X-Gm-Message-State: AOJu0YzwwmzRFhK1YnMF7wCURy7HrzABcFLpv+N4gqQH9jnb8HNVVb8C
	XF1L8bUK1d/Q44FZxcHJI/k53cS5I7NMlc2EtfG3OH06Y7Un1q7t
X-Google-Smtp-Source: AGHT+IF0xskwrMmWrtjLD2ozmMbhaGVUw1PuxJ1m4BaGD7SOiNKnNBc/j4r35lnX/kDTDCHgA1D/Wg==
X-Received: by 2002:a25:db87:0:b0:dbf:1913:388d with SMTP id g129-20020a25db87000000b00dbf1913388dmr1444200ybf.26.1705719059194;
        Fri, 19 Jan 2024 18:50:59 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id v1-20020a25c501000000b00dc23a0382c6sm180986ybe.6.2024.01.19.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:50:58 -0800 (PST)
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
Subject: [PATCH 2/9] lib/group_cpus: optimize inner loop in grp_spread_init_one()
Date: Fri, 19 Jan 2024 18:50:46 -0800
Message-Id: <20240120025053.684838-3-yury.norov@gmail.com>
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

The loop starts from the beginning every time we switch to the next
sibling mask. This is the Schlemiel the Painter's style of coding
because we know for sure that nmsk is clear up to current CPU, and we
can just continue from the next CPU.

Also, we can do it nicer if leverage the dedicated for_each() iterator,
and simplify the logic of clearing a bit in nmsk.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..063ed9ae1b8d 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -30,14 +30,14 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
-				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
+		sibl = cpu + 1;
+
+		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
+			if (cpus_per_grp-- == 0)
+				return;
+
+			cpumask_clear_cpu(sibl, nmsk);
 			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_grp--;
 		}
 	}
 }
-- 
2.40.1


