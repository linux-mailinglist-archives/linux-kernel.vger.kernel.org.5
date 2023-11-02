Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA17DFA9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377401AbjKBTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377445AbjKBTBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D512C10C6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so18439797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951660; x=1699556460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fohxzhQfhxYVopBcNANdGNbb7WZIM4Bu1Q06IAp2S3Q=;
        b=RoGdSNez/L5tAmj8SqXnDolednKzeXr0lGtZS0756rtfQBtmEYC1xnxXVaLzuXTYrO
         Cn9ZSxuH7h4sY8p1lbHPIGhita8iqvKAWSK59gfgu610AXwkd6LLsBdStlH8Ouot7co+
         zdA5/0USbVs4TYhS41IyR3Inm7lLJvPiZqqjneFGIdIvuv99BiF8fSu6WsLRm55w+aUF
         rGJzzBnxsBWdbq8U3CfVJ8BhjjtM7jHfsvxwwpxuO+cPdUJZIxdWY7625IC/c+BJhoPi
         L1oUkNdNnBiM+EClJGJITL/yxBKuIII/XZB2lwVTDpkk+ryy5uHZGs+8fQcriMHk6L7G
         9Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951660; x=1699556460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fohxzhQfhxYVopBcNANdGNbb7WZIM4Bu1Q06IAp2S3Q=;
        b=mCxo1lMnRvdyOLe3w3xN8ClQVZkRtKb5Er2fkOe5u/QGVCMBcyBo6OX3Hcez3feo7O
         Ds1F31hcXcc8yR7ga8ma0bK1w/V+NQxYf4J6rzrHRh7ucxVZ4ZFqHvaVeJhkITycgtbR
         BSmkoPqWbM+DJs5ut7nedgoXK5axOhvTL5hCEk9J1c9rIRFbVFEjDK2Wcx0qCqDjWFlN
         BizdrZ10BjkXhTLSKjdT4xWUGZzcvFt3+ovjn+gCDzhBHjbNl6Cnl8TpBtG0vcGdhTyI
         toEvB1d/wgVgU+LYJixOwWkEmcMTdfR1rIhsyFCLsfTiFjzh4DYdb08ZSkAzcgjV2+w0
         xOpA==
X-Gm-Message-State: AOJu0Yx1t5Z3vcnduVfMub6ITkWdoqB/1AJga/j527iyYCiofGJVLsuu
        YKME55wX5HlU7axkQGDErwPgAYN6FFBGlw==
X-Google-Smtp-Source: AGHT+IEEaAqMod1gL8uMntB+S+y0GDl/J30t8mD6qKxnOeeQsQQA8hFQ9Mu7Z7gVVkQadWw9tKGdffVCGLkrHg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:848c:0:b0:d9a:5e10:c34d with SMTP id
 v12-20020a25848c000000b00d9a5e10c34dmr379739ybk.11.1698951659740; Thu, 02 Nov
 2023 12:00:59 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:14 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-14-cmllamas@google.com>
Subject: [PATCH 13/21] binder: relocate low space calculation
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the low async space calculation to debug_low_async_space_locked().
This logic not only fits better here but also offloads some of the many
tasks currently done in binder_alloc_new_buf_locked().

No functional change in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 3fe5c734c3df..cc627c106a01 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -375,6 +375,15 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc)
 	size_t num_buffers = 0;
 	struct rb_node *n;
 
+	/*
+	 * Only start detecting spammers once we have less than 20% of async
+	 * space left (which is less than 10% of total buffer size).
+	 */
+	if (alloc->free_async_space >= alloc->buffer_size / 10) {
+		alloc->oneway_spam_detected = false;
+		return false;
+	}
+
 	for (n = rb_first(&alloc->allocated_buffers); n != NULL;
 		 n = rb_next(n)) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -497,16 +506,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_alloc_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
-		if (alloc->free_async_space < alloc->buffer_size / 10) {
-			/*
-			 * Start detecting spammers once we have less than 20%
-			 * of async space left (which is less than 10% of total
-			 * buffer size).
-			 */
-			buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc);
-		} else {
-			alloc->oneway_spam_detected = false;
-		}
+		if (debug_low_async_space_locked(alloc))
+			buffer->oneway_spam_suspect = true;
 	}
 
 	return buffer;
-- 
2.42.0.869.gea05f2083d-goog

