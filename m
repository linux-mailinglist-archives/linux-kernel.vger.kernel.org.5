Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16347CE3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjJRRGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjJRRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:06:31 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B811B;
        Wed, 18 Oct 2023 10:06:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a6830df017so2344339f.3;
        Wed, 18 Oct 2023 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648781; x=1698253581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Nv87Lg2zXFTsrsMPJe4o1KQfKM5CR/Su7zfjGsbi8=;
        b=QmuNrB9Kjw4FVRfeq0nV/mRRwbSyHapUnNjPiOxlytCcCZPoEAb1QnT24VgQJKjxhQ
         iWARqGBt9xtLp2G/TcPWraVghfz7WJ/OdSkr55YdKv3hbGZ4i1XGQ4q5N99XPoQ+hfga
         HvFy4bM3GFXgRG33gjAXxt4WuUYiAAvmOdIS9K7oGeiQtLguIiC5lSRhab6MyBiFHeZF
         /+ctpXNDVOs9O8cdqrZAhMYotRSvHW+qfKNAj/YYtQ9/YJyOWfW77xTtbLjg1n2qYVJV
         nQsaGRgtwDXApbqVdUtqU42hP+xYZBvyJJmHSA7qPGRfiQ/obSoRroXh1pZbvZHQG8xK
         DhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648782; x=1698253582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Nv87Lg2zXFTsrsMPJe4o1KQfKM5CR/Su7zfjGsbi8=;
        b=hbyLtZTBWEQoboKcTQf7Wlu52WlnQ584m1zndhPVBEQCi8ivv+XaV6XZcwFXHZazwf
         +zm+ASR65355Ag19t5lRQ/gH7s7aKiRn0FXojYoOsreRfiMLB17HZdTv1Cjs3xtgZjO5
         T7WRFfD/VWUzWM5xemb0wQqPh+A2S9x4Vhc/EK9zQ6RddY7lLvbAyStmN5RzQJXv/OpG
         XfFb+oR4RwQdClNaVyaKe6CTHYZtUWaj3kFKrRPSA5QhAe1tD/NMwjKSLJ8lF0XC5yqC
         SL9jIZh2kP+wQCexRUYBSTKjLBEcuuySPg2hmu4DjlbvO6xdgwvsHG0yLBDaEoSt0rSm
         jzLg==
X-Gm-Message-State: AOJu0YyNbyEpyVYw68q8hbtbWlULZw1At9rh3R3eCiM6CujuCUJm2YzH
        HxB0edLu+hDW+ziqqi8FoE7nFd00UmopMA==
X-Google-Smtp-Source: AGHT+IG6lZXzulci6YGFdscPrHiN4tISG8h2nXpy9EJZW1KW9NsOJNsFRiWgdpO0OyMO6nbCvvwZ2w==
X-Received: by 2002:a05:6602:3fc8:b0:795:c6f:59ff with SMTP id fc8-20020a0566023fc800b007950c6f59ffmr8247388iob.17.1697648781706;
        Wed, 18 Oct 2023 10:06:21 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7c 10/24] dyndbg: tighten ddebug_class_name() 1st arg type
Date:   Wed, 18 Oct 2023 11:05:50 -0600
Message-ID: <20231018170604.569042-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018170604.569042-1-jim.cromie@gmail.com>
References: <20231018170604.569042-1-jim.cromie@gmail.com>
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

