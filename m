Return-Path: <linux-kernel+bounces-31691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC90833286
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AB62834BA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E33F9D6;
	Sat, 20 Jan 2024 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQFBWkHG"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD46DDBC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719069; cv=none; b=hyumcpfLMEifibOqBddMvrdE5fLrqWtz9d6nSEbPJYLkt9Q2GIroCmV8EyQkKup3seJ6vxmNQ3xxcHYyixXxa7FAeloYP7VFUXL9Rj74nNB4fWcFuDvV40f6U3dYXNMZd2TqHpqK/UxMDScyV+GGpHPr3AzTzuxpa/VB3jgxupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719069; c=relaxed/simple;
	bh=g4Q/v+BsQEl39aheDnpAa2RdKnHhflblAdg2pabSwXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/Qv5RK+I4jnbl43xkx1SzbaOneNAaTuYiEdml2cEePb+kOhrq2Q+7CmKFlcKLsA2InWvFhbBbzzi3v63nxXp+ZgyywvcCNSK7dYBr3aDUsEsE5QPoClCBU8MfB7PFIk5QiUD7lZAHvkDzCXKfedZrTQAKlFqQNuxv17IbNIKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQFBWkHG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5f0629e67f4so14828157b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719067; x=1706323867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK3MSQRvDzIpKb0PB7VHqnVj86mu8pY62lcMb7kaIwo=;
        b=GQFBWkHG27Zh41Z4Aecxi2ktaH5NuzK4VanYBIVwEHbsC/JwS9D48nU3WG2kw4s1wZ
         hfwqvI9Szud0Sxr27AEA9ML4Wi4petizqqfEzUGW3zyrCLQ018s94ZGBCPhMr5tlVP5Y
         F6+GgkTBKsKRGg8H6jcKvstn3TAzUR2TTFnfwKn3RUg+iEDZDSTs6+YsSRNsigFSnUDQ
         ZD5/3WM8aXmvXNK9VxitEOkM68xZBBW3RgLSyBo2xZup2bl8R59o3tObRp3ulvE3tar8
         BVA9V7/k5J10Kui7hpL/r7bmp9r4Fr4YOM1sn+NzO3jIOicmkiC+HKTJ2ezvOQ+dxD8h
         eRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719067; x=1706323867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK3MSQRvDzIpKb0PB7VHqnVj86mu8pY62lcMb7kaIwo=;
        b=TnOgrPLWvC8dpbvwBp4FiBCqce8S/TooqTY2gNe1bwEZO0rLGtGxk5sDp5NGfqZuLC
         7ahUiisfFIW9ZXMKH4I2Rq6Yfl8gGUzyXWpO1OmxnCQYrCQGLYnGOz2ZMOGh1h5h39DC
         5q5lwPL9EPQcKb18sWzA172vbkn4SoR2wgzShV++DzEq7uP/JgU8CwAyhhGiO2K3Oxey
         oeJZrNeW6Rbs8ABnI+tBN1zhaWzCoCz6jwmGBYaO8fzhqqpdkhaX9NmIzlOQ3tIf2kLC
         6/tSYOVR4/SJTXruKVgmR3sEDF46l1xAniauOT3b6lY/kwpeEPCgNZhKV4YCuFAG0pax
         xCjA==
X-Gm-Message-State: AOJu0Yz5HC/HlShwXp7He67BQG4CLHJgNr0I4Q2AXupPgmd5VOjQIwYT
	CbK+nItoZ6Hzs7D4lkczInooFo4U0bPOxcSVHomlmiQDUmxkNauM
X-Google-Smtp-Source: AGHT+IEwbvhpM0763THgchq4r36P/ykWzE2VFrUoLccf/V/oLviZzmPeNmVu64oa+SGSzgCqwCIfXw==
X-Received: by 2002:a0d:e811:0:b0:5fa:ea54:f413 with SMTP id r17-20020a0de811000000b005faea54f413mr796695ywe.1.1705719067174;
        Fri, 19 Jan 2024 18:51:07 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id r74-20020a819a4d000000b005ff8179bbfesm1926501ywg.104.2024.01.19.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:51:06 -0800 (PST)
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
Subject: [PATCH 8/9] lib/group_cpus: rework group_cpus_evenly()
Date: Fri, 19 Jan 2024 18:50:52 -0800
Message-Id: <20240120025053.684838-9-yury.norov@gmail.com>
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

Leverage cleanup machinery and drop most of housekeeping code.
Particularly, drop unneeded and erroneously initialized with -ENOMEM
variable ret.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 79 +++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 54 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index b8c0c3ae2bbd..4c09df9eb886 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -76,6 +76,8 @@ static void free_node_to_cpumask(cpumask_var_t *masks)
 	kfree(masks);
 }
 
+DEFINE_FREE(free_node_to_cpumask, cpumask_var_t *, if (_T) free_node_to_cpumask(_T));
+
 static void build_node_to_cpumask(cpumask_var_t *masks)
 {
 	int cpu;
@@ -345,26 +347,16 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {
-	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
-	cpumask_var_t *node_to_cpumask;
-	cpumask_var_t nmsk, npresmsk;
-	int ret = -ENOMEM;
-	struct cpumask *masks = NULL;
-
-	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
+	cpumask_var_t *node_to_cpumask __free(free_node_to_cpumask) = alloc_node_to_cpumask();
+	struct cpumask *masks __free(kfree) = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	cpumask_var_t npresmsk __free(free_cpumask_var) = CPUMASK_NULL;
+	cpumask_var_t nmsk __free(free_cpumask_var) = CPUMASK_NULL;
+	int curgrp, nr_present, nr_others;
+
+	if (!masks || !node_to_cpumask || !alloc_cpumask_var(&nmsk, GFP_KERNEL)
+			|| !alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		return NULL;
 
-	if (!alloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail_nmsk;
-
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		goto fail_npresmsk;
-
-	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
-	if (!masks)
-		goto fail_node_to_cpumask;
-
 	build_node_to_cpumask(node_to_cpumask);
 
 	/*
@@ -382,11 +374,15 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_copy(npresmsk, data_race(cpu_present_mask));
 
 	/* grouping present CPUs first */
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
-	if (ret < 0)
-		goto fail_build_affinity;
-	nr_present = ret;
+	nr_present = __group_cpus_evenly(0, numgrps, node_to_cpumask, npresmsk, nmsk, masks);
+	if (nr_present < 0)
+		return NULL;
+
+	/* If npresmsk is empty */
+	if (!cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
+		return_ptr(masks);
+
+	curgrp = nr_present < numgrps ? nr_present : 0;
 
 	/*
 	 * Allocate non present CPUs starting from the next group to be
@@ -394,38 +390,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	 * group space, assign the non present CPUs to the already
 	 * allocated out groups.
 	 */
-	if (nr_present >= numgrps)
-		curgrp = 0;
-	else
-		curgrp = nr_present;
-
-	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
-		/* If npresmsk is not empty */
-		ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-					  npresmsk, nmsk, masks);
-	else
-		ret = 0;
-
-	if (ret >= 0)
-		nr_others = ret;
-
- fail_build_affinity:
-	if (ret >= 0)
-		WARN_ON(nr_present + nr_others < numgrps);
-
- fail_node_to_cpumask:
-	free_node_to_cpumask(node_to_cpumask);
-
- fail_npresmsk:
-	free_cpumask_var(npresmsk);
-
- fail_nmsk:
-	free_cpumask_var(nmsk);
-	if (ret < 0) {
-		kfree(masks);
+	nr_others = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+					npresmsk, nmsk, masks);
+	if (nr_others < 0)
 		return NULL;
-	}
-	return masks;
+
+	WARN_ON(nr_present + nr_others < numgrps);
+	return_ptr(masks);
 }
 #else /* CONFIG_SMP */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
-- 
2.40.1


