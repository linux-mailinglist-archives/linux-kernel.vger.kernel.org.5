Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB69811CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjLMSjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjLMSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:39:00 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B9C116;
        Wed, 13 Dec 2023 10:39:02 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58ceab7daddso3134636eaf.3;
        Wed, 13 Dec 2023 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702492741; x=1703097541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNurO2RUnEzKo4ZS8HOimOcXuDT2A2EtiRl1qsSi+WE=;
        b=bX+E2bqAO9MGAx+W81g+1R49Ras0p7oBYirKD6USexGbUOIeAKryi1aIGQJLjnmI/E
         aH1yCm5iOj3ouISJODnOsr7b1dIWr7NCsMY9uv3pojl4oCLxJwV6j4xsXwskIOvp43vD
         sUGgu56mXUI2pAue4mn3dAzNvmBZNZeb5bsWErmpa64b5mRelhQiKYM96pXxSuT51jRg
         lUnenxtzelS4xfEt8CGvBrdINi+h+Tbe6r0/cmNm3yZZGP9gEVipjmApqT9Co6H/SlEN
         5g1K5CMK76ym+N+Asbyo2WJ54UtA1Wwpq1PIMrkCauEoktTiWeu2AhtjV/ErOoKUg3aG
         oPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492741; x=1703097541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNurO2RUnEzKo4ZS8HOimOcXuDT2A2EtiRl1qsSi+WE=;
        b=QlIuBF8Wmm7cLW363vM4GKPCsQtCh82X89OUvZMZ37vQPxpD68iw4OZAwAiktGQ21E
         JjGnUUNk77TroOKdYqcd+Q88atjs0AfPq/dB2lR2vS4u3ZxiXI0AXjDGLSbkG3LYZNVr
         2uT11UdLwwRChiI1aNtB1x8e2A8OLL5sL6klQuqV9/G4J42xdxtREVD/N1SzvmEjysfd
         bzQOmnE9vdzoRDX7I2ivp6G75DX6xxTy8PS6mQhOHO0DW7T8dzFewy9xLtdw/uxoOh/q
         obdTqToVbUouDVqvaeW9/HyKu67o9XrqARWY00A79vV4WXqjByheLW4ziH0HfgvC9qpX
         pylg==
X-Gm-Message-State: AOJu0YxxPvIgIZmbssC1v0Un5pMAlMjDL3glQAK5M3U8ZiDM5U6p7yMt
        8W/kIVPQ1rGhiH7kRgCULEtBRg9XRbtYiGfL
X-Google-Smtp-Source: AGHT+IGoPgsSzIDZXty3JpWjVN4Zx9Qy5YElEqStEHOl3F+ifcnvX7maL7VZZYoUMZWVeEerEpD2BA==
X-Received: by 2002:a05:6358:5e0f:b0:170:4208:ecc with SMTP id q15-20020a0563585e0f00b0017042080eccmr3385080rwn.5.1702492741037;
        Wed, 13 Dec 2023 10:39:01 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id k189-20020a6324c6000000b005bcea1bf43bsm9981750pgk.12.2023.12.13.10.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:39:00 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 4/3] srcu: Use try-lock lockdep annotation for NMI-safe access.
Date:   Wed, 13 Dec 2023 23:48:43 +0530
Message-Id: <20231213181843.12844-1-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212174750.GA11886@neeraj.linux>
References: <20231212174750.GA11886@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

It is claimed that srcu_read_lock_nmisafe() NMI-safe. However it
triggers a lockdep if used from NMI because lockdep expects a deadlock
since nothing disables NMIs while the lock is acquired.

This is because commit f0f44752f5f61 ("rcu: Annotate SRCU's update-side
lockdep dependencies") annotates synchronize_srcu() as a write lock
usage. This helps to detect a deadlocks such as
	srcu_read_lock();
	synchronize_srcu();
	srcu_read_unlock();

The side effect is that the lock srcu_struct now has a USED usage in normal
contexts, so it conflicts with a USED_READ usage in NMI. But this shouldn't
cause a real deadlock because the write lock usage from synchronize_srcu()
is a fake one and only used for read/write deadlock detection.

Use a try-lock annotation for srcu_read_lock_nmisafe() to avoid lockdep
complains if used from NMI.

Fixes: f0f44752f5f6 ("rcu: Annotate SRCU's update-side lockdep dependencies")
Link: https://lore.kernel.org/r/20230927160231.XRCDDSK4@linutronix.de
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 include/linux/rcupdate.h | 6 ++++++
 include/linux/srcu.h     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f7206b2623c9..31d523c4e089 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -301,6 +301,11 @@ static inline void rcu_lock_acquire(struct lockdep_map *map)
 	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
 }
 
+static inline void rcu_try_lock_acquire(struct lockdep_map *map)
+{
+	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
+}
+
 static inline void rcu_lock_release(struct lockdep_map *map)
 {
 	lock_release(map, _THIS_IP_);
@@ -315,6 +320,7 @@ int rcu_read_lock_any_held(void);
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 # define rcu_lock_acquire(a)		do { } while (0)
+# define rcu_try_lock_acquire(a)	do { } while (0)
 # define rcu_lock_release(a)		do { } while (0)
 
 static inline int rcu_read_lock_held(void)
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 127ef3b2e607..236610e4a8fa 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 
 	srcu_check_nmi_safety(ssp, true);
 	retval = __srcu_read_lock_nmisafe(ssp);
-	rcu_lock_acquire(&ssp->dep_map);
+	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
 }
 
-- 
2.40.1

