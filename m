Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB07A9A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjIUShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIUShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:37:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB4D8685
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:29:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34fcb08d1d5so1009155ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695320962; x=1695925762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/OGVEqmKZ+YrEmaYsT23Mong0SvETBYb//Qn3SwQyE=;
        b=ouP89gePGLkXltybMGwkkustlfFAplUbJ4vP8U3TPcA3954wsu06QRtfnzwyvbYSYs
         QTVHkUdd32WVcNpJRncn7PZABjuOL6kSBVZA5/n2nwrpfc7UspeBjKI2sCPmEM3Kt5zW
         wHrwgAgk5ePJk4X5bYIyrevgGO5xLjj+P3TuE6Qn0T6aZvpAevB2QEv5ucKh70Y5YtCh
         /pwmK27WAxolaya57PNG4z/YSDrVzW8q3s7bm6oHwrL/c2etyw+ELu4SDQrAtVbwrzqd
         XjerkcEb5mbjB9u9WLAcyoW3KquEhxUKzGQ3PT9ROfv2DZiDl01XgicGqolS6PWTRO1d
         XnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320962; x=1695925762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/OGVEqmKZ+YrEmaYsT23Mong0SvETBYb//Qn3SwQyE=;
        b=D8EmFImjnAgIi1Ucf3oaqHoszP8dD2ggW2d7BUBI2MRguwV8f9mqKGEV9fNV36COPo
         pCxxCoNX2TfRFFrja1B9xIOUJxfWL7d6oGFZ1BY+DLWZtcHXducSh9nYZt22gORvq9or
         4vdw5o3fIT6WyzVWMh/1+mvYf/P9EXvQzx8LnvtKocRyb3LgVOtBFAsNXWMiNfCPXUQ+
         uG2JphHY14+rDOSJ2mpnmaV9zkwtg5bZP0KejdXNlHFQMxC1FWSGzqJa6gLZ7CEzA4I4
         3nfrP35VqksvGHl2JvL68YkuqA48rasUY82uEuWDs+BduN2J+NcttQCZKdTbeIkGlTON
         VkqQ==
X-Gm-Message-State: AOJu0YzADdMIom8ckhNSDzF+aACwHRIaj8XTZ+zQ+uKIekIhDUg64gMH
        0wt34Me5XAzqOmP/tjthJw/koA2VwnYxtw7tiArfkw==
X-Google-Smtp-Source: AGHT+IH0d1Lv9v5XvuHBRWZ4j3Pa5hUPuJ0lr8dkl2Yd+m6TonTxY7UwEf5Qp3o95XPyf+oRWhbkLA==
X-Received: by 2002:a92:c52d:0:b0:34f:7ba2:50e8 with SMTP id m13-20020a92c52d000000b0034f7ba250e8mr6203745ili.2.1695320961817;
        Thu, 21 Sep 2023 11:29:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o25-20020a02c6b9000000b0042b227eb1ddsm500441jan.55.2023.09.21.11.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:29:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, andres@anarazel.de, tglx@linutronix.de,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] futex: make futex_parse_waitv() available as a helper
Date:   Thu, 21 Sep 2023 12:29:06 -0600
Message-Id: <20230921182908.160080-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230921182908.160080-1-axboe@kernel.dk>
References: <20230921182908.160080-1-axboe@kernel.dk>
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

To make it more generically useful, augment it with allowing the caller
to pass in the wake handler and wake data. Convert the futex_waitv()
syscall, passing in the default handlers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/futex/futex.h    |  5 +++++
 kernel/futex/syscalls.c | 16 +++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 76f6c2e0f539..6b6a6b3da103 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -361,6 +361,11 @@ struct futex_vector {
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
index 2b5cafdfdc50..4b6da9116aa6 100644
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
@@ -306,7 +311,8 @@ SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
 		goto destroy_timer;
 	}
 
-	ret = futex_parse_waitv(futexv, waiters, nr_futexes);
+	ret = futex_parse_waitv(futexv, waiters, nr_futexes, futex_wake_mark,
+				NULL);
 	if (!ret)
 		ret = futex_wait_multiple(futexv, nr_futexes, timeout ? &to : NULL);
 
@@ -421,7 +427,7 @@ SYSCALL_DEFINE4(futex_requeue,
 	if (!waiters)
 		return -EINVAL;
 
-	ret = futex_parse_waitv(futexes, waiters, 2);
+	ret = futex_parse_waitv(futexes, waiters, 2, futex_wake_mark, NULL);
 	if (ret)
 		return ret;
 
-- 
2.40.1

