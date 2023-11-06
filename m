Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD07E2CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjKFTMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E099
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699297907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFYAlpr3mCFx2VdOux1+OiNwc+JRrHXIPRJP0tooHeo=;
        b=eJ1REd9E8+7a3wE+qSGL/fvHFfrqNrOVjfDUF6JbPLtdmoLK4WWnwTHdtWQRxNxsaBxw16
        pEf32zEknno4jPDhdOb5hchxViXPPATW7vRP+pfZTFl9UkBFgv/YR7wBqX+bKzKXdVo2L+
        /HrNVKp57KZDtebFxzbtirVPg/CPe2o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-oHThYmJUOn6oNy-3gimBAA-1; Mon,
 06 Nov 2023 14:11:45 -0500
X-MC-Unique: oHThYmJUOn6oNy-3gimBAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9072808FE6;
        Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81CDF1121307;
        Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     peterz@infradead.org
Cc:     will@kernel.org, gfs2@lists.linux.dev, aahringo@redhat.com,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] refcount: introduce __refcount_dec_and_lock macro
Date:   Mon,  6 Nov 2023 14:11:37 -0500
Message-Id: <20231106191138.3179599-2-aahringo@redhat.com>
In-Reply-To: <20231106191138.3179599-1-aahringo@redhat.com>
References: <20231106191138.3179599-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Co-developed: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/refcount.h | 25 +++++++++++++++++++++++++
 lib/refcount.c           | 36 ++++++------------------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 741cc6295f54..d5cf40d3f4bc 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -362,6 +362,31 @@ static inline void refcount_dec(refcount_t *r)
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 
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
 /**
  * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
  *                               refcount to 0
diff --git a/lib/refcount.c b/lib/refcount.c
index c37edf66994f..5511498df708 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -96,46 +96,22 @@ EXPORT_SYMBOL(refcount_dec_not_one);
 
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

