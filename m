Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40A76BAA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjHARES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjHARDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:45 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D0A2D74
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:30 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56c85b723cfso1898166eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909409; x=1691514209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fCryleot7DYJMVCUstKegVHZxdFt0UcbYK1dV/Zx9Y=;
        b=kROfNG8LDRCn7UgNyAgqsZx6rWtyVz4JtO0DqGP4BXmprbgnYl0ZfixoqPBvhGkHOU
         EU95RXDWQ9rUb+HVd3GNUq5Hhbfo+Jd63RduLoThfH63By1HGzM3fIIxH5EYZOA3fk1t
         xOSTQM1hGCm9bPNXS8l7jMFe1NzNjNFOXY+5SkbgAmGdOlrhPlkff3D8T+xCJJVVxMZj
         jSey6N4JABae7aNdBp+Z9ivpSWuvs286z11haAnSUP+OoJ14dm8baX2yH1+ViERfCHyf
         Pm6D9+hWoxJ40Q/bygWehp4Y0CPgMIZXI7WopcauzC6ikHCTgD5CIAQpne4kQVO0JQKY
         rXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909409; x=1691514209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fCryleot7DYJMVCUstKegVHZxdFt0UcbYK1dV/Zx9Y=;
        b=iXxBSxzBx/3naLGdQx1hZTig7N820AUlm/ELHjuViOnrwEZGo2fYxWE/vNFYQYupZI
         8AI3THwQRjoowAi1IpMzFdeZXTcUHd048WayhVJrvj0h7UczEG5ZdbVbJ1O3OQQcuajA
         eBr5lZN42qyKdZ4Ml2p1PIZihGQNdkYgfvXR/z2T5vkq+cDZRRspNlqMr73lvPM4YoRJ
         /SoT3HeN6jitrEfRBiO0m2/4Z8+PsA4IVJNy5caKprhRJ8DeyjGqJil7gXDS1VszqOzG
         SdygZ/90+bdRWX23L8+kaFAD1DgaqbPT7XMYCeA6Qh1BRqVOz8q4wzk6dbFm8K1WVjvC
         S+Sw==
X-Gm-Message-State: ABy/qLZgm699jov+2cjN21r+YqlAPFY48pXGIraOlEA6kdotKeH3vNl9
        WnZvX8rKw68FWDxWQyHsbqo=
X-Google-Smtp-Source: APBJJlGGypX+v5MzycUzumx+CRUCdd0/RZ51+QF02i+R9Xx9KDzdU4X8EgAM+zTDxV9IMoWuyMcmsg==
X-Received: by 2002:a05:6870:82a4:b0:1be:d3a1:fd9 with SMTP id q36-20020a05687082a400b001bed3a10fd9mr7622319oae.9.1690909409285;
        Tue, 01 Aug 2023 10:03:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 10/22] dyndbg: tighten ddebug_class_name() 1st arg type
Date:   Tue,  1 Aug 2023 11:02:42 -0600
Message-ID: <20230801170255.163237-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
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

