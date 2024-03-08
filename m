Return-Path: <linux-kernel+bounces-97398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 173148769FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AFB21936
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765DF5916F;
	Fri,  8 Mar 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1gQq0Ef"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207154BC1;
	Fri,  8 Mar 2024 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919260; cv=none; b=KGuTQFDKzqLBQCqeHBbl4nm7NpheP/Y6IxLbOjq+tEvWDf2CD+g07F/IVl7rPeHqtvlv4mz6XY/9kifSXsjzOkBjyjrUy+sykgBZa09h3Qny1+YkbYd/wbor4xyyJl17OfBMIUDmIWKK62fOroktsAJwFnnxrviCSQ7+VgswEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919260; c=relaxed/simple;
	bh=v+sxR+Ob4ZQPLQ09ulDfHwcTMlnB/RStbMjd236wci8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjDqDylajryT2ST+6KO4d/GGjNV4hI0QmXKyB3sOseqQ/TrPb+eVempm6qBbyf5NZ5btOSBKNWCLgis5EE0e+ZwhI/qKN34K3N8bzNoJDgdCWFDfk+ZghJ4ofsdehfdl8RLCoouDZl36flQyoFDCqxkeYCXFlF0MfMczJ3nekS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1gQq0Ef; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51340e89df1so2514387e87.1;
        Fri, 08 Mar 2024 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919257; x=1710524057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQxHmqgduMjmouOggzpR5Nl/EtQ16DC5+fzglQp0ujU=;
        b=U1gQq0EfO2xQ9QsFXklSTXUPSa5wipTXiGWQaJrIMf5OsYKwQ1Hwr9ZFfJLuOjnooW
         WMoxS2E1rY41sI75Og/FjXqXuIzefL8VnfYZlfh5/AY2jZezqT1JmblvOz5mvBMg9rEA
         /vJ2cgF1AYPuyeDBBJHjJZzDEDAaHdduX1cG+EgIMXBHbrs4zK3pCIz/tbNxck01PcXK
         OcvX8I7KMr+GS/n5xjMZbfOsW1nUAQHvuWEjCrqpks0jbZb3UKgckMObIvDOMnvMXoRY
         YVX6RK8LvhXh9qhhwwoJn7Rz0X+OAcpVY8s7Ud072HSbAdk0VYi4RYKnKqh6RXpISldW
         nGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919257; x=1710524057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQxHmqgduMjmouOggzpR5Nl/EtQ16DC5+fzglQp0ujU=;
        b=V42b++bqXx2S7fNsDrYKuKrgcr+kEEO6rejgFF3MRVl+rx9yNo9O2gqb+Gt27RCbSV
         XlP/PJpdbeb7l1fAyMsEftQ8a6piYyw5nSB9g44fi04iTYledwTiPeCxKV26J/otdrmQ
         zruO5KlAO68f7VrGv6SSHedXtqVTuL8T2Nhy76wsYUrVR8ymeOmg8txvENH7JpFG1GXS
         hs7EK2PXjojJRkdAFCXgVhPTQwhZgw1EsefWNfG3ViEH88fweBvKZECTlfA99VSIhD3z
         DhB/cjeQwUNB8/b1y7nSOsAbXi68iUxYEqGCkyoxdC9O6jNDe0nAB87mejnKwd6A8LNx
         mLOw==
X-Forwarded-Encrypted: i=1; AJvYcCVw2vqc6MaLnCYc4A3lNSduUTFgdxQ6IerOSMV8+aNd1BoiAHWF0E36RBr/8avoqst5x3b2KUVHGedgwcKb5bJjzxem9FZUPvYKg5Hc
X-Gm-Message-State: AOJu0YzXEGMvw9yYyrKI1a7rA4XC93Id6BPJxtleCtYI+e1R12dtSm/O
	tfkfDq5k6dyPWbykzzWWqN4aU0/ovghOIWdEj5wRMpcnbRpl07mB
X-Google-Smtp-Source: AGHT+IE5WRbqVE9uNkknnNbc6iyH+E0ACPKnVHNkrm+ZiUnPl2tgqWmTBO//NvpQNPmCgJVsQcKczA==
X-Received: by 2002:a05:6512:238f:b0:512:b27c:18b5 with SMTP id c15-20020a056512238f00b00512b27c18b5mr6044752lfv.30.1709919256950;
        Fri, 08 Mar 2024 09:34:16 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a23-20020a195f57000000b0051333e2f55dsm3150504lfj.159.2024.03.08.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:34:16 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v6 5/6] rcu: Do not release a wait-head from a GP kthread
Date: Fri,  8 Mar 2024 18:34:08 +0100
Message-Id: <20240308173409.335345-6-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308173409.335345-1-urezki@gmail.com>
References: <20240308173409.335345-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a below race by not releasing a wait-head from the
GP-kthread as it can lead for reusing it whereas a worker
can still access it thus execute newly added callbacks too
early.

CPU 0                              CPU 1
-----                              -----

// wait_tail == HEAD1
rcu_sr_normal_gp_cleanup() {
    // has passed SR_MAX_USERS_WAKE_FROM_GP
    wait_tail->next = next;
    // done_tail = HEAD1
    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
    queue_work() {
        test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
        __queue_work()
    }
}

                               set_work_pool_and_clear_pending()
                               rcu_sr_normal_gp_cleanup_work() {
// new GP, wait_tail == HEAD2
rcu_sr_normal_gp_cleanup() {
    // executes all completion, but stop at HEAD1
    wait_tail->next = HEAD1;
    // done_tail = HEAD2
    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
    queue_work() {
        test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
        __queue_work()
    }
}
                                 // done = HEAD2
                                 done = smp_load_acquire(&rcu_state.srs_done_tail);
                                 // head = HEAD1
                                 head = done->next;
                                 done->next = NULL;
                                 llist_for_each_safe() {
                                 // completes all callbacks, release HEAD1
                                 }
                               }
                               // Process second queue
                               set_work_pool_and_clear_pending()
                               rcu_sr_normal_gp_cleanup_work() {
                               // done = HEAD2
                               done = smp_load_acquire(&rcu_state.srs_done_tail);

// new GP, wait_tail == HEAD3
rcu_sr_normal_gp_cleanup() {
    // Finds HEAD2 with ->next == NULL at the end
    rcu_sr_put_wait_head(HEAD2)
    ...

// A few more GPs later
rcu_sr_normal_gp_init() {
     HEAD2 = rcu_sr_get_wait_head();
     llist_add(HEAD2, &rcu_state.srs_next);
                               // head == rcu_state.srs_next
                               head = done->next;
                               done->next = NULL;
                               llist_for_each_safe() {
                                // EXECUTE CALLBACKS TOO EARLY!!!
                                }
                               }

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 063200613444..d854115ff11f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1684,21 +1684,11 @@ static void rcu_sr_normal_gp_cleanup(void)
 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
 
 	/*
-	 * Process (a) and (d) cases. See an illustration. Apart of
-	 * that it handles the scenario when all clients are done,
-	 * wait-head is released if last. The worker is not kicked.
+	 * Process (a) and (d) cases. See an illustration.
 	 */
 	llist_for_each_safe(rcu, next, wait_tail->next) {
-		if (rcu_sr_is_wait_head(rcu)) {
-			if (!rcu->next) {
-				rcu_sr_put_wait_head(rcu);
-				wait_tail->next = NULL;
-			} else {
-				wait_tail->next = rcu;
-			}
-
+		if (rcu_sr_is_wait_head(rcu))
 			break;
-		}
 
 		rcu_sr_normal_complete(rcu);
 		// It can be last, update a next on this step.
@@ -1712,8 +1702,12 @@ static void rcu_sr_normal_gp_cleanup(void)
 	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
-	if (wait_tail->next)
-		schedule_work(&rcu_state.srs_cleanup_work);
+	/*
+	 * We schedule a work in order to perform a final processing
+	 * of outstanding users(if still left) and releasing wait-heads
+	 * added by rcu_sr_normal_gp_init() call.
+	 */
+	schedule_work(&rcu_state.srs_cleanup_work);
 }
 
 /*
-- 
2.39.2


