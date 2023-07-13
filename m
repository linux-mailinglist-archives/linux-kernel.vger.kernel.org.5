Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D127A7528DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjGMQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjGMQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:20 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B92D47
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:58 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-346129c9512so1948605ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266216; x=1691858216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fCryleot7DYJMVCUstKegVHZxdFt0UcbYK1dV/Zx9Y=;
        b=j84zOzS2UdE9+xPQXLUCHUex2P5pCyffe4WuGd1a5TD9mNcJ3dfkxSd0JWEcrmKK3p
         FsN52We9fV2omZa9UTDcqgaDUazFxwF3PhwXq8kuFKlLKAHU8jlF2UG+nitlQWarAtRB
         SQAswSd2N5CMlwNXtfBIlzg51uROWTE+9wIKl/pY7nwagOoH9+NNZukDTeBKk3uSXd1g
         BsCCFDamozGg3oBsY5uQqVrGjGa7pwxon538wE1rQzY9doyU5eJNfIaDSFJbKbTlna5n
         MwlLLEDDfw01PI6/2ba8Zs3D75BG21Bn6VZr9c7GmAaC5gTfgadse9rfrAlHWoi7eX8u
         YpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266216; x=1691858216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fCryleot7DYJMVCUstKegVHZxdFt0UcbYK1dV/Zx9Y=;
        b=gFYJVIijex34RYRQbHdOZveSuS0JTZlFbdU4aiF9inUMKIoTVDf0TI0JAV2RMYI3Si
         hGlmLrlU00ENmL74tkrHH3SoccrHeSeugtwnWbXADBpKQ7IeUA0qrlw1NiS9HNHMVCOU
         l+mTowhJWyvQHD1g/8n6CRg+7Jz1P1qlzy+DXIhdBfgCRKvGuk0B64+cHhOoO8hdbdDB
         /Wz3mJi8CSWUmnMCFz7zbuKUeCz7iX2WeAeTHI3KnRqzIz4baAovCdFofzy8mFhI05bx
         sPz7y8TPcDOQEHoyLLeScud1YNSnqDUtvuA6Mw/FIEu2bEBPhQ42RQT0vAfRqYKCulLu
         81zQ==
X-Gm-Message-State: ABy/qLaT3Od0SoTZcwzg++aa2JOSxbvsq0IOBMdUgu7Lx3F2eFHLRDgG
        Hd+VcP+hbJzlZioOwLzr2hA=
X-Google-Smtp-Source: APBJJlGFst7/NrXtwCSYzDr7Fr8pT9UUNTPwR86Us+eEz2G7l30W0AuGerUvYYRag5Vb6AlTWP67WA==
X-Received: by 2002:a05:6e02:66f:b0:341:24f1:3f74 with SMTP id l15-20020a056e02066f00b0034124f13f74mr132294ilt.14.1689266215917;
        Thu, 13 Jul 2023 09:36:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:36:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 10/21] dyndbg: tighten ddebug_class_name() 1st arg type
Date:   Thu, 13 Jul 2023 10:36:15 -0600
Message-ID: <20230713163626.31338-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index a8973d1a6896..f392f692b452 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1112,12 +1112,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
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
 
@@ -1151,7 +1151,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_puts(m, "\"");
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-- 
2.41.0

