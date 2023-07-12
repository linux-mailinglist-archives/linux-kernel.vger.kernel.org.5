Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2CF750E41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjGLQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGLQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:21:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC02D41
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:20:27 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so65583439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689178825; x=1689783625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY5+GbYjkQ8F3AhNYX1zBu/AgfgWHjnN3p/L+7LXa1c=;
        b=tMY9eVMmmz14rAjujFwmQ7tYA7VhYA+ljVfRFj0f7oDFx2oXil3dyZoEITmL66l3ca
         B3uHHjN+lHI1xbcNSDywy3rbl0V1sDNze98IEVWF7nfpr0IwKdHab/epFZmefbqxyyOC
         EJkiSvROtPvLi57TDwILXVQJ45JX+80MKq1kQmyir9VReA2fXVERKLFTQCyZcAZW5TNL
         CTwAOANTAS1M3Dp+67LNFhUIPMa86maSCBpgl0OTed8pNeoubsdkgrT2Bj2HZ5+sIan9
         fx9oA/RGMoaAWiVDXthG/XEMXTQy0I9CeOsADG9bGnvCjqe8dV+v49YfUoADHbe2+1Um
         e6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178825; x=1689783625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY5+GbYjkQ8F3AhNYX1zBu/AgfgWHjnN3p/L+7LXa1c=;
        b=bV+X1VFRA3pkYgeyQR6Tfajfv4dNDXX7vWk7qvYkZy/H532pZBbK240BiEguKHM6DT
         S1i4cP4zV40X+LetrTrIkWv5oNtiUoSFjnaB/c11sWSUvZwevlVym68J2R6+vedKXBV2
         MIQeMY/JAelQYA7pQyfzzsloBHIj0HZCY2W7i5r5k00e+YaJilGnFREy2G/wPB4KalZX
         /LvPoKa1dATQfDgFudcKLG1HCQS51PTDoRRsKJkUAxh8Akz3tHdInCJBTIdaMUJofpS5
         Ze+u6Ss1J5Gl5kQ+EBIJ2hnnPzcltLtgDTVd3Wmyej/C5pCxmf5b/bxCnTDAbYcm3EJZ
         NE5w==
X-Gm-Message-State: ABy/qLY+yImDD0ekwOXUSL5gCWlX0dlPltGrX2kMgZCBToHZgvJpamBO
        5LW7TyX4h+D9w/t5Dt3hQNoiKpEmDQFk9Fv0Ojw=
X-Google-Smtp-Source: APBJJlH0YcxQzskAZgxY8LV2IoicfMMUMCI5mn4XoDC2tqZ8SyguVPAsdbUTEPFEr82tWRgbD8IT0A==
X-Received: by 2002:a05:6602:3993:b0:780:c6bb:ad8d with SMTP id bw19-20020a056602399300b00780c6bbad8dmr20527261iob.0.1689178825676;
        Wed, 12 Jul 2023 09:20:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x24-20020a029718000000b0042aec33bc26sm1328775jai.18.2023.07.12.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:20:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        andres@anarazel.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] futex: factor out the futex wake handling
Date:   Wed, 12 Jul 2023 10:20:11 -0600
Message-Id: <20230712162017.391843-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712162017.391843-1-axboe@kernel.dk>
References: <20230712162017.391843-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for having another waker that isn't futex_wake_mark(),
add a wake handler in futex_q. No extra data is associated with the
handler outside of struct futex_q itself. futex_wake_mark() is defined as
the standard wakeup helper, now set through futex_q_init like other
defaults.

Normal sync futex waiting relies on wake_q holding tasks that should
be woken up. This is what futex_wake_mark() does, it'll unqueue the
futex and add the associated task to the wake queue. For async usage of
futex waiting, rather than having tasks sleeping on the futex, we'll
need to deal with a futex wake differently. For the planned io_uring
case, that means posting a completion event for the task in question.
Having a definable wake handler can help support that use case.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/futex/futex.h    | 4 ++++
 kernel/futex/requeue.c  | 3 ++-
 kernel/futex/waitwake.c | 6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index b8f454792304..54b7de21ef00 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -69,6 +69,9 @@ struct futex_pi_state {
 	union futex_key key;
 } __randomize_layout;
 
+struct futex_q;
+typedef void (futex_wake_fn)(struct wake_q_head *wake_q, struct futex_q *q);
+
 /**
  * struct futex_q - The hashed futex queue entry, one per waiting task
  * @list:		priority-sorted list of tasks waiting on this futex
@@ -98,6 +101,7 @@ struct futex_q {
 
 	struct task_struct *task;
 	spinlock_t *lock_ptr;
+	futex_wake_fn *wake;
 	union futex_key key;
 	struct futex_pi_state *pi_state;
 	struct rt_mutex_waiter *rt_waiter;
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index cba8b1a6a4cc..e892bc6c41d8 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -58,6 +58,7 @@ enum {
 
 const struct futex_q futex_q_init = {
 	/* list gets initialized in futex_queue()*/
+	.wake		= futex_wake_mark,
 	.key		= FUTEX_KEY_INIT,
 	.bitset		= FUTEX_BITSET_MATCH_ANY,
 	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
@@ -591,7 +592,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 		/* Plain futexes just wake or requeue and are done */
 		if (!requeue_pi) {
 			if (++task_count <= nr_wake)
-				futex_wake_mark(&wake_q, this);
+				this->wake(&wake_q, this);
 			else
 				requeue_futex(this, hb1, hb2, &key2);
 			continue;
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index ba01b9408203..3471af87cb7d 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -174,7 +174,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
 
-			futex_wake_mark(&wake_q, this);
+			this->wake(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -289,7 +289,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 				ret = -EINVAL;
 				goto out_unlock;
 			}
-			futex_wake_mark(&wake_q, this);
+			this->wake(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -303,7 +303,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 					ret = -EINVAL;
 					goto out_unlock;
 				}
-				futex_wake_mark(&wake_q, this);
+				this->wake(&wake_q, this);
 				if (++op_ret >= nr_wake2)
 					break;
 			}
-- 
2.40.1

