Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19699767238
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjG1Qnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjG1Qm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:42:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD14223
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77dcff76e35so28574539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690562568; x=1691167368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O15ZlJlMRRtfXuiAf9H5Y3NU4zBlFmFQB8XZUfTXeI4=;
        b=jVw7OGLEOwjjGVchaN6wX+a8JIucwVplUbPRiAybz25B+NvXLDyU7MPnQhfWGs38Or
         tly/xPZ68rh/HXSyZLyh3dB+QhVmCvxvAMdiAkX5xtV2698P8H6YoT3P6K7zlCkWg5Pe
         KSMOqbCNSDEgaXVZNh17+j4Kh8wTkzvWbeWeSYy0FtXgwM4clwYUefYE3YOZAuyyOl/s
         4bjBIQnHWNdnJV45lXmC8uf5CAEFRkgEg2v6HUd/Pj5BwKCAlOJ3RC3gz879bN+YOl70
         TFXw6nnIQOKHcQKkQX1en86DI89y3zVQKOzMra3/Na90JNMsKytK/54b8vOihTV9bhiE
         mI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562568; x=1691167368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O15ZlJlMRRtfXuiAf9H5Y3NU4zBlFmFQB8XZUfTXeI4=;
        b=TXhOsfiJTu//JR9u7gODF+ZQm3FTzg9iZQxH/2jO2/jYTFA6tLm4sFhZMDjLOhfm+b
         jQP5ctbsuWtwi17mxQzJ/ytoDGbfZM1vgyYHLDrKrUDq+M69RRBEYfOMMgxJwXztBbY1
         ++HergkKwM6Df0szDbUU+nPH1qLxOBcgN7nVFfOyWXmq8RScuRUI1rmMGv43s5JPUujE
         01d9qQE3rM3pTpGpdiSgo++Vw6waQvhgNLWi7q8cdE5h0Yp0YDshQlysZqtjw+fCU0I8
         YDPnKytfecpNGF5PiRg//Ke9clbJ9WZo+sWV/ycSQwzFJHZf6LFvVeAR6rZVLwcD34aR
         YzwA==
X-Gm-Message-State: ABy/qLbS+rtXAk/oVe/VgL138++/CiKIDMACVT7xYhS5REEVxGnFQOrb
        m6SSX8GGvpV+5T77RMV88Smcgw==
X-Google-Smtp-Source: APBJJlGKlSXFxFxxRloaX5Gi5aKRPavKM4FCE0fJPAcWwlHsa0M1NoWfz6vJ0S3r82zpEeCfr/rQRg==
X-Received: by 2002:a6b:b797:0:b0:783:63e8:3bfc with SMTP id h145-20020a6bb797000000b0078363e83bfcmr116801iof.0.1690562567714;
        Fri, 28 Jul 2023 09:42:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1158808jal.136.2023.07.28.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:42:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, andres@anarazel.de, tglx@linutronix.de,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/12] futex: make futex_parse_waitv() available as a helper
Date:   Fri, 28 Jul 2023 10:42:33 -0600
Message-Id: <20230728164235.1318118-11-axboe@kernel.dk>
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

To make it more generically useful, augment it with allowing the caller
to pass in the wake handler and wake data. Convert the futex_waitv()
syscall, passing in the default handlers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/futex/futex.h    |  5 +++++
 kernel/futex/syscalls.c | 14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 4633c99ea4b6..6a13275ca231 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -355,6 +355,11 @@ struct futex_vector {
 	struct futex_q q;
 };
 
+extern int futex_parse_waitv(struct futex_vector *futexv,
+			     struct futex_waitv __user *uwaitv,
+			     unsigned int nr_futexes, futex_wake_fn *wake,
+			     void *wake_data);
+
 extern int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
 			       struct hrtimer_sleeper *to);
 
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 221c49797de9..bbb3b3ceef51 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -184,12 +184,15 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
  * @futexv:	Kernel side list of waiters to be filled
  * @uwaitv:     Userspace list to be parsed
  * @nr_futexes: Length of futexv
+ * @wake:	Wake to call when futex is woken
+ * @wake_data:	Data for the wake handler
  *
  * Return: Error code on failure, 0 on success
  */
-static int futex_parse_waitv(struct futex_vector *futexv,
-			     struct futex_waitv __user *uwaitv,
-			     unsigned int nr_futexes)
+int futex_parse_waitv(struct futex_vector *futexv,
+		      struct futex_waitv __user *uwaitv,
+		      unsigned int nr_futexes, futex_wake_fn *wake,
+		      void *wake_data)
 {
 	struct futex_waitv aux;
 	unsigned int i;
@@ -214,6 +217,8 @@ static int futex_parse_waitv(struct futex_vector *futexv,
 		futexv[i].w.val = aux.val;
 		futexv[i].w.uaddr = aux.uaddr;
 		futexv[i].q = futex_q_init;
+		futexv[i].q.wake = wake;
+		futexv[i].q.wake_data = wake_data;
 	}
 
 	return 0;
@@ -290,7 +295,8 @@ SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
 		goto destroy_timer;
 	}
 
-	ret = futex_parse_waitv(futexv, waiters, nr_futexes);
+	ret = futex_parse_waitv(futexv, waiters, nr_futexes, futex_wake_mark,
+				NULL);
 	if (!ret)
 		ret = futex_wait_multiple(futexv, nr_futexes, timeout ? &to : NULL);
 
-- 
2.40.1

