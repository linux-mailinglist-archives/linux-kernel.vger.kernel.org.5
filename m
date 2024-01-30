Return-Path: <linux-kernel+bounces-43753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD4841896
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B256B234D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B45537FC;
	Tue, 30 Jan 2024 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CkD3Z2+B"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE538DE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578953; cv=none; b=MwGErnV2I6li5WT+v+Bpr98cOTc6tfXbab8ljt4ErJen7oTwTySaPnmUhNZM1uiHOzuPCTX6qCKS4LnYClFh/rchmcJpktYH4fJemKxXyH8qKb/M0B6D4ddZ9qgZ35qqtsy6zQt6yJhuagF4z+0plmNKJ7IDSnlEnLMEq8wFEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578953; c=relaxed/simple;
	bh=OAJsTuMgjZCEgvmJagS5ZBSB40PFf9Qscvr3W/cEgM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPoRAqa1KW9E3zxW6cRvv/cbdKa51ntAmV8bpwWXUYLwqP9CHYndY7TE+kuBVpj5hM3yf/BG73iA9STlcIzAvmS8CvfuO1ZwfaxGYiP+Kw78g4l9Ax3w6MfCGsh0lbQbFwvhvIxlTbLH29KodGLOyXKN6YegSgG/jIGO5OD4Gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CkD3Z2+B; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783f27300b1so177393885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578951; x=1707183751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOr65lcwE97/+IL040qC2nQXATF0TLQoSMjJ/TctotE=;
        b=CkD3Z2+BJDaLaG9KMCbpYY8ywdwzFENO/jD+aVsycZshMsfXIywSlNCoWBLCqGD1l8
         jLtecnaME4plphW72l7GjiyoJe0a8gmgCuNQak8Ujh2X1Z7J2aRQekbai0DGALmROvq3
         RMISGk7ryF5/od/m2Jxyvo78D829hjgzwWJoCymTQQ6ze5+zX1d2lzb3/VPmTfJnLahe
         bWoDJzxTDR0UUzKv0rqLQdASYpTWhEyPAicvX7hBVUbE9y6Txfi1Aufgex6gD7yzTLnP
         bcDceeDZUL2yScqwDpmFm8FqsxHMtYjAtu3HEjicIWcUGSsjQr/7LFxfW6X61LEV4qv1
         qTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578951; x=1707183751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOr65lcwE97/+IL040qC2nQXATF0TLQoSMjJ/TctotE=;
        b=HoMd4HCmLHaGgKv+vOyx9GrJlA5/StXrDInGc83M/zCoKfArOUSnCD2NpqEoRmtI4h
         S3986t7a8s58mxKw2Z92JFeATYcSpAGlgfQEZm27Es/MFJXl/zvXkO8VuVvJxAfdOAsr
         uIfWuX28wkOx46nyEsk9VUxyyp9v5gL22gJ2yap/4OybVBljt4lDxwn9wHai/91Ughz4
         94WV4qkXQGHPhGVGFZal/l12S83Wy8UsaNBdyvsS7Ny+97dQogZJVUcl3bkBV8X6twi0
         P4cuLoMnEH26G8pbH3TeRwTKfjT84ti4vxV2u557JHQiQ3bCMydlEFA/pS11I4MlVqSs
         gBOg==
X-Gm-Message-State: AOJu0YwuMvmA4f4JeX/it5MPc/NSq4c+nj/6XbRfELsa5BE5W0s/xj0k
	7kvSDvYvVlDxOZPzYk3p9ASy6zlmMUXASyvkIrXjLnkZ0f2u+UP3ioH5OH1qljg=
X-Google-Smtp-Source: AGHT+IGBNUuoDAQL0pkLCMyHWCaO2KYdN3eRRjbq+JcAUmpZl/6o0Vki6wyVQPOrxoVvBtwDFwQh9g==
X-Received: by 2002:a05:6214:20ce:b0:67a:a721:b1b5 with SMTP id 14-20020a05621420ce00b0067aa721b1b5mr9104092qve.112.1706578951030;
        Mon, 29 Jan 2024 17:42:31 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a0f8600b007832575779esm3580991qkn.52.2024.01.29.17.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:30 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] mm: zswap: function ordering: public lru api
Date: Mon, 29 Jan 2024 20:36:50 -0500
Message-ID: <20240130014208.565554-15-hannes@cmpxchg.org>
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

The zswap entry section sits awkwardly in the middle of LRU-related
functions. Group the external LRU API functions first.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e650fc587116..511bfafc1456 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -746,6 +746,10 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
+/*********************************
+* lru functions
+**********************************/
+
 /* should be called under RCU */
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entry *entry)
@@ -764,6 +768,21 @@ static inline int entry_to_nid(struct zswap_entry *entry)
 	return page_to_nid(virt_to_page(entry));
 }
 
+void zswap_lruvec_state_init(struct lruvec *lruvec)
+{
+	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
+}
+
+void zswap_folio_swapin(struct folio *folio)
+{
+	struct lruvec *lruvec;
+
+	if (folio) {
+		lruvec = folio_lruvec(folio);
+		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+	}
+}
+
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 {
 	struct zswap_pool *pool;
@@ -798,24 +817,6 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 	kmem_cache_free(zswap_entry_cache, entry);
 }
 
-/*********************************
-* zswap lruvec functions
-**********************************/
-void zswap_lruvec_state_init(struct lruvec *lruvec)
-{
-	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
-}
-
-void zswap_folio_swapin(struct folio *folio)
-{
-	struct lruvec *lruvec;
-
-	if (folio) {
-		lruvec = folio_lruvec(folio);
-		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	}
-}
-
 /*********************************
 * lru functions
 **********************************/
-- 
2.43.0


