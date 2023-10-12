Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB037C7736
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442778AbjJLTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442640AbjJLTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:40 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5980DA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fe6da0049so55216739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140051; x=1697744851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6n2IA/eHEf6LdvM5ZmMrOftNFYznxmP1Ujq1nl5xlM=;
        b=Q7Oe7F/zJLL8IR7TW7SSCog9l0h8zrRSR3WWxOnkfhxVrsnVBO97J2v70BwVEBFDmN
         TtzER+z/8WuU89ReRwNYBcJ6COxYiZCaJvVPvBr3bUJsYnnm82GjpfMP2fmq3UY1RD71
         IIGwlY57BrVbuzyrZo0PXOEYPEVDCaF3TX52tBWNoJeuJ1XMGjNyuY7A8ai6Fqyg0tmN
         nL1keobWjIgif98loQkAjhLfIhvPDQHUnmvTXe487DflOtzUZRT8BV91TiKoXBzyXS+n
         C/j5XpqPOW5ZYKBnFguTsDuXL0A6fqb8JsQtWTyITt0V/n0kpIIo3J67Mh1IIBE0B0xn
         wkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140051; x=1697744851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6n2IA/eHEf6LdvM5ZmMrOftNFYznxmP1Ujq1nl5xlM=;
        b=rJXNmFmLDotG8WfzjrtkQcd/OjLJI7WMDSvYSz6Z9H4u7b3Iu6Dfe7Y5cpuLLiN6T+
         kTHYSnHxuPFhkMspkx1Vq8FAU/VSQC9M+7iVn0+XTdZCz7T4ivELbFEAJ1e9TPD05l4Y
         TGV6N+Sh+PSrkDYf8K/Qw7ds/hPxrMwA8v3PcfNIsNnRmMb38WMC3P6o/+VoKFTHHw0G
         6WEQqjeLlenvLoRDnjU0uZaRpFWPcOKz/64Auz7kJ4+2a5dxus03nOqJIOwPdmJdvBOh
         lbmdgp9MwbtMHnmjmanvR3kc0flPrpphBWaLpeA6HLVZpSPud9/wiQHx7zJaIyUhOYsM
         V0UQ==
X-Gm-Message-State: AOJu0YwXNTOllAGBJTf6+tIuT2hSfFKHi8KbIawF5ssifqRZqhH99JZ6
        5n1bn5a9je4TUmVhZhtkDgl7ySvmQjh+zg==
X-Google-Smtp-Source: AGHT+IGFZRnX/2jEPkfFaY6CF3iLQdJpD5uSzZ8sAWGpNzzXtIHRrYje0mKyf+N3fhni1GhvWfWi0w==
X-Received: by 2002:a5d:9cd5:0:b0:79f:d4e6:5175 with SMTP id w21-20020a5d9cd5000000b0079fd4e65175mr28322159iow.16.1697140051534;
        Thu, 12 Oct 2023 12:47:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 10/10] dyndbg: cache the dynamically generated prefixes per callsite
Date:   Thu, 12 Oct 2023 13:47:11 -0600
Message-ID: <20231012194711.3288031-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194711.3288031-1-jim.cromie@gmail.com>
References: <20231012194711.3288031-1-jim.cromie@gmail.com>
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

