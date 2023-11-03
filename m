Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8007E063C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjKCQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344763AbjKCQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EBE194
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699028199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tGwXPfRgzPSC1/7v7/xvW9BOx29g/brNKkSt4SGOuac=;
        b=c5iOJh3Mk1MnnrlMmfQE7E4Mp1kvo1OEndvW3+8TNTwBzehmkNM6D+rCmYiHeCyad4HSor
        VHm+PknXyGMrtbR/cXLGzISOYewQesG4+zy3M+pg0rsCG8vZdFldbThUqMIu/hGr3YvtIW
        /tgHl/wCBTfR2ekZQF5+J1zwLRG7klQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-0WUFZsn1MwqGhvhsr2N9QA-1; Fri,
 03 Nov 2023 12:16:36 -0400
X-MC-Unique: 0WUFZsn1MwqGhvhsr2N9QA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 758883806710;
        Fri,  3 Nov 2023 16:16:36 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 511B71121308;
        Fri,  3 Nov 2023 16:16:36 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     will@kernel.org
Cc:     gfs2@lists.linux.dev, aahringo@redhat.com, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 1/2] refcount: introduce generic lockptr funcs
Date:   Fri,  3 Nov 2023 12:16:34 -0400
Message-Id: <20231103161635.1902667-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce lockptr refcount operations. Currently refcount has
a lot of refcount_dec_and_lock() functionality for most common used
locktype. Those functions look mostly all the same and is duplicated
inside the refcount implementation. Instead of introducing a new whole
refcount_dec_and_lock() functionality e.g. for rwlock_t and their _bh
variants this patch will introduce lockptr. A lockptr is just a void *
and refers to the actual locking instance that can even be an own
locking type. Over the passed callbacks for lock and unlock operations
the void *lockptr becomes to the real thing by casting it and do the
locktype specific lock operation.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/refcount.h | 15 +++++++
 lib/refcount.c           | 92 ++++++++++++++++++++++++++++------------
 2 files changed, 80 insertions(+), 27 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a62fcca97486..7b1fb85212cc 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -366,4 +366,19 @@ extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
 						       unsigned long *flags) __cond_acquires(lock);
+extern bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockptr),
+				     void (*unlock)(void *lockptr),  void *lockptr) __cond_acquires(lockptr);
+
+extern void lockptr_mutex_lock(void *lockptr) __acquires(lockptr);
+extern void lockptr_mutex_unlock(void *lockptr) __releases(lockptr);
+extern void lockptr_spin_lock(void *lockptr) __acquires(lockptr);
+extern void lockptr_spin_unlock(void *lockptr) __releases(lockptr);
+
+struct lockptr_irqsave_data {
+	void *lockptr;
+	unsigned long *flags;
+};
+extern void lockptr_irqsave(void *lockptr) __acquires(lockptr);
+extern void lockptr_irqsave(void *lockptr) __releases(lockptr);
+
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..e28678f0f473 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
 }
 EXPORT_SYMBOL(refcount_dec_not_one);
 
+bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockptr),
+			      void (*unlock)(void *lockptr),  void *lockptr)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	lock(lockptr);
+	if (!refcount_dec_and_test(r)) {
+		unlock(lockptr);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_lockptr);
+
+void lockptr_mutex_lock(void *lockptr)
+{
+	mutex_lock(lockptr);
+}
+EXPORT_SYMBOL(lockptr_mutex_lock);
+
+void lockptr_mutex_unlock(void *lockptr)
+{
+	mutex_unlock(lockptr);
+}
+EXPORT_SYMBOL(lockptr_mutex_unlock);
+
 /**
  * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
  *                               refcount to 0
@@ -112,18 +140,22 @@ EXPORT_SYMBOL(refcount_dec_not_one);
  */
 bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
+	return refcount_dec_and_lockptr(r, lockptr_mutex_lock,
+					lockptr_mutex_unlock, lock);
+}
+EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
 
-	mutex_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		mutex_unlock(lock);
-		return false;
-	}
+void lockptr_spin_lock(void *lockptr)
+{
+	spin_lock(lockptr);
+}
+EXPORT_SYMBOL(lockptr_spin_lock);
 
-	return true;
+void lockptr_spin_unlock(void *lockptr)
+{
+	spin_unlock(lockptr);
 }
-EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
+EXPORT_SYMBOL(lockptr_spin_unlock);
 
 /**
  * refcount_dec_and_lock - return holding spinlock if able to decrement
@@ -143,18 +175,26 @@ EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
  */
 bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
+	return refcount_dec_and_lockptr(r, lockptr_spin_lock,
+					lockptr_spin_unlock, lock);
+}
+EXPORT_SYMBOL(refcount_dec_and_lock);
 
-	spin_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock(lock);
-		return false;
-	}
+void lockptr_lock_irqsave(void *lockptr)
+{
+	struct lockptr_irqsave_data *d = lockptr;
 
-	return true;
+	spin_lock_irqsave(d->lockptr, *d->flags);
 }
-EXPORT_SYMBOL(refcount_dec_and_lock);
+EXPORT_SYMBOL(lockptr_lock_irqsave);
+
+void lockptr_unlock_irqsave(void *lockptr)
+{
+	struct lockptr_irqsave_data *d = lockptr;
+
+	spin_unlock_irqrestore(d->lockptr, *d->flags);
+}
+EXPORT_SYMBOL(lockptr_unlock_irqsave);
 
 /**
  * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
@@ -172,15 +212,13 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
 bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 				   unsigned long *flags)
 {
-	if (refcount_dec_not_one(r))
-		return false;
+	struct lockptr_irqsave_data d = {
+		.lockptr = lock,
+		.flags = flags,
+	};
 
-	spin_lock_irqsave(lock, *flags);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock_irqrestore(lock, *flags);
-		return false;
-	}
-
-	return true;
+	return refcount_dec_and_lockptr(r, lockptr_lock_irqsave,
+					lockptr_unlock_irqsave, &d);
 }
 EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
+
-- 
2.39.3

