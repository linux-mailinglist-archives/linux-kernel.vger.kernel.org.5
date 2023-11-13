Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6167EA508
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKMUst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKMUss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC919E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699908503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WP+Y4q+4xEgs51EbL6GPWxpQ0/7X1AlpT4HcryotvYE=;
        b=EWK0hlLNxZYCI/AnEVjN3nkTUY0iutSeLqSe4+pgSf423LUN0UYiby4l7ddbOXgPwlQ6jo
        iSHIG1EjB52v9ZXyjzaAlqvxv4/QDWYrjukPE7mAKT6s9Yr4hWUPk+GvBCQN5EJdJiG5JT
        DqCSIJ11nhPRxezCGosNEzba2HkzgPU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-gKnhWEH6N-272dshLWNAaw-1; Mon,
 13 Nov 2023 15:48:19 -0500
X-MC-Unique: gKnhWEH6N-272dshLWNAaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21D6B1C0F2DD;
        Mon, 13 Nov 2023 20:48:19 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09AEC1C060B9;
        Mon, 13 Nov 2023 20:48:19 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     peterz@infradead.org
Cc:     will@kernel.org, gfs2@lists.linux.dev, aahringo@redhat.com,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/2] refcount: introduce __refcount_dec_and_lock macro
Date:   Mon, 13 Nov 2023 15:48:08 -0500
Message-Id: <20231113204809.4052009-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the __refcount_dec_and_lock macro to generate code for a
lock specific refcount_dec_and_lock implementation. Existing
refcount_dec_and_lock implementation are updated to use the new
__refcount_dec_and_lock macro. In future other lock implementation can
added to use the refcount_dec_and_lock trick to only hold the lock when
the refcount is going to be zero. Per subsystem own lock implementation
can use the macro as well to provide such implementation for their own
locking type.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
changes since v2:
 - drop kdoc move to header, it need to be at the implementation
 - add Acked-by from Peter Zijlstra
 - fix Peter Zijlstra in Co-developed

 include/linux/refcount.h | 26 ++++++++++++++++++++++++++
 lib/refcount.c           | 36 ++++++------------------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a62fcca97486..0db03df681fe 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -361,6 +361,32 @@ static inline void refcount_dec(refcount_t *r)
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
+
+/**
+ * __refcount_dec_and_lock - macro to create code to holding a lock if being
+ *                           able to decremnt refcount to 0
+ * @_ref: the refcount
+ * @_lock: lock function call code
+ * @_unlock: unlock function call code
+ *
+ * The result will be directly returned as a right operand operation. Uusally
+ * the caller use it directly after a return statement.
+ */
+#define __refcount_dec_and_lock(_ref, _lock, _unlock)	\
+({							\
+	bool _ret = false;				\
+							\
+	if (!refcount_dec_not_one(_ref)) {		\
+		_lock;					\
+		if (!refcount_dec_and_test(_ref))	\
+			_unlock;			\
+		else					\
+			_ret = true;			\
+	}						\
+							\
+	_ret;						\
+})
+
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(lock);
 extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(lock);
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..2afe279cfb5a 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -112,16 +112,8 @@ EXPORT_SYMBOL(refcount_dec_not_one);
  */
 bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
-
-	mutex_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		mutex_unlock(lock);
-		return false;
-	}
-
-	return true;
+	return __refcount_dec_and_lock(r, mutex_lock(lock),
+				       mutex_unlock(lock));
 }
 EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
 
@@ -143,16 +135,8 @@ EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
  */
 bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
-
-	spin_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock(lock);
-		return false;
-	}
-
-	return true;
+	return __refcount_dec_and_lock(r, spin_lock(lock),
+				       spin_unlock(lock));
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
 
@@ -172,15 +156,7 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
 bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 				   unsigned long *flags)
 {
-	if (refcount_dec_not_one(r))
-		return false;
-
-	spin_lock_irqsave(lock, *flags);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock_irqrestore(lock, *flags);
-		return false;
-	}
-
-	return true;
+	return __refcount_dec_and_lock(r, spin_lock_irqsave(lock, *flags),
+				       spin_unlock_irqrestore(lock, *flags));
 }
 EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
-- 
2.39.3

