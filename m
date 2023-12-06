Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7E80672C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376994AbjLFGHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376904AbjLFGGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:06:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21071D6D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d069b1d127so26084855ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842797; x=1702447597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6abx9zF8o8O5TeS/ywwBDTAT+8QpF2rP4pNJ9ZpbgvE=;
        b=nLK+P+X6MBvI4uK779aodJifGNiro1QhuSp848soYZsUF7Y8tiAietL/WwwiSPgS84
         s7NwROAcdxsuYb9dXJgkNockQQyfVQrCL9/31a3AC9N8Fn5xjzDzFeJtdh70Y4cZhoYS
         WBkFTzhqamosXgvoln0cb3daNPiwuIsChm9CWTfw8Ds2hFVe9W1Mp0UIJPoMY13eXrr7
         yXC1T9qugab1tcrvHcnZk2etfRIkKHeOMtJleVbg+nPbsdy3X35iqymk8zJkH0vSFR2L
         sVS5fgP8cbUEPiteZChwcZh/ubBTAGen6Yd+G4W54CWgIpT2iTzeXaM62lcuddZ5NvGO
         C1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842797; x=1702447597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6abx9zF8o8O5TeS/ywwBDTAT+8QpF2rP4pNJ9ZpbgvE=;
        b=hGIutnKqwFQXOwkgAz3mIJHqTupxQ3vvJsVuQ/+xcQ/J4YVq8gqVFK43STR7n7b8Ra
         CWhSz+AKHfotE/09Ddreg5O6eyl2tvB3yeH4zjdy9UWJNfqUMXLxVF9DR6bzzt2wa1FS
         cX4idEUyFNz+j6c0ZP0iK7iotofqRfp15Oy3lQsbLvmi1EX7g4uu9/Ztkgj7mrpK63Hv
         7w/qWEghcokLkG2cClwRNlet3bw+xirMaVtwtMHaATsFbw00EgALiNCVp7ql+Nf8q9GK
         rH5BGi1/3puMXLOe70b1tlqZy7Wc9KRzDwhxfFd5W9wicDHWvx0DlZevopj4BabTxvHe
         Davg==
X-Gm-Message-State: AOJu0YzOqXboKZkHU4bCfVNnLAKw0ArZXlS33EwBRuKukTubmPfMy/Y6
        JSS9sQ5a7HzbZzbhQajrwcmESQ==
X-Google-Smtp-Source: AGHT+IFKCj2l+HHNkskWM6wYwhN/m2VAve+sjenp2dIB6q/RGjWECFDc5vjIz5MBW7qSCJwyduhwrQ==
X-Received: by 2002:a17:902:bc8c:b0:1d0:6ffd:f222 with SMTP id bb12-20020a170902bc8c00b001d06ffdf222mr231131plb.120.1701842797392;
        Tue, 05 Dec 2023 22:06:37 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001d0b4693539sm3945964pli.189.2023.12.05.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:34 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.96)
        (envelope-from <dave@fromorbit.com>)
        id 1rAl3I-004VP7-13;
        Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
        (envelope-from <dave@devoid.disaster.area>)
        id 1rAl3H-0000000BrVf-3cUt;
        Wed, 06 Dec 2023 17:06:31 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-cachefs@redhat.com,
        dhowells@redhat.com, gfs2@lists.linux.dev,
        dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] hash-bl: explicitly initialise hash-bl heads
Date:   Wed,  6 Dec 2023 17:05:38 +1100
Message-ID: <20231206060629.2827226-10-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Because we are going to change how the structure is laid out to
support RTPREEMPT and LOCKDEP, just assuming that the hash table is
allocated as zeroed memory is no longer sufficient to initialise
a hash-bl table.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/dcache.c           | 21 ++++++++++++++++++++-
 fs/fscache/cookie.c   |  8 ++++++++
 fs/fscache/internal.h |  6 ++++--
 fs/fscache/main.c     |  3 +++
 fs/fscache/volume.c   |  8 ++++++++
 fs/inode.c            | 19 ++++++++++++++++++-
 6 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c82ae731df9a..9059b3a55370 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3284,7 +3284,10 @@ __setup("dhash_entries=", set_dhash_entries);
 
 static void __init dcache_init_early(void)
 {
-	/* If hashes are distributed across NUMA nodes, defer
+	int i;
+
+	/*
+	 * If hashes are distributed across NUMA nodes, defer
 	 * hash allocation until vmalloc space is available.
 	 */
 	if (hashdist)
@@ -3300,11 +3303,20 @@ static void __init dcache_init_early(void)
 					NULL,
 					0,
 					0);
+	/*
+	 * The value returned in d_hash_shift tells us the size of the
+	 * hash table that was allocated as a log2 value.
+	 */
+	for (i = 0; i < (1 << d_hash_shift); i++)
+		INIT_HLIST_BL_HEAD(&dentry_hashtable[i]);
+
 	d_hash_shift = 32 - d_hash_shift;
 }
 
 static void __init dcache_init(void)
 {
+	int i;
+
 	/*
 	 * A constructor could be added for stable state like the lists,
 	 * but it is probably not worth it because of the cache nature
@@ -3328,6 +3340,13 @@ static void __init dcache_init(void)
 					NULL,
 					0,
 					0);
+	/*
+	 * The value returned in d_hash_shift tells us the size of the
+	 * hash table that was allocated as a log2 value.
+	 */
+	for (i = 0; i < (1 << d_hash_shift); i++)
+		INIT_HLIST_BL_HEAD(&dentry_hashtable[i]);
+
 	d_hash_shift = 32 - d_hash_shift;
 }
 
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index bce2492186d0..21617f7c88e4 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -32,6 +32,14 @@ static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
 static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
+void fscache_cookie_hash_init(void)
+{
+	int i;
+
+	for (i = 0; i < (1 << fscache_cookie_hash_shift); i++)
+		INIT_HLIST_BL_HEAD(&fscache_cookie_hash[i]);
+}
+
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
 	const u8 *k;
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 1336f517e9b1..6cbe07decc11 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -61,8 +61,9 @@ extern const struct seq_operations fscache_cookies_seq_ops;
 #endif
 extern struct timer_list fscache_cookie_lru_timer;
 
-extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
-extern bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
+void fscache_cookie_hash_init(void);
+void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
+bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
 					enum fscache_access_trace why);
 
 static inline void fscache_see_cookie(struct fscache_cookie *cookie,
@@ -143,6 +144,7 @@ int fscache_stats_show(struct seq_file *m, void *v);
 extern const struct seq_operations fscache_volumes_seq_ops;
 #endif
 
+void fscache_volume_hash_init(void);
 struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where);
 void fscache_put_volume(struct fscache_volume *volume,
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index dad85fd84f6f..7db2a4423315 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -92,6 +92,9 @@ static int __init fscache_init(void)
 		goto error_cookie_jar;
 	}
 
+	fscache_volume_hash_init();
+	fscache_cookie_hash_init();
+
 	pr_notice("Loaded\n");
 	return 0;
 
diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index cdf991bdd9de..8b029c46a3a3 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -17,6 +17,14 @@ static LIST_HEAD(fscache_volumes);
 
 static void fscache_create_volume_work(struct work_struct *work);
 
+void fscache_volume_hash_init(void)
+{
+	int i;
+
+	for (i = 0; i < (1 << fscache_volume_hash_shift); i++)
+		INIT_HLIST_BL_HEAD(&fscache_volume_hash[i]);
+}
+
 struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where)
 {
diff --git a/fs/inode.c b/fs/inode.c
index 3eb9c4e5b279..57c1030ccad3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2353,7 +2353,10 @@ __setup("ihash_entries=", set_ihash_entries);
  */
 void __init inode_init_early(void)
 {
-	/* If hashes are distributed across NUMA nodes, defer
+	int i;
+
+	/*
+	 * If hashes are distributed across NUMA nodes, defer
 	 * hash allocation until vmalloc space is available.
 	 */
 	if (hashdist)
@@ -2369,10 +2372,18 @@ void __init inode_init_early(void)
 					&i_hash_mask,
 					0,
 					0);
+	/*
+	 * The value returned in i_hash_shift tells us the size of the
+	 * hash table that was allocated as a log2 value.
+	 */
+	for (i = 0; i < (1 << i_hash_shift); i++)
+		INIT_HLIST_BL_HEAD(&inode_hashtable[i]);
 }
 
 void __init inode_init(void)
 {
+	int i;
+
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache",
 					 sizeof(struct inode),
@@ -2395,6 +2406,12 @@ void __init inode_init(void)
 					&i_hash_mask,
 					0,
 					0);
+	/*
+	 * The value returned in i_hash_shift tells us the size of the
+	 * hash table that was allocated as a log2 value.
+	 */
+	for (i = 0; i < (1 << i_hash_shift); i++)
+		INIT_HLIST_BL_HEAD(&inode_hashtable[i]);
 }
 
 void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
-- 
2.42.0

