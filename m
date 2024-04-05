Return-Path: <linux-kernel+bounces-132426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7528994C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FB01C226DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A01B249F9;
	Fri,  5 Apr 2024 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZrv1iuN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB92262B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712295319; cv=none; b=YebOSQpQ0rwiv3/bXNjgKgFUpierbS4P06k6CYhQqEG6saXzv40aYZKDUvNBGt6KRPKlfJvXpr3lKoyYHITsm/rnWuHSDB6VMOlhZkXalUUwGlRtxqgD9d103D8z8MgWyQp4E3jiJnk+GrjCjYmmcRNfLWMNhFCtyqMFUfF3lvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712295319; c=relaxed/simple;
	bh=UkS+UYc9cwpvUdu5QZSiW9gBMAbwVnbpUHqxoQJnyCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=roem8CRw+JhtfXC/APlDBLfiYJFMmzPOAuZphcOdvrNGJSbCQwRWg8yUNlACx56STYANyerRxxvAy44fY6nf0MxLCjBf/QF/dy5dPEjLsjlCmV2gQ3WpGR6BQ9bZcrOGeLi+VC9PFWiO0Nn/Rc2uuKrxTPNTrkyvbmSrNZumkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZrv1iuN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so3323046276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712295316; x=1712900116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLsh2mavKyRbc6llROScpNs5yKk8UXbWOX30PW11RTM=;
        b=cZrv1iuNAB1701JwUO6+3K2fqh5eO4pLDlRP4/MsQ7MIFX1T151emjidLTO/evkFNB
         OvcXB1SnV3Y3n3hQ8s3ltXBtroZyLAQPXXsPswcpYPWMT3iOghwTFAAxUWwCz7GbltDB
         kL+T60EoeMQUd0XBOE1yboUROggN4mWz3qSVSD6x6TL5r2iU91EnuY7QyFZJqxVhSxiQ
         C5rlPgZksbavc6Dv4RSzNAf3E8VaUYQYSwVpzXcMYJNGKMOv5hfkWnDmxDHx4NTwHx25
         qi+bHEXamGSySczhiiCeESIZfywdnJAOSLD+7X1s0l32BVBBn3cn+3k9sOxEvsJuC535
         jUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712295316; x=1712900116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLsh2mavKyRbc6llROScpNs5yKk8UXbWOX30PW11RTM=;
        b=M84q86ILD4X+WfM3j8gdIr5UF2QMFCdC8nUKICoHbcAL46/8j2Qa6ejq4vG5BjTd2p
         aNvMnJ7dk3wiVxIN1bHf+nL2fYVb1NfVQ/JHkGpqxzKIrVqxSFl/puwrBTlsH6nDHonY
         obPrdGNJ7mK5HBfDwGad9Jo80csMMP5PETTNi9dXnB18H4+9Y+hZqvsyzIe/M2P2XkI0
         igjVRm9lhvY9MdJC5G98MXuWF23qaAuYRJ1V6N+HgtBdkeZO9Q1/zwrJ2jGs26HdWRmg
         o+yZBZhicHazVf1rPunVFA4vescjeKXKT6hhvHDQs8r26UTCK3fwtIuVGslIpVlnAJVj
         Al0g==
X-Forwarded-Encrypted: i=1; AJvYcCXn4sYtzw7x3sJ5PU/VxyoZJuA4CrXpxMPVVHjvmZfxwLkd9+Mbmmzf0Vu7aEIvRABtbQd4bZtDwuN8hJBb3NsLLZQP7vxRxmlk4MxA
X-Gm-Message-State: AOJu0Yy342CBFNSYQWLU+c7ETh3HLQPSjceOND/sTL43mDTY6wBdCmzw
	35eM+wBB9A95ktiCFjeW+BkgRklF1r6FDAsB2tVZU8iX9QnAIW5m/x8oY/8cTKKUQKdjzF8B/w0
	ATXTcouIVJwCYSEROCA==
X-Google-Smtp-Source: AGHT+IH7oL3hUlxA/yZh4c4iQx4M23yR54gCIDKzNRckDvrgcltEIddaQ+ef2AO7ne3vgWVM1zEbXHHpxJ8/KEde
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:f87:b0:dc7:8e30:e2e3 with SMTP
 id ft7-20020a0569020f8700b00dc78e30e2e3mr97855ybb.2.1712295316513; Thu, 04
 Apr 2024 22:35:16 -0700 (PDT)
Date: Fri,  5 Apr 2024 05:35:07 +0000
In-Reply-To: <20240405053510.1948982-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405053510.1948982-3-yosryahmed@google.com>
Subject: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, we calculate the zswap global limit, and potentially the
acceptance threshold in the zswap, in pages in the zswap store path.
This is unnecessary because the values rarely change.

Instead, precalculate the them when the module parameters are updated,
which should be rare. Since we are adding custom handlers for setting
the percentages now, add proper validation that they are <= 100.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 86 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1cf3ab4b22e64..832e3f56232f0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -116,12 +116,29 @@ module_param_cb(zpool, &zswap_zpool_param_ops, &zswap_zpool_type, 0644);
 
 /* The maximum percentage of memory that the compressed pool can occupy */
 static unsigned int zswap_max_pool_percent = 20;
-module_param_named(max_pool_percent, zswap_max_pool_percent, uint, 0644);
+static unsigned long zswap_max_pages;
+
+static int zswap_max_pool_param_set(const char *,
+				       const struct kernel_param *);
+static const struct kernel_param_ops zswap_max_pool_param_ops = {
+	.set =		zswap_max_pool_param_set,
+	.get =		param_get_uint,
+};
+module_param_cb(max_pool_percent, &zswap_max_pool_param_ops,
+		&zswap_max_pool_percent, 0644);
 
 /* The threshold for accepting new pages after the max_pool_percent was hit */
 static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
-module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
-		   uint, 0644);
+unsigned long zswap_accept_thr_pages;
+
+static int zswap_accept_thr_param_set(const char *,
+				      const struct kernel_param *);
+static const struct kernel_param_ops zswap_accept_thr_param_ops = {
+	.set =		zswap_accept_thr_param_set,
+	.get =		param_get_uint,
+};
+module_param_cb(accept_threshold_percent, &zswap_accept_thr_param_ops,
+		&zswap_accept_thr_percent, 0644);
 
 /*
  * Enable/disable handling same-value filled pages (enabled by default).
@@ -490,14 +507,16 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
-static unsigned long zswap_max_pages(void)
+static void zswap_update_max_pages(void)
 {
-	return totalram_pages() * zswap_max_pool_percent / 100;
+	WRITE_ONCE(zswap_max_pages,
+		   totalram_pages() * zswap_max_pool_percent / 100);
 }
 
-static unsigned long zswap_accept_thr_pages(void)
+static void zswap_update_accept_thr_pages(void)
 {
-	return zswap_max_pages() * zswap_accept_thr_percent / 100;
+	WRITE_ONCE(zswap_accept_thr_pages,
+		   READ_ONCE(zswap_max_pages) * zswap_accept_thr_percent / 100);
 }
 
 unsigned long zswap_total_pages(void)
@@ -684,6 +703,43 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
+static int __zswap_percent_param_set(const char *val,
+				     const struct kernel_param *kp)
+{
+	unsigned int n;
+	int ret;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret || n > 100)
+		return -EINVAL;
+
+	return param_set_uint(val, kp);
+}
+
+static int zswap_max_pool_param_set(const char *val,
+				    const struct kernel_param *kp)
+{
+	int err = __zswap_percent_param_set(val, kp);
+
+	if (!err) {
+		zswap_update_max_pages();
+		zswap_update_accept_thr_pages();
+	}
+
+	return err;
+}
+
+static int zswap_accept_thr_param_set(const char *val,
+				      const struct kernel_param *kp)
+{
+	int err = __zswap_percent_param_set(val, kp);
+
+	if (!err)
+		zswap_update_accept_thr_pages();
+
+	return err;
+}
+
 /*********************************
 * lru functions
 **********************************/
@@ -1305,10 +1361,6 @@ static void shrink_worker(struct work_struct *w)
 {
 	struct mem_cgroup *memcg;
 	int ret, failures = 0;
-	unsigned long thr;
-
-	/* Reclaim down to the accept threshold */
-	thr = zswap_accept_thr_pages();
 
 	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
@@ -1358,7 +1410,8 @@ static void shrink_worker(struct work_struct *w)
 			break;
 resched:
 		cond_resched();
-	} while (zswap_total_pages() > thr);
+		/* Reclaim down to the accept threshold */
+	} while (zswap_total_pages() > READ_ONCE(zswap_accept_thr_pages));
 }
 
 static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
@@ -1424,16 +1477,14 @@ bool zswap_store(struct folio *folio)
 
 	/* Check global limits */
 	cur_pages = zswap_total_pages();
-	max_pages = zswap_max_pages();
-
-	if (cur_pages >= max_pages) {
+	if (cur_pages >= READ_ONCE(zswap_max_pages)) {
 		zswap_pool_limit_hit++;
 		zswap_pool_reached_full = true;
 		goto reject;
 	}
 
 	if (zswap_pool_reached_full) {
-		if (cur_pages > zswap_accept_thr_pages())
+		if (cur_pages > READ_ONCE(zswap_accept_thr_pages))
 			goto reject;
 		else
 			zswap_pool_reached_full = false;
@@ -1734,6 +1785,9 @@ static int zswap_setup(void)
 		zswap_enabled = false;
 	}
 
+	zswap_update_max_pages();
+	zswap_update_accept_thr_pages();
+
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
 	zswap_init_state = ZSWAP_INIT_SUCCEED;
-- 
2.44.0.478.gd926399ef9-goog


