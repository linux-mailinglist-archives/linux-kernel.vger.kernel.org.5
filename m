Return-Path: <linux-kernel+bounces-124322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E307F8915A5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840C91F22BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779081C691;
	Fri, 29 Mar 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5By1wcu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F431EEFD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704020; cv=none; b=bdWGDCjK2bt6cBGmpMbL1CZbLrlJmy+QR6SNO5Bq/v9Qi8HvSDOyz1FXE9k1875sh/FBZytUx4Xwu8uAAlb+0s7idHlKGDudwT/X7uqqfkkw6J1AptXI9kKSbcu1YfJt2/75yec8yGdMVy6AM6Ybr52CwsOPOzmcpkSSB86MOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704020; c=relaxed/simple;
	bh=hm+AHHYWzLy+AlbU0wNJxAg9v3kNIE4Nl/55GME9dD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHPpfrasLPfweUBNimEU/MzDCRaKMzO+v74qll/AZhqQhPk/00EJh6qBRvbey2cPVyRmqsAhISIN11Cl1Bepx1zj9DFC0lCuTay4aFrpaNtxclwdgFHRf2FGyrIGzf61nSLb3qfSXK/Wcs7jjpF49R0SvwwCdwgb1cx/ehG/n+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5By1wcu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a21330d093so394719a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711704019; x=1712308819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzAzNpzkXXUAA+hRodaPXYuruuuBsEIO0xmoY7kmtxE=;
        b=Z5By1wcu/gAr4KcT+GuQJg9ra1ker3GNUGu6tsWeeXOEFumzZZNdrt1DMMBxdnkmef
         rzTVGu0zQT5sPg3X1wL6mqsXEiS9ab1+lftBv8A0OE1/Z/LD/efvgeYBZ5aGks2kqiJ1
         Qhi/+zpsK1x53M1RuBkkxFu38ibM+A3hAlcAn3EFnGSK6Fh8Vyy1h0TzmuGz2n7MAQpp
         W9oiZ490RTUGzioAJVZn5+hJGlbAFJdlEF184nTRWzRePQRaKkFnEjWkuLufldjrHHPg
         dcVl0+s6vxBXsg9bhOH6mPpIsMTH76o5NW07pJTPd83CnIO4XHL8BNTGC6dZK5x+kKxg
         72Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704019; x=1712308819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzAzNpzkXXUAA+hRodaPXYuruuuBsEIO0xmoY7kmtxE=;
        b=v+1wseo4Us4BM8HxGhNG5t7j3qEbL9D6PGh2YTo3MXPZMSfkzV1OvFPBi2n1XqMJIw
         BslOK+BivOrwbIkcpFEcyOYDo1rZe7j/LxgLTWpcY4dVre8dbk64w0UIeOvr46zwOGNe
         geXFrGsJHh65mE1fXhjABN0rzlMFI+3Ah/Eg39I9trT6cpKyVK1xM7ENEjkkr99b0jyg
         D74OfwQ1VHPWVcjpyLwkBSDiDdcL7JmKS3eZz+GXpwEhRlefTAeIpoN3a7/L/mdUr2n1
         D9YtQkPglMMhLwgWEwZQxucoBrd6QvqG0J3z0UQUSsVsp30tlDjNn1qVb3Xf5kb8kwTV
         /lXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYCg7Ac2ZHuUajGXq+ojd2tlqKjFSjFRb8AjqGNr4Qwz0qaok7DK6MSjNttIgXl0xLEARa4/DTleo1629xZye295fVgubZjhAMMNFc
X-Gm-Message-State: AOJu0YzbMm4p9I5Z6kQ+PkpfTkRS2VAcLBZtQjN5ANVnedoH9IHsAjJJ
	op+x8M/ZMAD2bMQgqNgR4FnRiMCNGEjp//oKoHaJIJkIwcmEz+Jc
X-Google-Smtp-Source: AGHT+IHpJqlbMNXPksDuY1MKu0WkYvo9ZpkHaDF3AK8xuBta1U0uxuEq7LDL/fezWumKJT+RiXPYTA==
X-Received: by 2002:a17:90b:3c50:b0:2a2:19f:dbc7 with SMTP id pm16-20020a17090b3c5000b002a2019fdbc7mr2203477pjb.0.1711704018727;
        Fri, 29 Mar 2024 02:20:18 -0700 (PDT)
Received: from PC-YLX4GJ2P.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id n16-20020a17090ac69000b002a06260ac96sm2639704pjt.16.2024.03.29.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:20:18 -0700 (PDT)
From: Chunxin Zang <spring.cxz@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com,
	zhouchunhua@lixiang.com,
	zangchunxin@lixiang.com,
	Chunxin Zang <spring.cxz@gmail.com>
Subject: [PATCH] sched/fair: Reset vlag in dequeue when PLAGE_LAG is disabled
Date: Fri, 29 Mar 2024 17:19:33 +0800
Message-Id: <20240329091933.340739-1-spring.cxz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vlag is calculated in dequeue when PLAGE_LAG is disabled. If we
enable the PLACE_LAG at some point, the old vlag of process will
affect itself and other process. These are not in line with our
original intention, where we expect the vlag of all processes to be
calculated from 0 after the enable PLAGE_LAG.

Reviewed-by: Chen Yang <yangchen11@lixiang.com>
Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
---
 kernel/sched/fair.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..bc103a1ee78a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3798,16 +3798,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	if (!se->on_rq) {
+	if (sched_feat(PLACE_LAG) && !se->on_rq) {
 		/*
 		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
 		 * we need to scale se->vlag when w_i changes.
 		 */
 		se->vlag = div_s64(se->vlag * se->load.weight, weight);
-	} else {
-		reweight_eevdf(cfs_rq, se, weight);
 	}
 
+	if (se->on_rq)
+		reweight_eevdf(cfs_rq, se, weight);
+
 	update_load_set(&se->load, weight);
 
 #ifdef CONFIG_SMP
@@ -5382,7 +5383,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	update_entity_lag(cfs_rq, se);
+	if (sched_feat(PLACE_LAG))
+		update_entity_lag(cfs_rq, se);
+	else
+		se->vlag = 0;
+
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
-- 
2.34.1


