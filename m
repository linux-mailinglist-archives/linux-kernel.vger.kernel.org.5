Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7D7E2CA6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjKFTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F9EBB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699297912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pvARdzk7JF5j0f2O61J3PPBv74WDWbFdIcUVxM6lsBQ=;
        b=FkXogrSowfzB+mAKbJMaUqFDIUFNGdZMW0nNH++iW1lO9INPweBVA1+owVdObZqzU4mQSx
        twZe1T5dKt1uC7M9IfoZ2iQ/+Oe8frA5thho0/Jy74Wa+dXVzQqRNPJiEW6a5iOlHSC//x
        KTn37lAATK5TGU4UblWGX5c7VgqcAUE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-pMWJkGsCMEWXJ3FSmzze8w-1; Mon,
 06 Nov 2023 14:11:45 -0500
X-MC-Unique: pMWJkGsCMEWXJ3FSmzze8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 822BC3C14767;
        Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABBA1121306;
        Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     peterz@infradead.org
Cc:     will@kernel.org, gfs2@lists.linux.dev, aahringo@redhat.com,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] refcount: move kdoc to header definition
Date:   Mon,  6 Nov 2023 14:11:36 -0500
Message-Id: <20231106191138.3179599-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the kdoc for refcount_dec_and_lock functionality to
it's header prototype declarations.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/refcount.h | 48 ++++++++++++++++++++++++++++++++++++++++
 lib/refcount.c           | 45 -------------------------------------
 2 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a62fcca97486..741cc6295f54 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -361,8 +361,56 @@ static inline void refcount_dec(refcount_t *r)
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
+
+/**
+ * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
+ *                               refcount to 0
+ * @r: the refcount
+ * @lock: the mutex to be locked
+ *
+ * Similar to atomic_dec_and_mutex_lock(), it will WARN on underflow and fail
+ * to decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold mutex if able to decrement refcount to 0, false
+ *         otherwise
+ */
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(lock);
+
+/**
+ * refcount_dec_and_lock - return holding spinlock if able to decrement
+ *                         refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ *
+ * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
+ * decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
 extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(lock);
+
+/**
+ * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
+ *                                 interrupts if able to decrement refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ * @flags: saved IRQ-flags if the is acquired
+ *
+ * Same as refcount_dec_and_lock() above except that the spinlock is acquired
+ * with disabled interrupts.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
 						       unsigned long *flags) __cond_acquires(lock);
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..c37edf66994f 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -94,22 +94,6 @@ bool refcount_dec_not_one(refcount_t *r)
 }
 EXPORT_SYMBOL(refcount_dec_not_one);
 
-/**
- * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
- *                               refcount to 0
- * @r: the refcount
- * @lock: the mutex to be locked
- *
- * Similar to atomic_dec_and_mutex_lock(), it will WARN on underflow and fail
- * to decrement when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides a control dependency such that free() must come after.
- * See the comment on top.
- *
- * Return: true and hold mutex if able to decrement refcount to 0, false
- *         otherwise
- */
 bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 {
 	if (refcount_dec_not_one(r))
@@ -125,22 +109,6 @@ bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
 
-/**
- * refcount_dec_and_lock - return holding spinlock if able to decrement
- *                         refcount to 0
- * @r: the refcount
- * @lock: the spinlock to be locked
- *
- * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
- * decrement when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides a control dependency such that free() must come after.
- * See the comment on top.
- *
- * Return: true and hold spinlock if able to decrement refcount to 0, false
- *         otherwise
- */
 bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
 	if (refcount_dec_not_one(r))
@@ -156,19 +124,6 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
 
-/**
- * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
- *                                 interrupts if able to decrement refcount to 0
- * @r: the refcount
- * @lock: the spinlock to be locked
- * @flags: saved IRQ-flags if the is acquired
- *
- * Same as refcount_dec_and_lock() above except that the spinlock is acquired
- * with disabled interrupts.
- *
- * Return: true and hold spinlock if able to decrement refcount to 0, false
- *         otherwise
- */
 bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 				   unsigned long *flags)
 {
-- 
2.39.3

