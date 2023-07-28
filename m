Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D476767239
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjG1Qn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjG1Qm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:42:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EF910F9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7748ca56133so22690939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690562569; x=1691167369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IWyuICOqdD99scZWz5YBmXli6kjkGIoPuZY8ce+o9s=;
        b=IhjMmRjWzjaP+W+W8beG37/ey8xKQzl2UDPk8dq4Di6aPaecAKUbMF6tPz4poXAP/A
         dBalPK12CUy/nTOhDvhkq44mLP/imORnLSDPvct+yQTmL/3w8+/gCss5zvkrSsDkimkN
         G0Isr0ckjR5bGBZ15KgvigMk5TXxkb9luuF0sDPiTOmXLJ9AB3kYMCnZthEoMT7UqMvJ
         5Mvqby+93gDIRseQdMraLEI+PQoi3R0znkV0qUEjT75Cwl6C8BJJJZ+DLYM3B/s19LPK
         WA1ok7IfO40y81DuOpIUTtrKmg2NI5U0aLBomyc2oHKUGxo02EvHT/asyNMG7jVIO4VY
         9Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562569; x=1691167369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IWyuICOqdD99scZWz5YBmXli6kjkGIoPuZY8ce+o9s=;
        b=ENUy0Qa2MI8pjHMlRePvTx4vIm4qUjo8Kfs683Ack1WEysD/N56eJoszSstmipiNDp
         tPgJN2KY52c4wYC2r0mwckRT7mZ7TsI9XtJ9fgzGMorDEO3foA6MRNkThSvADYAb/MI9
         Lq6S8uUPfGBZRSoFINeNkaazTV42ZW8zJMqf03dXcHArcXHMIu+c6e3HMoEztvLlpcW5
         WYdK86GHKJSnPzXRWt7Zd1SfYWirlnEf8359JHPXcoc1UBzGZTiKo/r9Q3S9Xdy3cVe3
         UrSDYLYv2VOEm6l2g84Uciv5ltVSaAlGTLcCP1XiLTonrN/Tie+Jpmi43QHBGulULSyT
         aYWQ==
X-Gm-Message-State: ABy/qLaC2YZ3c3Ny1wIUjEgJnmPShybVcYfb0Nodvc6vUZ+sRbhiPC2c
        sfydgFsHm60eswurraRSI2EFkj3IPXGd8g5RcWk=
X-Google-Smtp-Source: APBJJlHWkBxXOEDcpcpa7eTcGp4YgZG9tsH9Ht/clmWI2DPDvovcbEjwXkqL8ntZBdoGuysIxVRd0w==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr119853iov.1.1690562569351;
        Fri, 28 Jul 2023 09:42:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1158808jal.136.2023.07.28.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:42:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, andres@anarazel.de, tglx@linutronix.de,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/12] futex: make the vectored futex operations available
Date:   Fri, 28 Jul 2023 10:42:34 -0600
Message-Id: <20230728164235.1318118-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728164235.1318118-1-axboe@kernel.dk>
References: <20230728164235.1318118-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename unqueue_multiple() as futex_unqueue_multiple(), and make both
that and futex_wait_multiple_setup() available for external users. This
is in preparation for wiring up vectored waits in io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/futex/futex.h    |  5 +++++
 kernel/futex/waitwake.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 6a13275ca231..b099b849aecb 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -360,6 +360,11 @@ extern int futex_parse_waitv(struct futex_vector *futexv,
 			     unsigned int nr_futexes, futex_wake_fn *wake,
 			     void *wake_data);
 
+extern int futex_wait_multiple_setup(struct futex_vector *vs, int count,
+				     int *woken);
+
+extern int futex_unqueue_multiple(struct futex_vector *v, int count);
+
 extern int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
 			       struct hrtimer_sleeper *to);
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 86f67f652b95..6c8fb7300558 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -369,7 +369,7 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 }
 
 /**
- * unqueue_multiple - Remove various futexes from their hash bucket
+ * futex_unqueue_multiple - Remove various futexes from their hash bucket
  * @v:	   The list of futexes to unqueue
  * @count: Number of futexes in the list
  *
@@ -379,7 +379,7 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
  *  - >=0 - Index of the last futex that was awoken;
  *  - -1  - No futex was awoken
  */
-static int unqueue_multiple(struct futex_vector *v, int count)
+int futex_unqueue_multiple(struct futex_vector *v, int count)
 {
 	int ret = -1, i;
 
@@ -407,7 +407,7 @@ static int unqueue_multiple(struct futex_vector *v, int count)
  *  -  0 - Success
  *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
  */
-static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *woken)
+int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *woken)
 {
 	struct futex_hash_bucket *hb;
 	bool retry = false;
@@ -469,7 +469,7 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
 		 * was woken, we don't return error and return this index to
 		 * userspace
 		 */
-		*woken = unqueue_multiple(vs, i);
+		*woken = futex_unqueue_multiple(vs, i);
 		if (*woken >= 0)
 			return 1;
 
@@ -554,7 +554,7 @@ int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
 
 		__set_current_state(TASK_RUNNING);
 
-		ret = unqueue_multiple(vs, count);
+		ret = futex_unqueue_multiple(vs, count);
 		if (ret >= 0)
 			return ret;
 
-- 
2.40.1

