Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561917C7494
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441835AbjJLRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379635AbjJLRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3312E;
        Thu, 12 Oct 2023 10:21:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79f95439795so58490039f.0;
        Thu, 12 Oct 2023 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131317; x=1697736117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Nv87Lg2zXFTsrsMPJe4o1KQfKM5CR/Su7zfjGsbi8=;
        b=GByylgg/Vi8T/JsF5yGKkZ8PQHgPFzzloRCqrBg8H2qxLVGhft1LVXDnJ3I2BVS551
         NymSRm7+iTN3eROFwMAFTYDSwgwBguIi+awUxTXFVwKY25QWR81ea0v/1rhvN6uSX4tV
         oE3MJ4ZAyl3301WKhD7kD/ddeGogP+4ybZX4Ik7UHJM3PIJXVW0l/1DIe9o/isfuWIYk
         IjLlRqlzSlNGj18ywEgQyYw2cESAf8N3t/4I6dTk0sv7crFRTEFXMOhMFi3R+SsRYFCB
         Vct+YtXumXdAVB+pfBnXP9UNceO8TOCkwdoRtFKubuTyvsKiiv4pgz0m9QJIUH81s6ML
         usrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131317; x=1697736117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Nv87Lg2zXFTsrsMPJe4o1KQfKM5CR/Su7zfjGsbi8=;
        b=YQ8NTMK6jg/m3Mja2JqddZxMSVCLtr33XISuO8Nt+tWP8e4COzfnfdq+XhcfFZMkv5
         tgUvPp/B5KfV/gWDn1aglkrKRm/pVdS4D5HiUBeltLcb+VtWiI6iME5JjC59ZWUEV1Ym
         WZDHI5wuM++eqQTPP7cxaKD86aimvQAx9hAQy1XhYiWQKm8bbYSF5baNzpdD7KvkJOit
         FFbmxlFMPEhJfJtsDzsEc9ZMGXIwk7p/61MP1MtFaIXKPHk/PqaSyn02XRNdDb9RMWvh
         3rXqaGWMYUfbZ8M1rvYCExcFTtx3zoyx72yzpvzOkwm9Pm5CbiCDL9/I1gLtKiL/wzdw
         EbGg==
X-Gm-Message-State: AOJu0YxmiW36S7FXwNy2tl5hTbTcjchQcOMZPn/C7IdAoPx9pAeqgfA0
        zq71BxxvdiJihJz6jOfV+7nHcKDJswNC/w==
X-Google-Smtp-Source: AGHT+IFsoCgezLff2unJTvYEIKfSqNXTbNy4RrMEtsjU/boWD6E9+G6s4yHlhMjBwIKnpBjZpcfBbQ==
X-Received: by 2002:a05:6e02:156f:b0:351:59f1:5277 with SMTP id k15-20020a056e02156f00b0035159f15277mr19761543ilu.4.1697131317084;
        Thu, 12 Oct 2023 10:21:57 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:21:56 -0700 (PDT)
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
Subject: [PATCH v7 10/25] dyndbg: tighten ddebug_class_name() 1st arg type
Date:   Thu, 12 Oct 2023 11:21:21 -0600
Message-ID: <20231012172137.3286566-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change function's 1st arg-type, and deref in the caller.
The fn doesn't need any other fields in the struct.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b07aab422604..8158943b350d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1117,12 +1117,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct ddebug_class_map *map = dt->classes;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
+	for (i = 0; i < dt->num_classes; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1156,7 +1156,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_puts(m, "\"");
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-- 
2.41.0

