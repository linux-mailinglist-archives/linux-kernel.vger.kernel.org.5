Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158D87C774A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442786AbjJLTtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442582AbjJLTtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7617C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:47 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a2a9e5451bso55475239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140127; x=1697744927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6n2IA/eHEf6LdvM5ZmMrOftNFYznxmP1Ujq1nl5xlM=;
        b=ltMEbFLkfKUnvfbMJ0YNOCO3bEbsAjJrVlLkE0NspCBl1IhQ5KSDJt2Mq0GTzkjCaV
         H2V1TT8bfHHPsq9g9WJxTUwHaMHs0GEs4cNUBAXmm/JVk1JxyAnbNCAQijtm9i6WsZwP
         lYge+IHeozBI1d7MApuLRXaKVyhLn0WfNn6N3w8AQI3lMa5DHnMQ0Sq0/6plxhZIOvpg
         TItZjKPdUKhva7gyDC8vX7CqsNIDlypRiJJqkLKVNAUHBOdvHS7P9qYHZFj32sRFujac
         Y+20Xx7SNVQuYWkN+tJFegLNWvtnQHlglc8Rkyl/dQ0MFr7ADGHl5izN+hqD6rcRl3PQ
         LOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140127; x=1697744927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6n2IA/eHEf6LdvM5ZmMrOftNFYznxmP1Ujq1nl5xlM=;
        b=Imsn6FmFQs689EIIxCYYE2P6PN0OwJb0nbdiuubnGhIHAtGDxWmcjG/A70KgCjH4bN
         K8tfC81g4bx1nqI3jz/22NL9sG5A07m2qNkD3w13hSAzK4tUE0XMwEvg2D+3UqubOWbh
         +IlsIz6JT2UjcMQA82wLAcdTflbrcREut1B2+qOIAzwXMup44+LZcJMOGWhrSrBSQc6W
         JNVPhTDHlB29Yp9AWy0a+vbpua1dSeW47RXoJYZ3Uh/pt25O1yTyXFVSRN4Jce1AFoUv
         BUk8W2S1X9ljV3+RS0ZOQZITGippZBM9i8fBEl6FVGfAKmOWbTBoKm4oexb2kq1A166p
         XCTA==
X-Gm-Message-State: AOJu0YzC+XBNTTRrRlX63jiiMCgr7JsOTmljmHlmHfWFQ2JupjNzikSy
        tOfuTTS19UF+yPD9w/z7C1XC/sFyWK0kWw==
X-Google-Smtp-Source: AGHT+IEnq0smZ7G8P5z5vC02OT8MB+EcSRtbm1qklN4D/7Ye4KzZyrfDlCDnug/mqix5MN36Nab6Uw==
X-Received: by 2002:a05:6602:29a3:b0:785:d4f5:2225 with SMTP id u3-20020a05660229a300b00785d4f52225mr28824779ios.19.1697140127022;
        Thu, 12 Oct 2023 12:48:47 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 10/10] dyndbg: cache the dynamically generated prefixes per callsite
Date:   Thu, 12 Oct 2023 13:48:34 -0600
Message-ID: <20231012194834.3288085-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194834.3288085-1-jim.cromie@gmail.com>
References: <20231012194834.3288085-1-jim.cromie@gmail.com>
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

Add a private maple-tree to cache any prefix strings required (and
then generated) for any enabled pr_debug callsites.  And delete any
cache entries if any flags are changed afterwards.

This cache is strictly per-callsite, so if a function has 20
pr_debugs, all enabled with the same flags:

  echo function foo +pmfs > /proc/dynamic_debug/control

there will be 20 separate, identical cache items created.
Maybe this can be trivially improved later.
Or lineno could be folded in too, so the %d is rendered once.

NB: +tl flags are added outside the cache; the thread-id doesnt belong
in the cache, the lineno could be added, esp if the 20:1 sharing isnt
trivial enough.

NBB: lineno:18 is enormously "sparse".  At this point its not so far
to pack it into something else.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 92ffd70a07de..02df61ab6403 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -90,6 +90,8 @@ MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 static DEFINE_MTREE(mt_funcs);
 static DEFINE_MTREE(mt_files);
 static DEFINE_MTREE(mt_mods);
+/* cache of composed prefixes for enabled pr_debugs */
+static DEFINE_MTREE(pr_prefixes);
 
 static void dd_mt_scan(struct maple_tree *mt, const char *kind);
 static int param_set_do_scan(const char *instr, const struct kernel_param *kp)
@@ -112,6 +114,11 @@ static const struct kernel_param_ops param_ops_do_scan = {
 };
 module_param_cb(do_scan, &param_ops_do_scan, NULL, 0600);
 
+void ddebug_clear_prefix_cache(const struct _ddebug *dp)
+{
+	mtree_erase(&pr_prefixes, (unsigned long)dp);
+}
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -350,6 +357,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
 				continue;
+			ddebug_clear_prefix_cache(dp);
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
 				if (!(newflags & _DPRINTK_FLAGS_PRINT))
@@ -855,8 +863,18 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static int __dynamic_emit_prefix(const struct _ddebug *desc, char *buf, int pos)
+static int __dynamic_emit_prefix(struct _ddebug *desc, char *buf, int pos)
 {
+	char *prefix, *cpy;
+
+	if (desc->flags & _DPRINTK_FLAGS_PREFIX_CACHED) {
+		prefix = (char*) mtree_load(&pr_prefixes, (unsigned long)desc);
+		if (prefix) {
+			pos += snprintf(buf + pos, remaining(pos), "%s", prefix);
+			v4pr_info("using prefix cache:%px %s", buf, buf + pos);
+			return pos;
+		}
+	}
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc_modname(desc));
@@ -866,6 +884,13 @@ static int __dynamic_emit_prefix(const struct _ddebug *desc, char *buf, int pos)
 	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				trim_prefix(desc_filename(desc)));
+
+	/* save dup of buf to cache */
+	cpy = kstrdup(buf + pos, GFP_KERNEL);
+	mtree_store(&pr_prefixes, (unsigned long)desc, (void*)cpy, GFP_KERNEL);
+	desc->flags |= _DPRINTK_FLAGS_PREFIX_CACHED;
+	v3pr_info("filling prefix cache:%px %s", desc, cpy);
+
 	return pos;
 }
 
-- 
2.41.0

