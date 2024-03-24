Return-Path: <linux-kernel+bounces-112671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69F887CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B447C1F21492
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB517BB7;
	Sun, 24 Mar 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaCp6Cao"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA917559;
	Sun, 24 Mar 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711284157; cv=none; b=a79cFKuehMA3JlzhB4LIHfaLFwSDfy157NKLWKLV2HsE1ddUy4DTlFz+k9db9xcusBs1BR90DBE9CUB/3Ha29FQA7RS7vlek0mJD2HFdh9t2Kas6/j5bThgcv6db9QUH4Pl2hdyN/ROAu9eF7dVoilz/FUJLnEoRhJeFOKKnGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711284157; c=relaxed/simple;
	bh=/LdDrqL1Wm8W/i5SpjqNyiuDEMlyviBCIQ+tYK2m1Tw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EPJ+7dZaGgKzOcupWckORaOzdOS8vucAfhATGDdJvwUE48p/QJ0w70ju5kFRRCdJ/VnAOL1wrrc7/cqAjDE4J98inRtAiCNqJocpSxwICVp0aVsrhUjtrUB6V+ig3DMIOZArkTKolUFVZHo6O2cg6nWBy1dyujSk1eHauRqi/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaCp6Cao; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1def59b537cso20382665ad.2;
        Sun, 24 Mar 2024 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711284155; x=1711888955; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwcQYoh+U3Qtxf8QLgv1iNR4Tar3oUHwb88w3qHC/DQ=;
        b=iaCp6Caok/w7VDvVK6ccxTMRIDDkt/t7zW+5Ly08EXjVIzzacUBKxtxyelL5D5ZFtd
         ohGZ7eyQA5nmaba2WyVir+Qv/kPP7v3KDXy+Mh8C8sld52VHyl1lON12K4uj8bIWl2Ye
         6KVCq5flvWEmVWPqGdlc3VbarhMx0xAlBx+UdLWMlbpacEuXQyrtToHsYynUuB4Cvi9r
         amvIllO4sglEi30EmQVOHMrTX+F3Dgw+5T+vbAzMx/0M83v1xVpsxaOPoBnzLfRhk9e2
         fj236uUNN5uzhHPt4TvDA0wmcjVr+Rb5AX8v/SwxxsocCRw70HsWrSFPd+4uEXN3Kl6H
         6ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711284155; x=1711888955;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwcQYoh+U3Qtxf8QLgv1iNR4Tar3oUHwb88w3qHC/DQ=;
        b=cO2hZ1yV4aFZljpcxQzqJQcElCBBi8fMDwd+ijPb0ZpQmbam5OsaKnBv0JeHDzyXB9
         /wGiViJ9wYXlrsbr59DFFHs8hIMrVMH5cLyTZlRM7NO96D97dF8ybiHAKA2HANiO8nX/
         Smcc2/krQy5h/Hja4Uk279jxQX3etIJWRZ2uxSbAFIDMe13YTCriT7WRlbgyOL0Wkzcc
         9o4mDBAn+GQfyaDhaAVtVrnzk0GeTf+9JeZqoy1X2IzD/mh1820Gt7ZrpMlxeRMFBFo3
         g2xh34nf3608YagnBbE4yzfWfOKiUZZupJlak2jL2AXmRW2dPl5rmTas8Is3eV5+iftQ
         JPQw==
X-Forwarded-Encrypted: i=1; AJvYcCXj2iSTcUc2ESVeBLJ/INHUsL5C3xeTchmbhbzLiB/ULSaenbp/C3AN02yBd2tc4ULZEionQNwjC6bGk08517m2s7f3SIctyWG6myOXYuhqkDfd4TaiL9ljXy0i0V7UapZ+
X-Gm-Message-State: AOJu0YzSJB2pbRiJ8wGFuKOjqYyV4TJwGgP276xLVkKrkYBpDlgpXVch
	bmAr7bI2yqAsId2PH8NOVuW1A7INQKp2RF0u+5/GSQ7ScSsN5hVb
X-Google-Smtp-Source: AGHT+IHMjzefvxPOcEv9hVJfYlmRyEJEmQnm4OuMryHuGZmnO5GNRQYRjfLnWo/y2eDGCzy8nZdOhQ==
X-Received: by 2002:a17:903:1208:b0:1dd:a108:b68b with SMTP id l8-20020a170903120800b001dda108b68bmr4928352plh.9.1711284154730;
        Sun, 24 Mar 2024 05:42:34 -0700 (PDT)
Received: from localhost.localdomain ([120.244.141.242])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b001e0adef698asm1798342plg.230.2024.03.24.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 05:42:34 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Make rcutorture support srcu double call test
Date: Sun, 24 Mar 2024 20:42:24 +0800
Message-Id: <20240324124224.615-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit also allows rcutorture to support srcu double call test
with CONFIG_DEBUG_OBJECTS_RCU_HEAD option enabled. since the spinlock
will be called in call_srcu(), in RT-kernel, the spinlock is sleepable,
therefore remove disable-irq and disable-preempt protection.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3f9c3766f52b..6571a69142f8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -388,6 +388,7 @@ struct rcu_torture_ops {
 	int extendables;
 	int slow_gps;
 	int no_pi_lock;
+	int debug_objects;
 	const char *name;
 };
 
@@ -573,6 +574,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
+	.debug_objects		= 1,
 	.name			= "rcu"
 };
 
@@ -743,6 +745,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
+	.debug_objects	= 1,
 	.name		= "srcu"
 };
 
@@ -782,6 +785,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
+	.debug_objects	= 1,
 	.name		= "srcud"
 };
 
@@ -3481,35 +3485,37 @@ static void rcu_test_debug_objects(void)
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	struct rcu_head rh1;
 	struct rcu_head rh2;
+	int idx;
+
+	if (!cur_ops->debug_objects || !cur_ops->call ||
+			!cur_ops->cb_barrier)
+		return;
+
 	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 
 	init_rcu_head_on_stack(&rh1);
 	init_rcu_head_on_stack(&rh2);
-	pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
+	pr_alert("%s: WARN: Duplicate call_%s() test starting.\n", KBUILD_MODNAME, cur_ops->name);
 
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
-	preempt_disable(); /* Prevent preemption from interrupting test. */
-	rcu_read_lock(); /* Make it impossible to finish a grace period. */
-	call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
-	local_irq_disable(); /* Make it harder to start a new grace period. */
-	call_rcu_hurry(&rh2, rcu_torture_leak_cb);
-	call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	idx = cur_ops->readlock(); /* Make it impossible to finish a grace period. */
+	cur_ops->call(&rh1, rcu_torture_leak_cb); /* Start grace period. */
+	cur_ops->call(&rh2, rcu_torture_leak_cb);
+	cur_ops->call(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
 	if (rhp) {
-		call_rcu_hurry(rhp, rcu_torture_leak_cb);
-		call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+		cur_ops->call(rhp, rcu_torture_leak_cb);
+		cur_ops->call(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
 	}
-	local_irq_enable();
-	rcu_read_unlock();
-	preempt_enable();
+	cur_ops->readunlock(idx);
 
 	/* Wait for them all to get done so we can safely return. */
-	rcu_barrier();
-	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
+	cur_ops->cb_barrier();
+	pr_alert("%s: WARN: Duplicate call_%s() test complete.\n", KBUILD_MODNAME, cur_ops->name);
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
 	kfree(rhp);
 #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
+	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n", KBUILD_MODNAME, cur_ops->name);
 #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 }
 
-- 
2.17.1


