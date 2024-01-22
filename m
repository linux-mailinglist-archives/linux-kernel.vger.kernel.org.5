Return-Path: <linux-kernel+bounces-32632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF333835E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9991C21D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137639AE9;
	Mon, 22 Jan 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7kE113v"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B163A8E0;
	Mon, 22 Jan 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915635; cv=none; b=WDUB+d7h+9w1O+V+Omu2M3aB4FzQDF/oOSnTXK/9xO2lzIKO8zYut4E3vnwW6BczGFGweIhJeM6IOBE59UL+reyWkNujgbhjxt1+6ITUDo11OU9riHkrZNXIfLlSyslB3meEnyAp8m32J6cZVfN5ktVjXnTR0yf/sFEhJGTUpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915635; c=relaxed/simple;
	bh=c+pp3wM05kjEh1TGNSe7FIK8DIIwbLO/SK+P7CGfYCk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kpjl0Ua4m2wf7YjIiEPtKCqblcLIki4QtX4eeKo2XZoN1vAO9tjiwxyhM6XqrYxVrLNFl+NyVJNGUv8acNt+rLZqs434Z8CvuGGJl1KkEapkPqzAX4WxIGbtfycKzBj+C22IgiXSbuZOXeWw37q1g0mUuvFn3DfngeNeK3UPtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7kE113v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a308e6824ccso4684566b.0;
        Mon, 22 Jan 2024 01:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705915632; x=1706520432; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA56Trfdmas0N9KP+Qetqk6xxYzVaJwZcqc7VsxjPD4=;
        b=c7kE113vjydtZiVWpBo5miYdkwIQduwj4wz5rUKiAKvpxQtx99bawx8kx+2Z/fUGc6
         6v8FskV7aV7qFUdFNDe8iq3tD2fKSHZr6FA//BFgQtZkCTga6mLyuOK6z/qE8bZ+gqeA
         6+USIXNTnZIfEUkdDcwWqAeMke7IRNu47vhT0MO+WwPgeW+wZED6PA4gv3tPn9UuCEQt
         33hmWo5LVxK/AcrJWa8tdzI+LGIbm+OJkQEo1/nrxP8041U33eEtFIG5I/28ymMlmkyp
         w3OaSOq3gC/++umNpEcujin+H3expe7vSJoL24by9+VL/kG0Sd5C3SLL/HxdSx5K+93O
         Mg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705915632; x=1706520432;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA56Trfdmas0N9KP+Qetqk6xxYzVaJwZcqc7VsxjPD4=;
        b=WPmqZNLjVqu+PC/Dqjsk1G8Ub4WtWsEAPDFjyL1Fg1CeYQy9Y+/do9gHCrMIixrkFG
         L0/5mFQPCYbqVT312xqehgOqIea8eacmJh+jnKnZmwBmMg5a/r5X+SbqbpKCZNXEMTbJ
         UrjV/6jbv4i425qK0MYri295RNsCtsuv4eHVDNlCWKbtP5FBXjd5W+IJHdjDoCBEY7SZ
         m+WdpRaru1/RB3znnF02apJTXgFw6v4Z1TkkdqkK5yeWxe+Fg4D/hPxbT+dKufi/aNfs
         LdAF/yGJUemzysC5SDbCUkdeYQZlljowIGr9daE3n0lwskS74t3dovMuRvjM7NePFyWn
         X+IA==
X-Gm-Message-State: AOJu0YwQY9CP30367N+W3HEk+Eshn1+5t0r1aogdORRO6xW25sRHT3yJ
	6mlwftr8nXnH0mxR/k29qauRDjAD7e+5PRn1ttHLGKKroHS6FyiY
X-Google-Smtp-Source: AGHT+IESyAopfrZSpMlLQkQBCVGtEcQY2zrHFpASJJPNAHvpg3w9AW6i0xBMHApfSFn25rSKO9LHNg==
X-Received: by 2002:a17:907:982:b0:a2f:17c1:2abb with SMTP id bf2-20020a170907098200b00a2f17c12abbmr2426003ejc.60.1705915631745;
        Mon, 22 Jan 2024 01:27:11 -0800 (PST)
Received: from felia.fritz.box (ipb2191d3b.dynamic.kabel-deutschland.de. [178.25.29.59])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13114843ejh.22.2024.01.22.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 01:27:10 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mempolicy: clean up minor dead code in queue_pages_test_walk()
Date: Mon, 22 Jan 2024 10:25:04 +0100
Message-Id: <20240122092504.18377-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 2cafb582173f ("mempolicy: remove confusing MPOL_MF_LAZY dead code")
removes MPOL_MF_LAZY handling in queue_pages_test_walk(), and with that,
there is no effective use of the local variable endvma in that function
remaining.

Remove the local variable endvma and its dead code. No functional change.

This issue was identified with clang-analyzer's dead stores analysis.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 mm/mempolicy.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a2b5d64b28e0..31deff75de43 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -690,7 +690,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 {
 	struct vm_area_struct *next, *vma = walk->vma;
 	struct queue_pages *qp = walk->private;
-	unsigned long endvma = vma->vm_end;
 	unsigned long flags = qp->flags;
 
 	/* range check first */
@@ -718,9 +717,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 	    !(flags & MPOL_MF_STRICT))
 		return 1;
 
-	if (endvma > end)
-		endvma = end;
-
 	/*
 	 * Check page nodes, and queue pages to move, in the current vma.
 	 * But if no moving, and no strict checking, the scan can be skipped.
-- 
2.17.1


