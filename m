Return-Path: <linux-kernel+bounces-43755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D45841898
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B741C22952
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A6B54FB2;
	Tue, 30 Jan 2024 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="R6ky2NEp"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FF52F9E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578956; cv=none; b=pe7rVWqoHfHUspNahrwoWzT1gl4kGAjqzO3hwyG/Q5gtIV9Bis9TKqshzF1sV7cbPHJzrVsPvlir3VrpIQR1+YZ8ZCHS2fe9/qz9rL8eh9FkPxLdfH+1LHNMwuGHTRUXfKwyTMSr+uvQsJXVzdigxbDJehleufE3ddrJrWjQ4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578956; c=relaxed/simple;
	bh=nVmTrh/MvSf2JoHLpJGtENs1fTerVQ5OS6a8IAmlm6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoSCDTr8IVaWugU5lRYybIi2vfVeIkf76NnGU0ijwWlodmqhYapbMzVNUGbLoNQGVWZVTfFzrE1DG2iRE2VBg0toM6jRdSbOK/g2TNJsosquBfp8TnFbZOj3dWy/6GksmK2cr7muZ2z8bk9e4W40DLfAyq62/MFUz+2tnvKEFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=R6ky2NEp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a99cbb4bbso14297421cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578953; x=1707183753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBr/4NzQcxrA4rNO53TUlaG7d5zRLMT2JlV2BMAMPQs=;
        b=R6ky2NEpwqYitL3F/XRpOcE6iRCLlTXeC94g5fP42o1r/mjHwkScIKdXqgTDaG98+l
         DjVbd3weoahgacYZdsIeHGyoZmCiJWXrfqoPhUNR6CgrP55GkhYOm/nJ5GsGHOykcN4q
         dHZXUZHXk4BFz8j40LA4u3pgMmGUFQWAlXoA+vzbx7rBCTxcHaen9sMSncoZvolqjZsk
         kFSgsD6ZrjncQGzyMmd69pUK7Qs03s4TbY73Wi3uMO7xIZBeTjtEUw9iNBRvAyvONvqy
         6GP4IfNA6tFth6yijbsxM2FnWy6TnwzDgq/HTe/+kMFeorxiPYZ4cqzZz3l6fqfF23YY
         DAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578953; x=1707183753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBr/4NzQcxrA4rNO53TUlaG7d5zRLMT2JlV2BMAMPQs=;
        b=I5OUCwk/nTv5esHShxRTH7/Nb6eU/7vPhp+nbCYPRsaSwFjr7mGquD0kc/wCvIWQjf
         PTLI8PWP633remiDMszRrmlbAc16RpFvTQZ/a45GwrXKiRHDfH4pAzIVl4YnXHv5Ha2F
         NietUX4qANlstMbm1N9Jgw0UZMcnS+HW0NaeIvk3jsU6DUcngTdLfIHwm+7akCSJj9p9
         vAocnOt3VLB02NnUyeppNb0azGqizGTdKck+cTk57W7SxAf8MAhE1XngySPw/JReyK5c
         cggbEUJIgKQq+ThoROgDwmNXU0s+AgtN9Hp6rt7B8tmxesCvZJlaeC3LtKK2CyvyL7GV
         Mlrg==
X-Gm-Message-State: AOJu0YyOcBUS+n7gVOePAA8fDgm9FCy2lIITZP3VOBGOEbkpuXE2u7kV
	QOb3PtSE+CQZ4sLiBMFS6uORttppixkzG5lfKEaYuaTWO4xCe19OxJIN+/e70Ah+zFxCBhqLzJj
	G
X-Google-Smtp-Source: AGHT+IFnFy8t74gPrfD3nUEsIc6ZJrr+zQk6hXnBVgVJPyD5DXHBfSOXtvC3SYSy8pD3LO1UcyYHNA==
X-Received: by 2002:ac8:59cc:0:b0:42a:ad25:21a2 with SMTP id f12-20020ac859cc000000b0042aad2521a2mr340871qtf.16.1706578953364;
        Mon, 29 Jan 2024 17:42:33 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id bb36-20020a05622a1b2400b0042ab4a129easm236641qtb.73.2024.01.29.17.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:33 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] mm: zswap: function ordering: move entry section out of tree section
Date: Mon, 29 Jan 2024 20:36:52 -0500
Message-ID: <20240130014208.565554-17-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The higher-level entry operations modify the tree, so move the entry
API after the tree section.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 756d4d575efe..80adc2f7d1a2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -848,27 +848,6 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 	spin_unlock(&zswap_pools_lock);
 }
 
-/*********************************
-* zswap entry functions
-**********************************/
-static struct kmem_cache *zswap_entry_cache;
-
-static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
-{
-	struct zswap_entry *entry;
-	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
-	if (!entry)
-		return NULL;
-	entry->refcount = 1;
-	RB_CLEAR_NODE(&entry->rbnode);
-	return entry;
-}
-
-static void zswap_entry_cache_free(struct zswap_entry *entry)
-{
-	kmem_cache_free(zswap_entry_cache, entry);
-}
-
 /*********************************
 * rbtree functions
 **********************************/
@@ -930,6 +909,27 @@ static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
 	return false;
 }
 
+/*********************************
+* zswap entry functions
+**********************************/
+static struct kmem_cache *zswap_entry_cache;
+
+static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
+{
+	struct zswap_entry *entry;
+	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
+	if (!entry)
+		return NULL;
+	entry->refcount = 1;
+	RB_CLEAR_NODE(&entry->rbnode);
+	return entry;
+}
+
+static void zswap_entry_cache_free(struct zswap_entry *entry)
+{
+	kmem_cache_free(zswap_entry_cache, entry);
+}
+
 static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 {
 	int i = 0;
-- 
2.43.0


