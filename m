Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B717EA509
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjKMUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjKMUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEE189
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699908501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJ+LiwbN2BndSbRN+OoIP2/njNNsDf+m3Dwmn8bd/c4=;
        b=J3r5+lfxUoEZxlkb6HcRggO6L4TNSolbxT/XN5SyDt/m17K2XQg0/LCs/x0Sg1mjKv4hHT
        Spdx93LEaPjUvfnIcID2+cK6rykFCrD4hzG/oj5G758Zb6AZr1ZvS0JaYb1ReCpoLoyTOI
        5VnsI5+Vud7/0HWilZjO0KTbip1o5sU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-WoJ-KYIsNy25sLO5p57oGw-1; Mon, 13 Nov 2023 15:48:19 -0500
X-MC-Unique: WoJ-KYIsNy25sLO5p57oGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BC28185A785;
        Mon, 13 Nov 2023 20:48:19 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20DC81C060B5;
        Mon, 13 Nov 2023 20:48:19 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     peterz@infradead.org
Cc:     will@kernel.org, gfs2@lists.linux.dev, aahringo@redhat.com,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] kref: introduce __kref_put_lock macro
Date:   Mon, 13 Nov 2023 15:48:09 -0500
Message-Id: <20231113204809.4052009-2-aahringo@redhat.com>
In-Reply-To: <20231113204809.4052009-1-aahringo@redhat.com>
References: <20231113204809.4052009-1-aahringo@redhat.com>
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

This patch introduce the __kref_put_lock macro to easily write a
kref_put_lock functionality based on refcount_dec_and_lock functions.
Existing per lock type specific kref_put_lock functionality are updated
to use the new __kref_put_lock macro.

Co-developed: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/kref.h | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..d8e26ac1d54f 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -68,26 +68,43 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
 	return 0;
 }
 
+/**
+ * __kref_dec_and_lock - macro to create code to holding a lock and call the
+ *                       release callback if being able to decremnt refcount
+ *                       to 0
+ * @kref: the kref
+ * @_release: callback for the release function
+ * @_ref_dec_and_lock: ref_and_lock lock specific function call code
+ *
+ * The result will be directly returned as a right operand operation. Uusally
+ * the caller use it directly after a return statement.
+ */
+#define __kref_put_lock(_kref, _release, _ref_dec_and_lock)	\
+({								\
+	int _ret = 0;						\
+								\
+	if (_ref_dec_and_lock) {				\
+		_release(kref);					\
+		_ret = 1;					\
+	}							\
+								\
+	_ret;							\
+})
+
 static inline int kref_put_mutex(struct kref *kref,
 				 void (*release)(struct kref *kref),
 				 struct mutex *lock)
 {
-	if (refcount_dec_and_mutex_lock(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	return __kref_put_lock(kref, release,
+			       refcount_dec_and_mutex_lock(&kref->refcount, lock));
 }
 
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
 {
-	if (refcount_dec_and_lock(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	return __kref_put_lock(kref, release,
+			       refcount_dec_and_lock(&kref->refcount, lock));
 }
 
 /**
-- 
2.39.3

