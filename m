Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6557C7735
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442751AbjJLTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442529AbjJLTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:34 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5332F7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:31 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a25040faffso57245439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140050; x=1697744850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr8tQe/cDXue74QN3U0cEdutzIhNedVe/s3FJQcenu4=;
        b=YHVWKxIhT0CcKHm18j/EJlwqsMGKQlX6RfscPwPuLzQAdRcDbwugzX5RvnuFT4Bk5C
         TUaYrYn3XSSSRUlPenLuiMV0s6okybH1XW6KMoEcpYrcnGLGqNHojO8/svv2Ebay9/TN
         Wdr0OoRge9+Lj3Auj7EjQAe2yz/htyHKVvJzSRshhwxkmZRw8iO5zcyAVhAkk41/zBNo
         H3MYBXkwWgfB3r2evraA3p9PTslHOazEO0it9/9Pqk+QjePDKKHJC1JPdxnLKVn9psfZ
         3zdbve5IDsJ34ca5U67rKJVtT0OeuyBnfRDkc0up+8El/AbCo2gG8ZViqoAMWcLTA2Ms
         e9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140050; x=1697744850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jr8tQe/cDXue74QN3U0cEdutzIhNedVe/s3FJQcenu4=;
        b=vvneRmHY8c//pO7nCXH5chbMFBtUwprIg2ub/GzHIEjj/NjlT4sjS12eV0Tf4ZRMDy
         vMXnklxNOVfzWDU4e38LQ8Nh2au1/IWtELRCLe7J3cuRZU0XmA4amNheUtksWrxWs3aZ
         k5a5OiH2Bse44FoxNVYbUrvWKBw5eVwgkNMegouXkVQtn6JgdCAufMOt4Lq56YqD/OvM
         WjrSvvkfRfj3liyPiIkdMlaLx8kHOjfqtHi7erF7pCmdADVqrFeq32W+x6OrvqnUc0MJ
         4svFt7+yXfhl9O/T26eLAI2PFaAWXGyeoDtT7AuF77Bux+Ft/4uSpZ3k9nWROVQRbbbE
         Wytw==
X-Gm-Message-State: AOJu0YwgH4CvGFz5K2BQ5HGH5fl+JQ3ThudjxV5Z+Jyuib0DvH+wFhVO
        TDqphKYwgcvVhnY10SaeogTbPXAUbkakxg==
X-Google-Smtp-Source: AGHT+IHU6/UwAxmm5iYu+krC4jYwWl30+9Laj14aUjTrmQt6Cnwhp5cwnYiXxGdgbdS9u1QcuHlA7A==
X-Received: by 2002:a6b:da06:0:b0:783:4e11:76d7 with SMTP id x6-20020a6bda06000000b007834e1176d7mr24140049iob.21.1697140050527;
        Thu, 12 Oct 2023 12:47:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 09/10] dyndbg: add dd_clear_range to prune mtrees
Date:   Thu, 12 Oct 2023 13:47:10 -0600
Message-ID: <20231012194711.3288031-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194711.3288031-1-jim.cromie@gmail.com>
References: <20231012194711.3288031-1-jim.cromie@gmail.com>
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

Call new dd_clear_range() from ddebug_remove_module().  It calls
mtree_erase() on the trees storing the function, filename, modname
intervals, and passing the 1st descriptor of the interval (ie the
index used on the insert).

dd_clear_range() should properly undo the 3 mtree_insert_ranges done
by dd_store_range.

RFC: it doesnt work as I expected. What am I missing ?

The following log shows that 'rmmod amdgpu' only removes 1 entry from
each maple-tree, not the whole interval.  My index is the 1st
descriptor in each interval.

ISTM (naive reader) this contradicts the documented behavior.

  void *mtree_erase(struct maple_tree *mt, unsigned long index)
  Find an index and erase the entire range.

what is my "entire range" ?

bash-5.2# modprobe amdgpu
....
[   74.256006] dyndbg: attach-client-module:  module:amdgpu nd:4652 nc:0 nu:1
[   74.256968] dyndbg: 4652 debug prints in module amdgpu

bash-5.2# echo 2 > /sys/module/dynamic_debug/parameters/do_scan
[   81.370509] dyndbg: cache: funcs has 3741 entries
[   81.371233] dyndbg: cache: files has 911 entries
[   81.371819] dyndbg: cache: mods has 323 entries

bash-5.2# rmmod amdgpu
[  102.325851] dyndbg: removed module "amdgpu"

bash-5.2# echo 2 > /sys/module/dynamic_debug/parameters/do_scan
[  105.277439] dyndbg: cache: funcs has 3740 entries
[  105.278163] dyndbg: cache: files has 910 entries
[  105.278756] dyndbg: cache: mods has 322 entries

cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
cc: linux-mm@kvack.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fb72a7b05b01..92ffd70a07de 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1426,6 +1426,14 @@ static void dd_store_range(struct maple_tree *mt, const struct _ddebug *start,
 		v4pr_info("  ok %s at %lx\n", val, first);
 }
 
+static void dd_clear_range(const struct _ddebug *start)
+{
+	v3pr_info("clearing %px\n", start);
+	mtree_erase(&mt_funcs, (unsigned long)start);
+	mtree_erase(&mt_files, (unsigned long)start);
+	mtree_erase(&mt_mods, (unsigned long)start);
+}
+
 #define site_function(s)	(s)->_function
 #define site_filename(s)	(s)->_filename
 #define site_modname(s)		(s)->_modname
@@ -1578,6 +1586,8 @@ static int ddebug_remove_module(const char *mod_name)
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
 		if (dt->mod_name == mod_name) {
+			/* free mtree entries on descs */
+			dd_clear_range(dt->ddebugs);
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
-- 
2.41.0

