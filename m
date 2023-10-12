Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF97C74AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442144AbjJLRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347374AbjJLRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:40 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874B1A4;
        Thu, 12 Oct 2023 10:22:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77acb04309dso48098339f.2;
        Thu, 12 Oct 2023 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131330; x=1697736130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae2mlXqowKD5cqGlXb7uogfjENyHP+dyQJfUAIqJaiw=;
        b=Pa2GQujzG4xkFz1MuzT7bGXTbxpHxEwYnSn2HZOTK+wAMkeClULEYWDzJbSkTcq75z
         AUnimEfnsESxRNq0Y1Xcok3+qK9Jwn2FoGPupuZa6h5emSzldMZkSbt9yp8q58SgZuO/
         FoP0CLvtgHrDM76NfYfaVXL7TVhqdrCwTNZ3bVSzfVyRxnkmRZcweWvZmC3uoaHamH0b
         nQdY+9Xll4u7ZZSNBEYVcY3SgPfTe4ZYX0KgUB1gHzoMDEgK1NUzMIwl4lQsYY6S3i8c
         Uw5nFXqwGhToh1ROoGzqvtw7gieLU2enK/UAsE2H4viYHIPfJK2Ep/66mLkgAx27gXyP
         +B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131330; x=1697736130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae2mlXqowKD5cqGlXb7uogfjENyHP+dyQJfUAIqJaiw=;
        b=uZBzrZIxAwPeqy1WC1Ex6gGRy1KaejQyDEbyJuKuznHJ+fyYDgbwSyGZ2A3lELYxXP
         x5YAyf4dBvOH0Y7GKxrL/1eRM3Mhb5DOYsqMZdUjqnP2WUzKzBhTVID8Sg8wsg/xTKyL
         quss/g8uug+JCG+UPKZDh186lZ9KdTt6oUz71/C0Ihb1vtf5EctL33qtvpf35YpfcjC2
         WvbQtDTwdgcn4sxNodwuHpakJTuamoxl+sf88tBj9/cB0+cEKBUZGWbp+Fznbi8vt3pN
         F5M13cJZrBYIsqvwzKDqi2fC0dcZ3gdEx7kvgf+pA7Jz8q4T7/ud/BIzGBBmxDx5K1t7
         DSLw==
X-Gm-Message-State: AOJu0Yy5/CqEKdJmUrnCzDvuNU3Kah5sDO/1mpgki8R8cZ3V1DsOKCmS
        EHSsg0CODbgwyq1zNq+YxfyWFJwhsgDBLQ==
X-Google-Smtp-Source: AGHT+IEFuqgv0LKLuAzb7gwKQOS1mz1rZpZC9sUTpzcOz2n4Y5NvZOzIOkx+6OOoSZfI8IPqpfsYRQ==
X-Received: by 2002:a5e:8f4d:0:b0:791:2db5:c779 with SMTP id x13-20020a5e8f4d000000b007912db5c779mr30620229iop.10.1697131329992;
        Thu, 12 Oct 2023 10:22:09 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 21/25] dyndbg: refactor *dynamic_emit_prefix
Date:   Thu, 12 Oct 2023 11:21:32 -0600
Message-ID: <20231012172137.3286566-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the split of duties between outer & inner fns.

The outer fn was previously just an inline unlikely forward to inner,
which did all the work.

Now, outer handles +t and +l flags itself, and calls inner only when
_DPRINTK_FLAGS_INCL_LOOKUP is needed.

No functional change.

But it does make the results of the inner-fn more cache-friendly
(fewer entries, reused more often):

1- no spurious [TID] or <intr> noise
2- no LINE-number to bloat the cache (avg 9 pr_debugs/fn)
3- only LOOKUP stuff

Currently LOOKUPs are descriptor-field refs but could be replaced by
accessor functions.  This would allow the __dyndbg_sites section to be
de-duplicated and reclaimed; currently module, filename fields are
~90% repeated.  As the accessors get more expensive, the value of
caching part of the prefix goes up.

Also change inner-fn to return count of extra chars written to the
buffer, and drop "inline" from outer, let the compiler decide.  Maybe
also change name accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 55 ++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 17eefb35ac96..974395bf8a83 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -777,19 +777,8 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static int __dynamic_emit_prefix(const struct _ddebug *desc, char *buf, int pos)
 {
-	int pos_after_tid;
-	int pos = 0;
-
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
-		if (in_interrupt())
-			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
-		else
-			pos += snprintf(buf + pos, remaining(pos), "[%d] ",
-					task_pid_vnr(current));
-	}
-	pos_after_tid = pos;
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
@@ -799,22 +788,38 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				trim_prefix(desc->filename));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
-		pos += snprintf(buf + pos, remaining(pos), "%d:",
-				desc->lineno);
-	if (pos - pos_after_tid)
-		pos += snprintf(buf + pos, remaining(pos), " ");
-	if (pos >= PREFIX_SIZE)
-		buf[PREFIX_SIZE - 1] = '\0';
-
-	return buf;
+	return pos;
 }
 
-static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
+static char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
-	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
-		return __dynamic_emit_prefix(desc, buf);
-	return buf;
+        int pos_after_tid;
+        int pos = 0;
+
+        if (likely(!(desc->flags & _DPRINTK_FLAGS_INCL_ANY)))
+                return buf;
+
+        if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+                if (in_interrupt())
+                        pos += snprintf(buf + pos, remaining(pos), "<intr> ");
+                else
+                        pos += snprintf(buf + pos, remaining(pos), "[%d] ",
+                                        task_pid_vnr(current));
+        }
+        pos_after_tid = pos;
+
+        if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_LOOKUP))
+                pos += __dynamic_emit_prefix(desc, buf, pos);
+
+        if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+                pos += snprintf(buf + pos, remaining(pos), "%d:",
+                                desc->lineno);
+        if (pos - pos_after_tid)
+                pos += snprintf(buf + pos, remaining(pos), " ");
+        if (pos >= PREFIX_SIZE)
+                buf[PREFIX_SIZE - 1] = '\0';
+
+        return buf;
 }
 
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
-- 
2.41.0

