Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BA87999ED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjIIQ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346566AbjIIPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:11:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6931A8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 08:11:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68cb5278e3fso541769b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694272297; x=1694877097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N80d9tTOx+El+oLA0rnxQkY/Mmp5aWij6wuZoA1slCQ=;
        b=W0UA1F0LmeyPXK9OOOWoqe1CsQ20kSS7RY4kC6KD+NlIj96ngGiXjNv6GQib81YXkt
         z7zorI+wGI3hx7z0Y7SgOZJoqSY+tE5eSZRVVUHSKE1WDnLhgSrv0O1TlskNtBC7EGRb
         ZC0hRTf3Pr/74h+WVI7ECmJ19slIbHL3v3/+g8ALEia/HvNE3MHc0d3TxvbKbv/y8ABb
         /+84tzWmjbmZvgIoIzrS3sf5cDwJ6fDnUVfa0bvZxfug9b8aYLoIABNQnwe2uDyp+iBQ
         RkR4D0oR+d91c2XP5SC/iqVrXleSgJHjmqrsdH5PkJE87vpsIBsUiTlHoRJW9UfjdjZl
         abnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694272297; x=1694877097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N80d9tTOx+El+oLA0rnxQkY/Mmp5aWij6wuZoA1slCQ=;
        b=vZltVlvFvaIMgjmnbP6j/4RdSiYjRBHTF/QJKbD8m4UC4hYQIjhSWmkl0eVpdWpgkq
         cGHdg9+3W1iNSzsJx0DktoLOUjmKeJTXrmt5NTCKBC3eYqkzAds2lFhl8JLyOc8JNaPs
         1vHKKv/B+9BO/iyiOeeEo7EWvX24Gbo/XEIsPenpvBdXBP2LEB38hXp1lda9+ehezOqC
         3es5A9eHPSPrBtdTpQvCszSSjpn/9V4j0w2zRjyiK0ZUe3q7sBxjgxAoBmJfWuFSkxTP
         SEv90i7+CTgRlN29IxNNG4lccUWI9WHV4aQYCqdG5Vyh8Xy+2IGfHiViht6qXXV62270
         9Gzw==
X-Gm-Message-State: AOJu0YzBH6PmUHGBsRVB40avj8rTnEoBVxaL1uZ1pLWw3LvYacGlllD0
        aLT7tPqJ6Gs5Cx24xGr9sa5TxA==
X-Google-Smtp-Source: AGHT+IGH9fgouXg2YBTnJXGivErYDAyvzSDZR9rIrEEN7fQIm+/icgytxet8dyRfHPzNgpRaUyC33w==
X-Received: by 2002:a17:903:2448:b0:1c1:ee23:bb75 with SMTP id l8-20020a170903244800b001c1ee23bb75mr6415625pls.1.1694272297037;
        Sat, 09 Sep 2023 08:11:37 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ff0f00b001bdb0483e65sm3371450plj.265.2023.09.09.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 08:11:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     brauner@kernel.org, arnd@arndb.de, asml.silence@gmail.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] exit: move core of do_wait() into helper
Date:   Sat,  9 Sep 2023 09:11:21 -0600
Message-Id: <20230909151124.1229695-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909151124.1229695-1-axboe@kernel.dk>
References: <20230909151124.1229695-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have a maze of gotos, put the actual logic in __do_wait()
and have do_wait() loop deal with waitqueue setup/teardown and whether
to call __do_wait() again.

No functional changes intended in this patch.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/exit.c | 51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 2809dad69492..c6fba9ecca27 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1590,16 +1590,10 @@ static int do_wait_pid(struct wait_opts *wo)
 	return 0;
 }
 
-static long do_wait(struct wait_opts *wo)
+static long __do_wait(struct wait_opts *wo)
 {
-	int retval;
-
-	trace_sched_process_wait(wo->wo_pid);
+	long retval;
 
-	init_waitqueue_func_entry(&wo->child_wait, child_wait_callback);
-	wo->child_wait.private = current;
-	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
-repeat:
 	/*
 	 * If there is nothing that can match our criteria, just get out.
 	 * We will clear ->notask_error to zero if we see any child that
@@ -1611,24 +1605,23 @@ static long do_wait(struct wait_opts *wo)
 	   (!wo->wo_pid || !pid_has_task(wo->wo_pid, wo->wo_type)))
 		goto notask;
 
-	set_current_state(TASK_INTERRUPTIBLE);
 	read_lock(&tasklist_lock);
 
 	if (wo->wo_type == PIDTYPE_PID) {
 		retval = do_wait_pid(wo);
 		if (retval)
-			goto end;
+			return retval;
 	} else {
 		struct task_struct *tsk = current;
 
 		do {
 			retval = do_wait_thread(wo, tsk);
 			if (retval)
-				goto end;
+				return retval;
 
 			retval = ptrace_do_wait(wo, tsk);
 			if (retval)
-				goto end;
+				return retval;
 
 			if (wo->wo_flags & __WNOTHREAD)
 				break;
@@ -1638,14 +1631,32 @@ static long do_wait(struct wait_opts *wo)
 
 notask:
 	retval = wo->notask_error;
-	if (!retval && !(wo->wo_flags & WNOHANG)) {
-		retval = -ERESTARTSYS;
-		if (!signal_pending(current)) {
-			schedule();
-			goto repeat;
-		}
-	}
-end:
+	if (!retval && !(wo->wo_flags & WNOHANG))
+		return -ERESTARTSYS;
+
+	return retval;
+}
+
+static long do_wait(struct wait_opts *wo)
+{
+	int retval;
+
+	trace_sched_process_wait(wo->wo_pid);
+
+	init_waitqueue_func_entry(&wo->child_wait, child_wait_callback);
+	wo->child_wait.private = current;
+	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
+
+	do {
+		set_current_state(TASK_INTERRUPTIBLE);
+		retval = __do_wait(wo);
+		if (retval != -ERESTARTSYS)
+			break;
+		if (signal_pending(current))
+			break;
+		schedule();
+	} while (1);
+
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 	return retval;
-- 
2.40.1

