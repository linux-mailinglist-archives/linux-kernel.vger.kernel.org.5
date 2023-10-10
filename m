Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3FF7BF7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjJJJyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjJJJxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:53:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F593
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696931631;
        bh=4A4lQw0bzjvSp3inwHoIDBZkp/sk/XTofAR80wJXCrI=;
        h=From:Date:Subject:To:Cc:From;
        b=MrPL7c5VVMa1tNrZbRrspP5Wp26n6h9sxp5FQGqLzjW+ntk0S/Y+Caatlye6iWUyX
         4RIR26CEtRgngBY0jxtrAxtGQREVTfzmKtn046zW8/lGMSUb2J0ez7gpCHL+nl5DWv
         sZgkyUgxasGI+1/9M9ti1XlKAVRxHv+q/MySFdRE=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 10 Oct 2023 11:53:42 +0200
Subject: [PATCH] locking/osq: remove spin node definition from header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-osq-header-v1-1-d68fbc1bf1cf@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACUfJWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0MD3fziQt2M1MSU1CJdy8TkRHNzCyDb2EAJqKGgKDUtswJsWHRsbS0
 Ay+m2UVwAAAA=
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696931630; l=1776;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4A4lQw0bzjvSp3inwHoIDBZkp/sk/XTofAR80wJXCrI=;
 b=5kSfQw2XT7Svl8Az/t3Y8YX5Vbsgd+NBLz/Etj4dXt94v7PgBGKJLTabpBpqlTrPY8ss9stq1
 P+9lxQHnVX8A+saRK57qQnrWPNne9QGS7GFwat+iMYgvtbiMQDPakv5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This structure is an implementation detail of osq_lock.c, and there are
no external users.

Also drop the redundant overview comment from osq_lock.c.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/osq_lock.h  | 5 -----
 kernel/locking/osq_lock.c | 9 ++++++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
index 5581dbd3bd34..ea8fb31379e3 100644
--- a/include/linux/osq_lock.h
+++ b/include/linux/osq_lock.h
@@ -6,11 +6,6 @@
  * An MCS like lock especially tailored for optimistic spinning for sleeping
  * lock implementations (mutex, rwsem, etc).
  */
-struct optimistic_spin_node {
-	struct optimistic_spin_node *next, *prev;
-	int locked; /* 1 if lock acquired */
-	int cpu; /* encoded CPU # + 1 value */
-};
 
 struct optimistic_spin_queue {
 	/*
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d5610ad52b92..918866edbc30 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -3,10 +3,13 @@
 #include <linux/sched.h>
 #include <linux/osq_lock.h>
 
+struct optimistic_spin_node {
+	struct optimistic_spin_node *next, *prev;
+	int locked; /* 1 if lock acquired */
+	int cpu; /* encoded CPU # + 1 value */
+};
+
 /*
- * An MCS like lock especially tailored for optimistic spinning for sleeping
- * lock implementations (mutex, rwsem, etc).
- *
  * Using a single mcs node per CPU is safe because sleeping locks should not be
  * called from interrupt context and we have preemption disabled while
  * spinning.

---
base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
change-id: 20231010-osq-header-9aca778ade30

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

